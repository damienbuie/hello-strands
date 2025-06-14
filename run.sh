#!/bin/bash

# Colors for output
GREEN='[0;32m'
RED='[0;31m'
NC='[0m' # No Color

#python3 -m venv .venv
#source .venv/bin/activate
echo "📦 Assumes virtual environment exists"
echo "🔌 Assumes virtual environment has been activated"

# AWS Profile configuration
if [ -z "$STRANDS_CLI_PROFILE" ]; then
    echo -e "${RED}Error: STRANDS_CLI_PROFILE environment variable is not set${NC}"
    echo "Please set your AWS profile using:"
    echo "export STRANDS_CLI_PROFILE=your-profile-name"
    exit 1
fi

echo "🚀 Starting Strands Agent Setup..."


# Install requirements if needed
if [ ! -f ".venv/.requirements_installed" ]; then
    echo "📚 Installing requirements..."
    .venv/bin/pip install -r requirements.txt
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to install requirements${NC}"
        exit 1
    fi
    touch .venv/.requirements_installed
fi

# Check if AWS session is valid
echo "🔍 Checking AWS session..."
if aws sts get-caller-identity --profile "${STRANDS_CLI_PROFILE}" >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Using existing AWS session${NC}"
else
    # AWS SSO Login
    echo "🔑 Logging into AWS SSO..."
    aws sso login --profile "${STRANDS_CLI_PROFILE}"
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to login to AWS SSO${NC}"
        exit 1
    fi
fi

# Verify AWS connection
echo "🔍 Verifying AWS connection..."
aws sts get-caller-identity --profile "${STRANDS_CLI_PROFILE}"
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to verify AWS connection${NC}"
    exit 1
fi

# Check Bedrock model access
echo "🔍 Checking Bedrock model access..."
MODELS=$(aws bedrock list-foundation-models --profile "${STRANDS_CLI_PROFILE}")
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to list Bedrock models${NC}"
    exit 1
fi

# Check if Claude 3 Sonnet is available
if echo "$MODELS" | grep -q "anthropic.claude-3-sonnet"; then
    echo -e "${GREEN}✅ Claude 3 Sonnet model is available${NC}"
else
    echo -e "${RED}❌ Claude 3 Sonnet model is not available${NC}"
    exit 1
fi

# Run the agent
echo "🤖 Starting the agent..."
python3 src/agent.py

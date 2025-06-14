# Hello Strands

This project demonstrates the use of AWS Bedrock with Strands Agents to create an AI agent that can interact with AWS services.

## Prerequisites

- Python 3.10 or higher
- AWS Account with Bedrock access
- AWS CLI configured with appropriate credentials
- Access to Claude 3 Sonnet model in AWS Bedrock

## Setup

1. Create and activate a virtual environment:
```bash
python3 -m venv .venv
source .venv/bin/activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Configure AWS credentials:
```bash
aws configure
```

## Configuration

### AWS Profile

The application requires an AWS profile to be configured. Set your AWS profile using the `STRANDS_CLI_PROFILE` environment variable:

```bash
export STRANDS_CLI_PROFILE=your-profile-name
```

You can add this to your shell's configuration file (e.g., `~/.zshrc` or `~/.bashrc`) to make it permanent:

```bash
echo 'export STRANDS_CLI_PROFILE=your-profile-name' >> ~/.zshrc
```

### Environment Variables

The following environment variables are used by the application:

- `STRANDS_CLI_PROFILE`: AWS profile name to use for authentication
- `AWS_REGION`: AWS region (defaults to eu-west-2)

You can set these variables in your shell or create a `.env` file in the project root:
```bash
STRANDS_CLI_PROFILE=your-profile-name
AWS_REGION=eu-west-2
```

Make sure your AWS profile has the necessary permissions as described in the AWS Configuration section.

## Project Structure

```
hello-strands/
├── .venv/                  # Python virtual environment
├── src/
│   ├── __init__.py        # Package initialization
│   └── agent.py           # Main agent implementation
├── requirements.txt        # Python dependencies
└── run.sh                 # Setup and execution script
```

## Running the Agent

Use the provided script to run the agent:
```bash
./run.sh
```

This script will:
1. Set up the virtual environment if needed
2. Install dependencies
3. Log into AWS SSO
4. Verify AWS connection
5. Check Bedrock model access
6. Run the agent

## AWS Configuration

The agent requires the following AWS permissions:
- `bedrock:InvokeModel`
- `bedrock:ConverseStream`

Make sure your AWS profile has access to the Claude 3 Sonnet model in the eu-west-2 region.

## Development

To modify the agent's behavior:
1. Edit `src/agent.py` to change the agent's configuration
2. Add tools to the agent by modifying the `tools` list in the `create_agent()` function
3. Update the system prompt to change the agent's behavior

## Troubleshooting

Common issues:
1. AWS credentials not configured correctly
2. Missing Bedrock model access
3. Incorrect region configuration
4. Missing required permissions

Check the AWS Bedrock console to ensure you have access to the required models and permissions.
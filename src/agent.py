import os
from strands import Agent
from strands.models import BedrockModel

# Configure AWS region before importing Strands
if 'STRANDS_CLI_PROFILE' not in os.environ:
    raise ValueError("STRANDS_CLI_PROFILE environment variable is not set")

os.environ['AWS_PROFILE'] = os.environ['STRANDS_CLI_PROFILE']
os.environ["AWS_REGION"] = "eu-west-2"  # London region

def create_agent():
    # Initialize the Bedrock model
    model = BedrockModel(
        model_id="anthropic.claude-3-sonnet-20240229-v1:0",  # Update with your preferred model
    )
    
    # Create a basic agent
    agent = Agent(
        model=model,
        tools=[],  # We'll add tools later
        system_prompt="You are a helpful AI assistant."
    )
    
    return agent

if __name__ == "__main__":
    agent = create_agent()
    # Use the correct method to interact with the agent - call it directly
    response = agent("Hello! How can you help me today?")
    print(response) 
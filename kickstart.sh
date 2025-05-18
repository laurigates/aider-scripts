#!/bin/bash

# Exit on error, unset variables, and pipe failures
set -euo pipefail

# Check if we're in a git repository
if [ ! -d ".git" ]; then
  echo "Error: This script must be run from the root of a Git repository."
  exit 1
fi

# Create docs directory if it doesn't exist
mkdir -p docs

# Function to generate a document using aider
generate_document() {
  local filepath="$1"
  local prompt="$2"
  
  # Ensure the file exists
  touch "${filepath}"
  
  echo "Generating ${filepath}..."
  
  # Run aider non-interactively
  aider "${filepath}" --message "${prompt}" --yes-always --no-auto-commits
  
  # Add and commit the file
  git add "${filepath}"
  git commit -m "AI: Create ${filepath}"
  
  echo "${filepath} created and committed."
  echo "----------------------------------------"
}

# Generate docs/REQUIREMENTS.md
generate_document "docs/REQUIREMENTS.md" "Generate content for docs/REQUIREMENTS.md. This document outlines design requirements. Create a template with sections: 1. Introduction (Purpose, Scope, Definitions, Acronyms, References, Overview). 2. Overall Description (Product Perspective, Product Functions, User Characteristics, Constraints, Assumptions and Dependencies). 3. Specific Requirements (covering Functional, Usability, Performance, Security, and other Non-Functional Requirements). 4. System Models (optional, e.g., Use Cases, State Diagrams). Use placeholders like '[Details to be added]' or 'TBD'."

# Generate docs/DESIGN.md
generate_document "docs/DESIGN.md" "Generate content for docs/DESIGN.md. This document reflects the current project design. Create a template with sections: 1. Introduction (Purpose, Scope, Definitions, Acronyms, References, Overview). 2. System Architecture (Architectural Style, High-Level Diagram, Component Breakdown, Technology Stack). 3. Detailed Design (Module 1 Design, Module 2 Design, ..., Data Design, Interface Design). 4. Design Decisions and Trade-offs. 5. Deployment View. Mark content as 'Initial Draft - Subject to Elaboration'."

# Generate docs/LIBRARIES.md
generate_document "docs/LIBRARIES.md" "Generate content for docs/LIBRARIES.md. This document lists considered and chosen libraries. Structure it with: 1. Introduction. 2. Evaluation Criteria (e.g., Functionality, License, Community, Maturity, Performance). 3. Considered Libraries (for categories like 'Web Framework', 'Database Client', 'Testing Framework', etc., list each library with brief pros/cons). 4. Chosen Libraries (list selected libraries with justification for each). Include placeholder examples."

# Generate docs/TESTING.md
generate_document "docs/TESTING.md" "Generate content for docs/TESTING.md. This document describes the testing strategy and methodology. Include sections: 1. Introduction (Purpose, Scope). 2. Test Strategy (Levels: Unit, Integration, System, Acceptance; Types: Functional, Performance, Security, Usability). 3. Test Environment Setup. 4. Test Data Management. 5. Test Execution Process. 6. Defect Reporting and Tracking. 7. Roles and Responsibilities. Use placeholders for specific tools or procedures."

# Generate README.md
generate_document "README.md" "Generate a README.md for a new project. It should describe the project and basic usage. Include standard sections: Project Title (use '[Project Name]' placeholder), Short Description, Table of Contents (optional), Key Features, Prerequisites, Installation Steps, How to Run/Usage Examples, Running Tests, Contribution Guidelines, License Information (e.g., 'MIT License'), Contact/Support (optional). Fill with instructive placeholder text."

# Generate TODO.md
generate_document "TODO.md" "Generate a TODO.md file for tracking project progress. Use a Kanban-style structure with columns: 'Backlog', 'To Do (Ready for Dev)', 'In Progress', 'Done'. Add a few example placeholder tasks under 'To Do (Ready for Dev)', such as 'Initial project setup', 'Define core data structures', 'Implement user authentication feature'."

echo "Project kickstart complete! All documents have been created and committed."

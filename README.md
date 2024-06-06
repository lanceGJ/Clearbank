Practical task: 
We do not expect a “polished” solution. Try not to spend more than 1 hour to write the code and ensure you show how you approach the challenge and design a solution. If you want to, include a readme.md to explain how you’d evolve and improve the design, include testing, deploy the solution and so on. 
Terraform: 
Create two Azure VMs in three environments (test, staging, production), ensure that: 
•	each VM is provisioned in a dedicated resource group. 
•	each VM only allows incoming traffic from SSH. Outbound of DNS, HTTP, HTTPS
•	There is some form of backup strategy implemented.
•	the resources are protected from accidental deletion. 
There are different ways to structure and run the project. To simplify the task and focus on your terraform code skills, have one ".tfstate" file, and three variables (one per environment) in a single ".tfvars" file which will describe all your ASBNs in each environment. (Add your variables to a single “.tfvars” file (one per environment). This should describe your VM per environment). 
Feel free to replace VM with any other resource of your choice, preferably an Azure resource. We expect you to demonstrate your ability to use nested data structures, therefore make sure you have a root-level resource and a number of nested resources (and no dynamic blocks). 
Please provide a zip of your code, or a link to a git repository that can be accessed by us (we can provide a GitHub user to add to private repositories on GitHub). 

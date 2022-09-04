# Define Azure Policy Definition for Allowed SKU's
resource "azurerm_policy_definition" "Allowed-VM-SKU-Definition" {
  name         = "MPC-Allowed-VM-SKU"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "MPC-Allowed-VM-SKU"

  metadata     = <<METADATA
    {
    "category": "Compute"
    }
  METADATA

  policy_rule = <<POLICY_RULE
{
   "if": {
    "allOf": [
     {
      "field": "type",
      "equals": "Microsoft.Compute/virtualMachines"
     },
     {
      "not": {
       "field": "Microsoft.Compute/virtualMachines/sku.name",
       "in": "[parameters('listOfAllowedSKUs')]"
      }
     }
    ]
   },
   "then": {
    "effect": "audit"
   }
  }
POLICY_RULE

  parameters = <<PARAMETERS
    {
 "listOfAllowedSKUs": {
    "type": "Array",
    "metadata": {
     "displayName": "Allowed Azure VM SKUs",
     "description": "The list of size SKUs that can be specified for Azure VMs."
    }
   }
  }
PARAMETERS
}
## PowerControl
Setting the power output of a connector and retrieving its state and information.
### Description
This sample shows how to enable and disable the power output of connectors.
The available connectors are dependent on the device used. More information for
available power connectors can be found in the device manual or with the
code completion on the enum of Connector.Power.create(enum). In this sample
the Sensor 1 power connector is used. This may have to be adapted if another
device than a SIM4000 is used.
This script first enables the power connector and then toggles the power every
ten seconds and retrieves additional information. 
### How to Run
To show, this sample must be run on a device with power connectors. 
The results are printed to the console

### Topics
System, Hardware, Sample, SICK-AppSpace
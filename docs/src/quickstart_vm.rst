Ohara Quickstart VM
==============================



Prerequisites
-------------

* OS: Windows / Linux / MacOS
* `VirtualBox <https://www.virtualbox.org/>`_ 5.2+: Oracle VM VirtualBox, is a free and open-source virtual machine.
* `Ohara Quickstart VM image <https://github.com/oharastream/ohara-quickstart/releases>`__: An OVA(Open Virtual Appliance)
  file, a pre-prepared virtual machine image for Ohara quickstart. You can download .ova from the release page.
  For example: ohara-quickstart-0.8.0.ova

    .. figure:: images/download_assets.png
       :alt: download_assets
       :scale: 50%
       :target: https://github.com/oharastream/ohara-quickstart/releases

Installation
------------


VirtualBox
^^^^^^^^^^

  Please download virtualbox from `here <https://www.virtualbox.org/wiki/Downloads>`_, and reference
  `this article <https://www.virtualbox.org/manual/ch02.html>`__ to install.


Import Quickstart VM
^^^^^^^^^^^^^^^^^^^^

  You can use VirtualBox user interface to import the Ohara Quickstart VM(ova file):
  **Main menu -> File -> Import Appliance**


Setup VirtualBox network adapter
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Quickstart VM requires a **Host-only network adapter** to be configured so that you can connect from the host machine to
guest machine(Quickstart VM).

  .. note::
    Quickstart VM uses network adapter ``vboxnet0`` with DHCP Server enabled as **default Host-only adapter**,
    if there is already a ``vboxnet0`` adapter in your VirtualBox, you can just skip this step.

.. tabs::

  .. tab:: Mac/Linux

    1. Create new network adapter

       Click **Tools** and then click **Create**, ensure that the DHCP Enable option is
       selected.


      .. figure:: images/mac_add_network.jpg
         :alt: create\_network\_mac
         :scale: 30%

         MacOS - Create network adapter

    2. Setting network adapter

       Select the imported ohara-quickstart VM, click **Setting**, click **Network**,
       click **Adapter2**, select **Host-only Adapter**, and select the newly added
       network card.

      .. figure:: images/mac_setting_network.png
         :alt: setting\_network\_mac
         :scale: 30%

         MacOS - Setting VM's network adapter

  .. tab:: Windows

    1. Create network adapter

       Click **Global Tools** and then click **Create**, ensure that the DHCP Enable option
       is selected.

       .. figure:: images/win_add_network.png
          :alt: create\_network\_windows
          :scale: 45%

          Windows - Create network adapter

    2. Setting network adapter

       Select the imported ohara-quickstart VM, click **Setting**, click **Network**,
       click **Adapter2**, select **Host-only Adapter**, and select the newly added
       network card.

       .. figure:: images/win_setting_network.png
          :alt: setting\_network\_windows
          :scale: 45%

          Windows - Setting VM's network adapter


Install Ohara and other services
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Once the Quickstart VM is imported and the network adapter is configured, you can press
**Start** to start Quickstart VM and then use ``ohara`` as username and
``oharastream`` as password to log into the system.


Ohara installation will be starting automatically if this is your first time to log into the
system. This step will take some times to download Ohara docker images and other
backend service images(e.g., PostgreSQL, Ftp)


  .. figure:: images/vm_ohara_install_1.jpg
     :alt: install_ohara_1
     :scale: 30%

     Ohara installation started


  .. figure:: images/vm_ohara_install_2.jpg
     :alt: install_ohara_2
     :scale: 30%

     Ohara and service installed


After the installation is complete, some services connection information should be displayed.
For example:

  .. code-block:: text

    > FTP ready on ftp://ohara:oharastream@192.168.56.105:21

    > Postgresql ready on jdbc:postgresql://192.168.56.105:5432/postgres (user=ohara, password=oharastream)

    > SMB ready on smb://ohara:oharastream@192.168.56.105:445/ohara

    > Ohara ready on http://192.168.56.105:5050

As we can see in the above, the VM's IP address is `192.168.56.105`.
We can then open the browser and enter this URL in browser's address bar `http://192.168.56.105:5050`. to open  **Ohara Manager**.

Terminology
-----------

Node
  Ohara node is the basic unit of running service. It can be either physical
  machine or VM.

Workspace
  Every Ohara workspace contains multiple Ohara services including: Zookeepers, Brokers and Workers
  so that can be running pipelines which created in the workspace.

Pipeline
  Ohara Pipeline allows you to define your data stream, use **Connector** to connect the external storage systems,
  and use **StreamApp** to customize data transformation and stream processing.

Connector
  Connector is used to connect the external storage systems, it has two types - source connector and sink connector.
  Source connector pulls data from another system and then push to topic. By contrast, Sink connector pulls data from
  topic and then push to another system.

StreamApp
   StreamApp is powered by `Kafka Streams <https://kafka.apache.org/documentation/streams/>`_. Provide the user
   a simple way to write their own stream processing application.

----

Preparation for pipeline creation
---------------------------------

  Ohara Manager is the user interface of Ohara. Ohara Manager provides a user interface to allow user to design their data
  pipeline without complex coding. Because we just complete Ohara installation in the Quickstart VM, so we need to do the
  following tasks before creating our first data pipeline.

  * Add node
  * Create workspace
  * Create two topics
  * Upload StreamApp jar file

Add node
^^^^^^^^

- Click Menu **Nodes**
- Click **NEW NODE**

  .. figure:: images/node_list.png
     :alt: node\_list
     :scale: 40%

- In the **New node** dialog, please fill in the following fields:

  - Type Node (${IP})
  - Type Port **22**
  - Type User **ohara**
  - Type Password **oharastream**
- Click **TEST CONNECTION**
- Click **ADD**

  .. figure:: images/new_node.png
     :alt: new\_node
     :scale: 40%

- After the node was added, you can see the newly created node on the
  Nodes page.

  .. figure:: images/new_node_list.png
     :alt: node\_list
     :scale: 40%


Create workspace
^^^^^^^^^^^^^^^^

- Click Menu **Workspaces**
- Click **NEW WORKSPACE**

  .. figure:: images/workspace_list.png
     :alt: workspace\_list
     :scale: 40%

  .. note::
    Posgresql jdbc driver would be used by JDBC Source Connector, we need to upload the driver file during the
    workspace creation in current Ohara version. (Please download from `here <https://jdbc.postgresql.org/download.html>`__)

- In the **New workspace** dialog, please fill in the following fields:

  - Type name **wk00**
  - Select Node **${HOST} or ${IP}**
  - Click **NEW PLUGIN**
  - Upload file **postgresql-1.jdbc.jar**
  - Select **postgresql-1.jdbc.jar**
  - Click **ADD**

  .. figure:: images/new_workspace.png
     :alt: new\_workspace
     :scale: 40%

- And wait for the setup to complete.

  .. figure:: images/wait_workspace.png
     :alt: wait\_workspace
     :scale: 40%

- You can see that workspace has been built on the list

  .. figure:: images/new_workspace_list.png
     :alt: new\_workspace\_list
     :scale: 40%


Create Two Topics
^^^^^^^^^^^^^^^^^

- Click Menu **Workspaces**
- Click **wk00 Action**
- Click **TOPICS**

  .. figure:: images/topic_list.png
     :alt: topic\_list
     :scale: 40%

- Click **NEW TOPIC**
- In the **New topic** dialog, please fill in the following fields:

  - Type Topic name **topic00**
  - Type patitions **1**
  - Type Repliction factor **1**
  - Click **ADD**

  .. figure:: images/new_topic00.png
     :alt: new\_topic00
     :scale: 40%

- Click **NEW TOPIC**
- In the **New topic** dialog, please fill in the following fields:

  - Type Topic name **topic01**
  - Type patitions **1**
  - Type Repliction factor **1**
  - Click **ADD**

  .. figure:: images/new_topic01.png
     :alt: new\_topic01
     :scale: 40%

- Now you can see two topics to create the completion in the list

  .. figure:: images/new_topic_list2.png
     :alt: new\_topic\_list2
     :scale: 40%


Upload StreamApp Jar
^^^^^^^^^^^^^^^^^^^^

  .. tip::
    In this step, you can upload a stream-app jar for later usage in the Ohara Pipeline. There have a
    pre-prepared stream-app jar for this Quickstart, you can just download from
    `release <https://github.com/oharastream/ohara-quickstart/releases>`_ page.

    .. figure:: images/download_assets.png
       :alt: download_assets
       :scale: 50%

- Click **STREAM JARS**
- Click **NEW JAR**
- Upload file **ohara-streamapp.jar**

  .. figure:: images/stream_list.png
     :alt: stream\_list
     :scale: 25%

----

Create data pipeline
---------------------

  In this section, we will create a data pipeline using Ohara Manager. The following items are the tasks that we
  will complete in the next few steps.

  * Create empty pipeline
  * Add a JDBC source connector
  * Add Two Topics
  * Add a StreamApp
  * Add a FTP sink connector

  .. figure:: images/start_graph.png
     :alt: pipeline_graph


Create empty pipeline
^^^^^^^^^^^^^^^^^^^^^

- Click Menu **Piplines**
- Click **NEW PIPELINE**

  .. figure:: images/pipeline_list.png
     :alt: pipeline\_list
     :scale: 40%

     pipeline\_list

- In the **New pipeline** dialog, please fill in the following fields:

  - Type Pipeline name **pipeline**
  - Select Workspace name **wk00**
  - Click **ADD**

  .. figure:: images/new_pipeline.png
     :alt: new_pipeline
     :scale: 25%

  .. figure:: images/edit_pipeline.png
     :alt: edit_pipeline
     :scale: 25%


Add a JDBC source connector
^^^^^^^^^^^^^^^^^^^^^^^^^^^

- Click source connector icon
- Select **com.island.ohara.connector.jdbc.source.JDBCSourceConnector**
- Click **ADD**

  .. figure:: images/new_source_connector.png
     :alt: new\_source\_connector
     :scale: 25%

     new\_source\_connector

- Type name **jdbc**
- Click **ADD**

  .. figure:: images/new_source_connector_name.png
     :alt: new\_source\_connector\_name
     :scale: 25%

     new\_source\_connector\_name


Add two topics
^^^^^^^^^^^^^^^

- Click topic icon
- Select **topic00**
- Click **ADD**

  .. figure:: images/new_topic.png
     :alt: new\_topic
     :scale: 25%

     new\_topic

- Click topic icon
- Select **topic01**
- Click **ADD**

  .. figure:: images/new_topic2.png
     :alt: new\_topic2
     :scale: 25%

     new\_topic2


Add a StreamApp
^^^^^^^^^^^^^^^

- Click stream app icon
- Select **ohara-streamapp.jar**

  .. figure:: images/new_stream.png
     :alt: new\_stream
     :scale: 25%

     new\_stream

- Type name **stream**
- Click **ADD**

  .. figure:: images/new_stream_name.png
     :alt: new\_stream\_name
     :scale: 25%

     new\_stream\_name


Add a FTP sink connector
^^^^^^^^^^^^^^^^^^^^^^^^

- Click sink connector icon
- Select **com.island.ohara.connector.ftp.FtpSink**
- Click **ADD**

  .. figure:: images/new_sink_connector.png
     :alt: new\_sink\_connector
     :scale: 25%

     new\_sink\_connector

- Type name **ftp**
- Click **ADD**

  .. figure:: images/new_sink_connector_name.png
     :alt: new\_sink\_connector\_name
     :scale: 25%

     new\_sink\_connector\_name


Update component settings
^^^^^^^^^^^^^^^^^^^^^^^^^

Setting jdbc connector
  - Select jdbc connector
  - Type jdbc url

    For example: **jdbc:postgresql://192.168.56.105:5432/postgres**
  - Type user name **ohara**
  - Type password **oharastream**
  - Type table name **employees**
  - Type timestamp column name **create\_at**

    .. figure:: images/setting_jdbc_common.png
       :alt: setting\_jdbc\_common
       :scale: 25%

  - Click CORE tabs
  - Select Topics **topic00**
  - Click **TEST YOUR CONFIGS**
  - Verify that the settings are correct

    .. figure:: images/setting_jdbc_core.png
       :alt: setting\_jdbc\_core
       :scale: 25%



Setting StreamApp
  - Select streamapp
  - Type column name **employee\_id,first\_name**

    .. figure:: images/setting_stream_common.png
       :alt: setting\_stream\_common
       :scale: 25%

  - Click CORE tabs
  - Select From topic of data consuming from **topic00**
  - Select To topic of data produce to **topic01**
  - Type Instances **1**
  - Verify that the settings are correct

    .. figure:: images/setting_stream_core.png
       :alt: setting\_stream\_core
       :scale: 25%


Setting FTP Sink Connector
  - Select ftp connector
  - Type Output folder **output**
  - File Need Header **enabled**
  - Type Host **${FTP_HOST}**
  - Type Port **${FTP_PORT}**
  - Type User **ohara**
  - Type Password **oharastream**

    .. figure:: images/setting_sink_connector_common.png
       :alt: setting\_sink\_connector\_common
       :scale: 25%

  -  Click CORE tabs
  -  Select Topics **topic01**
  -  Click **TEST YOUR CONFIGS**
  -  Verify that the settings are correct

    .. figure:: images/setting_sink_connector_core.png
       :alt: setting\_sink\_connector\_core
       :scale: 25%


Start Pipeline
--------------

- Click Operate **START_ICON**

  .. figure:: images/start_graph.png
     :alt: start\_graph

- Wait a minute and you can see that all connectors on the graph turn
  green and metrics are displayed to indicate that the service started
  successfully.


Verify output file
------------------

- Open browser page with FTP url

  For example: **ftp://ohara:oharastream@192.168.56.105:21**

.. figure:: images/ftp_url.png
   :alt: ftp_url

.. figure:: images/ftp_output_url.png
   :alt: ftp_output_url

.. figure:: images/ftp_partition_url.png
   :alt: ftp_partition_url

.. figure:: images/ftp_csv_url.png
   :alt: ftp_csv_url

You should see that the output table has already filtered two fields, **employee_id** and **first_name**.


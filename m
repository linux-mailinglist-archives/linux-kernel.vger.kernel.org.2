Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEDB37F48B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhEMI7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:59:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:47031 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232288AbhEMI7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:59:12 -0400
IronPort-SDR: 0Kcv8M8qDSO/iEIzxCgOpL6l/4z8gzXAnII6wiZvY6u5vZ7O5X4XscLxHkzXjRP+eEKOKGGTkM
 KJRGIRfqa7zA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187032232"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187032232"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:58:02 -0700
IronPort-SDR: 5yS78dNZlCzjSC0Tkr7wAv9h95TyVxINE/GlEVqgdv/Dw3CIgvQk5VxhWWqodAQWR8v/IvmQYS
 CN8Bo1v9oASg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625928233"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 01:58:00 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH v2 01/15] misc: nnpi: Document NNP-I's driver overview
Date:   Thu, 13 May 2021 11:57:11 +0300
Message-Id: <20210513085725.45528-2-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210513085725.45528-1-guy.zadicario@intel.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce overview documentation for NNP-I card and driver
to let new readers of the driver understand better the
driver and the NNP-I device.

Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 Documentation/misc-devices/index.rst      |   1 +
 Documentation/misc-devices/intel-nnpi.rst | 237 ++++++++++++++++++++++++++++++
 2 files changed, 238 insertions(+)
 create mode 100644 Documentation/misc-devices/intel-nnpi.rst

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 30ac58f..7f14fc4 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -22,6 +22,7 @@ fit into other categories.
    dw-xdata-pcie
    ibmvmc
    ics932s401
+   intel-nnpi
    isl29003
    lis3lv02d
    max6875
diff --git a/Documentation/misc-devices/intel-nnpi.rst b/Documentation/misc-devices/intel-nnpi.rst
new file mode 100644
index 0000000..cb67fb4
--- /dev/null
+++ b/Documentation/misc-devices/intel-nnpi.rst
@@ -0,0 +1,237 @@
+.. SPDX-License-Identifier: GPL-2.0-ONLY
+
+======================================================================
+Device driver for Intel NNP-I (Neural Network Processor for Inference)
+======================================================================
+
+Terminology
+===========
+To avoid confusion and for better understanding of the code for new reviewers,
+here is a list of few definitions used throughout this document, in commit
+messages and in the code:
+
+card:
+    The NNP-I card, including hardware and embedded software running inside it,
+    which is connected to the host through PCIe.
+
+host:
+    The computer the NNP-I card is attached to through PCIe, and which runs the
+    Linux kernel with NNP-I driver.
+
+IPC protocol:
+    Protocol of messages exchanged between the host and card.
+
+command:
+    A message sent from host to card, typically a command to execute on the
+    card.
+
+response:
+    A message sent from card to the host, typically as a response to a command
+    sent previously from the host. or, a message sent from card to indicate some
+    event, such as an error condition, or the completion of an asynchronous request.
+
+nnp_user:
+    An object created for each file descriptor opened for /dev/nnpi_host. It
+    manages host memory resources. Each nnp_user has its own set of host resources which
+    cannot be shared with other nnp_user objects.
+
+channel, cmd_chan:
+    An object which manages communication between user-space applications and
+    cards. It provides an interface to send commands to the card and receive responses
+    from the card. Each application can create one or more channels to the same
+    or different cards. One channel connects a single nnp_user to a single card.
+    Each channel is associated with one NNP-I card and one nnp_user.
+    The channel can only access host memory resources belonging to that
+    nnp_user.
+
+ELBI:
+    This acronym refers to the set of hardware registers of the NNP-I card which
+    are accessible through BAR0. It stands for: "External Local Bus Interface".
+
+model:
+    A neural network used to process input data and generate output data
+
+Description
+===========
+NNP-I is a PCIe card which accelerates deep-learning inference
+applications. The card is equipped with LPDDR4 memory, a DMA engine, x86 cores
+and specialized compute units called Inference Compute Engines (ICE). These
+compute engines are designed for power-efficient inference-related computations.
+
+The card DRAM as well as the ICEs and other hardware components on the card
+are not accessible from host CPU; they are programmed and controlled by
+software components running on the card's x86 cores. Communication between the
+SW components on the card and the host is done through three interfaces:
+
+- A small size "command queue" and "response queue", through which commands
+  and responses can be sent and received to/from the card.
+- Two doorbell registers, through which the host and card can communicate state.
+- A DMA engine on the card, which copies big memory chunks between host and card
+  DRAM.
+
+A typical flow of an inference application running on the host is the following:
+
+1) Allocate memory on host to hold the model, input and output data.
+2) Request card's software to allocate space on the card DRAM for the model,
+   input and output data.
+3) Load a model into host DRAM, and request the card's DMA engine to copy it
+   over to the card's DRAM.
+4) Load host memory with input data.
+5) Schedule commands to the card to copy the input data to the card
+   DRAM, execute the model on this input, and copy the output data back to
+   host memory.
+
+The card's software stack consists of a BIOS image which is flashed on
+the card and kept in a dedicated persistent memory, and a full embedded Linux image
+which is loaded to the card during boot/reset process.
+During power-on, the card BIOS and host driver communicate through
+the doorbell registers and the "command queue". The card boot flow consists of
+loading a "boot image" to host memory and communicating the location of this
+image to the card's BIOS, the card's BIOS copies that boot image to card
+DRAM using the DMA engine and starts booting the embedded Linux running on the
+card's x86 cores.
+
+Each NNP-I card can support multiple inference application contexts; each
+context has its own space for card and host resource IDs.
+There is no hardware level restriction on one context to access resources of
+another context, however this is prevented by the card software stack by having a
+separate resource ID space for each of the contexts.
+
+There may be multiple NNP-I cards connected to one host. An inference application can
+hold channels to multiple NNP-I cards and should be able to map and access
+the same host resource memory on all cards, however only if the host resource
+and all device contexts are created by the same application. Possible use cases
+for this capability is to run different models on different cards in parallel
+on the same data, or passing output of one model ran on one card as input to
+another model which is loaded on another card. The driver implements
+that requirement by exporting two char devices, one for host resource management
+and another for card access. The application must provide host resource file
+descriptor to the card's character device to allow access to host resources created from
+the same file descriptor.
+
+ABI
+===
+There are two character device classes created by the driver with IOCTL
+interface, provided by include/uapi/misc/intel_nnpi.h:
+
+/dev/nnpi_host:
+
+ A character device which is not related to physical NNP-I  card.
+ It has 4 IOCTLs for creating, destroying,
+ locking and unlocking host resources. "host resource" is a
+ set of pinned memory pages on host which can be mapped
+ to PCI space and accessed by the card's DMA engine.
+ This character device is created on the first probed NNP-I card
+ so it will not be present on systems with no NNP-I cards.
+
+/dev/nnpi%d:
+
+ A character device with instance for each NNP-I card.
+ It support 5 IOCTLs for:
+
+ *  Creating a channel - A "channel" gives user-space the ability to
+    send commands and receive responses from the card.
+    For each channel an anonymous file descriptor is created and
+    returned to the user. Commands and responses to the card
+    are sent and received using write and read operations on
+    the channel file descriptor. The driver validates each
+    command sent and will reject unsupported or invalid commands.
+    Commands written to a channel are added to a queue; each
+    channel has its own command queue. For each card in the system
+    there's one kernel thread (msg_scheduler) which drains the
+    command queues to this card hardware command queue.
+    The channel is destroyed by closing the returned channel file
+    descriptor.
+    When creating a channel an open file descriptor for
+    /dev/nnpi_host needs to be provided. The channel object holds
+    a reference to that file, and the channel can map/unmap only
+    host resources which were created through that same file
+    descriptor.
+    Each channel has a unique 10-bit ID allocated by the driver.
+    Channel IDs in a range [0, 255] are used for inference
+    contexts.
+    Channel with ID greater than 255 is used for non-inference
+    related communication with the card (mainly maintenance,
+    stats query, etc).
+ *  Map/Unmap host resource - Maps a host resource to card PCI
+    space and sends to the card a pointer to a page table of
+    the physical addresses of the resource pages.
+    Each map has a unique 16-bit ID. Commands sent to the card
+    can include such ID in order to reference a host resource.
+    The ID space for host resources is private for each channel.
+ *  Create/Delete "ringbuffer" - This is exactly the same as
+    map/unmap host resource, but for special host resources,
+    called ring buffers, used to transfer data along with
+    some commands. There may be up to two host-to-card ring
+    buffers and two card-to-host ring buffers.
+
+sysfs
+=====
+There are multiple sysfs attributes for NNP-I card allowing to display
+card information and status, and some for control operations like enable/disable
+the card.
+
+Attributes are documented in `Documentation/ABI/testing/sysfs-driver-intel_nnpi`.
+
+PCI BARs
+========
+The card exposes two 64-bit BARs:
+
+BAR0-1:
+    4KB including card registers to control the command and response hardware
+    queues (FIFOs), doorbell registers and control/interrupt status registers.
+    The offsets and bitfields of those registers are defined in
+    if_include/nnpi_elbi.h
+
+BAR2-3:
+    Card Memory region of 64MB. The host has read/write access to this region.
+    The first 16KB of this region hold card crash dump in case the card
+    software stack has crashed (Obviously, this is an erroneous state that should
+    never happen, but when it does the crash dump helps debugging).
+    The layout of this 16KB is defined in if_include/nnp_inbound_mem.h.
+    This region will be filled by the card on event of crash and can be
+    read by the host for debugging purposes. When a crash is detected on card,
+    the card will send an event response message to indicate that event.
+    The Rest of this memory region (64MB - 16KB) is used by peer-to-peer
+    applications to transfer data between two NNP-I cards. A single application
+    can use multiple cards, there are commands to the card which allows such
+    application to allocate device resources in this BAR space as well as commands
+    to issue DMA copy request to copy data from one card DRAM memory to a second
+    card memory if the destination resource address is within BAR 2-3 space.
+
+Card's command protocol
+=======================
+Commands to the card include 1, 2 or 3 64-bit values. The lower 6 bits in the
+command specify the command opcode. The opcode also defines the command size as
+each command has constant size. Commands which are targeted to a specific channel
+include the channel ID in bits 15:6 of the command and must use opcode value
+above or equal to 32.
+
+The definition of other bits is specific to each command.
+Responses from the card have the same format.
+
+The opcodes and structure of the command and responses are defined in
+drivers/misc/intel-nnpi/ipc_include/ipc_protocol.h
+
+Driver architecture
+===================
+Since the NNP-I card has its own software stack and the way to program it is
+mainly by sending commands and receive responses, the driver is split into
+two modules.
+
+The PCIe device driver module, intel_nnpi_pcie, is responsible for detecting
+the NNP-I card and provide functionality for sending it commands, receive
+responses and perform few control operations. This module does not understand
+the IPC protocol, it only provides the mechanism to send and receive raw data.
+This module does not also provide any user space interfaces. The intel_nnpi_pcie
+module is a pci driver for the Intel NNP-I card and glue it into the NNP-I
+framework module.
+
+The NNP-I framework module, intel_nnpi, is the "logical" module that provides the
+user space interfaces, understands the IPC protocol, packs and unpacks commands
+and responses and control the card by calling to interfaces implemented by the
+device driver module. The main structure for an NNP-I card device in the framework
+is &struct nnp_device.
+
+These two modules serve similar roles to the "transport" and "application" layers
+in the `standard TCP/IP terminology <https://www.guru99.com/tcp-ip-model.html#3>`_.
-- 
1.8.3.1


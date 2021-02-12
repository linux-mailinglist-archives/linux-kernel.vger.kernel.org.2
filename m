Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB06D31A787
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 23:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhBLWZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 17:25:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:16458 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhBLWYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:24:54 -0500
IronPort-SDR: xAB33QJ2CHVCJ5zAS57rXTlVcMY91WEO26j9oRvx4buWrfnACa444FU8mvTP0A8Z/dxKlp+V+3
 L4ufxRO6Kdbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="178980681"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="178980681"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:23:08 -0800
IronPort-SDR: kNXimhJk8Bw5NMK+pA5o4R8BsGj2jLWrYOjdEYIz6QN6ElNBLAsE/K1WpDfi9MqHTurWH0a93E
 BIYniEIrPZSA==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="437732666"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:23:07 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id E2504636E;
        Fri, 12 Feb 2021 14:23:07 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id DAE923636F7; Fri, 12 Feb 2021 14:23:07 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH v6 08/34] misc: xlink-pcie: Add documentation for XLink PCIe driver
Date:   Fri, 12 Feb 2021 14:22:38 -0800
Message-Id: <20210212222304.110194-9-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212222304.110194-1-mgross@linux.intel.com>
References: <20210212222304.110194-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Provide overview of XLink PCIe driver implementation

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
---
 Documentation/vpu/index.rst      |  1 +
 Documentation/vpu/xlink-pcie.rst | 90 ++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/vpu/xlink-pcie.rst

diff --git a/Documentation/vpu/index.rst b/Documentation/vpu/index.rst
index 7e290e048910..661cc700ee45 100644
--- a/Documentation/vpu/index.rst
+++ b/Documentation/vpu/index.rst
@@ -14,3 +14,4 @@ This documentation contains information for the Intel VPU stack.
    :maxdepth: 2
 
    vpu-stack-overview
+   xlink-pcie
diff --git a/Documentation/vpu/xlink-pcie.rst b/Documentation/vpu/xlink-pcie.rst
new file mode 100644
index 000000000000..85a70990e9c9
--- /dev/null
+++ b/Documentation/vpu/xlink-pcie.rst
@@ -0,0 +1,90 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+Kernel driver: Xlink-pcie driver
+================================
+Supported chips:
+  * Intel Edge.AI Computer Vision platforms: Keem Bay
+    Suffix: Bay
+    Slave address: 6240
+    Datasheet: Publicly available at Intel
+
+Author: Srikanth Thokala Srikanth.Thokala@intel.com
+
+Introduction
+============
+The Xlink-pcie driver provides transport layer implementation for
+the data transfers to support Xlink protocol subsystem communication with the
+peer device, i.e., between remote host system and Keem Bay device.
+
+The Keem Bay device is an ARM-based SOC that includes a vision processing
+unit (VPU) and deep learning, neural network core in the hardware.
+The Xlink-pcie driver exports a functional device endpoint to the Keem Bay
+device and supports two-way communication with the peer device.
+
+High-level architecture
+=======================
+Remote Host: IA CPU
+Local Host: ARM CPU (Keem Bay)::
+
+        +------------------------------------------------------------------------+
+        |  Remote Host IA CPU              | | Local Host ARM CPU (Keem Bay) |   |
+        +==================================+=+===============================+===+
+        |  User App                        | | User App                      |   |
+        +----------------------------------+-+-------------------------------+---+
+        |   XLink UAPI                     | | XLink UAPI                    |   |
+        +----------------------------------+-+-------------------------------+---+
+        |   XLink Core                     | | XLink Core                    |   |
+        +----------------------------------+-+-------------------------------+---+
+        |   XLink PCIe                     | | XLink PCIe                    |   |
+        +----------------------------------+-+-------------------------------+---+
+        |   XLink-PCIe Remote Host driver  | | XLink-PCIe Local Host driver  |   |
+        +----------------------------------+-+-------------------------------+---+
+        |-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:|:|:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:|
+        +----------------------------------+-+-------------------------------+---+
+        |     PCIe Host Controller         | | PCIe Device Controller        | HW|
+        +----------------------------------+-+-------------------------------+---+
+               ^                                             ^
+               |                                             |
+               |------------- PCIe x2 Link  -----------------|
+
+This XLink PCIe driver comprises of two variants:
+* Local Host driver
+
+  * Intended for ARM CPU
+  * It is based on PCI Endpoint Framework
+  * Driver path: {tree}/drivers/misc/Xlink-pcie/local_host
+
+* Remote Host driver
+
+       * Intended for IA CPU
+       * It is a PCIe endpoint driver
+       * Driver path: {tree}/drivers/misc/Xlink-pcie/remote_host
+
+XLink PCIe communication between local host and remote host is achieved through
+ring buffer management and MSI/Doorbell interrupts.
+
+The Xlink-pcie driver subsystem registers the Keem Bay device as an endpoint
+driver and provides standard Linux PCIe sysfs interface:
+'/sys/bus/pci/devices/xxxx:xx:xx.0/'
+
+
+XLink protocol subsystem
+========================
+Xlink is an abstracted control and communication subsystem based on channel
+identification. It is intended to support VPU technology both at SoC level as
+well as at IP level, over multiple interfaces.
+
+- The Xlink subsystem abstracts several types of communication channels
+  underneath, allowing the usage of different interfaces with the
+  same function call interface.
+- The Communication channels are full-duplex protocol channels allowing
+  concurrent bidirectional communication.
+- The Xlink subsystem also supports control operations to VPU either
+  from standalone local system or from remote system based on communication
+  interface underneath.
+- The Xlink subsystem supports the following communication interfaces:
+    * USB CDC
+    * Gigabit Ethernet
+    * PCIe
+    * IPC
-- 
2.17.1


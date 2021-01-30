Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F779309382
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhA3Jhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:37:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:46340 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233495AbhA3DTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 22:19:33 -0500
IronPort-SDR: Txc6rGkn5vEh3Fal7g73pC5LMgCx10BhFxPljZcNHhoTPBeWb+i6ecnyzvf3JC9JZvK/dw/aJ/
 kCYXALegu7og==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="167606751"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="167606751"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:30 -0800
IronPort-SDR: uCEDT2GnF3wQnIyBErHsLo3IGdnX1vxud7Vm3jxxINc3ywBTCMcXAsntvZ38NnKSHx8jOJJ4e6
 LaywyRxOGJcg==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="352488066"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:29 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 534746365;
        Fri, 29 Jan 2021 18:21:29 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 479AF363652; Fri, 29 Jan 2021 18:21:29 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/34] Intel Vision Processing base enabling
Date:   Fri, 29 Jan 2021 18:20:50 -0800
Message-Id: <20210130022124.65083-36-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210130022124.65083-1-mgross@linux.intel.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Gross <mgross@linux.intel.com>

The Intel Vision Processing Unit (VPU) is an IP block that is showing up for
the first time as part of the Keem Bay SOC.  Keem Bay is a quad core A53 Arm
SOC.  It is designed to be used as a stand alone SOC as well as in an PCIe
Vision Processing accelerator add in card.

This forth version of this patch set includes updates to the dt yaml files and
some missed updates from feedback given on the V2 patch set for keembay-vpu-ipc
and the Kconfig for intel_tsens 

At the bottom of this coverletter is the delta between v2 and V3 for easy
review of the modifications.  Feels like things are converging. :)

Thanks for looking at these and providing feedback.

--mark


C, Udhayakumar (8):
  dt-bindings: misc: intel_tsens: Add tsens thermal bindings
    documentation
  misc: Tsens ARM host thermal driver.
  misc: Intel tsens IA host driver.
  Intel tsens i2c slave driver.
  misc:intel_tsens: Intel Keem Bay tsens driver.
  dt-bindings: misc: hddl_dev: Add hddl device management documentation
  misc: Hddl device management for local host
  misc: HDDL device management for IA host

Daniele Alessandrelli (4):
  dt-bindings: mailbox: Add Intel VPU IPC mailbox bindings
  mailbox: vpu-ipc-mailbox: Add support for Intel VPU IPC mailbox
  dt-bindings: Add bindings for Keem Bay IPC driver
  keembay-ipc: Add Keem Bay IPC module

Li, Tingqian (2):
  dt-bindings: misc: Add Keem Bay vpumgr
  misc: Add Keem Bay VPU manager

Paul Murphy (2):
  dt-bindings: Add bindings for Keem Bay VPU IPC driver
  keembay-vpu-ipc: Add Keem Bay VPU IPC module

Ramya P Karanth (1):
  Intel Keem Bay XLink SMBus driver

Seamus Kelly (7):
  xlink-ipc: Add xlink ipc device tree bindings
  xlink-ipc: Add xlink ipc driver
  xlink-core: Add xlink core device tree bindings
  xlink-core: Add xlink core driver xLink
  xlink-core: Enable xlink protocol over pcie
  xlink-core: Enable VPU IP management and runtime control
  xlink-core: add async channel and events

Srikanth Thokala (9):
  misc: xlink-pcie: Add documentation for XLink PCIe driver
  misc: xlink-pcie: lh: Add PCIe EPF driver for Local Host
  misc: xlink-pcie: lh: Add PCIe EP DMA functionality
  misc: xlink-pcie: lh: Add core communication logic
  misc: xlink-pcie: lh: Prepare changes for adding remote host driver
  misc: xlink-pcie: rh: Add PCIe EP driver for Remote Host
  misc: xlink-pcie: rh: Add core communication logic
  misc: xlink-pcie: Add XLink API interface
  misc: xlink-pcie: Add asynchronous event notification support for
    XLink

mark gross (1):
  Add Vision Processing Unit (VPU) documentation.

 .../mailbox/intel,vpu-ipc-mailbox.yaml        |   69 +
 .../bindings/misc/intel,hddl-client.yaml      |  114 +
 .../bindings/misc/intel,intel-tsens.yaml      |  118 +
 .../bindings/misc/intel,keembay-vpu-mgr.yaml  |   48 +
 .../misc/intel,keembay-xlink-ipc.yaml         |   51 +
 .../bindings/misc/intel,keembay-xlink.yaml    |   29 +
 .../bindings/soc/intel/intel,keembay-ipc.yaml |   45 +
 .../soc/intel/intel,keembay-vpu-ipc.yaml      |  143 ++
 Documentation/hwmon/index.rst                 |    2 +
 Documentation/hwmon/intel_tsens_host.rst      |   71 +
 Documentation/hwmon/intel_tsens_sensor.rst    |   67 +
 Documentation/i2c/busses/index.rst            |    1 +
 .../i2c/busses/intel-xlink-smbus.rst          |   71 +
 Documentation/index.rst                       |    1 +
 .../misc-devices/hddl_device_client.rst       |  212 ++
 .../misc-devices/hddl_device_server.rst       |  205 ++
 Documentation/misc-devices/index.rst          |    2 +
 Documentation/vpu/index.rst                   |   20 +
 Documentation/vpu/vpu-stack-overview.rst      |  270 +++
 Documentation/vpu/xlink-core.rst              |   81 +
 Documentation/vpu/xlink-ipc.rst               |   51 +
 Documentation/vpu/xlink-pcie.rst              |   90 +
 MAINTAINERS                                   |   54 +
 drivers/mailbox/Kconfig                       |   11 +
 drivers/mailbox/Makefile                      |    2 +
 drivers/mailbox/vpu-ipc-mailbox.c             |  297 +++
 drivers/misc/Kconfig                          |    7 +
 drivers/misc/Makefile                         |    7 +
 drivers/misc/hddl_device/Kconfig              |   26 +
 drivers/misc/hddl_device/Makefile             |    7 +
 drivers/misc/hddl_device/hddl_device.c        |  565 +++++
 drivers/misc/hddl_device/hddl_device_lh.c     |  764 +++++++
 drivers/misc/hddl_device/hddl_device_rh.c     |  837 +++++++
 drivers/misc/hddl_device/hddl_device_util.h   |   52 +
 drivers/misc/intel_tsens/Kconfig              |   54 +
 drivers/misc/intel_tsens/Makefile             |   10 +
 drivers/misc/intel_tsens/intel_tsens_host.c   |  351 +++
 drivers/misc/intel_tsens/intel_tsens_i2c.c    |  119 +
 .../misc/intel_tsens/intel_tsens_thermal.c    |  651 ++++++
 .../misc/intel_tsens/intel_tsens_thermal.h    |   38 +
 drivers/misc/intel_tsens/keembay_thermal.c    |  169 ++
 drivers/misc/intel_tsens/keembay_tsens.h      |  366 +++
 drivers/misc/vpumgr/Kconfig                   |    9 +
 drivers/misc/vpumgr/Makefile                  |    3 +
 drivers/misc/vpumgr/vpu_common.h              |   31 +
 drivers/misc/vpumgr/vpu_mgr.c                 |  370 +++
 drivers/misc/vpumgr/vpu_smm.c                 |  554 +++++
 drivers/misc/vpumgr/vpu_smm.h                 |   30 +
 drivers/misc/vpumgr/vpu_vcm.c                 |  584 +++++
 drivers/misc/vpumgr/vpu_vcm.h                 |   84 +
 drivers/misc/xlink-core/Kconfig               |   33 +
 drivers/misc/xlink-core/Makefile              |    5 +
 drivers/misc/xlink-core/xlink-core.c          | 1331 +++++++++++
 drivers/misc/xlink-core/xlink-core.h          |   25 +
 drivers/misc/xlink-core/xlink-defs.h          |  181 ++
 drivers/misc/xlink-core/xlink-dispatcher.c    |  436 ++++
 drivers/misc/xlink-core/xlink-dispatcher.h    |   26 +
 drivers/misc/xlink-core/xlink-ioctl.c         |  554 +++++
 drivers/misc/xlink-core/xlink-ioctl.h         |   36 +
 drivers/misc/xlink-core/xlink-multiplexer.c   | 1164 ++++++++++
 drivers/misc/xlink-core/xlink-multiplexer.h   |   35 +
 drivers/misc/xlink-core/xlink-platform.c      |  273 +++
 drivers/misc/xlink-core/xlink-platform.h      |   65 +
 drivers/misc/xlink-ipc/Kconfig                |    7 +
 drivers/misc/xlink-ipc/Makefile               |    4 +
 drivers/misc/xlink-ipc/xlink-ipc.c            |  878 +++++++
 drivers/misc/xlink-pcie/Kconfig               |   20 +
 drivers/misc/xlink-pcie/Makefile              |    2 +
 drivers/misc/xlink-pcie/common/core.h         |  245 ++
 drivers/misc/xlink-pcie/common/interface.c    |  124 +
 drivers/misc/xlink-pcie/common/util.c         |  373 +++
 drivers/misc/xlink-pcie/common/util.h         |   68 +
 drivers/misc/xlink-pcie/common/xpcie.h        |  100 +
 drivers/misc/xlink-pcie/local_host/Makefile   |    6 +
 drivers/misc/xlink-pcie/local_host/core.c     |  817 +++++++
 drivers/misc/xlink-pcie/local_host/dma.c      |  575 +++++
 drivers/misc/xlink-pcie/local_host/epf.c      |  482 ++++
 drivers/misc/xlink-pcie/local_host/epf.h      |  101 +
 drivers/misc/xlink-pcie/remote_host/Makefile  |    6 +
 drivers/misc/xlink-pcie/remote_host/core.c    |  621 +++++
 drivers/misc/xlink-pcie/remote_host/main.c    |   93 +
 drivers/misc/xlink-pcie/remote_host/pci.c     |  523 +++++
 drivers/misc/xlink-pcie/remote_host/pci.h     |   65 +
 drivers/misc/xlink-smbus/Kconfig              |   26 +
 drivers/misc/xlink-smbus/Makefile             |    5 +
 drivers/misc/xlink-smbus/xlink-smbus.c        |  467 ++++
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/intel/Kconfig                     |   33 +
 drivers/soc/intel/Makefile                    |    5 +
 drivers/soc/intel/keembay-ipc.c               | 1364 +++++++++++
 drivers/soc/intel/keembay-vpu-ipc.c           | 2026 +++++++++++++++++
 include/linux/hddl_device.h                   |  153 ++
 include/linux/intel_tsens_host.h              |   34 +
 include/linux/soc/intel/keembay-ipc.h         |   30 +
 include/linux/soc/intel/keembay-vpu-ipc.h     |   62 +
 include/linux/xlink-ipc.h                     |   48 +
 include/linux/xlink.h                         |  146 ++
 include/linux/xlink_drv_inf.h                 |   70 +
 include/uapi/misc/vpumgr.h                    |   64 +
 include/uapi/misc/xlink_uapi.h                |  145 ++
 101 files changed, 21767 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/intel,hddl-client.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/intel,intel-tsens.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
 create mode 100644 Documentation/hwmon/intel_tsens_host.rst
 create mode 100644 Documentation/hwmon/intel_tsens_sensor.rst
 create mode 100644 Documentation/i2c/busses/intel-xlink-smbus.rst
 create mode 100644 Documentation/misc-devices/hddl_device_client.rst
 create mode 100644 Documentation/misc-devices/hddl_device_server.rst
 create mode 100644 Documentation/vpu/index.rst
 create mode 100644 Documentation/vpu/vpu-stack-overview.rst
 create mode 100644 Documentation/vpu/xlink-core.rst
 create mode 100644 Documentation/vpu/xlink-ipc.rst
 create mode 100644 Documentation/vpu/xlink-pcie.rst
 create mode 100644 drivers/mailbox/vpu-ipc-mailbox.c
 create mode 100644 drivers/misc/hddl_device/Kconfig
 create mode 100644 drivers/misc/hddl_device/Makefile
 create mode 100644 drivers/misc/hddl_device/hddl_device.c
 create mode 100644 drivers/misc/hddl_device/hddl_device_lh.c
 create mode 100644 drivers/misc/hddl_device/hddl_device_rh.c
 create mode 100644 drivers/misc/hddl_device/hddl_device_util.h
 create mode 100644 drivers/misc/intel_tsens/Kconfig
 create mode 100644 drivers/misc/intel_tsens/Makefile
 create mode 100644 drivers/misc/intel_tsens/intel_tsens_host.c
 create mode 100644 drivers/misc/intel_tsens/intel_tsens_i2c.c
 create mode 100644 drivers/misc/intel_tsens/intel_tsens_thermal.c
 create mode 100644 drivers/misc/intel_tsens/intel_tsens_thermal.h
 create mode 100644 drivers/misc/intel_tsens/keembay_thermal.c
 create mode 100644 drivers/misc/intel_tsens/keembay_tsens.h
 create mode 100644 drivers/misc/vpumgr/Kconfig
 create mode 100644 drivers/misc/vpumgr/Makefile
 create mode 100644 drivers/misc/vpumgr/vpu_common.h
 create mode 100644 drivers/misc/vpumgr/vpu_mgr.c
 create mode 100644 drivers/misc/vpumgr/vpu_smm.c
 create mode 100644 drivers/misc/vpumgr/vpu_smm.h
 create mode 100644 drivers/misc/vpumgr/vpu_vcm.c
 create mode 100644 drivers/misc/vpumgr/vpu_vcm.h
 create mode 100644 drivers/misc/xlink-core/Kconfig
 create mode 100644 drivers/misc/xlink-core/Makefile
 create mode 100644 drivers/misc/xlink-core/xlink-core.c
 create mode 100644 drivers/misc/xlink-core/xlink-core.h
 create mode 100644 drivers/misc/xlink-core/xlink-defs.h
 create mode 100644 drivers/misc/xlink-core/xlink-dispatcher.c
 create mode 100644 drivers/misc/xlink-core/xlink-dispatcher.h
 create mode 100644 drivers/misc/xlink-core/xlink-ioctl.c
 create mode 100644 drivers/misc/xlink-core/xlink-ioctl.h
 create mode 100644 drivers/misc/xlink-core/xlink-multiplexer.c
 create mode 100644 drivers/misc/xlink-core/xlink-multiplexer.h
 create mode 100644 drivers/misc/xlink-core/xlink-platform.c
 create mode 100644 drivers/misc/xlink-core/xlink-platform.h
 create mode 100644 drivers/misc/xlink-ipc/Kconfig
 create mode 100644 drivers/misc/xlink-ipc/Makefile
 create mode 100644 drivers/misc/xlink-ipc/xlink-ipc.c
 create mode 100644 drivers/misc/xlink-pcie/Kconfig
 create mode 100644 drivers/misc/xlink-pcie/Makefile
 create mode 100644 drivers/misc/xlink-pcie/common/core.h
 create mode 100644 drivers/misc/xlink-pcie/common/interface.c
 create mode 100644 drivers/misc/xlink-pcie/common/util.c
 create mode 100644 drivers/misc/xlink-pcie/common/util.h
 create mode 100644 drivers/misc/xlink-pcie/common/xpcie.h
 create mode 100644 drivers/misc/xlink-pcie/local_host/Makefile
 create mode 100644 drivers/misc/xlink-pcie/local_host/core.c
 create mode 100644 drivers/misc/xlink-pcie/local_host/dma.c
 create mode 100644 drivers/misc/xlink-pcie/local_host/epf.c
 create mode 100644 drivers/misc/xlink-pcie/local_host/epf.h
 create mode 100644 drivers/misc/xlink-pcie/remote_host/Makefile
 create mode 100644 drivers/misc/xlink-pcie/remote_host/core.c
 create mode 100644 drivers/misc/xlink-pcie/remote_host/main.c
 create mode 100644 drivers/misc/xlink-pcie/remote_host/pci.c
 create mode 100644 drivers/misc/xlink-pcie/remote_host/pci.h
 create mode 100644 drivers/misc/xlink-smbus/Kconfig
 create mode 100644 drivers/misc/xlink-smbus/Makefile
 create mode 100644 drivers/misc/xlink-smbus/xlink-smbus.c
 create mode 100644 drivers/soc/intel/Kconfig
 create mode 100644 drivers/soc/intel/Makefile
 create mode 100644 drivers/soc/intel/keembay-ipc.c
 create mode 100644 drivers/soc/intel/keembay-vpu-ipc.c
 create mode 100644 include/linux/hddl_device.h
 create mode 100644 include/linux/intel_tsens_host.h
 create mode 100644 include/linux/soc/intel/keembay-ipc.h
 create mode 100644 include/linux/soc/intel/keembay-vpu-ipc.h
 create mode 100644 include/linux/xlink-ipc.h
 create mode 100644 include/linux/xlink.h
 create mode 100644 include/linux/xlink_drv_inf.h
 create mode 100644 include/uapi/misc/vpumgr.h
 create mode 100644 include/uapi/misc/xlink_uapi.h

-- 
2.17.1

diff --git a/Documentation/devicetree/bindings/misc/intel,intel-tsens.yaml b/Documentation/devicetree/bindings/misc/intel,intel-tsens.yaml
index abac41995643..2418355d9c47 100644
--- a/Documentation/devicetree/bindings/misc/intel,intel-tsens.yaml
+++ b/Documentation/devicetree/bindings/misc/intel,intel-tsens.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/misc/intel,intel_tsens.yaml#"
+$id: "http://devicetree.org/schemas/misc/intel,intel-tsens.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
 title: Intel Temperature sensors in Bay series
@@ -36,8 +36,6 @@ properties:
       - description: thermal sensor clock
 
   clk-rate:
-    minItems: 1
-    maxItems: 1
     additionalItems: false
     items:
       - description: thermal sensor clock freq
@@ -85,8 +83,6 @@ examples:
     tsens: tsens@20260000 {
         compatible = "intel,intel-tsens";
         status = "disabled";
-        #address-cells = <2>;
-        #size-cells = <2>;
         plat_name = "intel,keembay_thermal";
         reg = <0x0 0x20260000 0x0 0x100>;
         clocks = <&scmi_clk>;
diff --git a/Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml b/Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml
index 7fad14274ee2..a44f492277ab 100644
--- a/Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml
+++ b/Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml
@@ -19,8 +19,8 @@ properties:
   compatible:
     items:
       - enum:
-        - intel,keembay-vpu-mgr
-        - intel,keembay-vpusmm
+          - intel,keembay-vpu-mgr
+          - intel,keembay-vpusmm
 
   memory-region:
     description:
diff --git a/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml b/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
index 699e43c4cd40..70a3061d024d 100644
--- a/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
+++ b/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
@@ -18,7 +18,7 @@ properties:
   compatible:
     oneOf:
       - items:
-        - const: intel,keembay-xlink-ipc
+          - const: intel,keembay-xlink-ipc
 
   memory-region:
     items:
@@ -37,6 +37,8 @@ properties:
     $ref: "/schemas/types.yaml#/definitions/phandle"
     description: reference to the corresponding intel,keembay-vpu-ipc node.
 
+additionalProperties: False
+
 examples:
   - |
     xlink-ipc {
diff --git a/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml b/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
index 89c34018fa04..5ac2e7fa5b5e 100644
--- a/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
+++ b/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
@@ -18,7 +18,9 @@ properties:
   compatible:
     oneOf:
       - items:
-        - const: intel,keembay-xlink
+          - const: intel,keembay-xlink
+
+additionalProperties: False
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml b/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
index cd1c4abe8bc9..9dae8ab4c723 100644
--- a/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
+++ b/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
@@ -9,16 +9,21 @@ title: Intel Keem Bay VPU IPC
 
 maintainers:
   - Paul Murphy <paul.j.murphy@intel.com>
+  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
 
 description:
-  The VPU IPC driver facilitates loading of firmware, control, and communication
-  with the VPU over the IPC FIFO in the Intel Keem Bay SoC.
+  This binding provides support for the Vision Processing Unit (VPU) found on
+  the Intel Keem Bay SoC.
+
+  The VPU is started and controlled by SoC CPU, which is in charge of loading
+  the VPU firmware. The SoC CPU can communicate with the VPU firmware using an
+  Inter-Processor Communication (IPC) mechanism.
 
 properties:
   compatible:
     oneOf:
       - items:
-        - const: intel,keembay-vpu-ipc
+          - const: intel,keembay-vpu-ipc
 
   reg:
     items:
@@ -82,24 +87,11 @@ properties:
       - const: nce_wdt
       - const: mss_wdt
 
-  intel,keembay-vpu-ipc-nce-wdt-redirect:
-    $ref: "/schemas/types.yaml#/definitions/uint32"
-    description:
-      Number to which we will request that the NCE sub-system
-      re-directs it's WDT timeout IRQ
-
-  intel,keembay-vpu-ipc-mss-wdt-redirect:
-    $ref: "/schemas/types.yaml#/definitions/uint32"
-    description:
-      Number to which we will request that the MSS sub-system
-      re-directs it's WDT timeout IRQ
-
   intel,keembay-vpu-ipc-imr:
     $ref: "/schemas/types.yaml#/definitions/uint32"
     description:
-      IMR (isolated memory region) number which we will request
-      the runtime service uses to protect the VPU memory region
-      before authentication
+      Isolated Memory Region (IMR) number that the runtime service must use to
+      protect the VPU memory region before authentication.
 
   intel,keembay-vpu-ipc-id:
     $ref: "/schemas/types.yaml#/definitions/uint32"
@@ -146,8 +138,6 @@ examples:
         interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-names = "nce_wdt", "mss_wdt";
-        intel,keembay-vpu-ipc-nce-wdt-redirect = <63>;
-        intel,keembay-vpu-ipc-mss-wdt-redirect = <47>;
         intel,keembay-vpu-ipc-imr = <9>;
         intel,keembay-vpu-ipc-id = <0>;
     };
diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
index bd575d99281d..5cfe6b4004e5 100644
--- a/drivers/misc/intel_tsens/Kconfig
+++ b/drivers/misc/intel_tsens/Kconfig
@@ -17,8 +17,7 @@ config INTEL_TSENS_LOCAL_HOST
 config INTEL_TSENS_I2C_SLAVE
 	bool "I2C slave driver for intel tsens"
 	depends on INTEL_TSENS_LOCAL_HOST
-	select I2C
-	select I2C_SLAVE
+	depends on I2C=y && I2C_SLAVE
 	help
 	  This option enables tsens I2C slave driver.
 
diff --git a/drivers/soc/intel/keembay-vpu-ipc.c b/drivers/soc/intel/keembay-vpu-ipc.c
index 31b880195cac..8f3d6a466629 100644
--- a/drivers/soc/intel/keembay-vpu-ipc.c
+++ b/drivers/soc/intel/keembay-vpu-ipc.c
@@ -81,6 +81,7 @@
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
@@ -175,6 +176,13 @@
 /* SoC stepping length, in bytes. */
 #define SOC_INFO_STEPPING_BYTES		2
 
+/*
+ * The offset to convert the HW IRQ reported by irqd_to_hwirq() to the GIC_SPI
+ * IRQ number specified in the device tree:
+ * GIC_SPI x = irqd_to_hwirq() - 32
+ */
+#define GIC_SPI_HWIRQ_OFFSET		32
+
 /**
  * struct boot_parameters - Boot parameters passed to the VPU.
  * @magic_number:		Magic number to indicate structure populated
@@ -315,8 +323,6 @@ struct atf_mem {
  *			the NCE WDT timeout interrupt.
  * @mss_irq:		IRQ number of the A53 re-direct IRQ which will be used
  *			for receiving the MSS WDT timeout interrupt.
- * @nce_wdt_redirect:   Re-direct IRQ for NCE ICB.
- * @mss_wdt_redirect:	Re-direct IRQ for MSS ICB.
  * @imr:		Isolated Memory Region (IMR) to be used to protect the
  *			loaded VPU firmware.
  * @vpu_id:		The ID of the VPU associated with this device.
@@ -349,8 +355,6 @@ struct vpu_ipc_dev {
 	struct clk *pll[NUM_PLLS][NUM_PLL_OUTPUTS];
 	int nce_irq;
 	int mss_irq;
-	u32 nce_wdt_redirect;
-	u32 mss_wdt_redirect;
 	u32 imr;
 	u32 vpu_id;
 	void __iomem *nce_wdt_reg;
@@ -897,22 +901,6 @@ static int setup_watchdog_resources(struct vpu_ipc_dev *vpu_dev)
 		return rc;
 	}
 
-	/* Request interrupt re-direct numbers */
-	rc = of_property_read_u32(dev->of_node,
-				  "intel,keembay-vpu-ipc-nce-wdt-redirect",
-				  &vpu_dev->nce_wdt_redirect);
-	if (rc) {
-		dev_err(dev, "failed to get NCE WDT redirect number.\n");
-		return rc;
-	}
-	rc = of_property_read_u32(dev->of_node,
-				  "intel,keembay-vpu-ipc-mss-wdt-redirect",
-				  &vpu_dev->mss_wdt_redirect);
-	if (rc) {
-		dev_err(dev, "failed to get MSS WDT redirect number.\n");
-		return rc;
-	}
-
 	return 0;
 }
 
@@ -956,9 +944,11 @@ static int setup_boot_parameters(struct vpu_ipc_dev *vpu_dev)
 
 	/* Fill in IRQ re-direct request information */
 	vpu_dev->boot_params->mss_wdt_to_irq_a53_redir =
-		vpu_dev->mss_wdt_redirect;
+			irqd_to_hwirq(irq_get_irq_data(vpu_dev->mss_irq)) -
+			GIC_SPI_HWIRQ_OFFSET;
 	vpu_dev->boot_params->nce_wdt_to_irq_a53_redir =
-		vpu_dev->nce_wdt_redirect;
+			irqd_to_hwirq(irq_get_irq_data(vpu_dev->nce_irq)) -
+			GIC_SPI_HWIRQ_OFFSET;
 
 	/* Setup A53SS_VERSION_ID */
 	vpu_dev->boot_params->a53ss_version_id = vpu_ipc_soc_info->hardware_id;


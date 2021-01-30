Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676093093FF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhA3KGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:06:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:15844 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233201AbhA3Crl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 21:47:41 -0500
IronPort-SDR: xpRrQB623TiPd4lU81lHxe8xt7cE7kC/ACr+KUl9IrJ2bqW+GemXjh1KuFgEqLypY6LZJAf1AC
 SoOWNNsAQGRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="265339387"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="265339387"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:29 -0800
IronPort-SDR: P9ZmE7JGjTYrIQ81VVKTKZr+Mg85Vs/t/unOsZqLL6s2IJyN1H1XmQooBWzG2IstcWWf08BRGZ
 kOaJTHKnl6Rw==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="354867496"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:28 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 6A291636B;
        Fri, 29 Jan 2021 18:21:29 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 5EB37363654; Fri, 29 Jan 2021 18:21:29 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 02/34] dt-bindings: mailbox: Add Intel VPU IPC mailbox bindings
Date:   Fri, 29 Jan 2021 18:20:52 -0800
Message-Id: <20210130022124.65083-38-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210130022124.65083-1-mgross@linux.intel.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add bindings for the Intel VPU IPC mailbox driver.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Signed-off-by: Mark Gross <mgross@linux.intel.com>
---
 .../mailbox/intel,vpu-ipc-mailbox.yaml        | 69 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
new file mode 100644
index 000000000000..923a6d619a64
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2020 Intel Corporation
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mailbox/intel,vpu-ipc-mailbox.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel VPU IPC mailbox
+
+maintainers:
+  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+
+description: |
+  Intel VPU SoCs like Keem Bay have hardware FIFOs to enable Inter-Processor
+  Communication (IPC) between the CPU and the VPU.
+
+  Specifically, there is one HW FIFO for the CPU (aka Application Processor -
+  AP) and one for the VPU. Each FIFO can hold 128 entries of 32 bits each. A
+  "FIFO-not-empty" interrupt is raised every time there is at least a message
+  in the FIFO. The CPU FIFO raises interrupts to the CPU, while the VPU FIFO
+  raises interrupts to VPU. When the CPU wants to send a message to the VPU it
+  writes to the VPU FIFO, similarly, when the VPU want to send a message to the
+  CPU, it writes to the CPU FIFO.
+
+  Refer to ./mailbox.txt for generic information about mailbox device-tree
+  bindings.
+
+properties:
+  compatible:
+    const: intel,vpu-ipc-mailbox
+
+  reg:
+    items:
+      - description: The CPU FIFO registers
+      - description: The VPU FIFO registers
+
+  reg-names:
+    items:
+      - const: cpu_fifo
+      - const: vpu_fifo
+
+  interrupts:
+    items:
+      - description: CPU FIFO-not-empty interrupt
+
+  "#mbox-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    vpu_ipc_mailbox@203300f0 {
+        compatible = "intel,vpu-ipc-mailbox";
+        #mbox-cells = <1>;
+        reg = <0x203300f0 0x310>,
+              <0x208200f0 0x310>;
+        reg-names = "cpu_fifo", "vpu_fifo";
+        interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 992fe3b0900a..2b82526a00dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9181,6 +9181,12 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel-vbtn.c
 
+INTEL VPU IPC MAILBOX
+M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+M:	Mark Gross <mgross@linux.intel.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
+
 INTEL WIRELESS 3945ABG/BG, 4965AGN (iwlegacy)
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
 L:	linux-wireless@vger.kernel.org
-- 
2.17.1


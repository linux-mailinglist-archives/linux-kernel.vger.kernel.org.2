Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C563CBE7D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 23:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhGPV3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 17:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbhGPV32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 17:29:28 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37022C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 14:26:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id y4so11179601pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCqUTi8QcukAsDM3Vsuvdl4VskaTFVpSG5W8yb85NDw=;
        b=tIqcqbTFITCM7wJXjOAAfgB4xlmdCnJmxoVkI9m8fH2UI2C/njH7XUVOMm7m/bD2Fm
         VFaXN1AZJiZaZfUQFJdXMWRzMyk3AAkiYR/5L/WMUic7Vv5/F398pJK0n9qKVP84UDp9
         RlJc9ZyfnrgRqRBxf7npytUw5RzIfOtHuRqL3VZZIbtNKsGNyJhfjuPbikpzOF6u7dGk
         ixaylMqdSR7yMv4rsFVV4V7f8OrsuUAeZzkY6aLpHTKKQGXwYGU9TGQoEtO732teYolq
         /LENmIH6OS2eTd8i/QAVHgc8SoeA7nvL02R0SkeXpwC7IjG8kniVby9lATUFxcvIK1Zy
         e3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCqUTi8QcukAsDM3Vsuvdl4VskaTFVpSG5W8yb85NDw=;
        b=Ddk417ejb8jr6TGYL30r74fAAhtTZ7HP66dtwpw1SYCXgegvaGyhcwC4sRs8yxtZOm
         zPuirPlBrtSWLeoCbntXtjil53OoD0MvvnvmvsCw98plRw6AlNAlhIvv3oDU4epo6tvh
         5/9mu4RoU+pc/pT8gQikV+mVMFDbh/+uhQWAqfSbswqLsdED2xnT9kpFp9nlX/8nZ+v+
         GPk33QAaE2rEHP1pkCZhqxvuie4KZhruXkifpaBSKC8IqGE9WCe0wTyRHCny2A8ioSRA
         lQBu2TnDIM/cJRCbfXKWvlY6GyLs0p6vGXeO9Odd4HV2+QGMBIKRkjGbb7ELOqElB+jt
         /8dg==
X-Gm-Message-State: AOAM5310tgVmZ1GKR133JdqHQYwEXts7pf8HdQDrtiZq4VygclvBAu9m
        3nyJDJbmCv6a3LIznEL9ChsJ
X-Google-Smtp-Source: ABdhPJx9xtvMcX3jBpgIvGlxFveWMRzxMi++Dl5S+qGFQNrUZgmXfTJQaWh9yftp4BaiAPH5ugukug==
X-Received: by 2002:a65:5c89:: with SMTP id a9mr11856102pgt.207.1626470791710;
        Fri, 16 Jul 2021 14:26:31 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id k10sm10772475pfc.169.2021.07.16.14.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 14:26:31 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     robh+dt@kernel.org, michal.simek@xilinx.com, mdf@kernel.org,
        trix@redhat.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        navam@xilinx.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH v2] dt-bindings: fpga: convert Xilinx Zynq MPSoC bindings to YAML
Date:   Sat, 17 Jul 2021 06:26:21 +0900
Message-Id: <20210716212621.286806-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FPGA Manager for Xilinx Zynq MPSoC bindings documentation to
YAML.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

---
v2:
  - Fix to the correct maintainer 'Nava kishore Manne <navam@xilinx.com>'.
  - Update the word from configuration to Configuration.

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 25 -------------
 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml  | 36 +++++++++++++++++++
 2 files changed, 36 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
deleted file mode 100644
index 3052bf619dd547..00000000000000
--- a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.
-The ZynqMP SoC uses the PCAP (Processor configuration Port) to configure the
-Programmable Logic (PL). The configuration uses  the firmware interface.
-
-Required properties:
-- compatible: should contain "xlnx,zynqmp-pcap-fpga"
-
-Example for full FPGA configuration:
-
-	fpga-region0 {
-		compatible = "fpga-region";
-		fpga-mgr = <&zynqmp_pcap>;
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
-	};
-
-	firmware {
-		zynqmp_firmware: zynqmp-firmware {
-			compatible = "xlnx,zynqmp-firmware";
-			method = "smc";
-			zynqmp_pcap: pcap {
-				compatible = "xlnx,zynqmp-pcap-fpga";
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
new file mode 100644
index 00000000000000..6cd2bdc06b5fef
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq Ultrascale MPSoC FPGA Manager Device Tree Bindings
+
+maintainers:
+  - Nava kishore Manne <navam@xilinx.com>
+
+description: |
+  Device Tree Bindings for Zynq Ultrascale MPSoC FPGA Manager.
+  The ZynqMP SoC uses the PCAP (Processor Configuration Port) to
+  configure the Programmable Logic (PL). The configuration uses the
+  firmware interface.
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-pcap-fpga
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      zynqmp_firmware: zynqmp-firmware {
+        zynqmp_pcap: pcap {
+          compatible = "xlnx,zynqmp-pcap-fpga";
+        };
+      };
+    };
+...
-- 
2.32.0


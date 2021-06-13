Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931AC3A5A9F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 23:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhFMVb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 17:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhFMVbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 17:31:25 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E829EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 14:29:23 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g22so2002998pgk.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+U5yHEUqdMTROj7uMRwfEteYut+EmPEud6gYJLYiFQ=;
        b=sgY/Idbxj8Sp5P11pa+MocZHR0W9u/r4+nJ5n/DikJczLPMbCsbm/Ym0rxJ0NAtKmP
         XKlAjuN7WIrjP8qdgh8beks0junSpWFtWqaBrUKLLYuwDvt5YtnKKpc89NoJ1JcElfqk
         8yTq2B+6UrVvPxLy+zVT1fUP/PNqIGu/nxstx+C/Qr+NZRnRK45EpnnK9qR6BcDNemn7
         qczobuBjEtx6yFsWFw19N81CyZCeejGA8du4L2xAk/JGaS3piHM4qps1Dmatv47wxZR6
         4ZJQR3qUf7Q4lkRj1Vk9d4sj8hnHu1oJ8lOm4ASxSE/k7IXm65omhfn1/kOTAUi6DBdA
         Bz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+U5yHEUqdMTROj7uMRwfEteYut+EmPEud6gYJLYiFQ=;
        b=bajZdeal0l6z5B0a5imd9Sq63rojUquWewL5lPccoU6WFFXl90hW08wVLCURhzRB6n
         YrXkzrlmSmND2SErG9btFjjRJWxxAzPhV1czmHC8iHcJsJLpfmq0luY8t0E9DN2BbYKw
         US9dopz8URF/6HXouuhaQ2AKgSeJaWywOnFlzw0dRqlpMaJlnr0eYrP+etNv7q1ZH3Pb
         aaaW6MEbR7kJ6x9v8xkC+L9vTEohBLcC5AY6kkMlukY5POZbiJvPGcObdvYi/X4pT9oN
         T3zFzmdoDzu852Ch+lejkEFRE9fR392FaKl7KXzGV51DBC+amYynmGAUIdzcpa2KceZA
         Wz7A==
X-Gm-Message-State: AOAM530NZFesFkEt1aLTUHUf8KoJTPwFQrUdnTFoXmR5D2Ns8kYktXLp
        NLlaV2pdIwQ8qSzMCS2xDx1v
X-Google-Smtp-Source: ABdhPJxmr/Hrz/E4RLtlhawcGS+HmW1ekreB0+nEtYZjD40aH5KGF5t8/d6QgcB06neLtxja2+pWsw==
X-Received: by 2002:a63:6e09:: with SMTP id j9mr14063297pgc.275.1623619763290;
        Sun, 13 Jun 2021 14:29:23 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id k21sm10609804pgb.56.2021.06.13.14.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 14:29:22 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     robh@kernel.org, moritz.fischer@ettus.com, michal.simek@xilinx.com,
        trix@redhat.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] dt-bindings: fpga: zynq: convert bindings to YAML
Date:   Mon, 14 Jun 2021 06:28:56 +0900
Message-Id: <20210613212856.296153-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FPGA for Xilinx Zynq SoC bindings documentation to YAML.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 .../bindings/fpga/xilinx-zynq-fpga-mgr.txt    | 19 -------
 .../bindings/fpga/xilinx-zynq-fpga-mgr.yaml   | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
deleted file mode 100644
index 7018aa89683591..00000000000000
--- a/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Xilinx Zynq FPGA Manager
-
-Required properties:
-- compatible:		should contain "xlnx,zynq-devcfg-1.0"
-- reg:			base address and size for memory mapped io
-- interrupts:		interrupt for the FPGA manager device
-- clocks:		phandle for clocks required operation
-- clock-names:		name for the clock, should be "ref_clk"
-- syscon:		phandle for access to SLCR registers
-
-Example:
-	devcfg: devcfg@f8007000 {
-		compatible = "xlnx,zynq-devcfg-1.0";
-		reg = <0xf8007000 0x100>;
-		interrupts = <0 8 4>;
-		clocks = <&clkc 12>;
-		clock-names = "ref_clk";
-		syscon = <&slcr>;
-	};
diff --git a/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml
new file mode 100644
index 00000000000000..29daca4be47fcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xilinx-zynq-fpga-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq FPGA Manager Device Tree Bindings
+
+maintainers:
+  - Michal Simek <michal.simek@xilinx.com>
+
+properties:
+  compatible:
+    const: xlnx,zynq-devcfg-1.0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ref_clk
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to syscon block which provide access to SLCR registers
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    devcfg: devcfg@f8007000 {
+      compatible = "xlnx,zynq-devcfg-1.0";
+      reg = <0xf8007000 0x100>;
+      interrupts = <0 8 4>;
+      clocks = <&clkc 12>;
+      clock-names = "ref_clk";
+      syscon = <&slcr>;
+    };
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E17E3954FC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 07:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEaFXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 01:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhEaFXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 01:23:30 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4564C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 22:21:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z26so4157622pfj.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 22:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E3q0ltUCFlSFseFjGj/1JuyMtl0G1U7pcNWroIzsbf8=;
        b=p1vx7rRbhioTXeIw85nkmMjInDyqreY9bHa5TuENc4iYfontBGckFW11pHqbBGmFlA
         VsvyzHohQTLr3Xlgqsf0nmlkRdTH0yvTW7xBKqhsG9rmw9jDfLoKIZGGwd2TtUKim3tJ
         Sp0FDcS+Rtp9wlK1yAxjjLkXgysgrogQ8VVVCuZf/A/2RjcXTuI7loCo1yjVTQyoTUol
         klGs+rXLKNTN7TmmGb5lkC71s2/prsiNK1ZB/GO6v1lEQy5yoGdnTdUy5pjnkN5wZXe0
         +Ktq+blfteTSnoJni50AwSFRuyh5FfjkEoOCX7LBl2AqAQy2Ys6g2o36LS/qi1l+6SCZ
         fyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E3q0ltUCFlSFseFjGj/1JuyMtl0G1U7pcNWroIzsbf8=;
        b=aBr7QI1LnDZck8LLms9DINiU+O5wcxXk8ID2yEeLpHUjml7JwmD4i2pvEytqRx0q7w
         /Jbneao+S4p8gx6bWDdXUfp8DuRTcD0Gb9V1tPM6IsbwSXenkta0t3rPD9X72aIfJBnu
         aJsEjIq5uemYW9p+NSqO+4xGoMN+3vtV/F1UP4UeWFyunG6WsyMI6v1qWxB1vMeXqbGi
         R8Tm2YtQjXChsIkOZPegc7qBx8v3alSgLK+sVGZ6Yisl2k3Y0L+XE+IAEJbBrD79WG98
         D9KhxiwU//KIRiNuMJoGvbQcLpmoZ77dIiLqWL1z0tVc6c8babNQ808nUzOJ8S2LK4w1
         LemA==
X-Gm-Message-State: AOAM532jGlrg+0wRwJgtGhMBh0K6+J4nhgPoyZ5VORBXIAdfp0JMKJO2
        Gy9ovGoNz5L6h+ILTX0FbTFD
X-Google-Smtp-Source: ABdhPJx13Hy5iHnn4j54rkqO+jQQvuruShVRfadlrgD/A/1CxNcr3mqofJZ1qsW46Uu67C8P80c+wA==
X-Received: by 2002:a65:5c4a:: with SMTP id v10mr21009984pgr.142.1622438508391;
        Sun, 30 May 2021 22:21:48 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id t12sm2898165pfc.133.2021.05.30.22.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 22:21:47 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] dt-bindings: spi: xilinx: convert to yaml
Date:   Mon, 31 May 2021 14:21:42 +0900
Message-Id: <20210531052142.695430-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert SPI for Xilinx bindings documentation to YAML schemas.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 .../devicetree/bindings/spi/spi-xilinx.txt    | 23 ---------
 .../devicetree/bindings/spi/spi-xilinx.yaml   | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-xilinx.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-xilinx.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
deleted file mode 100644
index 5f4ed3e5c9942c..00000000000000
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Xilinx SPI controller Device Tree Bindings
--------------------------------------------------
-
-Required properties:
-- compatible		: Should be "xlnx,xps-spi-2.00.a", "xlnx,xps-spi-2.00.b" or "xlnx,axi-quad-spi-1.00.a"
-- reg			: Physical base address and size of SPI registers map.
-- interrupts		: Property with a value describing the interrupt
-			  number.
-
-Optional properties:
-- xlnx,num-ss-bits	 : Number of chip selects used.
-- xlnx,num-transfer-bits : Number of bits per transfer. This will be 8 if not specified
-
-Example:
-	axi_quad_spi@41e00000 {
-			compatible = "xlnx,xps-spi-2.00.a";
-			interrupt-parent = <&intc>;
-			interrupts = <0 31 1>;
-			reg = <0x41e00000 0x10000>;
-			xlnx,num-ss-bits = <0x1>;
-			xlnx,num-transfer-bits = <32>;
-	};
-
diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
new file mode 100644
index 00000000000000..17463151b36a02
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-xilinx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx SPI controller Device Tree Bindings
+
+maintainers:
+  - Michal Simek <michal.simek@xilinx.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - const: xlnx,xps-spi-2.00.a
+      - const: xlnx,xps-spi-2.00.b
+      - const: xlnx,axi-quad-spi-1.00.a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  xlnx,num-ss-bits:
+    description: Number of chip selects used.
+
+  xlnx,num-transfer-bits:
+    description: Number of bits per transfer. This will be 8 if not specified.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi0: spi@41e00000 {
+      compatible = "xlnx,xps-spi-2.00.a";
+      interrupt-parent = <&intc>;
+      interrupts = <0 31 1>;
+      reg = <0x41e00000 0x10000>;
+      xlnx,num-ss-bits = <0x1>;
+      xlnx,num-transfer-bits = <32>;
+    };
+...
-- 
2.30.0


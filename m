Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7983A5A6C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhFMUtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:49:06 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:40757 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhFMUtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:49:02 -0400
Received: by mail-pg1-f171.google.com with SMTP id m2so317827pgk.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hj6PxG9Uu38xsSuh/hPwTGIxfZIdP7m3pLuGKjMI4Ig=;
        b=bmu2JThxVHAxXOKEYhsFEtuH0nryHuVmYu4OmNnz+kZZWdpYhkWRc2E6+JxoadL7dt
         2RbYeGwq0TA/zqWtVfOrLWuziOLWAsjYdJ4ajxfi7s7wxW7PWFmO9H/i2YxE7GIQFb8m
         t88txhMBaBgPrkVc77atYDYUM2cx6EeSQWO32R5hX0fF7r+MV3FFncfZLuZq2Nk6TqXS
         mIT7kmINjqLUpFEaaUwojPFAmIwXVyxAxWPN0JWtzvFbYz9pWXm0V6kLyQlnOjFL30iK
         6iwoooocEtD888TmW/lxUiv+JSYIhHILQl/NvBHTxNhWN/tPAUU2cATvJiZp1e/d5tdX
         wJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hj6PxG9Uu38xsSuh/hPwTGIxfZIdP7m3pLuGKjMI4Ig=;
        b=FjWWvZjnFprrk98Cl6kUY6iHAwQWxgZ2ISq6UEHkeLzJo52EYdlNdRWItSKFRoJ2gc
         luHq7V4YckS9M5DCV8rzmk+rBearXENQcwP2CrPM3w32aFJrsXptxAU1mbFrtKPB69Eh
         7Lh2L4hhQyiXIzcZ135Fsop4GYt2ShPIURyz2GaWD9Rgoyy/b6dNDYsFSXq2QjV+Sx7r
         JawT/3hSBayVHft16d+adqC+aqOVMRaekMpcarR11dz4125pGSJMkdveIg25xhmvUhn0
         MqGpPMWSR+di9MaroBV5epLA0ycIReoNNUEJ0BwGbfXtnYpaLt8bEnzVxZr2QcDfQ2qU
         MDIg==
X-Gm-Message-State: AOAM531ChZlNmXpYjGkTbqkfwY0GMwMHs2kqjvxZR6jOz9TWLEdkR2qW
        4CNikycwscgYYrg34BEL7qyvJb/2B4Pgmt0=
X-Google-Smtp-Source: ABdhPJySEgrWjFdxISwelgWe5aaaq9/MjvjjsiLJBt9wbvsLwYM8vvx3QL1cWls+noKMXLzqTlO/Pw==
X-Received: by 2002:a62:ea1a:0:b029:2ec:9146:30be with SMTP id t26-20020a62ea1a0000b02902ec914630bemr18700202pfh.29.1623617145141;
        Sun, 13 Jun 2021 13:45:45 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id iq15sm14651277pjb.53.2021.06.13.13.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 13:45:44 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     michal.simek@xilinx.com, mturquette@baylibre.com, robh@kernel.org,
        sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH v3] dt-bindings: rtc: zynqmp: convert bindings to YAML
Date:   Mon, 14 Jun 2021 05:45:32 +0900
Message-Id: <20210613204532.291512-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Real Time Clock for Xilinx Zynq MPSoC SoC bindings documentation
to YAML schemas.
And this renamed the file to compatible string of DT.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
v3: Fix description.
    Add $refs to calibration property.
    Add minimum, maximum and default to calibration property.
v2: Fix warning with DT_CHECKER_FLAGS=-m

 .../bindings/rtc/xlnx,zynqmp-rtc.yaml         | 65 +++++++++++++++++++
 .../devicetree/bindings/rtc/xlnx-rtc.txt      | 25 -------
 2 files changed, 65 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/xlnx-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
new file mode 100644
index 00000000000000..bdb72d3ddf2a93
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/xlnx,zynqmp-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq Ultrascale+ MPSoC Real Time Clock
+
+description:
+  RTC controller for the Xilinx Zynq MPSoC Real Time Clock.
+  The RTC controller has separate IRQ lines for seconds and alarm.
+
+maintainers:
+  - Michal Simek <michal.simek@xilinx.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+
+  interrupt-names:
+    items:
+      - const: alarm
+      - const: sec
+
+  calibration:
+    description: |
+      calibration value for 1 sec period which will
+      be programmed directly to calibration register.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x1
+    maximum: 0x1FFFFF
+    default: 0x198233
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      rtc: rtc@ffa60000 {
+        compatible = "xlnx,zynqmp-rtc";
+        reg = <0x0 0xffa60000 0x0 0x100>;
+        interrupt-parent = <&gic>;
+        interrupts = <0 26 4>, <0 27 4>;
+        interrupt-names = "alarm", "sec";
+        calibration = <0x198233>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt b/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
deleted file mode 100644
index 0df6f016b1b771..00000000000000
--- a/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* Xilinx Zynq Ultrascale+ MPSoC Real Time Clock
-
-RTC controller for the Xilinx Zynq MPSoC Real Time Clock
-Separate IRQ lines for seconds and alarm
-
-Required properties:
-- compatible: Should be "xlnx,zynqmp-rtc"
-- reg: Physical base address of the controller and length
-       of memory mapped region.
-- interrupts: IRQ lines for the RTC.
-- interrupt-names: interrupt line names eg. "sec" "alarm"
-
-Optional:
-- calibration: calibration value for 1 sec period which will
-		be programmed directly to calibration register
-
-Example:
-rtc: rtc@ffa60000 {
-	compatible = "xlnx,zynqmp-rtc";
-	reg = <0x0 0xffa60000 0x100>;
-	interrupt-parent = <&gic>;
-	interrupts = <0 26 4>, <0 27 4>;
-	interrupt-names = "alarm", "sec";
-	calibration = <0x198233>;
-};
-- 
2.32.0


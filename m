Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B921D3A5A73
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhFMUwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhFMUwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:52:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4969C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 13:50:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k22-20020a17090aef16b0290163512accedso9435231pjz.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 13:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hj6PxG9Uu38xsSuh/hPwTGIxfZIdP7m3pLuGKjMI4Ig=;
        b=mwXVVLB90/gQt17r0SmRD3NCA1LSGQ9lYDRT4es14qQWrN8t1CedXYywJJ92B4DG/O
         081kJCAGNs6l5OWxj319TpXx/u3FUc5Yuf/zxR/mbOdkUj5rve3p7DlMLWcdNIDbUYLz
         I8PXWjtNW6kED/8QAcYbG6C8WpgIx8ij3VyBT0CDbWrtBbCBFy/2yu2SvY5/sIhYJlm8
         CMIR3GgNMAf+hGVB03QYIWhE3JUcWDFu93mUepG2ENUnUvy7oTDFeKEvw2oK2jOAovDf
         BijJsPAfDKaYlfJStl4n9RLsRuDrsvXt00cZquhcTNHz+eBvJ9KXZoU6H+SBk7aqm0u1
         5lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hj6PxG9Uu38xsSuh/hPwTGIxfZIdP7m3pLuGKjMI4Ig=;
        b=SfklasAzPvmPhU8aoOil9mc6EW5mmEcJQWXakpfvXfjAb92mlvTBC+FEmzMdVQKjTP
         uZrFkeaMILX6RRkUdNHl0f8FbvGCS3lqh8TcCDh0nR1EP1/gFWDZ2pDHVw4hi3AuUZfK
         rgOo58RLNd4RcCoH+LpoR2tzncsHEtjtG/o3jskWlYRxgYXbsTWbyHWJpIJO/OyRQVr/
         EHGLrwpJuEyy9iETfKIKvv5sAW1gdEWZPgv45CRjaRBQSuwr8sRroOtgGmbns6mCKe0B
         zTc6SkRPlRxXSORxXVCvOfkegd8oFRrBZiUtHsKOb5SUACTVnqiKN63+Af9ersEp7zAH
         LsoQ==
X-Gm-Message-State: AOAM531wKdX58NjEPHq4+efKhR9Xa9Lgum59Yqsa8+hhEngbgo1iW7ga
        popH0EUamIG9wTHDqJUHPo7g
X-Google-Smtp-Source: ABdhPJzR0RqnjUDAD8TPWM4Ru3po1fe+dl5FA/QfSsiGQXlnOQZgkLt17y1WJ5ATp2FD+cI1FPgtPQ==
X-Received: by 2002:a17:903:2311:b029:115:29a9:a3ee with SMTP id d17-20020a1709032311b029011529a9a3eemr13557169plh.46.1623617428389;
        Sun, 13 Jun 2021 13:50:28 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id y3sm6986615pgr.46.2021.06.13.13.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 13:50:27 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     robh@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, michal.simek@xilinx.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH v3 resend] dt-bindings: rtc: zynqmp: convert bindings to YAML
Date:   Mon, 14 Jun 2021 05:50:22 +0900
Message-Id: <20210613205022.292575-1-iwamatsu@nigauri.org>
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


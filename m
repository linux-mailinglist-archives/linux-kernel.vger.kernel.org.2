Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7603A5A6F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhFMUut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:50:49 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:45847 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhFMUus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:50:48 -0400
Received: by mail-pg1-f170.google.com with SMTP id q15so7014487pgg.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+nt2gxzCeIwwu5FmgBWJSi87ilyvtFgbF20fAbcptk=;
        b=msqVap0O3FgrfRlVBY17+t6fSzvFm1flFjIeZ6hEZRw1mAO13Eh57ZO13eoowW2vGH
         fUCqVryPmH9rcAX/e53KYl/11rAtU3dUZy6sANsOOPG3mBm/oukDFEpUFl49/yYtgYGw
         yXgWBGP+clBkdN/iHYHCGD4xfJsLCwQ5PenzlMRVOQkm19jTF8UA0CU5pnO6XTTkTSTh
         6wU8wQ4aikEQfFZWSdcY046urFMbipGVxNRZ8dGqQ2sznYUzgnkOcDNcmHlRkisSmfOj
         bt23O6/GJPsbj7msd92UHzTLMhUQJXZyvNrrWdVVfZXJGu/es46putfMJE+kIQ9RvuPC
         Hf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+nt2gxzCeIwwu5FmgBWJSi87ilyvtFgbF20fAbcptk=;
        b=LKamQglWYLqg/sItdhgNXyIWnnrzT4t8n4besYiGlnycXLU2g1i/QKLh1NObiBgqAS
         zRVdvqaSssdH8PyVXhYYHp4vt3FQK1Lj6PoBRYmLy4Q4FdIhG+4UczsWKFdpE9jMPTGb
         rCDdfpzBUO5mPPi6KV8Uib+1kD+bZ7FRWmKnWmtGQLntFzcFRLR7vvsrtjob0+Y7QHtN
         KJJPb8YlXuGvGaypbspiFCdAhMGj/aJemTEttCW5edhwMlBRaq4LnoInDLG8ZtJFCeyq
         lETSHHJ7QZ6uXZYLD4F75ER+kj8nyiUwj6vti4L/xllElovEPIJEjpmth6uYpfpOyCu9
         YKrQ==
X-Gm-Message-State: AOAM533I0I4v3+1otulj+I2ZMR4dTecprJJU3F28AV9UydoNTi+/+E0s
        2VQmCRXLI8MMZTU7NUEOQcf7
X-Google-Smtp-Source: ABdhPJxeXSdmOh0ofTfS52IKc517CKWXYPl2uIUqdX+cLnnFL2hEr2df4+eB4FDB9vLWE6MFqzIhiA==
X-Received: by 2002:aa7:8bd9:0:b029:2f2:f491:8836 with SMTP id s25-20020aa78bd90000b02902f2f4918836mr18654852pfd.47.1623617266443;
        Sun, 13 Jun 2021 13:47:46 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id nn6sm9648463pjb.57.2021.06.13.13.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 13:47:45 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     michal.simek@xilinx.com, mturquette@baylibre.com, robh@kernel.org,
        sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH v3] dt-bindings: clk: zynqmp: convert bindings to YAML
Date:   Mon, 14 Jun 2021 05:47:42 +0900
Message-Id: <20210613204742.292053-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert common clock for Xilinx Zynq MPSoC SoC bindings documentation
to YAML.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
v3: Drop commit for mailbox/xlnx,zynqmp-ipi-mailbox.txt
v2: Fix warning with DT_CHECKER_FLAGS=-m.

 .../bindings/clock/xlnx,zynqmp-clk.txt        | 63 -------------------
 .../bindings/clock/xlnx,zynqmp-clk.yaml       | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
deleted file mode 100644
index 391ee1a60bed4a..00000000000000
--- a/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
+++ /dev/null
@@ -1,63 +0,0 @@
---------------------------------------------------------------------------
-Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
-Zynq MPSoC firmware interface
---------------------------------------------------------------------------
-The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
-tree. It reads required input clock frequencies from the devicetree and acts
-as clock provider for all clock consumers of PS clocks.
-
-See clock_bindings.txt for more information on the generic clock bindings.
-
-Required properties:
- - #clock-cells:	Must be 1
- - compatible:		Must contain:	"xlnx,zynqmp-clk"
- - clocks:		List of clock specifiers which are external input
-			clocks to the given clock controller. Please refer
-			the next section to find the input clocks for a
-			given controller.
- - clock-names:		List of clock names which are exteral input clocks
-			to the given clock controller. Please refer to the
-			clock bindings for more details.
-
-Input clocks for zynqmp Ultrascale+ clock controller:
-
-The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
-inputs. These required clock inputs are:
- - pss_ref_clk (PS reference clock)
- - video_clk (reference clock for video system )
- - pss_alt_ref_clk (alternative PS reference clock)
- - aux_ref_clk
- - gt_crx_ref_clk (transceiver reference clock)
-
-The following strings are optional parameters to the 'clock-names' property in
-order to provide an optional (E)MIO clock source:
- - swdt0_ext_clk
- - swdt1_ext_clk
- - gem0_emio_clk
- - gem1_emio_clk
- - gem2_emio_clk
- - gem3_emio_clk
- - mio_clk_XX		# with XX = 00..77
- - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
-
-
-Output clocks are registered based on clock information received
-from firmware. Output clocks indexes are mentioned in
-include/dt-bindings/clock/xlnx-zynqmp-clk.h.
-
--------
-Example
--------
-
-firmware {
-	zynqmp_firmware: zynqmp-firmware {
-		compatible = "xlnx,zynqmp-firmware";
-		method = "smc";
-		zynqmp_clk: clock-controller {
-			#clock-cells = <1>;
-			compatible = "xlnx,zynqmp-clk";
-			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
-			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.yaml b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.yaml
new file mode 100644
index 00000000000000..e7a1384fb646e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/xlnx,zynqmp-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq Ultrascale+ MPSoC clock controller Device Tree Bindings
+
+maintainers:
+  - Michal Simek <michal.simek@xilinx.com>
+
+description: |
+  The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
+  tree. It reads required input clock frequencies from the devicetree and acts
+  as clock provider for all clock consumers of PS clocks.
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-clk
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    description: |
+      List of clock specifiers which are external input
+      clocks to the given clock controller.
+    items:
+      - description: PS reference clock
+      - description: reference clock for video system
+      - description: alternative PS reference clock
+      - description: auxiliary reference clock
+      - description: transceiver reference clock
+
+  clock-names:
+    items:
+      - const: pss_ref_clk
+      - const: video_clk
+      - const: pss_alt_ref_clk
+      - const: aux_ref_clk
+      - const: gt_crx_ref_clk
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      zynqmp_firmware: zynqmp-firmware {
+        zynqmp_clk: clock-controller {
+          #clock-cells = <1>;
+          compatible = "xlnx,zynqmp-clk";
+          clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+          clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
+        };
+      };
+    };
+...
-- 
2.32.0


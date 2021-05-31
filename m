Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1BA3959FB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhEaMAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 08:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhEaMAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 08:00:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AEAC061760
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:59:10 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 27so8204556pgy.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBKMfrf99JWaDydMD97VUp77kKrBHAo3mwSgOYKx6mc=;
        b=t/saIXTf4FHqHLfsP+uKU0qx55g0y18EoDx4qn13idEBQKZ6vhH7omOBBy553vlsEw
         k3M+6YX3zk5yQZMgrsR6dvLzQUSxqwDE/d4eBddN0HgbvLdqSaWCGGx5XJzPDtxDlvpz
         KEy4kT21+GRQ3tcYdD7HWxW9q1bWA+KmcZFZsXp9NNzPji14NEnvvD+tqBYTydKlg4fx
         iHRVNdrD8cxZgXKF4gZ7rsKULZfMq33Q6tclMiTWfD92n4ssWQ6qzArcWJpJ0CCYpdUn
         VhySdvFYMzX8zYR+8PlqR96amFcRngBbkQ6Z+zPYEAt/7KYk9Wca399crKICVXGoK4H8
         55Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBKMfrf99JWaDydMD97VUp77kKrBHAo3mwSgOYKx6mc=;
        b=ZblJOCfq8uydMrFpguPMMT6SJFS29GwGFS5OzogOyAvFWpLPGAhVlIf9ZZj4vWHMjt
         n+COhhVsgJMDlQ41ck6S9K/giWpjlPTk2iWmWYbh/8TslWVv6LELQxYGji+DPMvg6jO6
         /fEMq3TXSI2yLxCjZaSyxVb0kHbCBGHcvIE7qsQCMa6n6A+YHYxsTsIcn0UPDl/JRRxR
         fxOIFddhEhQ1gKcNh1s7d2WPGq2Rdfm+H1lJjElRhWUfsfFiSmYBkToE2eYDnWU0ccUW
         ujBhlRRFIwNBC57P/S/BtrdM+alkmydewkz263B/AgF4Bzuy6VKH5aAVt5nZLjhAa8MQ
         urUQ==
X-Gm-Message-State: AOAM532w5r/BEsMlHruwptvyaLC2m+Dgnsm+6o3nTkmBU9HkRdc2s0bi
        FCYytx67j5rpfOfPjKG2MIUK
X-Google-Smtp-Source: ABdhPJwY3gXkVBqAZgArKVxqDz8RrxrcHIB0WpZ0FR19ZGx5H1TrMdvTp6/tWbh1V9iram4OT0AbtQ==
X-Received: by 2002:a05:6a00:2282:b029:2db:7cfe:a43b with SMTP id f2-20020a056a002282b02902db7cfea43bmr16480019pfe.34.1622462349775;
        Mon, 31 May 2021 04:59:09 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id g2sm3355444pfv.106.2021.05.31.04.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 04:59:09 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] dt-bindings: clk: zynqmp: convert bindings to YAML
Date:   Mon, 31 May 2021 20:58:57 +0900
Message-Id: <20210531115857.718985-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert common clock for Xilinx Zynq MPSoC SoC bindings documentation
to YAML.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 .../bindings/clock/xlnx,zynqmp-clk.txt        | 63 ------------------
 .../bindings/clock/xlnx,zynqmp-clk.yaml       | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 63 deletions(-)
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
index 00000000000000..6f081e7cf24153
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.yaml
@@ -0,0 +1,65 @@
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
+        compatible = "xlnx,zynqmp-firmware";
+        method = "smc";
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
2.30.0


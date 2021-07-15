Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692AF3C9C42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbhGOJ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbhGOJ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:59:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DC6C061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 02:56:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 17so4695725pfz.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 02:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pAbGfmGIN7oGE7b33dBXT52a/I1Bp6/dyLoRt/OWcj0=;
        b=tTo1TsVkAEv4rRqKE9ive3ECR2+1oNoArkYcuQAMp/kYkBA5qGGL3X8aZF4aZc2wcK
         1jNkwqdj8FZtiyRH5jFm6eRYexnIkUeQ2pFRp7jfrz5rIRfcYT5FOzTVNaG+cjteCNib
         pEgHeoZMBm8kZJASIgGXSRA/A0MWQYMBvZiNfFGQw6+3qirYmhKZrY9U8ker+v4zet0P
         /B/kW0a4appRkUVz3j0Y65CVqqWQSMIk4EF5efSNZHJl0Owm+4RDBySqQr+5/kBGfXas
         vMsn0DEvm1e+LoH3giTujAHTz8puFrUH01Cn3Q46Wt1HXkF2MjI8+r4lDpO7WgMo3/tA
         bwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pAbGfmGIN7oGE7b33dBXT52a/I1Bp6/dyLoRt/OWcj0=;
        b=Ksql8NakVxXZMrBCWmNDwC+A61oTFgKre3MOrk8J8AgbLkq255n5C8NH79a1cpvjMC
         yX/kH1h0Ha5XMpBJA04LhAj2mMYR4+vVQxH3aFjCxOc8Q0qrNznDx+MvZZhH23SFFoLe
         aTQCYiX8eaP6UJpQnnazej/++47JmAm98ZOKC1cO8CkLOIL+6fGdvACGyEPocXKsJ4A0
         qOnT6c7jECB6ciQxp/4J8Xtkjndzqcnex16NsYol2o7IeiTT+cFvNppAalKTfKeOzWL0
         2B11yb69hiVB1fFI94sp7IfK6+22EagPfp3kbGXxFrnNlfqk0RMtvUkojMzETowMth6p
         7Qqg==
X-Gm-Message-State: AOAM530WlyiFhQDPXm+RQdzeWAUCVh/dt+YHBG4fP9j6ShORtQobQVwZ
        rgnErCmBg+0fQaMG648sk0sg
X-Google-Smtp-Source: ABdhPJxmoDfagR1oLYfii3pKQM3+qP53LIHABt0awxdsRdZLy6bY+e9CyUoxphzb0oSa7OzYEn5MoA==
X-Received: by 2002:a63:d213:: with SMTP id a19mr3772584pgg.28.1626343007458;
        Thu, 15 Jul 2021 02:56:47 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id m34sm6764256pgb.85.2021.07.15.02.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 02:56:47 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        michal.simek@xilinx.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] dt-bindings: power: reset: convert Xilinx Zynq MPSoC bindings to YAML
Date:   Thu, 15 Jul 2021 18:56:27 +0900
Message-Id: <20210715095627.228176-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert power managemnet for Xilinx Zynq MPSoC bindings documentation to
YAML.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 .../power/reset/xlnx,zynqmp-power.txt         | 61 --------------
 .../power/reset/xlnx,zynqmp-power.yaml        | 83 +++++++++++++++++++
 2 files changed, 83 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
deleted file mode 100644
index bb529ecf8a5768..00000000000000
--- a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
+++ /dev/null
@@ -1,61 +0,0 @@
---------------------------------------------------------------------
-Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
---------------------------------------------------------------------
-The zynqmp-power node describes the power management configurations.
-It will control remote suspend/shutdown interfaces.
-
-Required properties:
- - compatible:		Must contain:	"xlnx,zynqmp-power"
- - interrupts:		Interrupt specifier
-
-Optional properties:
- - mbox-names	: Name given to channels seen in the 'mboxes' property.
-		  "tx" - Mailbox corresponding to transmit path
-		  "rx" - Mailbox corresponding to receive path
- - mboxes	: Standard property to specify a Mailbox. Each value of
-		  the mboxes property should contain a phandle to the
-		  mailbox controller device node and an args specifier
-		  that will be the phandle to the intended sub-mailbox
-		  child node to be used for communication. See
-		  Documentation/devicetree/bindings/mailbox/mailbox.txt
-		  for more details about the generic mailbox controller
-		  and client driver bindings. Also see
-		  Documentation/devicetree/bindings/mailbox/ \
-		  xlnx,zynqmp-ipi-mailbox.txt for typical controller that
-		  is used to communicate with this System controllers.
-
---------
-Examples
---------
-
-Example with interrupt method:
-
-firmware {
-	zynqmp_firmware: zynqmp-firmware {
-		compatible = "xlnx,zynqmp-firmware";
-		method = "smc";
-
-		zynqmp_power: zynqmp-power {
-			compatible = "xlnx,zynqmp-power";
-			interrupts = <0 35 4>;
-		};
-	};
-};
-
-Example with IPI mailbox method:
-
-firmware {
-	zynqmp_firmware: zynqmp-firmware {
-		compatible = "xlnx,zynqmp-firmware";
-		method = "smc";
-
-		zynqmp_power: zynqmp-power {
-			compatible = "xlnx,zynqmp-power";
-			interrupt-parent = <&gic>;
-			interrupts = <0 35 4>;
-			mboxes = <&ipi_mailbox_pmu0 0>,
-				 <&ipi_mailbox_pmu0 1>;
-			mbox-names = "tx", "rx";
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
new file mode 100644
index 00000000000000..68d7c14a716388
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/xlnx,zynqmp-power.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq MPSoC Power Management Device Tree Bindings
+
+maintainers:
+  - Michal Simek <michal.simek@xilinx.com>
+
+description: |
+  The zynqmp-power node describes the power management configurations.
+  It will control remote suspend/shutdown interfaces.
+
+properties:
+  compatible:
+    const: "xlnx,zynqmp-power"
+
+  interrupts:
+    maxItems: 1
+
+  mboxes:
+    description: |
+      Standard property to specify a Mailbox. Each value of
+      the mboxes property should contain a phandle to the
+      mailbox controller device node and an args specifier
+      that will be the phandle to the intended sub-mailbox
+      child node to be used for communication. See
+      Documentation/devicetree/bindings/mailbox/mailbox.txt
+      for more details about the generic mailbox controller
+      and client driver bindings. Also see
+      Documentation/devicetree/bindings/mailbox/ \
+      xlnx,zynqmp-ipi-mailbox.txt for typical controller that
+      is used to communicate with this System controllers.
+    items:
+      - description: tx channel
+      - description: rx channel
+
+  mbox-names:
+    description:
+      Name given to channels seen in the 'mboxes' property.
+    items:
+      - const: tx
+      - const: rx
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |+
+
+    // Example with interrupt method:
+
+    firmware {
+      zynqmp-firmware {
+        zynqmp-power {
+          compatible = "xlnx,zynqmp-power";
+          interrupts = <0 35 4>;
+        };
+      };
+    };
+
+  - |+
+
+    // Example with IPI mailbox method:
+
+    firmware {
+      zynqmp-firmware {
+        zynqmp-power {
+          compatible = "xlnx,zynqmp-power";
+          interrupt-parent = <&gic>;
+          interrupts = <0 35 4>;
+          mboxes = <&ipi_mailbox_pmu1 0>,
+                   <&ipi_mailbox_pmu1 1>;
+          mbox-names = "tx", "rx";
+        };
+      };
+    };
+...
-- 
2.32.0


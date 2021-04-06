Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF68E355124
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245146AbhDFKsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237178AbhDFKss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:48:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C016610C8;
        Tue,  6 Apr 2021 10:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617706121;
        bh=L4xi4dGURAattxUGGVtS9EHjtxImRX8+XaMDYzyZAsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=STKb3zn+IQ46VC9iF2YCpecy7xukt4SjljXqLQLtYyX6Vcv5qS1WGPpG/cT4o99k4
         QqtZ/9qMPHKdOLrHc5QSP/mqWZ9scWunigDuU8lBUCE9uY28a2FDJlQjvNnSiCLTk5
         tEW8SiyeFCbtpcOOTznX+g/cRTLZn2gFEODesabhON5FdxMHQnkcLpPA50NzgOoGm+
         8jh6g0gaD+IPLNMPliQuBRd0q9yo5rSOz2GxRyS14fGQW8yi3T9vdZ362AsRRRsvWu
         qEz/MAXdauRm6Tucx8w65lWu9BuvDaED3exillYJ+xwmj3b8Cmzw4TbgMr7L57Nis5
         DfA67YqhFYM6Q==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Saenz Julienne <nsaenz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, adrian.hunter@intel.com,
        alcooperx@gmail.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        stefan.wahren@i2se.com, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/3] dt-bindings: mmc: iproc-sdhci: Convert to json-schema
Date:   Tue,  6 Apr 2021 12:48:01 +0200
Message-Id: <20210406104802.20898-2-nsaenz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406104802.20898-1-nsaenz@kernel.org>
References: <20210406104802.20898-1-nsaenz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the brcm,iproc-sdhci binding to DT schema format using json-schema

Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

---

 .../bindings/mmc/brcm,iproc-sdhci.yaml        | 63 +++++++++++++++++++
 .../bindings/mmc/brcm,sdhci-iproc.txt         | 37 -----------
 2 files changed, 63 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt

diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
new file mode 100644
index 000000000000..6f569fbfa134
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/brcm,iproc-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom IPROC SDHCI controller
+
+maintainers:
+  - Ray Jui <ray.jui@broadcom.com>
+  - Scott Branden <scott.branden@broadcom.com>
+  - Nicolas Saenz Julienne <nsaenz@kernel.org>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm2835-sdhci
+      - brcm,bcm2711-emmc2
+      - brcm,sdhci-iproc-cygnus
+      - brcm,sdhci-iproc
+
+  reg:
+    minItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      Handle to core clock for the sdhci controller.
+
+  sdhci,auto-cmd12:
+    type: boolean
+    description: Specifies that controller should use auto CMD12
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/bcm-cygnus.h>
+
+    mmc@18041000 {
+      compatible = "brcm,sdhci-iproc-cygnus";
+      reg = <0x18041000 0x100>;
+      interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&lcpll0_clks BCM_CYGNUS_LCPLL0_SDIO_CLK>;
+      bus-width = <4>;
+      sdhci,auto-cmd12;
+      no-1-8-v;
+    };
+...
diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
deleted file mode 100644
index 09d87cc1182a..000000000000
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Broadcom IPROC SDHCI controller
-
-This file documents differences between the core properties described
-by mmc.txt and the properties that represent the IPROC SDHCI controller.
-
-Required properties:
-- compatible : Should be one of the following
-	       "brcm,bcm2835-sdhci"
-	       "brcm,bcm2711-emmc2"
-	       "brcm,sdhci-iproc-cygnus"
-	       "brcm,sdhci-iproc"
-
-Use brcm2835-sdhci for the eMMC controller on the BCM2835 (Raspberry Pi) and
-bcm2711-emmc2 for the additional eMMC2 controller on BCM2711.
-
-Use sdhci-iproc-cygnus for Broadcom SDHCI Controllers
-restricted to 32bit host accesses to SDHCI registers.
-
-Use sdhci-iproc for Broadcom SDHCI Controllers that allow standard
-8, 16, 32-bit host access to SDHCI register.
-
-- clocks : The clock feeding the SDHCI controller.
-
-Optional properties:
-  - sdhci,auto-cmd12: specifies that controller should use auto CMD12.
-
-Example:
-
-sdhci0: sdhci@18041000 {
-	compatible = "brcm,sdhci-iproc-cygnus";
-	reg = <0x18041000 0x100>;
-	interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&lcpll0_clks BCM_CYGNUS_LCPLL0_SDIO_CLK>;
-	bus-width = <4>;
-	sdhci,auto-cmd12;
-	no-1-8-v;
-};
-- 
2.30.2


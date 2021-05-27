Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01498392993
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhE0Iao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:30:44 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:33904 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbhE0Iam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:30:42 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 91CE2D18CE;
        Thu, 27 May 2021 16:29:08 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31748T140095126476544S1622104146775929_;
        Thu, 27 May 2021 16:29:08 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <46299ccad168625504fce4e4f790793b>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     heiko@sntech.de, lee.jones@linaro.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, jbx6244@gmail.com,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH v2 1/3] dt-bindings: soc: rockchip: convert io-domain.txt to YAML
Date:   Thu, 27 May 2021 16:29:03 +0800
Message-Id: <20210527082905.1447591-2-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527082905.1447591-1-jay.xu@rock-chips.com>
References: <20210527082905.1447591-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the rockchip-io-domain.txt from power/avs dir to soc
dir and rename to io-domain.txt, without any change in the step.

Then covert the io-domain.txt to YAML.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
v2:
- first version
 .../bindings/power/rockchip-io-domain.txt     | 135 ------------------
 .../bindings/soc/rockchip/io-domain.yaml      |  45 ++++++
 2 files changed, 45 insertions(+), 135 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/rockchip-io-domain.txt
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
deleted file mode 100644
index e66fd4eab71c..000000000000
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+++ /dev/null
@@ -1,135 +0,0 @@
-Rockchip SRAM for IO Voltage Domains:
--------------------------------------
-
-IO domain voltages on some Rockchip SoCs are variable but need to be
-kept in sync between the regulators and the SoC using a special
-register.
-
-A specific example using rk3288:
-- If the regulator hooked up to a pin like SDMMC0_VDD is 3.3V then
-  bit 7 of GRF_IO_VSEL needs to be 0.  If the regulator hooked up to
-  that same pin is 1.8V then bit 7 of GRF_IO_VSEL needs to be 1.
-
-Said another way, this driver simply handles keeping bits in the SoC's
-general register file (GRF) in sync with the actual value of a voltage
-hooked up to the pins.
-
-Note that this driver specifically doesn't include:
-- any logic for deciding what voltage we should set regulators to
-- any logic for deciding whether regulators (or internal SoC blocks)
-  should have power or not have power
-
-If there were some other software that had the smarts of making
-decisions about regulators, it would work in conjunction with this
-driver.  When that other software adjusted a regulator's voltage then
-this driver would handle telling the SoC about it.  A good example is
-vqmmc for SD.  In that case the dw_mmc driver simply is told about a
-regulator.  It changes the regulator between 3.3V and 1.8V at the
-right time.  This driver notices the change and makes sure that the
-SoC is on the same page.
-
-
-Required properties:
-- compatible: should be one of:
-  - "rockchip,px30-io-voltage-domain" for px30
-  - "rockchip,px30-pmu-io-voltage-domain" for px30 pmu-domains
-  - "rockchip,rk3188-io-voltage-domain" for rk3188
-  - "rockchip,rk3228-io-voltage-domain" for rk3228
-  - "rockchip,rk3288-io-voltage-domain" for rk3288
-  - "rockchip,rk3328-io-voltage-domain" for rk3328
-  - "rockchip,rk3368-io-voltage-domain" for rk3368
-  - "rockchip,rk3368-pmu-io-voltage-domain" for rk3368 pmu-domains
-  - "rockchip,rk3399-io-voltage-domain" for rk3399
-  - "rockchip,rk3399-pmu-io-voltage-domain" for rk3399 pmu-domains
-  - "rockchip,rv1108-io-voltage-domain" for rv1108
-  - "rockchip,rv1108-pmu-io-voltage-domain" for rv1108 pmu-domains
-
-Deprecated properties:
-- rockchip,grf: phandle to the syscon managing the "general register files"
-    Systems should move the io-domains to a sub-node of the grf simple-mfd.
-
-You specify supplies using the standard regulator bindings by including
-a phandle the relevant regulator.  All specified supplies must be able
-to report their voltage.  The IO Voltage Domain for any non-specified
-supplies will be not be touched.
-
-Possible supplies for PX30:
-- vccio6-supply: The supply connected to VCCIO6.
-- vccio1-supply: The supply connected to VCCIO1.
-- vccio2-supply: The supply connected to VCCIO2.
-- vccio3-supply: The supply connected to VCCIO3.
-- vccio4-supply: The supply connected to VCCIO4.
-- vccio5-supply: The supply connected to VCCIO5.
-- vccio-oscgpi-supply: The supply connected to VCCIO_OSCGPI.
-
-Possible supplies for PX30 pmu-domains:
-- pmuio1-supply: The supply connected to PMUIO1.
-- pmuio2-supply: The supply connected to PMUIO2.
-
-Possible supplies for rk3188:
-- ap0-supply:    The supply connected to AP0_VCC.
-- ap1-supply:    The supply connected to AP1_VCC.
-- cif-supply:    The supply connected to CIF_VCC.
-- flash-supply:  The supply connected to FLASH_VCC.
-- lcdc0-supply:  The supply connected to LCD0_VCC.
-- lcdc1-supply:  The supply connected to LCD1_VCC.
-- vccio0-supply: The supply connected to VCCIO0.
-- vccio1-supply: The supply connected to VCCIO1.
-                 Sometimes also labeled VCCIO1 and VCCIO2.
-
-Possible supplies for rk3228:
-- vccio1-supply: The supply connected to VCCIO1.
-- vccio2-supply: The supply connected to VCCIO2.
-- vccio3-supply: The supply connected to VCCIO3.
-- vccio4-supply: The supply connected to VCCIO4.
-
-Possible supplies for rk3288:
-- audio-supply:  The supply connected to APIO4_VDD.
-- bb-supply:     The supply connected to APIO5_VDD.
-- dvp-supply:    The supply connected to DVPIO_VDD.
-- flash0-supply: The supply connected to FLASH0_VDD.  Typically for eMMC
-- flash1-supply: The supply connected to FLASH1_VDD.  Also known as SDIO1.
-- gpio30-supply: The supply connected to APIO1_VDD.
-- gpio1830       The supply connected to APIO2_VDD.
-- lcdc-supply:   The supply connected to LCDC_VDD.
-- sdcard-supply: The supply connected to SDMMC0_VDD.
-- wifi-supply:   The supply connected to APIO3_VDD.  Also known as SDIO0.
-
-Possible supplies for rk3368:
-- audio-supply:  The supply connected to APIO3_VDD.
-- dvp-supply:    The supply connected to DVPIO_VDD.
-- flash0-supply: The supply connected to FLASH0_VDD.  Typically for eMMC
-- gpio30-supply: The supply connected to APIO1_VDD.
-- gpio1830       The supply connected to APIO4_VDD.
-- sdcard-supply: The supply connected to SDMMC0_VDD.
-- wifi-supply:   The supply connected to APIO2_VDD.  Also known as SDIO0.
-
-Possible supplies for rk3368 pmu-domains:
-- pmu-supply:    The supply connected to PMUIO_VDD.
-- vop-supply:    The supply connected to LCDC_VDD.
-
-Possible supplies for rk3399:
-- bt656-supply:  The supply connected to APIO2_VDD.
-- audio-supply:  The supply connected to APIO5_VDD.
-- sdmmc-supply:  The supply connected to SDMMC0_VDD.
-- gpio1830       The supply connected to APIO4_VDD.
-
-Possible supplies for rk3399 pmu-domains:
-- pmu1830-supply:The supply connected to PMUIO2_VDD.
-
-Example:
-
-	io-domains {
-		compatible = "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf = <&grf>;
-
-		audio-supply = <&vcc18_codec>;
-		bb-supply = <&vcc33_io>;
-		dvp-supply = <&vcc_18>;
-		flash0-supply = <&vcc18_flashio>;
-		gpio1830-supply = <&vcc33_io>;
-		gpio30-supply = <&vcc33_pmuio>;
-		lcdc-supply = <&vcc33_lcd>;
-		sdcard-supply = <&vccio_sd>;
-		wifi-supply = <&vcc18_wl>;
-	};
diff --git a/Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml b/Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml
new file mode 100644
index 000000000000..2931e0ea8fa8
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/rockchip/io-domain.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SRAM for IO Voltage Domains
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+            - rockchip,px30-io-voltage-domain
+            - rockchip,px30-pmu-io-voltage-domain
+            - rockchip,rk3188-io-voltage-domain
+            - rockchip,rk3228-io-voltage-domain
+            - rockchip,rk3288-io-voltage-domain
+            - rockchip,rk3328-io-voltage-domain
+            - rockchip,rk3368-io-voltage-domain
+            - rockchip,rk3368-pmu-io-voltage-domain
+            - rockchip,rk3399-io-voltage-domain
+            - rockchip,rk3399-pmu-io-voltage-domain
+            - rockchip,rv1108-io-voltage-domain
+            - rockchip,rv1108-pmu-io-voltage-domain
+
+
+examples:
+  - |
+    io-domains {
+        compatible = "rockchip,rk3288-io-voltage-domain";
+
+	audio-supply = <&vcc18_codec>;
+	bb-supply = <&vcc33_io>;
+	dvp-supply = <&vcc_18>;
+	flash0-supply = <&vcc18_flashio>;
+	gpio1830-supply = <&vcc33_io>;
+	gpio30-supply = <&vcc33_pmuio>;
+	lcdc-supply = <&vcc33_lcd>;
+	sdcard-supply = <&vccio_sd>;
+	wifi-supply = <&vcc18_wl>;
+    };
-- 
2.25.1




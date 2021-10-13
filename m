Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A0D42BEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhJMLPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:15:33 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:61900 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhJMLPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634123607; x=1665659607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yinNDxbc/jAjNgJElWjyLyp5kYgk94veEsfSuJcbY8M=;
  b=QbvlO5cgRuzDfWCRQIy7gfyIZWycU/wvtEf8XaP0c/oUL1M8wMTH0aNe
   Z42mFNKVFgU0Qjuox5HaHrRyE+32DI05pxODt3ngznrbTowir/Cc8azvl
   6AghdBq2rVeHWmB8/k92vC4sM56TmK2UUbsdIP/OMtFLmHbXTnCDP2sWL
   95LntZRqk12HvYVoZZEw1JPOqT74LbzrSIgYOi83Z4uZavgDentovECp3
   RJZWQ7MxTRxO/Ik+imROZlW2RZLZ0OnnEdvUNwCxGyNSym3Sd3TkmnOEE
   Z5ZO+g+OMX3LQL8j/rb0jbXFJYU4/wXFb5gpTPO9qh2du9xQ7ZBoM15zA
   A==;
X-IronPort-AV: E=Sophos;i="5.85,370,1624312800"; 
   d="scan'208";a="20020844"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Oct 2021 13:13:25 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 13 Oct 2021 13:13:25 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 13 Oct 2021 13:13:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634123605; x=1665659605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yinNDxbc/jAjNgJElWjyLyp5kYgk94veEsfSuJcbY8M=;
  b=Zb+z76FQc3opejgKLGhBX6pyIRN/P9e3zQzShqJ6lVtlpXQ1Hgwza24p
   qHT8ofUVL2JmnxedBik0U7Ew4BSrmfHATWtD3zIBA7II93iAjEjhTuAQU
   Kh2kEwrFsg55D1HZms9LAIcdhi8s7NsVdEUIb8fxvRvET0knCmXBOD9eM
   phmUu4Gx/dgrGQ6isJt31P9r7xQ3tv7PsscYBV60H5mQA5KJzsghN4X1T
   uQbcX95d0OcX8+BHk8nUslkxMOZ0Mg67QKGnvL/3sY9ZvRMdPdTmkl2e7
   E2xdTM6qSiANdDuq4mAJyG7iuLvIx37VshtHWMx+cYBA/MnwkOATafz1N
   g==;
X-IronPort-AV: E=Sophos;i="5.85,370,1624312800"; 
   d="scan'208";a="20020843"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Oct 2021 13:13:25 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id F0B36280078;
        Wed, 13 Oct 2021 13:13:24 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH 3/3] ARM: dts: imx6qdl: add TQ-Systems MBa6x device trees
Date:   Wed, 13 Oct 2021 13:12:02 +0200
Message-Id: <20211013111202.6231-3-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211013111202.6231-1-matthias.schiffer@ew.tq-group.com>
References: <20211013111202.6231-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Add device trees for the MBa6x mainboard with TQMa6Q/QP/DL SoMs.

Files are imported with (GPL-2.0-or-later OR MIT) license where the
copyright is held fully by TQ-Systems. Other files with less clear
copyright ownership use their original GPL-2.0-or-later license.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/Makefile           |   5 +
 arch/arm/boot/dts/imx6dl-mba6.dtsi   |  22 ++
 arch/arm/boot/dts/imx6dl-mba6a.dts   |  21 ++
 arch/arm/boot/dts/imx6dl-mba6b.dts   |  21 ++
 arch/arm/boot/dts/imx6q-mba6.dtsi    |  44 +++
 arch/arm/boot/dts/imx6q-mba6a.dts    |  20 +
 arch/arm/boot/dts/imx6q-mba6b.dts    |  20 +
 arch/arm/boot/dts/imx6qdl-mba6.dtsi  | 528 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-mba6a.dtsi |  36 ++
 arch/arm/boot/dts/imx6qdl-mba6b.dtsi |  52 +++
 arch/arm/boot/dts/imx6qp-mba6b.dts   |  18 +
 11 files changed, 787 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-mba6.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-mba6a.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-mba6b.dts
 create mode 100644 arch/arm/boot/dts/imx6q-mba6.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-mba6a.dts
 create mode 100644 arch/arm/boot/dts/imx6q-mba6b.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-mba6.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-mba6a.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-mba6b.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qp-mba6b.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 38838ba90c72..a5d83c664735 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -474,6 +474,8 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-icore-rqs.dtb \
 	imx6dl-lanmcu.dtb \
 	imx6dl-mamoj.dtb \
+	imx6dl-mba6a.dtb \
+	imx6dl-mba6b.dtb \
 	imx6dl-nit6xlite.dtb \
 	imx6dl-nitrogen6x.dtb \
 	imx6dl-phytec-mira-rdk-nand.dtb \
@@ -575,6 +577,8 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-kp-tpc.dtb \
 	imx6q-logicpd.dtb \
 	imx6q-marsboard.dtb \
+	imx6q-mba6a.dtb \
+	imx6q-mba6b.dtb \
 	imx6q-mccmon6.dtb \
 	imx6q-nitrogen6x.dtb \
 	imx6q-nitrogen6_max.dtb \
@@ -620,6 +624,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-wandboard-revb1.dtb \
 	imx6q-wandboard-revd1.dtb \
 	imx6q-zii-rdu2.dtb \
+	imx6qp-mba6b.dtb \
 	imx6qp-nitrogen6_max.dtb \
 	imx6qp-nitrogen6_som2.dtb \
 	imx6qp-phytec-mira-rdk-nand.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-mba6.dtsi b/arch/arm/boot/dts/imx6dl-mba6.dtsi
new file mode 100644
index 000000000000..d444668e1fc7
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-mba6.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2013 Sascha Hauer, Pengutronix
+ *
+ * Copyright 2013-2021 TQ-Systems GmbH
+ * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ */
+
+&ethphy {
+	rxdv-skew-ps = <180>;
+	txen-skew-ps = <0>;
+	rxd3-skew-ps = <180>;
+	rxd2-skew-ps = <180>;
+	rxd1-skew-ps = <180>;
+	rxd0-skew-ps = <180>;
+	txd3-skew-ps = <120>;
+	txd2-skew-ps = <0>;
+	txd1-skew-ps = <300>;
+	txd0-skew-ps = <120>;
+	txc-skew-ps = <1860>;
+	rxc-skew-ps = <1860>;
+};
diff --git a/arch/arm/boot/dts/imx6dl-mba6a.dts b/arch/arm/boot/dts/imx6dl-mba6a.dts
new file mode 100644
index 000000000000..bdba624ba112
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-mba6a.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2013 Sascha Hauer, Pengutronix
+ *
+ * Copyright 2013-2021 TQ-Systems GmbH
+ * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "imx6dl-tqma6a.dtsi"
+#include "imx6qdl-mba6.dtsi"
+#include "imx6qdl-mba6a.dtsi"
+#include "imx6dl-mba6.dtsi"
+
+/ {
+	model = "TQ TQMa6S/DL on MBa6x";
+	compatible = "tq,imx6dl-mba6x-a", "tq,mba6a",
+		     "tq,imx6dl-tqma6dl-a", "fsl,imx6dl";
+};
diff --git a/arch/arm/boot/dts/imx6dl-mba6b.dts b/arch/arm/boot/dts/imx6dl-mba6b.dts
new file mode 100644
index 000000000000..69ac9d811801
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-mba6b.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2013 Sascha Hauer, Pengutronix
+ *
+ * Copyright 2013-2021 TQ-Systems GmbH
+ * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "imx6dl-tqma6b.dtsi"
+#include "imx6qdl-mba6.dtsi"
+#include "imx6qdl-mba6b.dtsi"
+#include "imx6dl-mba6.dtsi"
+
+/ {
+	model = "TQ TQMa6S/DL on MBa6x";
+	compatible = "tq,imx6dl-mba6x-b", "tq,mba6b",
+		     "tq,imx6dl-tqma6dl-b", "fsl,imx6dl";
+};
diff --git a/arch/arm/boot/dts/imx6q-mba6.dtsi b/arch/arm/boot/dts/imx6q-mba6.dtsi
new file mode 100644
index 000000000000..edd84107f9c1
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-mba6.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2013 Sascha Hauer, Pengutronix
+ *
+ * Copyright 2013-2021 TQ-Systems GmbH
+ * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ */
+
+&ecspi5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi5_mba6x>;
+	cs-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+};
+
+&ethphy {
+	rxdv-skew-ps = <180>;
+	txen-skew-ps = <120>;
+	rxd3-skew-ps = <180>;
+	rxd2-skew-ps = <180>;
+	rxd1-skew-ps = <180>;
+	rxd0-skew-ps = <180>;
+	txd3-skew-ps = <120>;
+	txd2-skew-ps = <0>;
+	txd1-skew-ps = <180>;
+	txd0-skew-ps = <360>;
+	txc-skew-ps = <1860>;
+	rxc-skew-ps = <1860>;
+};
+
+&sata {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_ecspi5_mba6x: ecspi5grp-mba6x {
+		fsl,pins = <
+			/* HYS, SPEED = MED, 100k up, DSE = 011, SRE_FAST */
+			MX6QDL_PAD_SD1_DAT0__ECSPI5_MISO 0x1b099
+			MX6QDL_PAD_SD1_CMD__ECSPI5_MOSI 0xb099
+			MX6QDL_PAD_SD1_CLK__ECSPI5_SCLK 0xb099
+			MX6QDL_PAD_SD1_DAT1__GPIO1_IO17 0xb099 /* eCSPI5 SS0 */
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q-mba6a.dts b/arch/arm/boot/dts/imx6q-mba6a.dts
new file mode 100644
index 000000000000..bdf68f7e91a8
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-mba6a.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2013 Sascha Hauer, Pengutronix
+ *
+ * Copyright 2013-2021 TQ-Systems GmbH
+ * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ */
+
+/dts-v1/;
+
+#include "imx6q-tqma6a.dtsi"
+#include "imx6qdl-mba6.dtsi"
+#include "imx6qdl-mba6a.dtsi"
+#include "imx6q-mba6.dtsi"
+
+/ {
+	model = "TQ TQMa6Q on MBa6x";
+	compatible = "tq,imx6q-mba6x-a", "tq,mba6a",
+		     "tq,imx6q-tqma6q-a", "fsl,imx6q";
+};
diff --git a/arch/arm/boot/dts/imx6q-mba6b.dts b/arch/arm/boot/dts/imx6q-mba6b.dts
new file mode 100644
index 000000000000..08a67057a323
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-mba6b.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2013 Sascha Hauer, Pengutronix
+ *
+ * Copyright 2013-2021 TQ-Systems GmbH
+ * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ */
+
+/dts-v1/;
+
+#include "imx6q-tqma6b.dtsi"
+#include "imx6qdl-mba6.dtsi"
+#include "imx6qdl-mba6b.dtsi"
+#include "imx6q-mba6.dtsi"
+
+/ {
+	model = "TQ TQMa6Q on MBa6x";
+	compatible = "tq,imx6q-mba6x-b", "tq,mba6b",
+		     "tq,imx6q-tqma6q-b", "fsl,imx6q";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-mba6.dtsi b/arch/arm/boot/dts/imx6qdl-mba6.dtsi
new file mode 100644
index 000000000000..60c9be0d0c4e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-mba6.dtsi
@@ -0,0 +1,528 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2013 Sascha Hauer, Pengutronix
+ *
+ * Copyright 2013-2021 TQ-Systems GmbH
+ * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ */
+
+#include <dt-bindings/clock/imx6qdl-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
+
+/ {
+	aliases {
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc2;
+		/delete-property/ mmc2;
+		/delete-property/ mmc3;
+	};
+
+	chosen {
+		linux,stdout-path = &uart2;
+		stdout-path = &uart2;
+	};
+
+	beeper: gpio-beeper {
+		compatible = "gpio-beeper";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiobeeper>;
+		gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	gpio_buttons: gpio-buttons {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiobuttons>;
+
+		button1 {
+			label = "s6";
+			linux,code = <64>; /* KEY_F6 */
+			gpios = <&gpio7 13 GPIO_ACTIVE_LOW>;
+		};
+
+		button2 {
+			label = "s7";
+			linux,code = <65>; /* KEY_F7 */
+			gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+		};
+
+		button3 {
+			label = "s8";
+			linux,code = <66>; /* KEY_F8 */
+			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpioled>;
+		status = "okay";
+
+		led1 {
+			label = "led1";
+			gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		led2 {
+			label = "led2";
+			gpios = <&gpio6 31 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	reg_mba6_3p3v: regulator-mba6-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "supply-mba6-3p3v";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_pcie: regulator-pcie {
+		compatible = "regulator-fixed";
+		regulator-name = "supply-pcie";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		/* PCIE.PWR_EN */
+		gpio = <&gpio2 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		vin-supply = <&reg_mba6_3p3v>;
+	};
+
+	reg_vcc3v3_audio: regulator-vcc3v3-audio {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3-audio";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_mba6_3p3v>;
+	};
+
+	sound {
+		compatible = "fsl,imx-audio-tlv320aic32x4";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_audmux>;
+		model = "imx-audio-tlv320aic32x4";
+		ssi-controller = <&ssi1>;
+		audio-codec = <&tlv320aic32x4>;
+		audio-asrc = <&asrc>;
+		audio-routing =
+			"IN3_L", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"IN1_L", "Line In Jack",
+			"IN1_R", "Line In Jack",
+			"Line Out Jack", "LOL",
+			"Line Out Jack", "LOR";
+		mux-int-port = <1>;
+		mux-ext-port = <3>;
+	};
+};
+
+&audmux {
+	status = "okay";
+
+	ssi0 {
+		fsl,audmux-port = <MX31_AUDMUX_PORT1_SSI0>;
+		fsl,port-config = <
+			(IMX_AUDMUX_V2_PTCR_SYN |
+				IMX_AUDMUX_V2_PTCR_TFSDIR |
+				IMX_AUDMUX_V2_PTCR_TFSEL(MX31_AUDMUX_PORT3_SSI_PINS_3) |
+				IMX_AUDMUX_V2_PTCR_TCLKDIR |
+				IMX_AUDMUX_V2_PTCR_TCSEL(MX31_AUDMUX_PORT3_SSI_PINS_3))
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT3_SSI_PINS_3)
+		>;
+	};
+
+	aud3 {
+		fsl,audmux-port = <MX31_AUDMUX_PORT3_SSI_PINS_3>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT1_SSI0)
+		>;
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can2>;
+	status = "okay";
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>, <&pinctrl_ecspi1_mba6>;
+	cs-gpios = <&gpio3 19 0>, <&gpio3 24 0>;
+};
+
+&fec {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy>;
+	mac-address = [00 00 00 00 00 00];
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@3 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <3>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
+			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <1000>;
+			reset-deassert-us = <100000>;
+			micrel,force-master;
+			max-speed = <1000>;
+		};
+	};
+};
+
+&i2c1 {
+	tlv320aic32x4: codec@18 {
+		compatible = "ti,tlv320aic32x4";
+		reg = <0x18>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		clock-names = "mclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_codec>;
+		ldoin-supply = <&reg_vcc3v3_audio>;
+		iov-supply = <&reg_mba6_3p3v>;
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio6 7 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
+
+&ssi1 {
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	uart-has-rtscts;
+	linux,rs485-enabled-at-boot-time;
+	rs485-rts-active-low;
+	rs485-rx-during-tx;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usbh1 {
+	disable-over-current;
+	status = "okay";
+};
+
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	power-active-high;
+	over-current-active-low;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	dr_mode = "otg";
+	status = "okay";
+};
+
+/* SD card slot */
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	vmmc-supply = <&reg_mba6_3p3v>;
+	bus-width = <4>;
+	no-1-8-v;
+	no-mmc;
+	no-sdio;
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog1>;
+	/* does not work on unmodified starter kit */
+	/* fsl,ext-reset-output; */
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_audmux: audmuxgrp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD  0x1b0b0
+			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x1b0b0
+			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x1b0b0
+			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x1b0b0
+		>;
+	};
+
+	pinctrl_can1: can1grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX 0xb099
+			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX 0xb099
+		>;
+	};
+
+	pinctrl_can2: can2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0xb099
+			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0xb099
+		>;
+	};
+
+	pinctrl_codec: codecgrp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_MCLK__CCM_CLKO1 0xb0 /* CLK */
+		>;
+	};
+
+	pinctrl_ecspi1_mba6: ecspimba6grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D24__GPIO3_IO24 0xb099 /* eCSPI1 SS2 */
+		>;
+	};
+
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			/* FEC phy IRQ */
+			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28     0x00011008
+			/* FEC phy reset */
+			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25   0x1b099
+			/* DSE = 100, 100k up, SPEED = MED */
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0xb0a0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC         0xb0a0
+			/* DSE = 111, pull 100k up */
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0xb038
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0xb038
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0xb038
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0xb038
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0xb038
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0xb038
+			/* DSE = 111, pull external */
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x0038
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x0038
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x0038
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x0038
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x0038
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x0038
+			/* HYS = 1, DSE = 111, 100k up, SPEED = HIGH */
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0f0
+		>;
+	};
+
+	pinctrl_gpiobeeper: gpiobeepergrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_DAT3__GPIO1_IO21 0xb099
+		>;
+	};
+
+	pinctrl_gpiobuttons: gpiobuttongrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x0001b099
+			MX6QDL_PAD_GPIO_18__GPIO7_IO13 0x0001b099
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08 0x0001b099
+		>;
+	};
+
+	pinctrl_gpioled: gpioledgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CS3__GPIO6_IO16 0xb099 /* LED V15 */
+			MX6QDL_PAD_EIM_BCLK__GPIO6_IO31 0xb099 /* LED V16 */
+		>;
+	};
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			/* LCD.CONTRAST -> Rev 0100 only, not used on Rev.0200*/
+			MX6QDL_PAD_DI0_PIN4__GPIO4_IO20 0x0001b099
+
+			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26 0x0001b099
+			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x0001b099
+			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 0x0001b099
+
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0x0001b099
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x0001b099
+			MX6QDL_PAD_NANDF_D3__GPIO2_IO03 0x0001b099
+			MX6QDL_PAD_SD4_DAT0__GPIO2_IO08 0x0001b099
+			MX6QDL_PAD_EIM_CS0__GPIO2_IO23 0x0001b099
+			MX6QDL_PAD_EIM_CS1__GPIO2_IO24 0x0001b099
+			MX6QDL_PAD_EIM_OE__GPIO2_IO25 0x0001b099
+
+			MX6QDL_PAD_EIM_D20__GPIO3_IO20 0x0001b099
+			MX6QDL_PAD_EIM_D26__GPIO3_IO26 0x0001b099
+			MX6QDL_PAD_EIM_D27__GPIO3_IO27 0x0001b099
+			MX6QDL_PAD_EIM_D28__GPIO3_IO28 0x0001b099
+			MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x0001b099
+
+			MX6QDL_PAD_KEY_COL0__GPIO4_IO06 0x0001b099
+			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07 0x0001b099
+			MX6QDL_PAD_KEY_COL1__GPIO4_IO08 0x0001b099
+			MX6QDL_PAD_KEY_ROW1__GPIO4_IO09 0x0001b099
+
+			MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18 0x0001b099
+			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20 0x0001b099
+			MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21 0x0001b099
+
+			MX6QDL_PAD_NANDF_ALE__GPIO6_IO08 0x0001b099
+			MX6QDL_PAD_NANDF_CS1__GPIO6_IO14 0x0001b099
+		>;
+	};
+
+	pinctrl_pcie: pciegrp {
+		fsl,pins = <
+			/* HYS = 1, DSE = 110, 100k up, SPEED = HIGH (11)*/
+			MX6QDL_PAD_SD4_DAT3__GPIO2_IO11 0x001b0f0 /* #PCIE.WAKE */
+			MX6QDL_PAD_NANDF_CLE__GPIO6_IO07 0x001b0f0 /* #PCIE.RST */
+			MX6QDL_PAD_NANDF_CS0__GPIO6_IO11 0x001b0f0 /* #PCIE.DIS */
+			/* HYS = 1, DSE = 110, PUE+PKE, SPEED = HIGH (11)*/
+			MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0x00130f0 /* PCIE.PWR_EN */
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			/* 100 k PD, DSE 120 OHM, SPPEED LO */
+			MX6QDL_PAD_GPIO_9__PWM1_OUT 0x00003050
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			/* 100 k PD, DSE 120 OHM, SPPEED LO */
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x00003050
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			/* 100 k PD, DSE 120 OHM, SPPEED LO */
+			MX6QDL_PAD_SD4_DAT2__PWM4_OUT 0x00003050
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA 0x1b099
+			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA 0x1b099
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CLK__UART3_RX_DATA 0x1b0b1
+			MX6QDL_PAD_SD4_CMD__UART3_TX_DATA 0x1b0b1
+			MX6QDL_PAD_EIM_D30__UART3_CTS_B   0x1b0b1
+			MX6QDL_PAD_EIM_D31__UART3_RTS_B   0x1b0b1
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B 0x1b0b1
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT14__UART5_TX_DATA 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT15__UART5_RX_DATA 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT18__UART5_RTS_B 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT19__UART5_CTS_B 0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			/* CLK: 47k Pup SPD_LOW DSE 40Ohm SRE_FAST HYS */
+			MX6QDL_PAD_SD2_CLK__SD2_CLK    0x00017071
+			/* SD2: 47k Pup SPD_LOW DSE 80Ohm SRE_FAST HYS */
+			MX6QDL_PAD_SD2_CMD__SD2_CMD    0x00017059
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x00017059
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x00017059
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x00017059
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x00017059
+
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04  0x0001b099 /* usdhc2 CD */
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02  0x0001b099 /* usdhc2 WP */
+		>;
+	};
+
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D21__USB_OTG_OC  0x0001b0b0
+			MX6QDL_PAD_GPIO_1__USB_OTG_ID   0x00017059
+			MX6QDL_PAD_EIM_D22__USB_OTG_PWR 0x0001b099
+		>;
+	};
+
+	pinctrl_wdog1: wdog1grp {
+		fsl,pins = <
+			 /* Watchdog out */
+			MX6QDL_PAD_SD1_DAT2__WDOG1_B 0x0000b099
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qdl-mba6a.dtsi b/arch/arm/boot/dts/imx6qdl-mba6a.dtsi
new file mode 100644
index 000000000000..4b5fb44e94e9
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-mba6a.dtsi
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2013 Sascha Hauer, Pengutronix
+ *
+ * Copyright 2013-2021 TQ-Systems GmbH
+ * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ */
+
+/ {
+	aliases {
+		rtc0 = &rtc0;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>, <&pinctrl_enet_fix>;
+};
+
+&i2c1 {
+	lm75: temperature-sensor@49 {
+		compatible = "national,lm75";
+		reg = <0x49>;
+	};
+
+	m24c64_57: eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <32>;
+	};
+
+	rtc0: rtc@68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qdl-mba6b.dtsi b/arch/arm/boot/dts/imx6qdl-mba6b.dtsi
new file mode 100644
index 000000000000..82ac795cb8bd
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-mba6b.dtsi
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2013 Sascha Hauer, Pengutronix
+ *
+ * Copyright 2013-2021 TQ-Systems GmbH
+ * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ */
+
+/ {
+	aliases {
+		rtc0 = &rtc0;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
+&i2c3 {
+	lm75: temperature-sensor@49 {
+		compatible = "national,lm75";
+		reg = <0x49>;
+	};
+
+	m24c64_57: eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <32>;
+	};
+
+	rtc0: rtc@68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
+};
+
+&iomuxc {
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b899
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b899
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qp-mba6b.dts b/arch/arm/boot/dts/imx6qp-mba6b.dts
new file mode 100644
index 000000000000..a1ba6761a3f6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-mba6b.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright 2015-2021 TQ-Systems GmbH
+ * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ */
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "imx6qp-tqma6b.dtsi"
+#include "imx6qdl-mba6.dtsi"
+#include "imx6qdl-mba6b.dtsi"
+#include "imx6q-mba6.dtsi"
+
+/ {
+	model = "TQ TQMa6QP on MBa6x";
+	compatible = "tq,imx6qp-mba6x-b", "tq,mba6b",
+		     "tq,imx6qp-tqma6qp-b", "fsl,imx6qp";
+};
-- 
2.17.1


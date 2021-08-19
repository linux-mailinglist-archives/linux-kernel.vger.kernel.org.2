Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C67D3F1B43
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbhHSOKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:10:48 -0400
Received: from mout.perfora.net ([74.208.4.194]:42049 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240329AbhHSOKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:10:46 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Aug 2021 10:10:46 EDT
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LyX1k-1nAJXg2X6E-015upF;
 Thu, 19 Aug 2021 16:04:19 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: [PATCH v1 7/7] ARM: dts: colibri-imx6ull-emmc: add device trees
Date:   Thu, 19 Aug 2021 16:03:45 +0200
Message-Id: <20210819140345.357167-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819140345.357167-1-marcel@ziswiler.com>
References: <20210819140345.357167-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cGQ2OQwWXLChEXAfqbJIkrTXASzWSHIbnhPFXtF8s3yQNJtYj6b
 FhEz6pE8zeZfuPwOQO97T0Hj+9Vridruvq7Y+ABF87zv6O16egNoif/KO23Ywy9/2m3wW2s
 4iRG/rwDKf7GyWg7qTS+RiolrKy7zZYb68LCqXg6gCKP9pOsSyPSF2lyvqHcNw/b68zRZJp
 meXbRnj5RrSsQL2m9DCPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8zvSYGhE6YI=:v66aVD6dNs16vJCF6TOm3M
 UCZOIY/C87kk3gCtclkXy2mhoQt9en9f2H8bv3Jx1hfndNPv6E+wXYSvk5D/5u3OS3Bc4HLGR
 Jbya8SctO8zI8Ek5ywLyR4k6bndmdQgQySb3cgNqz72pev3eWKQuo9pSIN3y3QVrdzCkAJH+Q
 9Cul9tidUTaDSLrC0HwHEZUDNDoG6vrCKefIlF6oe6Itq7zvkgIGabNPWI67oUVh0Btf5OqFF
 VpAFVWNlpoTBG/yhBC4J5svq8fYhY/Kt5jeHMVqZAFaxubZW+NQciWZzvwO5eS5R2qSh5zDXl
 CK462aVnekrlBpCHY0JLGSWlrbVzZVQsy/F51eCFdUP7qlB2QlzEKHDwjuXwIGA7rpCYRQNfI
 zmeOap8sgSt877njkwEyP6He7rhqHuEtPVFQ2nuoQ7F0645N87MNTbyekpDEJgModDjJ/FmbM
 2RI7vINaqLcama+M9Jp50CJV8dTZ1b2QtU4hyD3K0D1WWikkcVi5w4aQvLmGz91ti2YpxSvp9
 0Ty4fOjjzroACeJzVVce8MinTyKzEaHAN4IvjX9lFmFhUYVxTHmWJFEU8k7HlcZ7V0YVQubsz
 /7lJLL7KLHxAfphHkcs4LLShaOgPpnlsmko7ZFLMC40PSg7+nY3yPvOSEzq/VHtzNzvICv2x0
 ZdwvmAGHhY2tSN3uPS5hv/lPGF0m1fm/lF2X/Q5m5xTW//A49pXu27Q98phobJ0aIpg2yoSpU
 KnVyFqi23QWZPWIoLpJchr2tVbXFV+Ps2XlZMnr+roGnfLuSugJu71gnYiy+KCNSdT3dUVmjx
 6A/Wmwf6S0LE+2BSjp8gUftrAathHNbtRrsGQ0CeDF8bpwO5IUD67qrLEYnCwQeLaJ3YI/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Add devices trees for a Colibri iMX6ULL 1GB which has a eMMC instead of
the raw NAND used on other SKUs.

Related-to: ELB-4056, ELB-4058
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/imx6ull-colibri-emmc-eval-v3.dts |  17 ++
 .../dts/imx6ull-colibri-emmc-nonwifi.dtsi     | 185 ++++++++++++++++++
 arch/arm/boot/dts/imx6ull-colibri.dtsi        |  30 ++-
 4 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e0934180724d..f88ddcc40b6ac 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -671,6 +671,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
 	imx6ull-14x14-evk.dtb \
+	imx6ull-colibri-emmc-eval-v3.dtb \
 	imx6ull-colibri-eval-v3.dtb \
 	imx6ull-colibri-wifi-eval-v3.dtb \
 	imx6ull-myir-mys-6ulx-eval.dtb \
diff --git a/arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dts b/arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dts
new file mode 100644
index 0000000000000..70104a6c5bac9
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Toradex AG
+ */
+
+/dts-v1/;
+
+#include "imx6ull-colibri-emmc-nonwifi.dtsi"
+#include "imx6ull-colibri-eval-v3.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX6ULL 1GB (eMMC) on Colibri Evaluation Board V3";
+	compatible = "toradex,colibri-imx6ull-emmc-eval",
+		     "toradex,colibri-imx6ull-emmc",
+		     "toradex,colibri-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi
new file mode 100644
index 0000000000000..df055617e51f7
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Toradex AG
+ */
+
+#include "imx6ull-colibri.dtsi"
+
+/ {
+	aliases {
+		mmc0 = &usdhc2; /* eMMC */
+		mmc1 = &usdhc1; /* MMC 4bit slot */
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>;
+	};
+};
+
+&gpio1 {
+	gpio-line-names = "SODIMM_8",
+			  "SODIMM_6",
+			  "SODIMM_129",
+			  "SODIMM_89",
+			  "SODIMM_19",
+			  "SODIMM_21",
+			  "UNUSABLE_SODIMM_180",
+			  "UNUSABLE_SODIMM_184",
+			  "SODIMM_4",
+			  "SODIMM_2",
+			  "SODIMM_106",
+			  "SODIMM_71",
+			  "SODIMM_23",
+			  "SODIMM_31",
+			  "SODIMM_99",
+			  "SODIMM_102",
+			  "SODIMM_33",
+			  "SODIMM_35",
+			  "SODIMM_25",
+			  "SODIMM_27",
+			  "SODIMM_36",
+			  "SODIMM_38",
+			  "SODIMM_32",
+			  "SODIMM_34",
+			  "SODIMM_135",
+			  "SODIMM_77",
+			  "SODIMM_100",
+			  "SODIMM_186",
+			  "SODIMM_196",
+			  "SODIMM_194";
+};
+
+&gpio2 {
+	gpio-line-names = "SODIMM_55",
+			  "SODIMM_63",
+			  "SODIMM_178",
+			  "SODIMM_188",
+			  "SODIMM_73",
+			  "SODIMM_30",
+			  "SODIMM_67",
+			  "SODIMM_104",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_190",
+			  "SODIMM_47",
+			  "SODIMM_192",
+			  "SODIMM_49",
+			  "SODIMM_51",
+			  "SODIMM_53";
+};
+
+&gpio3 {
+	gpio-line-names = "SODIMM_56",
+			  "SODIMM_44",
+			  "SODIMM_68",
+			  "SODIMM_82",
+			  "",
+			  "SODIMM_76",
+			  "SODIMM_70",
+			  "SODIMM_60",
+			  "SODIMM_58",
+			  "SODIMM_78",
+			  "SODIMM_72",
+			  "SODIMM_80",
+			  "SODIMM_46",
+			  "SODIMM_62",
+			  "SODIMM_48",
+			  "SODIMM_74",
+			  "SODIMM_50",
+			  "SODIMM_52",
+			  "SODIMM_54",
+			  "SODIMM_66",
+			  "SODIMM_64",
+			  "SODIMM_57",
+			  "SODIMM_61",
+			  "SODIMM_29",
+			  "SODIMM_37",
+			  "SODIMM_88",
+			  "SODIMM_86",
+			  "SODIMM_92",
+			  "SODIMM_90";
+};
+
+&gpio4 {
+	gpio-line-names = "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SODIMM_140",
+			  "SODIMM_59",
+			  "SODIMM_142",
+			  "SODIMM_144",
+			  "SODIMM_133",
+			  "SODIMM_146",
+			  "SODIMM_28",
+			  "SODIMM_75",
+			  "SODIMM_96",
+			  "SODIMM_81",
+			  "SODIMM_94",
+			  "SODIMM_101",
+			  "SODIMM_103",
+			  "SODIMM_79",
+			  "SODIMM_97",
+			  "SODIMM_69",
+			  "SODIMM_98",
+			  "SODIMM_85",
+			  "SODIMM_65";
+};
+
+&gpio5 {
+	gpio-line-names = "SODIMM_43",
+			  "SODIMM_45",
+			  "SODIMM_137",
+			  "SODIMM_95",
+			  "SODIMM_107",
+			  "SODIMM_131",
+			  "SODIMM_93",
+			  "",
+			  "SODIMM_138",
+			  "",
+			  "SODIMM_105",
+			  "SODIMM_127";
+};
+
+&gpmi {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3
+		&pinctrl_gpio4 &pinctrl_gpio6 &pinctrl_gpio7
+		&pinctrl_gpmi_gpio>;
+};
+
+&iomuxc_snvs {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_snvs_gpio1 &pinctrl_snvs_gpio3>;
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2emmc>;
+	assigned-clocks = <&clks IMX6UL_CLK_USDHC2_SEL>, <&clks IMX6UL_CLK_USDHC2>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL2_PFD2>;
+	assigned-clock-rates = <0>, <198000000>;
+	bus-width = <8>;
+	keep-power-in-suspend;
+	no-1-8-v;
+	non-removable;
+	vmmc-supply = <&reg_module_3v3>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 0cdbf7b6e7285..f432fc0a6a530 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * Copyright 2018 Toradex AG
+ * Copyright 2018-2021 Toradex AG
  */
 
 #include "imx6ull.dtsi"
@@ -345,6 +345,19 @@ MX6UL_PAD_ENET1_RX_DATA1__GPIO2_IO01	0xb0b0 /* SODIMM 63 */
 		>;
 	};
 
+		/*
+		 * With an eMMC instead of a raw NAND device the following pins
+		 * are available at SODIMM pins
+		 */
+		pinctrl_gpmi_gpio: gpmi-gpio-grp {
+			fsl,pins = <
+				MX6UL_PAD_NAND_ALE__GPIO4_IO10		0x10b0 /* SODIMM 140 */
+				MX6UL_PAD_NAND_CE0_B__GPIO4_IO13	0x10b0 /* SODIMM 144 */
+				MX6UL_PAD_NAND_CLE__GPIO4_IO15		0x10b0 /* SODIMM 146 */
+				MX6UL_PAD_NAND_READY_B__GPIO4_IO12	0x10b0 /* SODIMM 142 */
+			>;
+		};
+
 	pinctrl_gpmi_nand: gpmi-nand-grp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0x100a9
@@ -533,6 +546,21 @@ MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT	0x10
 		>;
 	};
 
+		pinctrl_usdhc2emmc: usdhc2emmcgrp {
+			fsl,pins = <
+				MX6UL_PAD_NAND_RE_B__USDHC2_CLK     0x17059
+				MX6UL_PAD_NAND_WE_B__USDHC2_CMD     0x17059
+				MX6UL_PAD_NAND_DATA00__USDHC2_DATA0 0x17059
+				MX6UL_PAD_NAND_DATA01__USDHC2_DATA1 0x17059
+				MX6UL_PAD_NAND_DATA02__USDHC2_DATA2 0x17059
+				MX6UL_PAD_NAND_DATA03__USDHC2_DATA3 0x17059
+				MX6UL_PAD_NAND_DATA04__USDHC2_DATA4 0x17059
+				MX6UL_PAD_NAND_DATA05__USDHC2_DATA5 0x17059
+				MX6UL_PAD_NAND_DATA06__USDHC2_DATA6 0x17059
+				MX6UL_PAD_NAND_DATA07__USDHC2_DATA7 0x17059
+			>;
+		};
+
 	pinctrl_wdog: wdog-grp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY    0x30b0
-- 
2.26.2


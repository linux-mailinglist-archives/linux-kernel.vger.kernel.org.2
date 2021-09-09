Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39B64058C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbhIIOSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344744AbhIIOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:18:02 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51181C101BEA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 05:37:37 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 80C4F1F5A3;
        Thu,  9 Sep 2021 14:37:34 +0200 (CEST)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v2 1/7] arm64: dts: qcom: Introduce support for MSM8998 Sony Yoshino platform
Date:   Thu,  9 Sep 2021 14:37:27 +0200
Message-Id: <20210909123733.367248-1-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces support for the Sony Yoshino platform, using
the MSM8998 SoC, including:
- Sony Xperia XZ1 (codename Poplar),
- Sony Xperia XZ1 Compact (codename Lilac),
- Sony Xperia XZ Premium (codename Maple).

All of the three aforementioned smartphones are sharing a 99%
equal board configuration, with very small differences between
each other, which is the reason for the introduction of a common
msm8998-sony-xperia-yoshino DT.

This base configuration includes regulators and project-wide pin
configurations and it's made to boot to a serial console.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |   3 +
 .../msm8998-sony-xperia-yoshino-lilac.dts     |  19 +
 .../msm8998-sony-xperia-yoshino-maple.dts     |  43 ++
 .../msm8998-sony-xperia-yoshino-poplar.dts    |  24 +
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 475 ++++++++++++++++++
 5 files changed, 564 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 70516508be56..8a0b558c3065 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -39,6 +39,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-lenovo-miix-630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-oneplus-cheeseburger.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-oneplus-dumpling.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-lilac.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dts b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dts
new file mode 100644
index 000000000000..550de79e0151
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, AngeloGioacchino Del Regno
+ *                     <angelogioacchino.delregno@somainline.org>
+ */
+
+/dts-v1/;
+
+#include "msm8998-sony-xperia-yoshino.dtsi"
+
+/ {
+	model = "Sony Xperia XZ1 Compact";
+	compatible = "sony,xperia-lilac", "qcom,msm8998";
+};
+
+&vreg_l22a_2p85 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
new file mode 100644
index 000000000000..35a6cdb55aec
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, AngeloGioacchino Del Regno
+ *                     <angelogioacchino.delregno@somainline.org>
+ */
+
+/dts-v1/;
+
+#include "msm8998-sony-xperia-yoshino.dtsi"
+
+/ {
+	model = "Sony Xperia XZ Premium";
+	compatible = "sony,xperia-maple", "qcom,msm8998";
+
+	disp_dvdd_vreg: disp-dvdd-vreg {
+		compatible = "regulator-fixed";
+		regulator-name = "disp_dvdd_en";
+		regulator-min-microvolt = <1350000>;
+		regulator-max-microvolt = <1350000>;
+		startup-delay-us = <0>;
+		enable-active-high;
+		gpio = <&pmi8998_gpio 10 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&disp_dvdd_en>;
+	};
+};
+
+&pmi8998_gpio {
+	disp_dvdd_en: disp-dvdd-en-active {
+		pins = "gpio10";
+		function = "normal";
+		bias-disable;
+		drive-push-pull;
+		output-high;
+		power-source = <0>;
+		qcom,drive-strength = <1>;
+	};
+};
+
+&vreg_l22a_2p85 {
+	regulator-min-microvolt = <2704000>;
+	regulator-max-microvolt = <2704000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dts b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dts
new file mode 100644
index 000000000000..6255004b9a09
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, AngeloGioacchino Del Regno
+ *                     <angelogioacchino.delregno@somainline.org>
+ */
+
+/dts-v1/;
+
+#include "msm8998-sony-xperia-yoshino.dtsi"
+
+/ {
+	model = "Sony Xperia XZ1";
+	compatible = "sony,xperia-poplar", "qcom,msm8998";
+};
+
+&vreg_l18a_2p85 {
+	regulator-min-microvolt = <2850000>;
+	regulator-max-microvolt = <2850000>;
+};
+
+&vreg_l22a_2p85 {
+	regulator-min-microvolt = <2700000>;
+	regulator-max-microvolt = <2700000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
new file mode 100644
index 000000000000..98d23f8b93ac
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, AngeloGioacchino Del Regno
+ *                     <angelogioacchino.delregno@somainline.org>
+ * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
+ */
+
+#include "msm8998.dtsi"
+#include "pm8005.dtsi"
+#include "pm8998.dtsi"
+#include "pmi8998.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+
+/ {
+	/* required for bootloader to select correct board */
+	qcom,msm-id = <0x124 0x20000>, <0x124 0x20001>; /* 8998v2, v2.1 */
+	qcom,board-id = <8 0>;
+
+	board_vbat: vbat-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VBAT";
+
+		regulator-min-microvolt = <4000000>;
+		regulator-max-microvolt = <4000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		input-name = "gpio-keys";
+		label = "Side buttons";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_down_pin_a>, <&cam_focus_pin_a>,
+			    <&cam_snapshot_pin_a>;
+		vol-down {
+			label = "Volume Down";
+			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_KEY>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpio-key,wakeup;
+			debounce-interval = <15>;
+		};
+
+		camera-snapshot {
+			label = "Camera Snapshot";
+			gpios = <&pm8998_gpio 7 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_KEY>;
+			linux,code = <KEY_CAMERA>;
+			debounce-interval = <15>;
+		};
+
+		camera-focus {
+			label = "Camera Focus";
+			gpios = <&pm8998_gpio 8 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_KEY>;
+			linux,code = <KEY_CAMERA_FOCUS>;
+			debounce-interval = <15>;
+		};
+	};
+
+	gpio-hall-sensor {
+		compatible = "gpio-keys";
+		input-name = "hall-sensors";
+		label = "Hall sensors";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hall_sensor0_default>;
+
+		hall-sensor0 {
+			label = "Cover Hall Sensor";
+			gpios = <&tlmm 124 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			gpio-key,wakeup;
+			debounce-interval = <30>;
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hyp_mem: memory@85800000 {
+			reg = <0x0 0x85800000 0x0 0x3700000>;
+			no-map;
+		};
+
+		cont_splash_mem: memory@9d400000 {
+			reg = <0x0 0x9d400000 0x0 0x2400000>;
+			no-map;
+		};
+
+		zap_shader_region: memory@f6400000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0xf6400000 0x0 0x2000>;
+			no-map;
+		};
+
+		adsp_region: memory@fe000000 {
+			reg = <0x0 0xfe000000 0x0 0x800000>;
+			no-map;
+		};
+
+		qseecom_region: memory@fe800000 {
+			reg = <0x0 0xfe800000 0x0 0x1400000>;
+			no-map;
+		};
+
+		ramoops@ffc00000 {
+			compatible = "ramoops";
+			reg = <0x0 0xffc00000 0x0 0x100000>;
+			record-size = <0x10000>;
+			console-size = <0x60000>;
+			ftrace-size = <0x10000>;
+			pmsg-size = <0x20000>;
+			ecc-size = <16>;
+		};
+	};
+};
+
+&blsp2_uart1 {
+	status = "okay";
+};
+
+&mmcc {
+	status = "ok";
+};
+
+&mmss_smmu {
+	status = "ok";
+};
+
+&pm8005_lsid1 {
+	pm8005-regulators {
+		compatible = "qcom,pm8005-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+
+		/* VDD_GFX supply */
+		pm8005_s1: s1 {
+			regulator-min-microvolt = <524000>;
+			regulator-max-microvolt = <1088000>;
+			regulator-enable-ramp-delay = <500>;
+			regulator-always-on;
+		};
+	};
+};
+
+&pm8998_gpio {
+	vol_down_pin_a: vol-down-active {
+		pins = "gpio5";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-pull-up;
+		input-enable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+
+	cam_focus_pin_a: cam-focus-btn-active {
+		pins = "gpio7";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-pull-up;
+		input-enable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+
+	cam_snapshot_pin_a: cam-snapshot-btn-active {
+		pins = "gpio8";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-pull-up;
+		input-enable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+};
+
+&pm8998_pon {
+	resin {
+		compatible = "qcom,pm8941-resin";
+		interrupts = <GIC_SPI 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+		debounce = <15625>;
+		bias-pull-up;
+		linux,code = <KEY_VOLUMEUP>;
+	};
+};
+
+&qusb2phy {
+	status = "okay";
+
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+};
+
+&rpm_requests {
+	pm8998-regulators {
+		compatible = "qcom,rpm-pm8998-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+		vdd_s7-supply = <&vph_pwr>;
+		vdd_s8-supply = <&vph_pwr>;
+		vdd_s9-supply = <&vph_pwr>;
+		vdd_s10-supply = <&vph_pwr>;
+		vdd_s11-supply = <&vph_pwr>;
+		vdd_s12-supply = <&vph_pwr>;
+		vdd_s13-supply = <&vph_pwr>;
+		vdd_l1_l27-supply = <&vreg_s7a_1p025>;
+		vdd_l2_l8_l17-supply = <&vreg_s3a_1p35>;
+		vdd_l3_l11-supply = <&vreg_s7a_1p025>;
+		vdd_l4_l5-supply = <&vreg_s7a_1p025>;
+		vdd_l6-supply = <&vreg_s5a_2p04>;
+		vdd_l7_l12_l14_l15-supply = <&vreg_s5a_2p04>;
+		vdd_l9-supply = <&vreg_bob>;
+		vdd_l10_l23_l25-supply = <&vreg_bob>;
+		vdd_l13_l19_l21-supply = <&vreg_bob>;
+		vdd_l16_l28-supply = <&vreg_bob>;
+		vdd_l18_l22-supply = <&vreg_bob>;
+		vdd_l20_l24-supply = <&vreg_bob>;
+		vdd_l26-supply = <&vreg_s3a_1p35>;
+		vdd_lvs1_lvs2-supply = <&vreg_s4a_1p8>;
+
+		vreg_s3a_1p35: s3 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+		vreg_s4a_1p8: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-system-load = <100000>;
+			regulator-allow-set-load;
+		};
+		vreg_s5a_2p04: s5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2032000>;
+		};
+		vreg_s7a_1p025: s7 {
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1028000>;
+		};
+		vreg_l1a_0p875: l1 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-system-load = <73400>;
+			regulator-allow-set-load;
+		};
+		vreg_l2a_1p2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-system-load = <12560>;
+			regulator-allow-set-load;
+		};
+		vreg_l3a_1p0: l3 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+		vreg_l5a_0p8: l5 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+		};
+		vreg_l6a_1p8: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l7a_1p8: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l8a_1p2: l8 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		vreg_l9a_1p8: l9 {
+			regulator-min-microvolt = <1808000>;
+			regulator-max-microvolt = <2960000>;
+		};
+		vreg_l10a_1p8: l10 {
+			regulator-min-microvolt = <1808000>;
+			regulator-max-microvolt = <2960000>;
+		};
+		vreg_l11a_1p0: l11 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+		vreg_l12a_1p8: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l13a_2p95: l13 {
+			regulator-min-microvolt = <1808000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
+		};
+		vreg_l14a_1p85: l14 {
+			regulator-min-microvolt = <1848000>;
+			regulator-max-microvolt = <1856000>;
+			regulator-system-load = <32000>;
+			regulator-allow-set-load;
+		};
+		vreg_l15a_1p8: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l16a_2p7: l16 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2704000>;
+		};
+		vreg_l17a_1p3: l17 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+		};
+		vreg_l18a_2p85: l18 {};
+		vreg_l19a_2p7: l19 {
+			regulator-min-microvolt = <2696000>;
+			regulator-max-microvolt = <2704000>;
+		};
+		vreg_l20a_2p95: l20 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-system-load = <10000>;
+			regulator-allow-set-load;
+		};
+		vreg_l21a_2p95: l21 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-system-load = <800000>;
+			regulator-allow-set-load;
+		};
+		vreg_l22a_2p85: l22 { };
+		vreg_l23a_3p3: l23 {
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3312000>;
+		};
+		vreg_l24a_3p075: l24 {
+			regulator-min-microvolt = <3088000>;
+			regulator-max-microvolt = <3088000>;
+		};
+		vreg_l25a_3p3: l25 {
+			regulator-min-microvolt = <3104000>;
+			regulator-max-microvolt = <3312000>;
+		};
+		vreg_l26a_1p2: l26 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-allow-set-load;
+		};
+		vreg_l28_3p0: l28 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+		vreg_lvs1a_1p8: lvs1 { };
+		vreg_lvs2a_1p8: lvs2 { };
+	};
+
+	pmi8998-regulators {
+		compatible = "qcom,rpm-pmi8998-regulators";
+
+		vdd_bob-supply = <&vph_pwr>;
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3600000>;
+		};
+	};
+};
+
+&sdhc2 {
+	status = "okay";
+	cd-gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
+
+	vmmc-supply = <&vreg_l21a_2p95>;
+	vqmmc-supply = <&vreg_l13a_2p95>;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <81 4>;
+
+	mdp_vsync_n: mdp-vsync-n {
+		pins = "gpio10";
+		function = "mdp_vsync_a";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	nfc_ven: nfc-ven {
+		pins = "gpio12";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+		output-low;
+	};
+
+	msm_mclk0_default: msm-mclk0-active {
+		pins = "gpio13";
+		function = "cam_mclk";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	msm_mclk1_default: msm-mclk1-active {
+		pins = "gpio14";
+		function = "cam_mclk";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	cci0_default: cci0-default {
+		pins = "gpio18", "gpio19";
+		function = "cci_i2c";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	cci1_default: cci1-default {
+		pins = "gpio19", "gpio20";
+		function = "cci_i2c";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	hall_sensor0_default: acc-cover-open {
+		pins = "gpio124";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+		input-enable;
+	};
+};
+
+/*
+ * WARNING:
+ * Disable UFS until card quirks are in to avoid unrecoverable hard-brick
+ * that would happen as soon as the UFS card gets probed as, without the
+ * required quirks, the bootloader will be erased right after card probe.
+ */
+&ufshc {
+	status = "disabled";
+};
+
+&ufsphy {
+	status = "disabled";
+};
+
+&usb3 {
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	/* Force to peripheral until we have Type-C hooked up */
+	dr_mode = "peripheral";
+};
+
+&usb3phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l2a_1p2>;
+};
-- 
2.32.0


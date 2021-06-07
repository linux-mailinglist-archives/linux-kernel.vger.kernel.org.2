Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D02839DBA4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhFGLmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:42:51 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:36428 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhFGLmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:42:49 -0400
Received: by mail-pg1-f175.google.com with SMTP id 27so13607189pgy.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 04:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pxk9jMy8Cjya3/7I3jpQbZX9wqd4VZaOXPNFzD47/JM=;
        b=FF16jz4FI0rZqKWnRUvm2o0+/OmsmpwT+6kqMjthc/XZ4V+EElUaK2TiW6IPXb0t6C
         i7zkj1MV9ysof0hl1ZmSQixVGSiEXSk5USyHlzeNHJBBuXKuyzrZmi2+1x43pZaArB8M
         aGRMX3MxcksyyGDDVD9lWBIYHZzv+PGvWkFnxIDFMfPFjnWsT2yKmuCupvL2YOBP6L0V
         wK6iugn3A9dJYCbp2xYuTxFh3BshePrdrfaDspC9H4VPAxVlb31l0yQAEu8abckVOaDU
         T3BBGw1cy91fnwfwusP5+dyt5b1xKM4WvsIlLVL+p4PSQwwQPWpa7AmgC+Br6PktPP1X
         nGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pxk9jMy8Cjya3/7I3jpQbZX9wqd4VZaOXPNFzD47/JM=;
        b=X7Wj0JIUF3Jg5OhH/NBvKO7QQc7lIsRY6rPEuSarnBMq2nOBX4ggzU/OethIi5Avu2
         M1+WECPYyhtsjxqCtHeClHz7J2cc0hAo5xqEuLaxOCOaqSRi1OTBpgfiFVeB9Vlv5uiE
         PLB9VUrfdgd4zP9IrZxKXbbMjIq9iHeod1cVOB0tQ/lU7AXJcMddEOloZJXsU1AtvTgi
         NAhcMcu+uy7HxhSXYFHsGs4pPthmqkpL9hZg2Fe+4fRIuOQ3/hxMLZKpCX752FgwnItv
         j5lSheFtfFizNV8zjdrsl2/GMERJJBFb21WWmrw+UgIZSpPAd/Y2ffOa9kfhX5TvjQlh
         gNow==
X-Gm-Message-State: AOAM532EkwJ4VB7DSS5ItiBDWJZaIJnhL9Y8WVbKNko70T0zUcoiPXc7
        9kPvaI2BhzYDm2HRt5XLoaFj4cCZpyc3Nw==
X-Google-Smtp-Source: ABdhPJwzMzOEx8SwHal3OfYVwIxhxRZyKdEQNqAYVNTnH+6PzRiTH9uUq+wNTGRQMFyWWWasIlxzIQ==
X-Received: by 2002:a05:6a00:1a41:b029:2ef:9721:879e with SMTP id h1-20020a056a001a41b02902ef9721879emr5775585pfv.74.1623065988689;
        Mon, 07 Jun 2021 04:39:48 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.177.211])
        by smtp.gmail.com with ESMTPSA id j7sm7223939pjf.0.2021.06.07.04.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:39:48 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH 8/8] arm64: dts: qcom: sa8155p-adp: Add base dts file
Date:   Mon,  7 Jun 2021 17:08:40 +0530
Message-Id: <20210607113840.15435-9-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607113840.15435-1-bhupesh.sharma@linaro.org>
References: <20210607113840.15435-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add base DTS file for sa8155p-adp and enable boot to console,
tlmm reserved range and also include pmic file(s).

SA8155p-adp board is based on sm8150 Qualcomm Snapdragon SoC.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile        |   1 +
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 363 +++++++++++++++++++++++
 2 files changed, 364 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8155p-adp.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 456502aeee49..38d3a4728871 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -71,6 +71,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
new file mode 100644
index 000000000000..470d740e060a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "sm8150.dtsi"
+#include "pmm8155au_1.dtsi"
+#include "pmm8155au_2.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. SA8155P ADP";
+	compatible = "qcom,sa8155p-adp";
+
+	aliases {
+		serial0 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	vreg_3p3: vreg_3p3_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_3p3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	/*
+	 * Apparently RPMh does not provide support for PM8150 S4 because it
+	 * is always-on; model it as a fixed regulator.
+	 */
+	vreg_s4a_1p8: smps4 {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s4a_1p8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply = <&vreg_3p3>;
+	};
+};
+
+&apps_rsc {
+	pmm8155au-1-rpmh-regulators {
+		compatible = "qcom,pmm8155au-1-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s1-supply = <&vreg_3p3>;
+		vdd-s2-supply = <&vreg_3p3>;
+		vdd-s3-supply = <&vreg_3p3>;
+		vdd-s4-supply = <&vreg_3p3>;
+		vdd-s5-supply = <&vreg_3p3>;
+		vdd-s6-supply = <&vreg_3p3>;
+		vdd-s7-supply = <&vreg_3p3>;
+		vdd-s8-supply = <&vreg_3p3>;
+		vdd-s9-supply = <&vreg_3p3>;
+		vdd-s10-supply = <&vreg_3p3>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s6a_0p92>;
+		vdd-l2-l10-supply = <&vreg_3p3>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s6a_0p92>;
+		vdd-l6-l9-supply = <&vreg_s6a_0p92>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p04>;
+		vdd-l13-l16-l17-supply = <&vreg_3p3>;
+
+		vreg_s5a_2p04: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_s6a_0p92: smps6 {
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1128000>;
+		};
+
+		vdda_wcss_pll:
+		vreg_l1a_0p752: ldo1 {
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <752000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_usb_hs_3p1:
+		vreg_l2a_3p072: ldo2 {
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3a_0p8: ldo3 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdd_usb_hs_core:
+		vdda_pll_hv_cc_ebi01:
+		vdda_pll_hv_cc_ebi23:
+		vdda_ufs_2ln_core:
+		vdda_ufs_2ln_core:
+		vdda_usb_ss_core:
+		vdda_usb_ss_dp_core_1:
+		vdda_usb_ss_dp_core_2:
+		vdda_sp_sensor:
+		vdda_qlink_lv:
+		vdda_qlink_lv_ck:
+		vdda_qrefs_0p875_5:
+		vreg_l5a_0p88: ldo5 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10a_2p96: ldo10 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11a_0p8: ldo11 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdd_qfprom:
+		vdd_qfprom_sp:
+		vdda_usb_hs_1p8:
+		vdda_apc_cs_1p8:
+		vdda_gfx_cs_1p8:
+		vddpx_11:
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13a_2p7: ldo13 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15a_1p7: ldo15 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16a_2p7: ldo16 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17a_2p96: ldo17 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	pmm8155au-2-rpmh-regulators {
+		compatible = "qcom,pmm8155au-2-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vreg_3p3>;
+		vdd-s2-supply = <&vreg_3p3>;
+		vdd-s3-supply = <&vreg_3p3>;
+		vdd-s4-supply = <&vreg_3p3>;
+		vdd-s5-supply = <&vreg_3p3>;
+		vdd-s6-supply = <&vreg_3p3>;
+		vdd-s7-supply = <&vreg_3p3>;
+		vdd-s8-supply = <&vreg_3p3>;
+		vdd-s9-supply = <&vreg_3p3>;
+		vdd-s10-supply = <&vreg_3p3>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s4c_1p352>;
+		vdd-l2-l10-supply = <&vreg_3p3>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s4c_1p352>;
+		vdd-l6-l9-supply = <&vreg_s6c_1p128>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5c_2p04>;
+		vdd-l13-l16-l17-supply = <&vreg_3p3>;
+
+		vreg_s4c_1p352: smps4 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_s5c_2p04: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_s6c_1p128: smps6 {
+			regulator-min-microvolt = <1128000>;
+			regulator-max-microvolt = <1128000>;
+		};
+
+		vdda_wcss_adcdac_1:
+		vdda_wcss_adcdac_2:
+		vreg_l1c_1p304: ldo1 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_5:
+		vreg_l2c_1p808: ldo2 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_10:
+		vreg_l5c_1p2: ldo5 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7c_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_qlink_hv_ck:
+		vdda_pcie_1ln_pll_1p2:
+		vdda_pcie_2ln_pll_1p2:
+		vdda_hv_refgen0:
+		vdda_ufs_2ln_1p2:
+		vdda_usb_ss_1p2:
+		vdda_usb_ss_dp_1p2:
+		vdda_csi_1p2:
+		vdda_dsi_1p2:
+		vreg_l8c_1p2: ldo8 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10c_3p3: ldo10 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_0p8: ldo11 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_6:
+		vreg_l12c_1p808: ldo12 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_2:
+		vreg_l13c_2p96: ldo13 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15c_1p9: ldo15 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16c_3p008: ldo16 {
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_pcie_1ln_core:
+		vdda_pcie_2ln_core:
+		vdda_csi_0_0p9:
+		vdda_csi_1_0p9:
+		vdda_csi_2_0p9:
+		vdda_csi_3_0p9:
+		vreg_l18c_0p88: ldo18 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>;
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&ufs_mem_hc {
+	status = "okay";
+
+	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l10a_2p96>;
+	vcc-max-microamp = <750000>;
+	vccq-supply = <&vreg_l5c_1p2>;
+	vccq-max-microamp = <700000>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+	vccq2-max-microamp = <750000>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l8c_1p2>;
+	vdda-max-microamp = <87100>;
+	vdda-pll-supply = <&vreg_l5a_0p88>;
+	vdda-pll-max-microamp = <18300>;
+};
+
+
+&usb_1_hsphy {
+	status = "okay";
+	vdda-pll-supply = <&vdd_usb_hs_core>;
+	vdda33-supply = <&vdda_usb_hs_3p1>;
+	vdda18-supply = <&vdda_usb_hs_1p8>;
+};
+
+&usb_1_qmpphy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l8c_1p2>;
+	vdda-pll-supply = <&vdda_usb_ss_dp_core_1>;
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC544D048
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 04:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhKKDUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 22:20:24 -0500
Received: from mx1.riseup.net ([198.252.153.129]:56372 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232644AbhKKDUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 22:20:22 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4HqRjT4WGJzF4mX;
        Wed, 10 Nov 2021 19:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1636600653; bh=+E6VEAxjqlIym6A5Rttl+DMEOX5o+2rRv/k27jFeC3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z996MHV8evvvQcSE5W+/t8VnosLGVXPGIpSAZVWTl88/vukHKwOLHSlptD9/WfMpf
         oFeAU/THCN8rLH5apBbAarnzC0KWNmXSaIjXskpWGa07f93EY39fW78GWGHTL1ReTl
         pre8PKRO0IAzzmis4PlNSAWiwL+6VrMV/giG0X4o=
X-Riseup-User-ID: 8FB5D1EF797A7D96A423D068CBECCB0D1A13D6D20AB4C596B6763F0AEED9EC11
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4HqRjQ43tVz5vVT;
        Wed, 10 Nov 2021 19:17:30 -0800 (PST)
From:   Dang Huynh <danct12@riseup.net>
To:     Dang Huynh <danct12@riseup.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexey Min <alexey.min@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Martin Botka <martin.botka@somainline.org>,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: [PATCH v3 3/8] arm64: dts: qcom: sdm660-xiaomi-lavender: Add RPM and fixed regulators
Date:   Thu, 11 Nov 2021 10:16:30 +0700
Message-Id: <20211111031635.3839947-4-danct12@riseup.net>
In-Reply-To: <20211111031635.3839947-1-danct12@riseup.net>
References: <20211111031635.3839947-1-danct12@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add most of the RPM PM660/PM660L regulators and the fixed ones,
defining the common electrical part of this platform.

Reviewed-by: Caleb Connolly <caleb@connolly.tech>
Reviewed-by: Konrad Dybcio <konradybcio@gmail.com>
Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 .../boot/dts/qcom/sdm660-xiaomi-lavender.dts  | 296 ++++++++++++++++++
 1 file changed, 296 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
index 1edc53fd6941..a6e3062dd520 100644
--- a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
+++ b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2020, Alexey Minnekhanov <alexey.min@gmail.com>
+ * Copyright (c) 2021, Dang Huynh <danct12@riseup.net>
  */
 
 /dts-v1/;
 
 #include "sdm660.dtsi"
+#include "pm660.dtsi"
+#include "pm660l.dtsi"
 
 / {
 	model = "Xiaomi Redmi Note 7";
@@ -20,6 +23,16 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -40,6 +53,289 @@ &blsp1_uart2 {
 	status = "okay";
 };
 
+&rpm_requests {
+	pm660l-regulators {
+		compatible = "qcom,rpm-pm660l-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+
+		vdd_l1_l9_l10-supply = <&vreg_s2b_1p05>;
+		vdd_l2-supply = <&vreg_bob>;
+		vdd_l3_l5_l7_l8-supply = <&vreg_bob>;
+		vdd_l4_l6-supply = <&vreg_bob>;
+		vdd_bob-supply = <&vph_pwr>;
+
+		vreg_s1b_1p125: s1 {
+			regulator-min-microvolt = <1125000>;
+			regulator-max-microvolt = <1125000>;
+			regulator-enable-ramp-delay = <200>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_s2b_1p05: s2 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-enable-ramp-delay = <200>;
+			regulator-ramp-delay = <0>;
+		};
+
+		/* LDOs */
+		vreg_l1b_0p925: l1 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <925000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		/* SDHCI 3.3V signal doesn't seem to be supported. */
+		vreg_l2b_2p95: l2 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <2696000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l3b_3p3: l3 {
+			regulator-min-microvolt = <1700000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l4b_2p95: l4 {
+			regulator-min-microvolt = <2944000>;
+			regulator-max-microvolt = <2952000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+
+			regulator-min-microamp = <200>;
+			regulator-max-microamp = <600000>;
+			regulator-system-load = <570000>;
+			regulator-allow-set-load;
+		};
+
+		/*
+		 * Downstream specifies a range of 1721-3600mV,
+		 * but the only assigned consumers are SDHCI2 VMMC
+		 * and Coresight QPDI that both request pinned 2.95V.
+		 * Tighten the range to 1.8-3.328 (closest to 3.3) to
+		 * make the mmc driver happy.
+		 */
+		vreg_l5b_2p95: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3328000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+			regulator-system-load = <800000>;
+		};
+
+		vreg_l7b_3p125: l7 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3125000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l8b_3p3: l8 {
+			regulator-min-microvolt = <3200000>;
+			regulator-max-microvolt = <3400000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3600000>;
+			regulator-enable-ramp-delay = <500>;
+			regulator-ramp-delay = <0>;
+		};
+	};
+
+	pm660-regulators {
+		compatible = "qcom,rpm-pm660-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+
+		vdd_l1_l6_l7-supply = <&vreg_s5a_1p35>;
+		vdd_l2_l3-supply = <&vreg_s2b_1p05>;
+		vdd_l5-supply = <&vreg_s2b_1p05>;
+		vdd_l8_l9_l10_l11_l12_l13_l14-supply = <&vreg_s4a_2p04>;
+		vdd_l15_l16_l17_l18_l19-supply = <&vreg_bob>;
+
+		/*
+		 * S1A (FTAPC0), S2A (FTAPC1), S3A (HFAPC1) are managed
+		 * by the Core Power Reduction hardened (CPRh) and the
+		 * Operating State Manager (OSM) HW automatically.
+		 */
+
+		vreg_s4a_2p04: s4 {
+			regulator-min-microvolt = <1805000>;
+			regulator-max-microvolt = <2040000>;
+			regulator-enable-ramp-delay = <200>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+		};
+
+		vreg_s5a_1p35: s5 {
+			regulator-min-microvolt = <1224000>;
+			regulator-max-microvolt = <1350000>;
+			regulator-enable-ramp-delay = <200>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_s6a_0p87: s6 {
+			regulator-min-microvolt = <504000>;
+			regulator-max-microvolt = <992000>;
+			regulator-enable-ramp-delay = <150>;
+			regulator-ramp-delay = <0>;
+		};
+
+		/* LDOs */
+		vreg_l1a_1p225: l1 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1250000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l2a_1p0: l2 {
+			regulator-min-microvolt = <950000>;
+			regulator-max-microvolt = <1010000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l3a_1p0: l3 {
+			regulator-min-microvolt = <950000>;
+			regulator-max-microvolt = <1010000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l5a_0p848: l5 {
+			regulator-min-microvolt = <525000>;
+			regulator-max-microvolt = <950000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l6a_1p3: l6 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1370000>;
+			regulator-allow-set-load;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l7a_1p2: l7 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l8a_1p8: l8 {
+			regulator-min-microvolt = <1750000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-system-load = <325000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l9a_1p8: l9 {
+			regulator-min-microvolt = <1750000>;
+			regulator-max-microvolt = <1900000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l10a_1p8: l10 {
+			regulator-min-microvolt = <1780000>;
+			regulator-max-microvolt = <1950000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l11a_1p8: l11 {
+			regulator-min-microvolt = <1780000>;
+			regulator-max-microvolt = <1950000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l12a_1p8: l12 {
+			regulator-min-microvolt = <1780000>;
+			regulator-max-microvolt = <1950000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		/* This gives power to the LPDDR4: never turn it off! */
+		vreg_l13a_1p8: l13 {
+			regulator-min-microvolt = <1780000>;
+			regulator-max-microvolt = <1950000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vreg_l14a_1p8: l14 {
+			regulator-min-microvolt = <1710000>;
+			regulator-max-microvolt = <1900000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l15a_1p8: l15 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l16a_2p7: l16 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+		};
+
+		vreg_l17a_1p8: l17 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <2952000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l19a_3p3: l19 {
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3400000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <8 4>;
 };
-- 
2.33.1


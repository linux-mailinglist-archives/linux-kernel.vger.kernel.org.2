Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA4422C6C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhJEP1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:27:15 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:44448 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236030AbhJEP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:27:11 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195ET843032075;
        Tue, 5 Oct 2021 17:25:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=PwEsk8zkmrpfizXyeItl/I5+19zlgjGxG1q8uuURRE4=;
 b=5WazbKLXqEaGt+el7ke8Hkk+V00m9LqS06Bmql3KujxBssoa7gIF42LyjEFKqOfgnxnQ
 em0X/Kb5foHSSBJI4zZdVAL6lzQO8rGZGaIGGK5WLE4hDB28HpwTneTwZM6tLzFnQSBU
 cMMYau4/0+wKcsFAMSGKE6KcVgYdrGVrVAm1+PfYUNjR098Bledf16UPRaqBJqyWqaKu
 amSUDsK56l4nvofa5DPh9ABGv5HIUeOSKtzfXeC8pbzPuWwPltRhZuMmYmdsTMUhXcEd
 tnfhtm3c2ZCeMCyiAD37JzpA3FhQ+KxFh5OaqxMbjHiWsawF8gaFb2enTqHu1WbEtuox mQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bgdt9uynv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 17:25:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0CB6610002A;
        Tue,  5 Oct 2021 17:25:00 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F0DF6229A8E;
        Tue,  5 Oct 2021 17:24:59 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct 2021 17:24:59
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 3/3] phy: stm32: add phy tuning support
Date:   Tue, 5 Oct 2021 17:24:53 +0200
Message-ID: <20211005152453.89330-4-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005152453.89330-1-amelie.delaunay@foss.st.com>
References: <20211005152453.89330-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-05_02,2021-10-04_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be necessary to adjust the phys settings to compensate parasitics.
This patch adds support of new optional properties to configure the tune
interface of the phys of stm32-usbphyc.
Properties are optional, that's why each property is skipped if not
found (-EINVAL).
Phy tuning is restored on resume because if deep low power state is
achieved, phy tuning configuration is reset.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 191 +++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 083593aea53a..238c4c8d4a15 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -20,6 +20,7 @@
 #define STM32_USBPHYC_PLL	0x0
 #define STM32_USBPHYC_MISC	0x8
 #define STM32_USBPHYC_MONITOR(X) (0x108 + ((X) * 0x100))
+#define STM32_USBPHYC_TUNE(X)	(0x10C + ((X) * 0x100))
 #define STM32_USBPHYC_VERSION	0x3F4
 
 /* STM32_USBPHYC_PLL bit fields */
@@ -41,6 +42,84 @@
 #define STM32_USBPHYC_MON_SEL_LOCKP 0x1F
 #define STM32_USBPHYC_MON_OUT_LOCKP BIT(3)
 
+/* STM32_USBPHYC_TUNE bit fields */
+#define INCURREN		BIT(0)
+#define INCURRINT		BIT(1)
+#define LFSCAPEN		BIT(2)
+#define HSDRVSLEW		BIT(3)
+#define HSDRVDCCUR		BIT(4)
+#define HSDRVDCLEV		BIT(5)
+#define HSDRVCURINCR		BIT(6)
+#define FSDRVRFADJ		BIT(7)
+#define HSDRVRFRED		BIT(8)
+#define HSDRVCHKITRM		GENMASK(12, 9)
+#define HSDRVCHKZTRM		GENMASK(14, 13)
+#define OTPCOMP			GENMASK(19, 15)
+#define SQLCHCTL		GENMASK(21, 20)
+#define HDRXGNEQEN		BIT(22)
+#define HSRXOFF			GENMASK(24, 23)
+#define HSFALLPREEM		BIT(25)
+#define SHTCCTCTLPROT		BIT(26)
+#define STAGSEL			BIT(27)
+
+enum boosting_vals {
+	BOOST_1_MA = 1,
+	BOOST_2_MA,
+	BOOST_MAX,
+};
+
+enum dc_level_vals {
+	DC_NOMINAL,
+	DC_PLUS_5_TO_7_MV,
+	DC_PLUS_10_TO_14_MV,
+	DC_MINUS_5_TO_7_MV,
+	DC_MAX,
+};
+
+enum current_trim {
+	CUR_NOMINAL,
+	CUR_PLUS_1_56_PCT,
+	CUR_PLUS_3_12_PCT,
+	CUR_PLUS_4_68_PCT,
+	CUR_PLUS_6_24_PCT,
+	CUR_PLUS_7_8_PCT,
+	CUR_PLUS_9_36_PCT,
+	CUR_PLUS_10_92_PCT,
+	CUR_PLUS_12_48_PCT,
+	CUR_PLUS_14_04_PCT,
+	CUR_PLUS_15_6_PCT,
+	CUR_PLUS_17_16_PCT,
+	CUR_PLUS_19_01_PCT,
+	CUR_PLUS_20_58_PCT,
+	CUR_PLUS_22_16_PCT,
+	CUR_PLUS_23_73_PCT,
+	CUR_MAX,
+};
+
+enum impedance_trim {
+	IMP_NOMINAL,
+	IMP_MINUS_2_OHMS,
+	IMP_MINUS_4_OMHS,
+	IMP_MINUS_6_OHMS,
+	IMP_MAX,
+};
+
+enum squelch_level {
+	SQLCH_NOMINAL,
+	SQLCH_PLUS_7_MV,
+	SQLCH_MINUS_5_MV,
+	SQLCH_PLUS_14_MV,
+	SQLCH_MAX,
+};
+
+enum rx_offset {
+	NO_RX_OFFSET,
+	RX_OFFSET_PLUS_5_MV,
+	RX_OFFSET_PLUS_10_MV,
+	RX_OFFSET_MINUS_5_MV,
+	RX_OFFSET_MAX,
+};
+
 /* STM32_USBPHYC_VERSION bit fields */
 #define MINREV			GENMASK(3, 0)
 #define MAJREV			GENMASK(7, 4)
@@ -60,6 +139,7 @@ struct stm32_usbphyc_phy {
 	struct regulator *vbus;
 	u32 index;
 	bool active;
+	u32 tune;
 };
 
 struct stm32_usbphyc {
@@ -375,6 +455,107 @@ static int stm32_usbphyc_clk48_register(struct stm32_usbphyc *usbphyc)
 	return ret;
 }
 
+static void stm32_usbphyc_phy_tuning(struct stm32_usbphyc *usbphyc,
+				     struct device_node *np, u32 index)
+{
+	struct stm32_usbphyc_phy *usbphyc_phy = usbphyc->phys[index];
+	u32 reg = STM32_USBPHYC_TUNE(index);
+	u32 otpcomp, val;
+	int ret;
+
+	/* Backup OTP compensation code */
+	otpcomp = FIELD_GET(OTPCOMP, readl_relaxed(usbphyc->base + reg));
+
+	ret = of_property_read_u32(np, "st,current-boost-microamp", &val);
+	if (ret != -EINVAL) {
+		if (!ret && val < BOOST_MAX) {
+			val = (val == BOOST_2_MA) ? 1 : 0;
+			usbphyc_phy->tune |= INCURREN | FIELD_PREP(INCURRINT, val);
+		} else {
+			dev_warn(usbphyc->dev, "phy%d: invalid st,current-boost-microamp\n", index);
+		}
+	}
+
+	if (!of_property_read_bool(np, "st,no-lsfs-fb-cap"))
+		usbphyc_phy->tune |= LFSCAPEN;
+
+	if (of_property_read_bool(np, "st,slow-hs-slew-rate"))
+		usbphyc_phy->tune |= HSDRVSLEW;
+
+	ret = of_property_read_u32(np, "st,tune-hs-dc-level", &val);
+	if (ret != -EINVAL) {
+		if (!ret && val < DC_MAX) {
+			if (val == DC_MINUS_5_TO_7_MV) {/* Decreases HS driver DC level */
+				usbphyc_phy->tune |= HSDRVDCCUR;
+			} else if (val > 0) {		/* Increases HS driver DC level */
+				val = (val == DC_PLUS_10_TO_14_MV) ? 1 : 0;
+				usbphyc_phy->tune |= HSDRVCURINCR | FIELD_PREP(HSDRVDCLEV, val);
+			}
+		} else {
+			dev_warn(usbphyc->dev, "phy%d: invalid st,tune-hs-dc-level\n", index);
+		}
+	}
+
+	if (of_property_read_bool(np, "st,enable-fs-rftime-tuning"))
+		usbphyc_phy->tune |= FSDRVRFADJ;
+
+	if (of_property_read_bool(np, "st,enable-hs-rftime-reduction"))
+		usbphyc_phy->tune |= HSDRVRFRED;
+
+	ret = of_property_read_u32(np, "st,trim-hs-current", &val);
+	if (ret != -EINVAL) {
+		if (!ret && val < CUR_MAX)
+			usbphyc_phy->tune |= FIELD_PREP(HSDRVCHKITRM, val);
+		else
+			dev_warn(usbphyc->dev, "phy%d: invalid st,trim-hs-current\n", index);
+	}
+
+	ret = of_property_read_u32(np, "st,trim-hs-impedance", &val);
+	if (ret != -EINVAL) {
+		if (!ret && val < IMP_MAX)
+			usbphyc_phy->tune |= FIELD_PREP(HSDRVCHKZTRM, val);
+		else
+			dev_warn(usbphyc->dev, "phy%d: invalid st,trim-hs-impedance\n", index);
+	}
+
+	ret = of_property_read_u32(np, "st,tune-squelch-level", &val);
+	if (ret != -EINVAL) {
+		if (!ret && val < SQLCH_MAX)
+			usbphyc_phy->tune |= FIELD_PREP(SQLCHCTL, val);
+		else
+			dev_warn(usbphyc->dev, "phy%d: invalid st,tune-squelch\n", index);
+	}
+
+	if (of_property_read_bool(np, "st,enable-hs-rx-gain-eq"))
+		usbphyc_phy->tune |= HDRXGNEQEN;
+
+	ret = of_property_read_u32(np, "st,tune-hs-rx-offset", &val);
+	if (ret != -EINVAL) {
+		if (!ret && val < RX_OFFSET_MAX)
+			usbphyc_phy->tune |= FIELD_PREP(HSRXOFF, val);
+		else
+			dev_warn(usbphyc->dev, "phy%d: invalid st,tune-hs-rx-offset\n", index);
+	}
+
+	if (of_property_read_bool(np, "st,no-hs-ftime-ctrl"))
+		usbphyc_phy->tune |= HSFALLPREEM;
+
+	if (!of_property_read_bool(np, "st,no-lsfs-sc"))
+		usbphyc_phy->tune |= SHTCCTCTLPROT;
+
+	if (of_property_read_bool(np, "st,enable-hs-tx-staggering"))
+		usbphyc_phy->tune |= STAGSEL;
+
+	/* Restore OTP compensation code */
+	usbphyc_phy->tune |= FIELD_PREP(OTPCOMP, otpcomp);
+
+	/*
+	 * By default, if no st,xxx tuning property is used, usbphyc_phy->tune is equal to
+	 * STM32_USBPHYC_TUNE reset value (LFSCAPEN | SHTCCTCTLPROT | OTPCOMP).
+	 */
+	writel_relaxed(usbphyc_phy->tune, usbphyc->base + reg);
+}
+
 static void stm32_usbphyc_switch_setup(struct stm32_usbphyc *usbphyc,
 				       u32 utmi_switch)
 {
@@ -550,6 +731,9 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 			usbphyc->phys[port]->vbus = NULL;
 		}
 
+		/* Configure phy tuning */
+		stm32_usbphyc_phy_tuning(usbphyc, child, index);
+
 		port++;
 	}
 
@@ -601,10 +785,17 @@ static int stm32_usbphyc_remove(struct platform_device *pdev)
 static int __maybe_unused stm32_usbphyc_resume(struct device *dev)
 {
 	struct stm32_usbphyc *usbphyc = dev_get_drvdata(dev);
+	struct stm32_usbphyc_phy *usbphyc_phy;
+	int port;
 
 	if (usbphyc->switch_setup >= 0)
 		stm32_usbphyc_switch_setup(usbphyc, usbphyc->switch_setup);
 
+	for (port = 0; port < usbphyc->nphys; port++) {
+		usbphyc_phy = usbphyc->phys[port];
+		writel_relaxed(usbphyc_phy->tune, usbphyc->base + STM32_USBPHYC_TUNE(port));
+	}
+
 	return 0;
 }
 
-- 
2.25.1


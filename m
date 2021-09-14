Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934F040B228
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhINOyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:54:51 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60432 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233992AbhINOys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:54:48 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E9qBZq029006;
        Tue, 14 Sep 2021 16:53:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=+XHamXQdZi2kEmdvcKwNfgbw0cyJVN5+1tLl4re1/3I=;
 b=xzMWf8WoRQl1+FMG4OAUg6PS3w0tfs6Xl1KNw2d7icdIlr3gCjDYI0fvo2rbz+xh/MrL
 YKk1ckJxdbbYOkPYgxqyHdrTZ2FS7fOFhyR4pXvAr7HJX91xnk0iOyBJUwigR6HCjjgq
 wuzGfuS2zf2RzuLbxBggCcJct3Sglhmv7MPTU9wteYhs5tlAEFXMFqQ+8EWqraleLON7
 z5ZQ/fYOwRbQRqGlkZVITCyuyWtksXzWFICjwA1kIWkFlopJi9LzS0iyo5oPDryAM7s0
 pbQ46nfyC8vdFIQyUH+uXCCxdhSsnSJql2xJGNvBUYC82APZ0tnbJkPoko34g4O06hCu hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b2sg19mpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 16:53:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4E3BA10002A;
        Tue, 14 Sep 2021 16:53:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4124F21A229;
        Tue, 14 Sep 2021 16:53:16 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 14 Sep 2021 16:53:16
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
Subject: [PATCH 3/3] phy: stm32: add phy tuning support
Date:   Tue, 14 Sep 2021 16:52:56 +0200
Message-ID: <20210914145256.243869-4-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914145256.243869-1-amelie.delaunay@foss.st.com>
References: <20210914145256.243869-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_03,2021-09-14_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be necessary to adjust the phys settings to compensate parasitics.
This patch adds support of the new optional property st,phy-tuning to
configure the tune interface of the phys of stm32-usbphyc.
Properties of st,phy-tuning phandle are also optional, that's why each
property is skipped if not found (-EINVAL).
Phy tuning is restored on resume because if deep low power state is
achieved, phy tuning configuration is reset.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 195 +++++++++++++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 083593aea53a..fb7ad7b8e815 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -20,6 +20,7 @@
 #define STM32_USBPHYC_PLL	0x0
 #define STM32_USBPHYC_MISC	0x8
 #define STM32_USBPHYC_MONITOR(X) (0x108 + ((X) * 0x100))
+#define STM32_USBPHYC_TUNE(X)	(0x10C + ((X) * 0x100))
 #define STM32_USBPHYC_VERSION	0x3F4
 
 /* STM32_USBPHYC_PLL bit fields */
@@ -41,6 +42,83 @@
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
+	DC_MINUS_5_TO_7_MV,
+	DC_PLUS_5_TO_7_MV,
+	DC_PLUS_10_TO_14_MV,
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
@@ -60,6 +138,7 @@ struct stm32_usbphyc_phy {
 	struct regulator *vbus;
 	u32 index;
 	bool active;
+	u32 tune;
 };
 
 struct stm32_usbphyc {
@@ -375,6 +454,111 @@ static int stm32_usbphyc_clk48_register(struct stm32_usbphyc *usbphyc)
 	return ret;
 }
 
+static void stm32_usbphyc_phy_tuning(struct stm32_usbphyc *usbphyc,
+				     struct device_node *np, u32 index)
+{
+	struct stm32_usbphyc_phy *usbphyc_phy = usbphyc->phys[index];
+	struct device_node *tune_np;
+	u32 reg = STM32_USBPHYC_TUNE(index);
+	u32 otpcomp, val;
+	int ret;
+
+	/* st,phy-tuning is optional so skip phy tuning if not found */
+	tune_np = of_parse_phandle(np, "st,phy-tuning", 0);
+	if (!tune_np)
+		return;
+
+	/* Backup OTP compensation code */
+	otpcomp = FIELD_GET(OTPCOMP, readl_relaxed(usbphyc->base + reg));
+
+	ret = of_property_read_u32(tune_np, "st,current-boost", &val);
+	if (ret != -EINVAL) {
+		if (!ret && val < BOOST_MAX) {
+			val = (val == BOOST_2_MA) ? 1 : 0;
+			usbphyc_phy->tune |= INCURREN | FIELD_PREP(INCURRINT, val);
+		} else {
+			dev_warn(usbphyc->dev, "phy%d: invalid st,current-boost value\n", index);
+		}
+	}
+
+	if (!of_property_read_bool(tune_np, "st,no-lsfs-fb-cap"))
+		usbphyc_phy->tune |= LFSCAPEN;
+
+	if (of_property_read_bool(tune_np, "st,hs-slew-ctrl"))
+		usbphyc_phy->tune |= HSDRVSLEW;
+
+	ret = of_property_read_u32(tune_np, "st,hs-dc-level", &val);
+	if (ret != -EINVAL) {
+		if (!ret && val < DC_MAX) {
+			if (val == DC_MINUS_5_TO_7_MV) {
+				usbphyc_phy->tune |= HSDRVDCCUR;
+			} else {
+				val = (val == DC_PLUS_10_TO_14_MV) ? 1 : 0;
+				usbphyc_phy->tune |= HSDRVCURINCR | FIELD_PREP(HSDRVDCLEV, val);
+			}
+		} else {
+			dev_warn(usbphyc->dev, "phy%d: invalid st,hs-dc-level value\n", index);
+		}
+	}
+
+	if (of_property_read_bool(tune_np, "st,fs-rftime-tuning"))
+		usbphyc_phy->tune |= FSDRVRFADJ;
+
+	if (of_property_read_bool(tune_np, "st,hs-rftime-reduction"))
+		usbphyc_phy->tune |= HSDRVRFRED;
+
+	ret = of_property_read_u32(tune_np, "st,hs-current-trim", &val);
+	if (ret != -EINVAL) {
+		if (!ret && val < CUR_MAX)
+			usbphyc_phy->tune |= FIELD_PREP(HSDRVCHKITRM, val);
+		else
+			dev_warn(usbphyc->dev, "phy%d: invalid st,hs-current-trim value\n", index);
+	}
+
+	ret = of_property_read_u32(tune_np, "st,hs-impedance-trim", &val);
+	if (ret != -EINVAL) {
+		if (!ret && val < IMP_MAX)
+			usbphyc_phy->tune |= FIELD_PREP(HSDRVCHKZTRM, val);
+		else
+			dev_warn(usbphyc->dev, "phy%d: invalid hs-impedance-trim value\n", index);
+	}
+
+	ret = of_property_read_u32(tune_np, "st,squelch-level", &val);
+	if (ret != -EINVAL) {
+		if (!ret && val < SQLCH_MAX)
+			usbphyc_phy->tune |= FIELD_PREP(SQLCHCTL, val);
+		else
+			dev_warn(usbphyc->dev, "phy%d: invalid st,squelch-level value\n", index);
+	}
+
+	if (of_property_read_bool(tune_np, "st,hs-rx-gain-eq"))
+		usbphyc_phy->tune |= HDRXGNEQEN;
+
+	ret = of_property_read_u32(tune_np, "st,hs-rx-offset", &val);
+	if (ret != -EINVAL) {
+		if (!ret && val < RX_OFFSET_MAX)
+			usbphyc_phy->tune |= FIELD_PREP(HSRXOFF, val);
+		else
+			dev_warn(usbphyc->dev, "phy%d: invalid st,hs-rx-offset value\n", index);
+	}
+
+	if (of_property_read_bool(tune_np, "st,no-hs-ftime-ctrl"))
+		usbphyc_phy->tune |= HSFALLPREEM;
+
+	if (!of_property_read_bool(tune_np, "st,no-lsfs-sc"))
+		usbphyc_phy->tune |= SHTCCTCTLPROT;
+
+	if (of_property_read_bool(tune_np, "st,hs-tx-staggering"))
+		usbphyc_phy->tune |= STAGSEL;
+
+	of_node_put(tune_np);
+
+	/* Restore OTP compensation code */
+	usbphyc_phy->tune |= FIELD_PREP(OTPCOMP, otpcomp);
+
+	writel_relaxed(usbphyc_phy->tune, usbphyc->base + reg);
+}
+
 static void stm32_usbphyc_switch_setup(struct stm32_usbphyc *usbphyc,
 				       u32 utmi_switch)
 {
@@ -550,6 +734,9 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 			usbphyc->phys[port]->vbus = NULL;
 		}
 
+		/* Configure phy tuning */
+		stm32_usbphyc_phy_tuning(usbphyc, child, index);
+
 		port++;
 	}
 
@@ -601,10 +788,18 @@ static int stm32_usbphyc_remove(struct platform_device *pdev)
 static int __maybe_unused stm32_usbphyc_resume(struct device *dev)
 {
 	struct stm32_usbphyc *usbphyc = dev_get_drvdata(dev);
+	struct stm32_usbphyc_phy *usbphyc_phy;
+	int port;
 
 	if (usbphyc->switch_setup >= 0)
 		stm32_usbphyc_switch_setup(usbphyc, usbphyc->switch_setup);
 
+	for (port = 0; port < usbphyc->nphys; port++) {
+		usbphyc_phy = usbphyc->phys[port];
+		if (usbphyc_phy->tune)
+			writel_relaxed(usbphyc_phy->tune, usbphyc->base + STM32_USBPHYC_TUNE(port));
+	}
+
 	return 0;
 }
 
-- 
2.25.1


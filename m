Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3556A3E7C89
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243559AbhHJPke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:40:34 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:27344 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243429AbhHJPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:38:43 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17AAlVvD027584;
        Tue, 10 Aug 2021 10:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=irJBOBLhsE1mq0f5FXZVdYE91m99aLTThi9zgZpov0g=;
 b=EZn9TekSVFbcZIsVLPA9yL78I+dMvotCLiF5Vl02eE+gXSG/RnZL7FL4ayarRry2hlEc
 2a/ZkfFSLiPOFZea/cECr0C6ainvOiPIuGcpbE455EX5hTEFTjAB7Z6lCXnZZtger5QL
 iTfoHC/ramGhsKjvVHF9Iku9Z4+QjxMWxyDlBPPC+F4J7g7goFtk1Zs0IpzI07RUVOQO
 6BnRvwKPvtWSJoB5kV9+aIntm+WJXs49o9/z1wWLmw6K8/rwnxhi0vUxyrQvmzUCKGpv
 R8rlohXuqSsa29qzw8L5wOyT+9BQMQhiEm5W5gcTEqGXoLRDnAMUdFdYBuxwMY53cd+Z DQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3abr0u0e2c-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Aug 2021 10:38:09 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 16:38:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 10 Aug 2021 16:38:05 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.221])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BAEFF46E;
        Tue, 10 Aug 2021 15:38:05 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 12/12] ASoC: cs42l42: Add control for audio slow-start switch
Date:   Tue, 10 Aug 2021 16:37:59 +0100
Message-ID: <20210810153759.24333-13-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810153759.24333-1-rf@opensource.cirrus.com>
References: <20210810153759.24333-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CAJRppaKcH18AbJAEtgdKiORnIPr60kI
X-Proofpoint-GUID: CAJRppaKcH18AbJAEtgdKiORnIPr60kI
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an ALSA control so that the slow-start audio ramp feature
can be disabled. This is useful for high-definition audio applications.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 33 ++++++++++++++++++++++++++++++++-
 sound/soc/codecs/cs42l42.h |  3 +++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index b2632fdef9a0..ae9190720380 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -43,6 +43,7 @@ static const struct reg_default cs42l42_reg_defaults[] = {
 	{ CS42L42_MCLK_STATUS,			0x02 },
 	{ CS42L42_MCLK_CTL,			0x02 },
 	{ CS42L42_SFTRAMP_RATE,			0xA4 },
+	{ CS42L42_SLOW_START_ENABLE,		0x70 },
 	{ CS42L42_I2C_DEBOUNCE,			0x88 },
 	{ CS42L42_I2C_STRETCH,			0x03 },
 	{ CS42L42_I2C_TIMEOUT,			0xB7 },
@@ -198,6 +199,7 @@ static bool cs42l42_readable_register(struct device *dev, unsigned int reg)
 	case CS42L42_MCLK_STATUS:
 	case CS42L42_MCLK_CTL:
 	case CS42L42_SFTRAMP_RATE:
+	case CS42L42_SLOW_START_ENABLE:
 	case CS42L42_I2C_DEBOUNCE:
 	case CS42L42_I2C_STRETCH:
 	case CS42L42_I2C_TIMEOUT:
@@ -408,6 +410,30 @@ static const struct regmap_config cs42l42_regmap = {
 static DECLARE_TLV_DB_SCALE(adc_tlv, -9700, 100, true);
 static DECLARE_TLV_DB_SCALE(mixer_tlv, -6300, 100, true);
 
+static int cs42l42_slow_start_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	u8 val;
+
+	/* all bits of SLOW_START_EN must be 1 to enable */
+	switch (ucontrol->value.integer.value[0]) {
+	case 0:
+		val = 0;
+		break;
+	case 1:
+		val = CS42L42_SLOW_START_EN_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_component_update_bits(component, CS42L42_SLOW_START_ENABLE,
+				      CS42L42_SLOW_START_EN_MASK, val);
+
+	return 0;
+}
+
 static const char * const cs42l42_hpf_freq_text[] = {
 	"1.86Hz", "120Hz", "235Hz", "466Hz"
 };
@@ -461,7 +487,12 @@ static const struct snd_kcontrol_new cs42l42_snd_controls[] = {
 	SOC_ENUM("HP Volume Scale", cs42l42_full_scale_vol_enum),
 	SOC_DOUBLE_R_TLV("Mixer Volume", CS42L42_MIXER_CHA_VOL,
 			 CS42L42_MIXER_CHB_VOL, CS42L42_MIXER_CH_VOL_SHIFT,
-				0x3f, 1, mixer_tlv)
+				0x3f, 1, mixer_tlv),
+
+	/* Global */
+	SOC_SINGLE_EXT("Slow Start Switch", CS42L42_SLOW_START_ENABLE,
+			CS42L42_SLOW_START_EN_SHIFT, true, false,
+			snd_soc_get_volsw, cs42l42_slow_start_put),
 };
 
 static int cs42l42_hp_adc_ev(struct snd_soc_dapm_widget *w,
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index b10796d755ae..85ba1d846072 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -62,6 +62,9 @@
 #define CS42L42_INTERNAL_FS_MASK	(1 << CS42L42_INTERNAL_FS_SHIFT)
 
 #define CS42L42_SFTRAMP_RATE		(CS42L42_PAGE_10 + 0x0A)
+#define CS42L42_SLOW_START_ENABLE	(CS42L42_PAGE_10 + 0x0B)
+#define CS42L42_SLOW_START_EN_MASK	GENMASK(6, 4)
+#define CS42L42_SLOW_START_EN_SHIFT	4
 #define CS42L42_I2C_DEBOUNCE		(CS42L42_PAGE_10 + 0x0E)
 #define CS42L42_I2C_STRETCH		(CS42L42_PAGE_10 + 0x0F)
 #define CS42L42_I2C_TIMEOUT		(CS42L42_PAGE_10 + 0x10)
-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22703DBC00
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbhG3PTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:19:50 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:59752 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239655AbhG3PTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:19:34 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16UEL0df003614;
        Fri, 30 Jul 2021 10:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=u/raanWu8QxKw7hxEaMYUQ8wjoKB+rgkVuf1kEvYiUU=;
 b=YUcTjmrZSHI2cDqTVPeK6rvlz7mcdzI+oPkmMRAfYk3iLCpzo4o5OPtOrUxM9Fz0vnyD
 BUMd2yWIfHCoa5WOPhTrHbV4o7BLO2sndqzeLv/pPxaskkWl8DGNd+k4ywoOocM+lnNa
 1DJhg0NOcPuuE4CWpMr5NfCozXGwwrcSNgcaSNj0nYPRzdIQBR2RRYXz/uGrV0JxjEus
 7mLS+I8H6cR/IxhjGCLoXC7J3zETveA7+diwPyfeXoEwOpVT9WhCflGk9TeCWbBbxnQ5
 NVbs4lARN64wsD/hbUc8C6O1Y5rBI7qfZfH4RaVniht1a0GrUaLejcbvukskUmasaEDG vA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a41wd181n-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Jul 2021 10:19:17 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 30 Jul
 2021 16:19:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 30 Jul 2021 16:19:09 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 22DEB45D;
        Fri, 30 Jul 2021 15:19:09 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v3 11/27] ALSA: hda/cs8409: Prevent I2C access during suspend time
Date:   Fri, 30 Jul 2021 16:18:28 +0100
Message-ID: <20210730151844.7873-12-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730151844.7873-1-vitalyr@opensource.cirrus.com>
References: <20210730151844.7873-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GVslHpCjrnPGDDMmvazMJ7M8BKSt3lkv
X-Proofpoint-ORIG-GUID: GVslHpCjrnPGDDMmvazMJ7M8BKSt3lkv
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107300102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v2:
- No changes

Changes in v3:
- No changes

 sound/pci/hda/patch_cs8409.c | 14 ++++++++++++++
 sound/pci/hda/patch_cs8409.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 4ad832f5c4ba..0b13bcecd778 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -127,9 +127,13 @@ static int cs8409_i2c_wait_complete(struct hda_codec *codec)
 static int cs8409_i2c_read(struct hda_codec *codec, unsigned int i2c_address, unsigned int i2c_reg,
 			   unsigned int paged)
 {
+	struct cs8409_spec *spec = codec->spec;
 	unsigned int i2c_reg_data;
 	unsigned int read_data;
 
+	if (spec->cs42l42_suspended)
+		return -EPERM;
+
 	cs8409_enable_i2c_clock(codec, 1);
 	cs8409_vendor_coef_set(codec, CS8409_I2C_ADDR, i2c_address);
 
@@ -172,8 +176,12 @@ static int cs8409_i2c_read(struct hda_codec *codec, unsigned int i2c_address, un
 static int cs8409_i2c_write(struct hda_codec *codec, unsigned int i2c_address, unsigned int i2c_reg,
 			    unsigned int i2c_data, unsigned int paged)
 {
+	struct cs8409_spec *spec = codec->spec;
 	unsigned int i2c_reg_data;
 
+	if (spec->cs42l42_suspended)
+		return -EPERM;
+
 	cs8409_enable_i2c_clock(codec, 1);
 	cs8409_vendor_coef_set(codec, CS8409_I2C_ADDR, i2c_address);
 
@@ -371,6 +379,8 @@ static void cs8409_cs42l42_reset(struct hda_codec *codec)
 	/* wait ~10ms */
 	usleep_range(10000, 15000);
 
+	spec->cs42l42_suspended = 0;
+
 	mutex_lock(&spec->cs8409_i2c_mux);
 
 	/* Clear interrupts, by reading interrupt status registers */
@@ -594,6 +604,9 @@ static int cs8409_suspend(struct hda_codec *codec)
 	/* Power down CS42L42 ASP/EQ/MIX/HP */
 	cs8409_i2c_write(codec, CS42L42_I2C_ADDR, 0x1101, 0xfe, 1);
 	mutex_unlock(&spec->cs8409_i2c_mux);
+
+	spec->cs42l42_suspended = 1;
+
 	/* Assert CS42L42 RTS# line */
 	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_DATA, 0);
 
@@ -759,6 +772,7 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 
 		spec->cs42l42_hp_jack_in = 0;
 		spec->cs42l42_mic_jack_in = 0;
+		spec->cs42l42_suspended = 1;
 
 		/* Basic initial sequence for specific hw configuration */
 		snd_hda_sequence_write(codec, cs8409_cs42l42_init_verbs);
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 1d3ce28415fa..0f2084b6ec8e 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -269,6 +269,7 @@ struct cs8409_spec {
 	unsigned int cs42l42_hp_jack_in:1;
 	unsigned int cs42l42_mic_jack_in:1;
 	unsigned int cs42l42_volume_init:1;
+	unsigned int cs42l42_suspended:1;
 	char cs42l42_hp_volume[CS42L42_HP_CH];
 	char cs42l42_hs_mic_volume[CS42L42_HS_MIC_CH];
 
-- 
2.25.1


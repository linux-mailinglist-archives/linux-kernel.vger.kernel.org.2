Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EC03E980E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhHKS6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:58:15 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60302 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231259AbhHKS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:58:09 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17BIq9wt001296;
        Wed, 11 Aug 2021 13:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=t540UbFt0EkF6Wl7WNpw/ciqir5n6yyjGROKWPNJ07I=;
 b=pmVbfNteF5YP3bl5tBSKk76u3O2GBD1OV3pxIgizYxeX8GXlRHJu1v2+gQYpWAEtKMP8
 8PQTd4WP/vwqiLOWiNyMFkHBO7+8tQwYZBmFIiqy5hWM2QMC/M5PaFoBngZeziflN4Y5
 RZLQhpgOSl4MLQV6uGzUqNL/vHggWq4PyJOl2PUdfdg3PiWHhGeXUMIrAIosOu6tr9nw
 GvVmDKyhvaWn22xpH5oEl+qO/RrTbW/1BIC9+1yjRYgpwDVG6lGb0Zp96zonHxvkaobE
 ix626SlsUF5Nmi4qUlxBGYrj/yPQY+G1w4FAScn/7KTLhmFORb87WSEjIQ8yCzmxPz98 Mw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3acgjkra4r-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Aug 2021 13:57:38 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 19:57:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 11 Aug 2021 19:57:33 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 274DC45D;
        Wed, 11 Aug 2021 18:57:33 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 27/27] ALSA: hda/cs8409: Unmute/Mute codec when stream starts/stops
Date:   Wed, 11 Aug 2021 19:56:54 +0100
Message-ID: <20210811185654.6837-28-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
References: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UOgr3c-r5lpfNAE6wuW9zVWQ7NmkKx5G
X-Proofpoint-ORIG-GUID: UOgr3c-r5lpfNAE6wuW9zVWQ7NmkKx5G
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Codec is muted on init, and then unmuted when the stream starts.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v2:
- No changes

Changes in v3:
- No changes

Changes in v4:
- No changes

 sound/pci/hda/patch_cs8409-tables.c |  20 ++---
 sound/pci/hda/patch_cs8409.c        | 123 +++++++++++++++++++++++-----
 sound/pci/hda/patch_cs8409.h        |   7 ++
 3 files changed, 120 insertions(+), 30 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index a9a0b8e3b2a9..0fb0a428428b 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -81,7 +81,7 @@ static const struct cs8409_i2c_param cs42l42_init_reg_seq[] = {
 	{ 0x1010, 0xB0 },
 	{ 0x1D01, 0x00 },
 	{ 0x1D02, 0x06 },
-	{ 0x1D03, 0x00 },
+	{ 0x1D03, 0x9F },
 	{ 0x1107, 0x01 },
 	{ 0x1009, 0x02 },
 	{ 0x1007, 0x03 },
@@ -111,8 +111,8 @@ static const struct cs8409_i2c_param cs42l42_init_reg_seq[] = {
 	{ 0x2901, 0x01 },
 	{ 0x1101, 0x0A },
 	{ 0x1102, 0x84 },
-	{ 0x2301, 0x00 },
-	{ 0x2303, 0x00 },
+	{ 0x2301, 0x3F },
+	{ 0x2303, 0x3F },
 	{ 0x2302, 0x3f },
 	{ 0x2001, 0x03 },
 	{ 0x1B75, 0xB6 },
@@ -284,7 +284,7 @@ static const struct cs8409_i2c_param dolphin_c0_init_reg_seq[] = {
 	{ 0x1010, 0xB0 },
 	{ 0x1D01, 0x00 },
 	{ 0x1D02, 0x06 },
-	{ 0x1D03, 0x00 },
+	{ 0x1D03, 0x9F },
 	{ 0x1107, 0x01 },
 	{ 0x1009, 0x02 },
 	{ 0x1007, 0x03 },
@@ -309,8 +309,8 @@ static const struct cs8409_i2c_param dolphin_c0_init_reg_seq[] = {
 	{ 0x1101, 0x0A },
 	{ 0x1102, 0x84 },
 	{ 0x2001, 0x03 },
-	{ 0x2301, 0x00 },
-	{ 0x2303, 0x00 },
+	{ 0x2301, 0x3F },
+	{ 0x2303, 0x3F },
 	{ 0x2302, 0x3f },
 	{ 0x1B75, 0xB6 },
 	{ 0x1B73, 0xC2 },
@@ -340,7 +340,7 @@ static const struct cs8409_i2c_param dolphin_c1_init_reg_seq[] = {
 	{ 0x1010, 0xB0 },
 	{ 0x1D01, 0x00 },
 	{ 0x1D02, 0x06 },
-	{ 0x1D03, 0x00 },
+	{ 0x1D03, 0x9F },
 	{ 0x1107, 0x01 },
 	{ 0x1009, 0x02 },
 	{ 0x1007, 0x03 },
@@ -365,8 +365,8 @@ static const struct cs8409_i2c_param dolphin_c1_init_reg_seq[] = {
 	{ 0x1101, 0x0E },
 	{ 0x1102, 0x84 },
 	{ 0x2001, 0x01 },
-	{ 0x2301, 0x00 },
-	{ 0x2303, 0x00 },
+	{ 0x2301, 0x3F },
+	{ 0x2303, 0x3F },
 	{ 0x2302, 0x3f },
 	{ 0x1B75, 0xB6 },
 	{ 0x1B73, 0xC2 },
@@ -377,7 +377,7 @@ static const struct cs8409_i2c_param dolphin_c1_init_reg_seq[] = {
 	{ 0x1112, 0x00 },
 	{ 0x1113, 0x80 },
 	{ 0x1C03, 0xC0 },
-	{ 0x1101, 0x02 },
+	{ 0x1101, 0x06 },
 	{ 0x1316, 0xff },
 	{ 0x1317, 0xff },
 	{ 0x1318, 0xff },
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 928972b4315d..272497b6cfcb 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -475,6 +475,38 @@ int cs42l42_volume_get(struct snd_kcontrol *kctrl, struct snd_ctl_elem_value *uc
 	return 0;
 }
 
+static void cs42l42_mute(struct sub_codec *cs42l42, int vol_type,
+	unsigned int chs, bool mute)
+{
+	if (mute) {
+		if (vol_type == CS42L42_VOL_DAC) {
+			if (chs & BIT(0))
+				cs8409_i2c_write(cs42l42, CS42L42_REG_HS_VOL_CHA, 0x3f);
+			if (chs & BIT(1))
+				cs8409_i2c_write(cs42l42, CS42L42_REG_HS_VOL_CHB, 0x3f);
+		} else if (vol_type == CS42L42_VOL_ADC) {
+			if (chs & BIT(0))
+				cs8409_i2c_write(cs42l42, CS42L42_REG_AMIC_VOL, 0x9f);
+		}
+	} else {
+		if (vol_type == CS42L42_VOL_DAC) {
+			if (chs & BIT(0))
+				cs8409_i2c_write(cs42l42, CS42L42_REG_HS_VOL_CHA,
+					-(cs42l42->vol[CS42L42_DAC_CH0_VOL_OFFSET])
+					& CS42L42_REG_HS_VOL_MASK);
+			if (chs & BIT(1))
+				cs8409_i2c_write(cs42l42, CS42L42_REG_HS_VOL_CHB,
+					-(cs42l42->vol[CS42L42_DAC_CH1_VOL_OFFSET])
+					& CS42L42_REG_HS_VOL_MASK);
+		} else if (vol_type == CS42L42_VOL_ADC) {
+			if (chs & BIT(0))
+				cs8409_i2c_write(cs42l42, CS42L42_REG_AMIC_VOL,
+					cs42l42->vol[CS42L42_ADC_VOL_OFFSET]
+					& CS42L42_REG_AMIC_VOL_MASK);
+		}
+	}
+}
+
 int cs42l42_volume_put(struct snd_kcontrol *kctrl, struct snd_ctl_elem_value *uctrl)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kctrl);
@@ -486,25 +518,20 @@ int cs42l42_volume_put(struct snd_kcontrol *kctrl, struct snd_ctl_elem_value *uc
 
 	switch (ofs) {
 	case CS42L42_VOL_DAC:
-		if (chs & BIT(0)) {
+		if (chs & BIT(0))
 			cs42l42->vol[ofs] = *valp;
-			cs8409_i2c_write(cs42l42, CS42L42_REG_HS_VOL_CHA,
-					 -(cs42l42->vol[ofs]) & CS42L42_REG_HS_VOL_MASK);
-		}
 		if (chs & BIT(1)) {
-			ofs++;
 			valp++;
-			cs42l42->vol[ofs] = *valp;
-			cs8409_i2c_write(cs42l42, CS42L42_REG_HS_VOL_CHB,
-					 -(cs42l42->vol[ofs]) & CS42L42_REG_HS_VOL_MASK);
+			cs42l42->vol[ofs + 1] = *valp;
 		}
+		if (spec->playback_started)
+			cs42l42_mute(cs42l42, CS42L42_VOL_DAC, chs, false);
 		break;
 	case CS42L42_VOL_ADC:
-		if (chs & BIT(0)) {
+		if (chs & BIT(0))
 			cs42l42->vol[ofs] = *valp;
-			cs8409_i2c_write(cs42l42, CS42L42_REG_AMIC_VOL,
-					 cs42l42->vol[ofs] & CS42L42_REG_AMIC_VOL_MASK);
-		}
+		if (spec->capture_started)
+			cs42l42_mute(cs42l42, CS42L42_VOL_ADC, chs, false);
 		break;
 	default:
 		break;
@@ -513,6 +540,64 @@ int cs42l42_volume_put(struct snd_kcontrol *kctrl, struct snd_ctl_elem_value *uc
 	return 0;
 }
 
+static void cs42l42_playback_pcm_hook(struct hda_pcm_stream *hinfo,
+				   struct hda_codec *codec,
+				   struct snd_pcm_substream *substream,
+				   int action)
+{
+	struct cs8409_spec *spec = codec->spec;
+	struct sub_codec *cs42l42;
+	int i;
+	bool mute;
+
+	switch (action) {
+	case HDA_GEN_PCM_ACT_PREPARE:
+		mute = false;
+		spec->playback_started = 1;
+		break;
+	case HDA_GEN_PCM_ACT_CLEANUP:
+		mute = true;
+		spec->playback_started = 0;
+		break;
+	default:
+		return;
+	}
+
+	for (i = 0; i < spec->num_scodecs; i++) {
+		cs42l42 = spec->scodecs[i];
+		cs42l42_mute(cs42l42, CS42L42_VOL_DAC, 0x3, mute);
+	}
+}
+
+static void cs42l42_capture_pcm_hook(struct hda_pcm_stream *hinfo,
+				   struct hda_codec *codec,
+				   struct snd_pcm_substream *substream,
+				   int action)
+{
+	struct cs8409_spec *spec = codec->spec;
+	struct sub_codec *cs42l42;
+	int i;
+	bool mute;
+
+	switch (action) {
+	case HDA_GEN_PCM_ACT_PREPARE:
+		mute = false;
+		spec->capture_started = 1;
+		break;
+	case HDA_GEN_PCM_ACT_CLEANUP:
+		mute = true;
+		spec->capture_started = 0;
+		break;
+	default:
+		return;
+	}
+
+	for (i = 0; i < spec->num_scodecs; i++) {
+		cs42l42 = spec->scodecs[i];
+		cs42l42_mute(cs42l42, CS42L42_VOL_ADC, 0x3, mute);
+	}
+}
+
 /* Configure CS42L42 slave codec for jack autodetect */
 static void cs42l42_enable_jack_detect(struct sub_codec *cs42l42)
 {
@@ -658,14 +743,6 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 	/* Clear interrupts, by reading interrupt status registers */
 	cs8409_i2c_bulk_read(cs42l42, irq_regs, ARRAY_SIZE(irq_regs));
 
-	/* Restore Volumes after Resume */
-	cs8409_i2c_write(cs42l42, CS42L42_REG_HS_VOL_CHA,
-			 -(cs42l42->vol[1]) & CS42L42_REG_HS_VOL_MASK);
-	cs8409_i2c_write(cs42l42, CS42L42_REG_HS_VOL_CHB,
-			 -(cs42l42->vol[2]) & CS42L42_REG_HS_VOL_MASK);
-	cs8409_i2c_write(cs42l42, CS42L42_REG_AMIC_VOL,
-			 cs42l42->vol[0] & CS42L42_REG_AMIC_VOL_MASK);
-
 	if (cs42l42->full_scale_vol)
 		cs8409_i2c_write(cs42l42, 0x2001, 0x01);
 
@@ -925,6 +1002,9 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		/* Fix Sample Rate to 48kHz */
 		spec->gen.stream_analog_playback = &cs42l42_48k_pcm_analog_playback;
 		spec->gen.stream_analog_capture = &cs42l42_48k_pcm_analog_capture;
+		/* add hooks */
+		spec->gen.pcm_playback_hook = cs42l42_playback_pcm_hook;
+		spec->gen.pcm_capture_hook = cs42l42_capture_pcm_hook;
 		/* Set initial DMIC volume to -26 dB */
 		snd_hda_codec_amp_init_stereo(codec, CS8409_CS42L42_DMIC_ADC_PIN_NID,
 					      HDA_INPUT, 0, 0xff, 0x19);
@@ -1120,6 +1200,9 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 		/* Fix Sample Rate to 48kHz */
 		spec->gen.stream_analog_playback = &cs42l42_48k_pcm_analog_playback;
 		spec->gen.stream_analog_capture = &cs42l42_48k_pcm_analog_capture;
+		/* add hooks */
+		spec->gen.pcm_playback_hook = cs42l42_playback_pcm_hook;
+		spec->gen.pcm_capture_hook = cs42l42_capture_pcm_hook;
 		snd_hda_gen_add_kctl(&spec->gen, "Headphone Playback Volume",
 				     &cs42l42_dac_volume_mixer);
 		snd_hda_gen_add_kctl(&spec->gen, "Mic Capture Volume", &cs42l42_adc_volume_mixer);
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 09987daa9cbf..207315ad5bf6 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -280,6 +280,10 @@ enum {
 	CS42L42_VOL_DAC,
 };
 
+#define CS42L42_ADC_VOL_OFFSET			(CS42L42_VOL_ADC)
+#define CS42L42_DAC_CH0_VOL_OFFSET		(CS42L42_VOL_DAC)
+#define CS42L42_DAC_CH1_VOL_OFFSET		(CS42L42_VOL_DAC + 1)
+
 struct cs8409_i2c_param {
 	unsigned int addr;
 	unsigned int value;
@@ -327,6 +331,9 @@ struct cs8409_spec {
 	unsigned int dev_addr;
 	struct delayed_work i2c_clk_work;
 
+	unsigned int playback_started:1;
+	unsigned int capture_started:1;
+
 	/* verb exec op override */
 	int (*exec_verb)(struct hdac_device *dev, unsigned int cmd, unsigned int flags,
 			 unsigned int *res);
-- 
2.25.1


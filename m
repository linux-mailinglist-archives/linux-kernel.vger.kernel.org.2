Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9BB3D8F78
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhG1Nrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:47:33 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:3026 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236652AbhG1No5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:44:57 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16S5XUr4014335;
        Wed, 28 Jul 2021 08:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=yVqEmPZxiL8drklmk0pAesV5mI/FqvN84HmgOLrlxJo=;
 b=I6tNMckLpyrY1z5yWBWlMRPrc9mZVwSxc0uU8ZM5JIT4L5BVGOiiYK4GOHEB8hX1QpvH
 OsAG2luhKta2El+i67XGbMAubVEswDbmVamr3BF56mMlfhu4EkL+JjED1DAaCT8MnYwv
 3YR4hYkZvKC2OdnKRLt6w6w8o2Tl0TRu7+61gVFGOvTptPR9L8y0yN8Rp3CT/IDK1qhC
 ueum5Yrnvmh54aBaOIwGbqWjhJ3eeArEPHxqkcLUmwjXLZt7s9EhxAMJ2JC06wji+jx+
 CjDJHGq277fIdm4epyMm/xjjUHdf0d5VEiWfL2/05F8m0aJEdOzIq6OfXCVjKnaUREwj Qg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3a30q20fx9-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 08:44:44 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 28 Jul
 2021 14:44:38 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 28 Jul 2021 14:44:38 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9268946E;
        Wed, 28 Jul 2021 13:44:38 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 27/27] ALSA: hda/cs8409: Unmute/Mute codec when stream starts/stops
Date:   Wed, 28 Jul 2021 14:44:08 +0100
Message-ID: <20210728134408.369396-28-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
References: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: t-waweEa4XHz3Kia3YUgNJX0hZgq2m_U
X-Proofpoint-GUID: t-waweEa4XHz3Kia3YUgNJX0hZgq2m_U
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Codec is muted on init, and then unmuted when the stream starts.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Changes in v2:
- No changes

---
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
index 0baed8bebfbb..bd81004fc81e 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -454,6 +454,38 @@ int cs42l42_volume_get(struct snd_kcontrol *kctrl, struct snd_ctl_elem_value *uc
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
@@ -465,25 +497,20 @@ int cs42l42_volume_put(struct snd_kcontrol *kctrl, struct snd_ctl_elem_value *uc
 
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
@@ -492,6 +519,64 @@ int cs42l42_volume_put(struct snd_kcontrol *kctrl, struct snd_ctl_elem_value *uc
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
@@ -637,14 +722,6 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
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
 
@@ -897,6 +974,9 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		/* Fix Sample Rate to 48kHz */
 		spec->gen.stream_analog_playback = &cs42l42_48k_pcm_analog_playback;
 		spec->gen.stream_analog_capture = &cs42l42_48k_pcm_analog_capture;
+		/* add hooks */
+		spec->gen.pcm_playback_hook = cs42l42_playback_pcm_hook;
+		spec->gen.pcm_capture_hook = cs42l42_capture_pcm_hook;
 		/* Set initial DMIC volume to -26 dB */
 		snd_hda_codec_amp_init_stereo(codec, CS8409_CS42L42_DMIC_ADC_PIN_NID,
 					      HDA_INPUT, 0, 0xff, 0x19);
@@ -1092,6 +1172,9 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
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


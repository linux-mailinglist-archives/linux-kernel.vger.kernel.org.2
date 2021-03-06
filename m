Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D232F9AF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 12:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhCFLVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 06:21:33 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:42044 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229917AbhCFLV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 06:21:27 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 126BHfEt014727;
        Sat, 6 Mar 2021 05:20:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=SICbcv9u5SQCV1fFOJFmPnFZ0HGeL49+Ka2E8ka69z4=;
 b=MLAuM7I00g5EZC27fOacONRYB3zeJvHxSvK2nE0PNk3zYNWegtsGzhoGe8VHe3EXla3e
 vrKAdnUWVsTI8dnf6x4CwP5owHYifIcW/NzjuktefQ5iwpp6q22smQzMfeHjE9bJ8Fb6
 Mif77cpzvl2NuwjYmKc3fC5eeEDjM20OrpfzPfXL07DrrvLbtss81cxCxtM7NCWu2ji4
 x1xs95y4zQBZtK7hpYCZFXmHa4OhEYxIlrAI+IIaxzhb/VhaBs2mvy7kwDo9sLZIdCg1
 UuA3966vtZu1+k0etDWX1BWcZklPrEE5vxC7WD/hqPq5PPYlZjomUiUs6YeOG7vWhRCY Ig== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 37471vr2n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Mar 2021 05:20:43 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 6 Mar 2021
 11:19:41 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sat, 6 Mar 2021 11:19:41 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C649211CB;
        Sat,  6 Mar 2021 11:19:35 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 4/4] ALSA: hda/cirrus: Add Headphone and Headset MIC Volume Control
Date:   Sat, 6 Mar 2021 11:19:34 +0000
Message-ID: <20210306111934.4832-5-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210306111934.4832-1-vitalyr@opensource.cirrus.com>
References: <20210306111934.4832-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103060069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

CS8409 does not support Volume Control for NIDs 0x24 (the Headphones),
or 0x34 (The Headset Mic).
However, CS42L42 codec does support gain control for both.
We can add support for Volume Controls, by writing the the CS42L42
regmap via i2c commands, using custom info, get and put volume
functions, saved in the control.

Tested on DELL Inspiron-3500, DELL Inspiron-3501, DELL Inspiron-3500

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v3:
- Added restore volumes after resume
- Removed redundant debug logging after testing


 sound/pci/hda/patch_cirrus.c | 200 +++++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 1d2f6a1224e6..6a9e5c803977 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -21,6 +21,9 @@
 /*
  */
 
+#define CS42L42_HP_CH     (2U)
+#define CS42L42_HS_MIC_CH (1U)
+
 struct cs_spec {
 	struct hda_gen_spec gen;
 
@@ -42,6 +45,9 @@ struct cs_spec {
 
 	unsigned int cs42l42_hp_jack_in:1;
 	unsigned int cs42l42_mic_jack_in:1;
+	unsigned int cs42l42_volume_init:1;
+	char cs42l42_hp_volume[CS42L42_HP_CH];
+	char cs42l42_hs_mic_volume[CS42L42_HS_MIC_CH];
 
 	struct mutex cs8409_i2c_mux;
 
@@ -1260,6 +1266,14 @@ static int patch_cs4213(struct hda_codec *codec)
 #define CIR_I2C_QWRITE	0x005D
 #define CIR_I2C_QREAD	0x005E
 
+#define CS8409_CS42L42_HP_VOL_REAL_MIN   (-63)
+#define CS8409_CS42L42_HP_VOL_REAL_MAX   (0)
+#define CS8409_CS42L42_AMIC_VOL_REAL_MIN (-97)
+#define CS8409_CS42L42_AMIC_VOL_REAL_MAX (12)
+#define CS8409_CS42L42_REG_HS_VOLUME_CHA (0x2301)
+#define CS8409_CS42L42_REG_HS_VOLUME_CHB (0x2303)
+#define CS8409_CS42L42_REG_AMIC_VOLUME   (0x1D03)
+
 struct cs8409_i2c_param {
 	unsigned int addr;
 	unsigned int reg;
@@ -1580,6 +1594,165 @@ static unsigned int cs8409_i2c_write(struct hda_codec *codec,
 	return retval;
 }
 
+static int cs8409_cs42l42_volume_info(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	u16 nid = get_amp_nid(kcontrol);
+	u8 chs = get_amp_channels(kcontrol);
+
+	codec_dbg(codec, "%s() nid: %d\n", __func__, nid);
+	switch (nid) {
+	case CS8409_CS42L42_HP_PIN_NID:
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+		uinfo->count = chs == 3 ? 2 : 1;
+		uinfo->value.integer.min = CS8409_CS42L42_HP_VOL_REAL_MIN;
+		uinfo->value.integer.max = CS8409_CS42L42_HP_VOL_REAL_MAX;
+		break;
+	case CS8409_CS42L42_AMIC_PIN_NID:
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+		uinfo->count = chs == 3 ? 2 : 1;
+		uinfo->value.integer.min = CS8409_CS42L42_AMIC_VOL_REAL_MIN;
+		uinfo->value.integer.max = CS8409_CS42L42_AMIC_VOL_REAL_MAX;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static void cs8409_cs42l42_update_volume(struct hda_codec *codec)
+{
+	struct cs_spec *spec = codec->spec;
+
+	mutex_lock(&spec->cs8409_i2c_mux);
+	spec->cs42l42_hp_volume[0] = -(cs8409_i2c_read(codec, CS42L42_I2C_ADDR,
+				CS8409_CS42L42_REG_HS_VOLUME_CHA, 1));
+	spec->cs42l42_hp_volume[1] = -(cs8409_i2c_read(codec, CS42L42_I2C_ADDR,
+				CS8409_CS42L42_REG_HS_VOLUME_CHB, 1));
+	spec->cs42l42_hs_mic_volume[0] = -(cs8409_i2c_read(codec, CS42L42_I2C_ADDR,
+				CS8409_CS42L42_REG_AMIC_VOLUME, 1));
+	mutex_unlock(&spec->cs8409_i2c_mux);
+	spec->cs42l42_volume_init = 1;
+}
+
+static int cs8409_cs42l42_volume_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct cs_spec *spec = codec->spec;
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	int chs = get_amp_channels(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+
+	if (!spec->cs42l42_volume_init) {
+		snd_hda_power_up(codec);
+		cs8409_cs42l42_update_volume(codec);
+		snd_hda_power_down(codec);
+	}
+	switch (nid) {
+	case CS8409_CS42L42_HP_PIN_NID:
+		if (chs & 1)
+			*valp++ = spec->cs42l42_hp_volume[0];
+		if (chs & 2)
+			*valp++ = spec->cs42l42_hp_volume[1];
+		break;
+	case CS8409_CS42L42_AMIC_PIN_NID:
+		if (chs & 1)
+			*valp++ = spec->cs42l42_hs_mic_volume[0];
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int cs8409_cs42l42_volume_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct cs_spec *spec = codec->spec;
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	int chs = get_amp_channels(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+	int change = 0;
+	char vol = 0;
+
+	snd_hda_power_up(codec);
+	switch (nid) {
+	case CS8409_CS42L42_HP_PIN_NID:
+		mutex_lock(&spec->cs8409_i2c_mux);
+		if (chs & 1) {
+			vol = -(*valp);
+			change = cs8409_i2c_write(codec, CS42L42_I2C_ADDR,
+				CS8409_CS42L42_REG_HS_VOLUME_CHA, vol, 1);
+			valp++;
+		}
+		if (chs & 2) {
+			vol = -(*valp);
+			change |= cs8409_i2c_write(codec, CS42L42_I2C_ADDR,
+				CS8409_CS42L42_REG_HS_VOLUME_CHB, vol, 1);
+		}
+		mutex_unlock(&spec->cs8409_i2c_mux);
+		break;
+	case CS8409_CS42L42_AMIC_PIN_NID:
+		mutex_lock(&spec->cs8409_i2c_mux);
+		if (chs & 1) {
+			change = cs8409_i2c_write(
+				codec, CS42L42_I2C_ADDR,
+				CS8409_CS42L42_REG_AMIC_VOLUME, (char)*valp, 1);
+			valp++;
+		}
+		mutex_unlock(&spec->cs8409_i2c_mux);
+		break;
+	default:
+		break;
+	}
+	cs8409_cs42l42_update_volume(codec);
+	snd_hda_power_down(codec);
+	return change;
+}
+
+static const DECLARE_TLV_DB_SCALE(
+	cs8409_cs42l42_hp_db_scale,
+	CS8409_CS42L42_HP_VOL_REAL_MIN * 100, 100, 1);
+
+static const DECLARE_TLV_DB_SCALE(
+	cs8409_cs42l42_amic_db_scale,
+	CS8409_CS42L42_AMIC_VOL_REAL_MIN * 100, 100, 1);
+
+static const struct snd_kcontrol_new cs8409_cs42l42_hp_volume_mixer = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.index = 0,
+	.name = "Headphone Playback Volume",
+	.subdevice = (HDA_SUBDEV_AMP_FLAG | HDA_SUBDEV_NID_FLAG),
+	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE
+			 | SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+	.info = cs8409_cs42l42_volume_info,
+	.get = cs8409_cs42l42_volume_get,
+	.put = cs8409_cs42l42_volume_put,
+	.tlv = { .p = cs8409_cs42l42_hp_db_scale },
+	.private_value = HDA_COMPOSE_AMP_VAL(
+		CS8409_CS42L42_HP_PIN_NID, 3, 0, HDA_OUTPUT)
+		| HDA_AMP_VAL_MIN_MUTE
+};
+
+static const struct snd_kcontrol_new cs8409_cs42l42_amic_volume_mixer = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.index = 0,
+	.name = "Headset Mic Capture Volume",
+	.subdevice = (HDA_SUBDEV_AMP_FLAG | HDA_SUBDEV_NID_FLAG),
+	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE
+			 | SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+	.info = cs8409_cs42l42_volume_info,
+	.get = cs8409_cs42l42_volume_get,
+	.put = cs8409_cs42l42_volume_put,
+	.tlv = { .p = cs8409_cs42l42_amic_db_scale },
+	.private_value = HDA_COMPOSE_AMP_VAL(
+		CS8409_CS42L42_AMIC_PIN_NID, 1, 0, HDA_INPUT)
+		| HDA_AMP_VAL_MIN_MUTE
+};
+
 /* Assert/release RTS# line to CS42L42 */
 static void cs8409_cs42l42_reset(struct hda_codec *codec)
 {
@@ -1900,6 +2073,24 @@ static int cs8409_cs42l42_hw_init(struct hda_codec *codec)
 		cs_vendor_coef_set(codec, 0x09, 0x0003);
 	}
 
+	/* Restore Volumes after Resume */
+	if (spec->cs42l42_volume_init) {
+		mutex_lock(&spec->cs8409_i2c_mux);
+		cs8409_i2c_write(codec, CS42L42_I2C_ADDR,
+					CS8409_CS42L42_REG_HS_VOLUME_CHA, -spec->cs42l42_hp_volume[0],
+					1);
+		cs8409_i2c_write(codec, CS42L42_I2C_ADDR,
+					CS8409_CS42L42_REG_HS_VOLUME_CHB, -spec->cs42l42_hp_volume[1],
+					1);
+		cs8409_i2c_write(
+					codec, CS42L42_I2C_ADDR,
+					CS8409_CS42L42_REG_AMIC_VOLUME, spec->cs42l42_hs_mic_volume[0],
+					1);
+		mutex_unlock(&spec->cs8409_i2c_mux);
+	}
+
+	cs8409_cs42l42_update_volume(codec);
+
 	cs8409_cs42l42_enable_jack_detect(codec);
 
 	/* Enable Unsolicited Response */
@@ -1991,6 +2182,14 @@ static int cs8409_cs42l42_fixup(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
+	if (!snd_hda_gen_add_kctl(
+			&spec->gen, NULL, &cs8409_cs42l42_hp_volume_mixer))
+		return -1;
+
+	if (!snd_hda_gen_add_kctl(
+			&spec->gen, NULL, &cs8409_cs42l42_amic_volume_mixer))
+		return -1;
+
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return err;
@@ -2072,6 +2271,7 @@ static int patch_cs8409(struct hda_codec *codec)
 
 		spec->gen.suppress_auto_mute = 1;
 		spec->gen.no_primary_hp = 1;
+		spec->gen.suppress_vmaster = 1;
 		/* GPIO 5 out, 3,4 in */
 		spec->gpio_dir = GPIO5_INT;
 		spec->gpio_data = 0;
-- 
2.25.1


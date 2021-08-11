Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6333E986F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhHKTN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:13:57 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:42802 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231546AbhHKTNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:13:50 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17B9hd03013981;
        Wed, 11 Aug 2021 14:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=j3tHuTWLhtwgNgrgfiPxjrp98XZO3yTo+WsWvrUQUtc=;
 b=askMvw6ap7oAzN738nRxcjStdN2efnPK3NSmh9qTBcLAav4yL952ESSCGK0DqGmcIHE1
 VnMfwktNpIZFqc+FPD/lKT1EmP8ROC9S/4qgw9Xc4ogR0wck8fkPyDFTBg/jGZ0vlHW7
 CE2qTpl1vT4FnufQe2irPtxMx4KXn7BWaq84grTKTq4H9KQxXA1bvgJwCknHYo/wbipV
 GtWpozMmBgfsUM381fAVKccRnhkogIUz3xFuXyDF1mXFCaYLuL6scFQ28ykbFRHZs1/y
 NJGogmCb99Rg6cJEnf/bxohU3W04gmOyjCRRLUT0zSbWacbakyoOGPeUlKhBkO/l3Am+ Zg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3acc5ngpgw-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Aug 2021 14:12:41 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 19:57:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 11 Aug 2021 19:57:32 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1CFDF2A9;
        Wed, 11 Aug 2021 18:57:32 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 23/27] ALSA: hda/cs8409: Set fixed sample rate of 48kHz for CS42L42
Date:   Wed, 11 Aug 2021 19:56:50 +0100
Message-ID: <20210811185654.6837-24-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
References: <20210811185654.6837-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: db_TbHUaQ3jZqfVzyzlYTCp9Kh9tp2Vb
X-Proofpoint-GUID: db_TbHUaQ3jZqfVzyzlYTCp9Kh9tp2Vb
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

CS42L42 is configured to use a fixed sample rate of 48kHz.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes in v2:
- No changes

Changes in v3:
- No changes

Changes in v4:
- No changes

 sound/pci/hda/patch_cs8409-tables.c | 8 ++++++++
 sound/pci/hda/patch_cs8409.c        | 6 ++++++
 sound/pci/hda/patch_cs8409.h        | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index a39b2c20f61c..a9a0b8e3b2a9 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -45,6 +45,14 @@ const struct snd_kcontrol_new cs42l42_adc_volume_mixer = {
 			 HDA_INPUT, CS42L42_VOL_ADC) | HDA_AMP_VAL_MIN_MUTE
 };
 
+const struct hda_pcm_stream cs42l42_48k_pcm_analog_playback = {
+	.rates = SNDRV_PCM_RATE_48000, /* fixed rate */
+};
+
+const struct hda_pcm_stream cs42l42_48k_pcm_analog_capture = {
+	.rates = SNDRV_PCM_RATE_48000, /* fixed rate */
+};
+
 /******************************************************************************
  *                   BULLSEYE / WARLOCK / CYBORG Specific Arrays
  *                               CS8409/CS42L42
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index daf9c07d10c4..897c48140d8b 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -912,6 +912,9 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 
 		break;
 	case HDA_FIXUP_ACT_PROBE:
+		/* Fix Sample Rate to 48kHz */
+		spec->gen.stream_analog_playback = &cs42l42_48k_pcm_analog_playback;
+		spec->gen.stream_analog_capture = &cs42l42_48k_pcm_analog_capture;
 		/* Set initial DMIC volume to -26 dB */
 		snd_hda_codec_amp_init_stereo(codec, CS8409_CS42L42_DMIC_ADC_PIN_NID,
 					      HDA_INPUT, 0, 0xff, 0x19);
@@ -1105,6 +1108,9 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 
 		break;
 	case HDA_FIXUP_ACT_PROBE:
+		/* Fix Sample Rate to 48kHz */
+		spec->gen.stream_analog_playback = &cs42l42_48k_pcm_analog_playback;
+		spec->gen.stream_analog_capture = &cs42l42_48k_pcm_analog_capture;
 		snd_hda_gen_add_kctl(&spec->gen, "Headphone Playback Volume",
 				     &cs42l42_dac_volume_mixer);
 		snd_hda_gen_add_kctl(&spec->gen, "Mic Capture Volume", &cs42l42_adc_volume_mixer);
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 1b5a8d04ba0f..2208be2ffad1 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -335,6 +335,8 @@ int cs42l42_volume_info(struct snd_kcontrol *kctrl, struct snd_ctl_elem_info *ui
 int cs42l42_volume_get(struct snd_kcontrol *kctrl, struct snd_ctl_elem_value *uctrl);
 int cs42l42_volume_put(struct snd_kcontrol *kctrl, struct snd_ctl_elem_value *uctrl);
 
+extern const struct hda_pcm_stream cs42l42_48k_pcm_analog_playback;
+extern const struct hda_pcm_stream cs42l42_48k_pcm_analog_capture;
 extern const struct snd_pci_quirk cs8409_fixup_tbl[];
 extern const struct hda_model_fixup cs8409_models[];
 extern const struct hda_fixup cs8409_fixups[];
-- 
2.25.1


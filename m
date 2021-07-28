Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F183D8F79
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhG1Nri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:47:38 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:38264 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236639AbhG1Noy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:44:54 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16S674iU029982;
        Wed, 28 Jul 2021 08:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Cd8sZsyPFjub9SNh+fp/si6i8IHWZ4PqUCYMaY7jOhU=;
 b=HQZqNmtrDYlRd5DVtaKekkNw1rxiJ0jD8avcx11n6ShamRGE3ym2vAqXTsvkZLXjAuLN
 2J9AZkHURJlfpUD5OH2FZJqyhsfEWsAlkymnbe9oYJDSfAlNquRU415cgfFR+kcaRXH8
 VMQgE8cXWFG0OG8zjwSxW5XgK3hedaNdUW5jii3cQHZZaDMjW94tOTjyX1BoLXNz8xTL
 T99tyTbcZ74y1akmZFaBW3jIQroW6GsYvuHEWg4VhvJzN+4aP/onFcSMj46DOI/Ac/pT
 OCfLFuRXup3UwABD1X0s3Hu2VmAKKAs0rDeWf+L7NNVewtdFeO9tzis4YXHUAYpVLSD4 zA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a31m2resc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 08:44:39 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 28 Jul
 2021 14:44:37 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 28 Jul 2021 14:44:37 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 42FB92BA;
        Wed, 28 Jul 2021 13:44:37 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 23/27] ALSA: hda/cs8409: Set fixed sample rate of 48kHz for CS42L42
Date:   Wed, 28 Jul 2021 14:44:04 +0100
Message-ID: <20210728134408.369396-24-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
References: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7M38jdXwygA7qXgKEnmLkLkz4Krc7-HL
X-Proofpoint-ORIG-GUID: 7M38jdXwygA7qXgKEnmLkLkz4Krc7-HL
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

CS42L42 is configured to use a fixed sample rate of 48kHz.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Changes in v2:
- No changes

---
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
index 97649d35aefb..5b6d843ab7fb 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -884,6 +884,9 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 
 		break;
 	case HDA_FIXUP_ACT_PROBE:
+		/* Fix Sample Rate to 48kHz */
+		spec->gen.stream_analog_playback = &cs42l42_48k_pcm_analog_playback;
+		spec->gen.stream_analog_capture = &cs42l42_48k_pcm_analog_capture;
 		/* Set initial DMIC volume to -26 dB */
 		snd_hda_codec_amp_init_stereo(codec, CS8409_CS42L42_DMIC_ADC_PIN_NID,
 					      HDA_INPUT, 0, 0xff, 0x19);
@@ -1077,6 +1080,9 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 
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


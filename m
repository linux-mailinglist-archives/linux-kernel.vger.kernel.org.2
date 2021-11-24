Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11DB45CBF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350227AbhKXSXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:23:04 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:54194 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242520AbhKXSWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:22:53 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AO7P93t013358;
        Wed, 24 Nov 2021 12:19:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=U8Ap+OhwHy2SWvzy0sqCvywt4yyXDWnVtiddXPBdUQ8=;
 b=GT6Wg99ftCaP4vptM9MfwILGC8BHoT8bTM2YjL+jYL2yyLLxFRkSC1I9zvEJivFg5F4j
 FwSlwwMVNn0vav4x1LiiJIkIfr4VPpKjpU7V/rkVCTjJoVAdhqroisZbhe3umDCEX6Mm
 Y+f+8xt8oN5+yzey4iL8gt26qK98iBB//ikawhQAA9BaoFB3P01jiu9ROCgwi1Fl+w1k
 hH3BTZI+AeoZ93dMgOSXlE7PMKN4P+5uCegni31Jw1+cIjmROjx4ZxiblX3bFL5eaIZ2
 Qmukx0Bu2ecJsYks2wFi1esKcPBEH3TSrSAuN5dEenYgkNblBdaLHGduziFwD9z2mUwA NQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3chds7gtp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Nov 2021 12:19:11 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 18:19:09 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 24 Nov 2021 18:19:09 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2D9EC2A1;
        Wed, 24 Nov 2021 18:19:08 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda/cs8409: Schedule delayed work for jack detect on resume
Date:   Wed, 24 Nov 2021 18:19:08 +0000
Message-ID: <20211124181908.50672-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: OecZu0N3k7o4BupfIvgv86XUL39FNquW
X-Proofpoint-ORIG-GUID: OecZu0N3k7o4BupfIvgv86XUL39FNquW
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

CS42L42 runs jack detect on resume, however this requires unsol
events, and unsol events are ignored whilst the power state is
not set to ON. The power state is set to ON only after the resume
finishes. Schedule a delayed work timer to run jack detect
after the resume call finishes.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 79 +++++++++++++++++++++++++++++-------
 sound/pci/hda/patch_cs8409.h |  1 +
 2 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 31ff11ab868e..88213e95f0b3 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -634,6 +634,30 @@ static void cs42l42_run_jack_detect(struct sub_codec *cs42l42)
 	cs8409_i2c_write(cs42l42, 0x1120, 0xc0);
 }
 
+static void cs42l42_run_jack_detect_all(struct hda_codec *codec)
+{
+	struct cs8409_spec *spec = codec->spec;
+	struct sub_codec *cs42l42;
+	int i;
+
+	for (i = 0; i < spec->num_scodecs; i++) {
+		cs42l42 = spec->scodecs[i];
+		cs42l42_enable_jack_detect(cs42l42);
+		if (!cs42l42->hp_jack_in)
+			cs42l42_run_jack_detect(cs42l42);
+	}
+}
+
+/*
+ * cs42l42_jack_detect_worker - Worker that retries jack detect
+ */
+static void cs42l42_jack_detect_worker(struct work_struct *work)
+{
+	struct cs8409_spec *spec = container_of(work, struct cs8409_spec, jack_detect_work.work);
+
+	cs42l42_run_jack_detect_all(spec->codec);
+}
+
 static int cs42l42_handle_tip_sense(struct sub_codec *cs42l42, unsigned int reg_ts_status)
 {
 	int status_changed = 0;
@@ -749,8 +773,6 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 
 	if (cs42l42->full_scale_vol)
 		cs8409_i2c_write(cs42l42, 0x2001, 0x01);
-
-	cs42l42_enable_jack_detect(cs42l42);
 }
 
 #ifdef CONFIG_PM
@@ -800,6 +822,7 @@ static void cs8409_free(struct hda_codec *codec)
 
 	/* Cancel i2c clock disable timer, and disable clock if left enabled */
 	cancel_delayed_work_sync(&spec->i2c_clk_work);
+	cancel_delayed_work_sync(&spec->jack_detect_work);
 	cs8409_disable_i2c_clock(codec);
 
 	snd_hda_gen_free(codec);
@@ -863,6 +886,7 @@ static int cs8409_cs42l42_suspend(struct hda_codec *codec)
 
 	/* Cancel i2c clock disable timer, and disable clock if left enabled */
 	cancel_delayed_work_sync(&spec->i2c_clk_work);
+	cancel_delayed_work_sync(&spec->jack_detect_work);
 	cs8409_disable_i2c_clock(codec);
 
 	snd_hda_shutup_pins(codec);
@@ -970,6 +994,8 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		spec->scodecs[CS8409_CODEC0]->codec = codec;
 		codec->patch_ops = cs8409_cs42l42_patch_ops;
 
+		INIT_DELAYED_WORK(&spec->jack_detect_work, cs42l42_jack_detect_worker);
+
 		spec->gen.suppress_auto_mute = 1;
 		spec->gen.no_primary_hp = 1;
 		spec->gen.suppress_vmaster = 1;
@@ -1029,9 +1055,16 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 	case HDA_FIXUP_ACT_INIT:
 		cs8409_cs42l42_hw_init(codec);
 		spec->init_done = 1;
-		if (spec->init_done && spec->build_ctrl_done
-			&& !spec->scodecs[CS8409_CODEC0]->hp_jack_in)
-			cs42l42_run_jack_detect(spec->scodecs[CS8409_CODEC0]);
+		if (spec->init_done && spec->build_ctrl_done) {
+			/* No point in running jack detect until we have fully resumed */
+			if (codec->core.dev.power.power_state.event != PM_EVENT_ON) {
+				codec_warn(codec, "Not ready to detect jack, deferring...\n");
+				schedule_delayed_work(&spec->jack_detect_work, msecs_to_jiffies(25));
+				return;
+			} else {
+				cs42l42_run_jack_detect_all(codec);
+			}
+		}
 		break;
 	case HDA_FIXUP_ACT_BUILD:
 		spec->build_ctrl_done = 1;
@@ -1040,9 +1073,16 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		 * been already plugged in.
 		 * Run immediately after init.
 		 */
-		if (spec->init_done && spec->build_ctrl_done
-			&& !spec->scodecs[CS8409_CODEC0]->hp_jack_in)
-			cs42l42_run_jack_detect(spec->scodecs[CS8409_CODEC0]);
+		if (spec->init_done && spec->build_ctrl_done) {
+			/* No point in running jack detect until we have fully resumed */
+			if (codec->core.dev.power.power_state.event != PM_EVENT_ON) {
+				codec_warn(codec, "Not ready to detect jack, deferring...\n");
+				schedule_delayed_work(&spec->jack_detect_work, msecs_to_jiffies(25));
+				return;
+			} else {
+				cs42l42_run_jack_detect_all(codec);
+			}
+		}
 		break;
 	default:
 		break;
@@ -1178,7 +1218,6 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 {
 	struct cs8409_spec *spec = codec->spec;
 	struct snd_kcontrol_new *kctrl;
-	int i;
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
@@ -1193,6 +1232,8 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 		spec->scodecs[CS8409_CODEC1]->codec = codec;
 		spec->num_scodecs = 2;
 
+		INIT_DELAYED_WORK(&spec->jack_detect_work, cs42l42_jack_detect_worker);
+
 		codec->patch_ops = cs8409_dolphin_patch_ops;
 
 		/* GPIO 1,5 out, 0,4 in */
@@ -1237,9 +1278,13 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 		dolphin_hw_init(codec);
 		spec->init_done = 1;
 		if (spec->init_done && spec->build_ctrl_done) {
-			for (i = 0; i < spec->num_scodecs; i++) {
-				if (!spec->scodecs[i]->hp_jack_in)
-					cs42l42_run_jack_detect(spec->scodecs[i]);
+			/* No point in running jack detect until we have fully resumed */
+			if (codec->core.dev.power.power_state.event != PM_EVENT_ON) {
+				codec_warn(codec, "Not ready to detect jack, deferring...\n");
+				schedule_delayed_work(&spec->jack_detect_work, msecs_to_jiffies(25));
+				return;
+			} else {
+				cs42l42_run_jack_detect_all(codec);
 			}
 		}
 		break;
@@ -1251,9 +1296,13 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 		 * Run immediately after init.
 		 */
 		if (spec->init_done && spec->build_ctrl_done) {
-			for (i = 0; i < spec->num_scodecs; i++) {
-				if (!spec->scodecs[i]->hp_jack_in)
-					cs42l42_run_jack_detect(spec->scodecs[i]);
+			/* No point in running jack detect until we have fully resumed */
+			if (codec->core.dev.power.power_state.event != PM_EVENT_ON) {
+				codec_warn(codec, "Not ready to detect jack, deferring...\n");
+				schedule_delayed_work(&spec->jack_detect_work, msecs_to_jiffies(25));
+				return;
+			} else {
+				cs42l42_run_jack_detect_all(codec);
 			}
 		}
 		break;
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index ade2b838590c..632d3ec8322d 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -330,6 +330,7 @@ struct cs8409_spec {
 	unsigned int i2c_clck_enabled;
 	unsigned int dev_addr;
 	struct delayed_work i2c_clk_work;
+	struct delayed_work jack_detect_work;
 
 	unsigned int playback_started:1;
 	unsigned int capture_started:1;
-- 
2.25.1


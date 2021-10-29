Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2F943FFCB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 17:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhJ2Ppx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhJ2Ppv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:45:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3441C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 08:43:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m22so16844536wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVedv0tb/dx9srclvIV/zvDVPCSsyAMNntTG/iU35S8=;
        b=MALvfCvq2cKfZ2NIS0ji5cb8N7+1ZPa4n3uMTB0bAzIZGnivy/AevuW65niQ5i4Yrj
         vRHtk7bklPoE7powvaoSU1eVSgrUxzowXP6LF0QTK4EmXT4fyP05MsdTrvY/YM0+kuRe
         x9hp+8L3Qb8ytqa1FKdqeFwTUpRU8dH32eAETs89WqVN4aAqTacWTAwG4fdnIWF+61xR
         fxT8BZZkRN05d/JD+kEwbJoCkd9jxCTnVtJQmArUOeigrRqRPVP0RJHDPAPMaDWzFnWN
         +B78LDCFlzkOa/vdLfeB4tNy6xdKIEjAqbyP4K4KxfjEs+QI7SYmjMCh1BNF/EXi05ug
         ww0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVedv0tb/dx9srclvIV/zvDVPCSsyAMNntTG/iU35S8=;
        b=UP3r3dndFK9L8ntDAOfRXl1ESVkXcHe9S+LmgAQ40brYZFKuzZ8tquCTOkJ2Tdirj2
         wleBuresQZz4Qflm1jPch8vsa6/et94AlA/Vz5ZhwU3jHDnVbuOdfOxUfIEPYOOMZ82V
         K260kWJz4FySnblv5XL5qQ5Vv0mWf0J49b9l41NyaKE2kV95GhdVXu8a9TsEVjNPXgJH
         bSnHgp7iJ9lzqXkvX/dVDtalVg7gKxoBU2VuiKR2Mwz4aXFvPOLOcdqylgEGQmGX5LPy
         PUe3lkiq6DyHfB3JymNnv5hEl//lGqlrOGZKyCHT4XhYqmw8GjouDz+vGr2mUylrEwv8
         E/dg==
X-Gm-Message-State: AOAM531YoiwQLGzuvFWxUe5H9ntjHXLrazgVdIhxbxhtdLGi5P8pzvoe
        DJvLclBI3PvPqzennm1SGvVUQDCjx/Ax
X-Google-Smtp-Source: ABdhPJxkEV4GK3fQEnfaB3Yc6J/QilQ7Qi3jMA4A4BR1gWrJAVQf9Zt66sQ+hLSNWNv9iwdZtvV2HQ==
X-Received: by 2002:adf:8b06:: with SMTP id n6mr15486793wra.5.1635522201228;
        Fri, 29 Oct 2021 08:43:21 -0700 (PDT)
Received: from rampage-hp2.broadband (static-90-251-248-205.vodafonexdsl.co.uk. [90.251.248.205])
        by smtp.googlemail.com with ESMTPSA id b8sm7936244wri.53.2021.10.29.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 08:43:20 -0700 (PDT)
From:   Jonathan Clarke <jonathan.a.clarke@gmail.com>
Cc:     Jonathan Clarke <jonathan.a.clarke@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Make top/rear speaker, mute and micmute leds work on HP x360 14-ea000 laptops that use Realtek 245 codec
Date:   Fri, 29 Oct 2021 16:43:13 +0100
Message-Id: <20211029154313.1005394-1-jonathan.a.clarke@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=210633
Signed-off-by: Jonathan Clarke <jonathan.a.clarke@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 22d27b12c..e3c6d17ea 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4409,6 +4409,13 @@ static void alc245_fixup_hp_x360_amp(struct hda_codec *codec,
 	case HDA_FIXUP_ACT_PRE_PROBE:
 		spec->gpio_mask |= 0x01;
 		spec->gpio_dir |= 0x01;
+
+		/* use only amp at 0x02 for bottom(front) speaker,
+		 * otherwise it is set to use 0x02,0x03,0x06 and when used in conjunction
+		 * with top(rear) speaker 0x14, gets locked at full volume */
+		static const hda_nid_t conn1[] = { 0x02 };
+		snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn1), conn1);
+
 		break;
 	case HDA_FIXUP_ACT_INIT:
 		/* need to toggle GPIO to enable the amp */
@@ -4503,6 +4510,26 @@ static void alc236_fixup_hp_mute_led_coefbit(struct hda_codec *codec,
 	}
 }
 
+static void alc245_fixup_hp_x360_mute_leds(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		/* mic mute is set via gpio 0x04 */
+		spec->micmute_led_polarity = 1;
+		codec->power_filter = led_power_filter;
+		alc_fixup_hp_gpio_led(codec, action, 0x00, 0x04);
+
+		/* output mute is set via SET_COEF_INDEX,SET_PROC_COEF */
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0x0b;
+		spec->mute_led_coef.mask = 0xffff;
+		spec->mute_led_coef.on = 0xa02f;
+		spec->mute_led_coef.off = 0x7774;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 /* turn on/off mic-mute LED per capture hook by coef bit */
 static int coef_micmute_led_set(struct led_classdev *led_cdev,
 				enum led_brightness brightness)
@@ -6557,6 +6584,8 @@ enum {
 	ALC269_FIXUP_HP_DOCK_GPIO_MIC1_LED,
 	ALC280_FIXUP_HP_9480M,
 	ALC245_FIXUP_HP_X360_AMP,
+	ALC245_FIXUP_HP_X360_MUTE_LEDS,
+	ALC245_FIXUP_HP_X360_GPIO_TOP_SPEAKER,
 	ALC288_FIXUP_DELL_HEADSET_MODE,
 	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC288_FIXUP_DELL_XPS_13,
@@ -7293,6 +7322,21 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC245_FIXUP_HP_X360_AMP] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_x360_amp,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_HP_X360_MUTE_LEDS
+	},
+	[ALC245_FIXUP_HP_X360_MUTE_LEDS] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_x360_mute_leds,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_HP_X360_GPIO_TOP_SPEAKER
+	},
+	[ALC245_FIXUP_HP_X360_GPIO_TOP_SPEAKER] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x14, 0x90170110 }, /* enable top(back) speaker in addition to bottom(front) speaker at 0x17 */
+			{ },
+		}
 	},
 	[ALC288_FIXUP_DELL_HEADSET_MODE] = {
 		.type = HDA_FIXUP_FUNC,
@@ -9003,6 +9047,8 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC255_FIXUP_XIAOMI_HEADSET_MIC, .name = "alc255-xiaomi-headset"},
 	{.id = ALC274_FIXUP_HP_MIC, .name = "alc274-hp-mic-detect"},
 	{.id = ALC245_FIXUP_HP_X360_AMP, .name = "alc245-hp-x360-amp"},
+	{.id = ALC245_FIXUP_HP_X360_MUTE_LEDS, .name = "alc245-hp-x360-mute-leds"},
+	{.id = ALC245_FIXUP_HP_X360_GPIO_TOP_SPEAKER, .name = "alc245-hp-x360-gpio-top-speaker"},
 	{.id = ALC295_FIXUP_HP_OMEN, .name = "alc295-hp-omen"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360, .name = "alc285-hp-spectre-x360"},
 	{.id = ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP, .name = "alc287-ideapad-bass-spk-amp"},
-- 
2.25.1


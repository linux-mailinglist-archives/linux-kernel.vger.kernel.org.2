Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10693434BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhJTNPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhJTNPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:15:31 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10615C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:13:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g79-20020a1c2052000000b00323023159e1so1631883wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNaRc1LfQTJ5XsgrKgds8CW0+sIIrnx24JRi3PJWCsw=;
        b=KQugN/1bB3y+s9vO4aEYeD73JSGDzHjCFPhfaAEkjZvpqh3+GPahrR3gHAK5NFsd/3
         2yYgvOuEbsbafzhxpBNrDOhiICNqrvUwbbsdWGsFIA4LmZ1TbS6caaaOmtj9DRakDbce
         ISRIopI041DlI9Cvz4QHdMJSirP8eOtASMBwmmBIgniddWW81fz3rTlhR3UCGIoyze6w
         9XOler2fVHbqoaJQxQ15aPLx1jiGeSUaQ6hr3X/wrJSIb/eC0FmhKmgNX3SoNkQMgBsK
         i2X8r2BO3Qj5k9PkZtuVhFTa81Jr1LSADV3X7ON+iqiW2kI36DXip9SYxrH2hHFAfoQJ
         zWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jNaRc1LfQTJ5XsgrKgds8CW0+sIIrnx24JRi3PJWCsw=;
        b=gjNmmh48X8XeOz9N7EBFkHzlPKe/3l3IEHHYEaXMMWU7+MKPfltMgN4EUQhbWuKbh5
         KfH5sebwdN+QolM3XYi+GGSq7VK06DO63Wi1ypZ6Ox3Z4SI3W/c2NRtd7c90/tCslBne
         oeZmtjqaKxOYLcyMh+t+CdvQYIjR9KPg0bIWjZH9VFSM2NUQ5gbNZLd3RcgxyLuZAHnv
         CEsY8OO0Dd+FNcYWZEApFUPDtzbe/3bfRBWfj643I2BXS5N8rjU7QCQKv9SxA1VCcjNi
         luCksuFv+s5ppFEYKhJ7lSpoSaM2bx4JkmUde25uthKkU9JqvUlpfYk5RFvqyaNEyGyH
         AXqA==
X-Gm-Message-State: AOAM530F6J6emHC64RfqvXdiTgmu9AEaOByOtwjJVZvfBk8VvJDjl6ow
        sM7VaFH4fGgw2WW3I3Xjwvg=
X-Google-Smtp-Source: ABdhPJxhf1WVsxyvu33UBwerIm+xYtq7wWb7p5NXus1pXL4gdfaucFbbN4HM6vqwHNkrekFIIdku/A==
X-Received: by 2002:a5d:69cc:: with SMTP id s12mr4813554wrw.108.1634735595375;
        Wed, 20 Oct 2021 06:13:15 -0700 (PDT)
Received: from localhost.localdomain (host-92-18-70-200.as13285.net. [92.18.70.200])
        by smtp.gmail.com with ESMTPSA id t12sm2346709wmq.44.2021.10.20.06.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:13:15 -0700 (PDT)
Sender: John Clark <johnc456@gmail.com>
From:   Johnathon Clark <john.clark@cantab.net>
Cc:     john.clark@cantab.net, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        PeiSen Hou <pshou@realtek.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Sami Loone <sami@loone.fi>, Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda/realtek: Fix mic mute LED for the HP Spectre x360 14
Date:   Wed, 20 Oct 2021 14:12:51 +0100
Message-Id: <20211020131253.35894-1-john.clark@cantab.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the 'HP Spectre x360 Convertible 14-ea0xx' the microphone mute led is
controlled by GPIO 0x04. The speaker mute LED does not seem to be
exposed by GPIO and is there not set.

Signed-off-by: Johnathon Clark <john.clark@cantab.net>
---
 sound/pci/hda/patch_realtek.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 965b096f416f..79c6fb39864d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4355,6 +4355,17 @@ static void alc287_fixup_hp_gpio_led(struct hda_codec *codec,
 	alc_fixup_hp_gpio_led(codec, action, 0x10, 0);
 }
 
+static void alc245_fixup_hp_gpio_led(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->micmute_led_polarity = 1;
+	}
+	alc_fixup_hp_gpio_led(codec, action, 0, 0x04);
+}
+
 /* turn on/off mic-mute LED per capture hook via VREF change */
 static int vref_micmute_led_set(struct led_classdev *led_cdev,
 				enum led_brightness brightness)
@@ -6709,6 +6720,7 @@ enum {
 	ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK,
 	ALC287_FIXUP_HP_GPIO_LED,
 	ALC256_FIXUP_HP_HEADSET_MIC,
+	ALC245_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_DELL_AIO_HEADSET_MIC,
 	ALC282_FIXUP_ACER_DISABLE_LINEOUT,
 	ALC255_FIXUP_ACER_LIMIT_INT_MIC_BOOST,
@@ -7333,6 +7345,8 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC245_FIXUP_HP_X360_AMP] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_x360_amp,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_HP_GPIO_LED
 	},
 	[ALC288_FIXUP_DELL_HEADSET_MODE] = {
 		.type = HDA_FIXUP_FUNC,
@@ -8432,6 +8446,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc256_fixup_tongfang_reset_persistent_settings,
 	},
+	[ALC245_FIXUP_HP_GPIO_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_gpio_led,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
-- 
2.33.1


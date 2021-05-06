Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6158D375CCC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 23:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhEFVWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 17:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhEFVWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 17:22:18 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1193DC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 14:21:19 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id k124so3662729vsk.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sh1ANwXuIsrJbdRn7AxGv7GgaPQjl7T0ZhQuUtO8iSc=;
        b=tv/ONCs9nYZ9vc+0H3UwP1d4NzhVZJ69hJ73g6QDXP+ehEDoTa3/qIc1gJUzOlLW7l
         cUi9vrlLlHlxy/xbZzCisH6QJL4bKgwZR0lkllMhC8ctymHvNbvdse+3GKfPPtwRy/ce
         nmbJ3KEacY8ho0wR64/YI6VTTdYSE5EL93rnksL1zzW82/67CPNxXz8O6hmoRMA9zVr/
         ItGuYMFM73aDdP1GXg7T57iEaGL144WnqH/AVH+kdngJh/PsCbwn9325Hs5ayQdEpDQ0
         wxXJvt9zl90i17RUjPr/idFCWAD1A5HWDSnJceEqn5MuYBI7TGfJFbHus5oWooV83fZf
         i1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sh1ANwXuIsrJbdRn7AxGv7GgaPQjl7T0ZhQuUtO8iSc=;
        b=HN86Rmj8+u5hqRzddFhDDb0kez9uK+uH8R0QzInbvQsD2QN1aDK0EHd35/GYRb+kJI
         Oi+9mDXY6htHzZRtnTcaXnSdQx+jsdhVs+Pq3gxhA/F5QogvSLkAh73dLQEyrTk4OvlK
         wzt1n4iGrnDHwCLd9/aeyULd+QajO+rNT126TQHTRHmasuFppvoW142gyGVXRSxgzPn3
         KjQTgon085ZuUvUxn8g/8rnEafHQiYCi3aQNfTMfJJbwXzHTJcGM14wh4UVB8U5puRog
         lHTupsN9ssLCre137+T+LOkcd+C87kPPQIAAG/FRqyGMStWBfDsxl4U18gC+NVVFfXN2
         NWxw==
X-Gm-Message-State: AOAM5329tKWPfeAwSLp1X9U7IuxoSfUoIuesrdAn2Z/8gj7Li7OhY1sw
        NYDBEUToFg64xlrNJS9WY/SutaA3y+/sJkYQ
X-Google-Smtp-Source: ABdhPJxMHt2uEDP7+k7SqzdXBJrgm5lE7CG8yLoZWVi5nW9+6RFBNCA/wrdJdX2B/72bQGGERMvglA==
X-Received: by 2002:a67:2d84:: with SMTP id t126mr6252792vst.2.1620336078296;
        Thu, 06 May 2021 14:21:18 -0700 (PDT)
Received: from localhost.localdomain (host-181-198-195-56.netlife.ec. [181.198.195.56])
        by smtp.googlemail.com with ESMTPSA id o1sm444868uar.2.2021.05.06.14.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 14:21:18 -0700 (PDT)
From:   Daniel Cordova A <danesc87@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, kailang@realtek.com, jhp@endlessos.org,
        kai.heng.feng@canonical.com, hui.wang@canonical.com,
        chenhuacai@kernel.org, linux-kernel@vger.kernel.org,
        Daniel Cordova A <danesc87@gmail.com>
Subject: [PATCH] ALSA: hda: fixup headset for ASUS GU502 laptop
Date:   Thu,  6 May 2021 16:21:05 -0500
Message-Id: <20210506212105.1532-1-danesc87@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GU502 requires a few steps to make headset i/o works properly:
pincfg, verbs to unmute headphone out and callback to toggle output
between speakers and headphone using jack.

Signed-off-by: Daniel Cordova A. <danesc87@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 62 +++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bd7bfd7c9ee7..d91ab7521496 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6210,6 +6210,35 @@ static void alc294_fixup_gx502_hp(struct hda_codec *codec,
 	}
 }
 
+static void alc294_gu502_toggle_output(struct hda_codec *codec,
+				       struct hda_jack_callback *cb)
+{
+	/* Windows sets 0x10 to 0x8420 for Node 0x20 which is
+	 * responsible from changes between speakers and headphones
+	 */
+	if (snd_hda_jack_detect_state(codec, 0x21) == HDA_JACK_PRESENT)
+		alc_write_coef_idx(codec, 0x10, 0x8420);
+	else
+		alc_write_coef_idx(codec, 0x10, 0x0a20);
+}
+
+static void alc294_fixup_gu502_hp(struct hda_codec *codec,
+				  const struct hda_fixup *fix, int action)
+{
+	if (!is_jack_detectable(codec, 0x21))
+		return;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_jack_detect_enable_callback(codec, 0x21,
+				alc294_gu502_toggle_output);
+		break;
+	case HDA_FIXUP_ACT_INIT:
+		alc294_gu502_toggle_output(codec, NULL);
+		break;
+	}
+}
+
 static void  alc285_fixup_hp_gpio_amp_init(struct hda_codec *codec,
 			      const struct hda_fixup *fix, int action)
 {
@@ -6427,6 +6456,9 @@ enum {
 	ALC294_FIXUP_ASUS_GX502_HP,
 	ALC294_FIXUP_ASUS_GX502_PINS,
 	ALC294_FIXUP_ASUS_GX502_VERBS,
+	ALC294_FIXUP_ASUS_GU502_HP,
+	ALC294_FIXUP_ASUS_GU502_PINS,
+	ALC294_FIXUP_ASUS_GU502_VERBS,
 	ALC285_FIXUP_HP_GPIO_LED,
 	ALC285_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_GPIO_LED,
@@ -7665,6 +7697,35 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc294_fixup_gx502_hp,
 	},
+	[ALC294_FIXUP_ASUS_GU502_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a11050 }, /* rear HP mic */
+			{ 0x1a, 0x01a11830 }, /* rear external mic */
+			{ 0x21, 0x012110f0 }, /* rear HP out */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_GU502_VERBS
+	},
+	[ALC294_FIXUP_ASUS_GU502_VERBS] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* set 0x15 to HP-OUT ctrl */
+			{ 0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0 },
+			/* unmute the 0x15 amp */
+			{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000 },
+			/* set 0x1b to HP-OUT */
+			{ 0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_GU502_HP
+	},
+	[ALC294_FIXUP_ASUS_GU502_HP] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc294_fixup_gu502_hp,
+	},
 	[ALC294_FIXUP_ASUS_COEF_1B] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -8163,6 +8224,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1881, "ASUS Zephyrus S/M", ALC294_FIXUP_ASUS_GX502_PINS),
+	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x18f1, "Asus FX505DT", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x194e, "ASUS UX563FD", ALC294_FIXUP_ASUS_HPE),
-- 
2.31.1


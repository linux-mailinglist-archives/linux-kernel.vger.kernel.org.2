Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219D2376985
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 19:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhEGRcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 13:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhEGRcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 13:32:35 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5488CC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 10:31:35 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id h1so5180873qvv.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qtUE2mUPa5CVvOdF0SZQxRaBf5wu+SCU/yRGFman2bo=;
        b=ncwQsBv77Vkomxcc7EZi1rMvixN+iCEQeuAYE2FVZX74UMHQ67zsqgEmI7fpyVgE7y
         g0ColgfdYQAifbsScUYkq+GefMvkZHXZPrLvcF2rXX8ZzMSsoflvp8A6wfpv9O6HVg1+
         0oZMI5uh2UkDq23TOPyLpQCQJ4zRpA6ULHPE8DcCHDdGNDQ7Ukb39LjNp3kVpK01pkED
         A+LbLQEcgphSabzl2PiMAbk+Hw9o0tatYwBoQyi7L/XbP1OjdFuB2ABaSsthSE+JXVTf
         +oiw5uTqGz1jb97INVHa/R7Mj/586+Cxh5iDHyG60IyA8jRsZEJo0l901XltAzMv9P69
         VPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qtUE2mUPa5CVvOdF0SZQxRaBf5wu+SCU/yRGFman2bo=;
        b=XaUFvKLolO5EQASmanKBwme3qqvnh6fastRaYqVapP7lOo9rMRe9ch4+Na2QV3Py+J
         +2Lf+/2M/gk2Nd+s30F9R6g5MCEPTJ8dmENV/oMoXmL3LJsWRPjOGOjY0fbfsxIokwVq
         GBOx8t47CTliUECS2pAEm8t3/vHuCG8corwAq64bF2Y75pC2H6iBtmaMCOKpbEtNXP/X
         PBHmZJcRYt+QQiPGcA4k1hgAKRT4gmr9ZdvR9VJeMBbOhJoKS9rfU/5WUCfvxsK90xOb
         zvCfus7dU3YPyNon/cnAz+KdKZ6TmPcMLSOfBsYZ7SQylMRE2HONmHImbzowJ7VrP/sa
         BB9Q==
X-Gm-Message-State: AOAM530ywK1RjqxRacFcVz0QtGsr13KXSzaMVRfhmbuzSdj1O1b3mgm0
        sPVeeeVtqmeShw47dYiU93M=
X-Google-Smtp-Source: ABdhPJzXuzfvcY4a7Zu9CCB/FcdaI2hmTrGrPVrMNgMvv7Ty/EW9z/LDvlWSqIloRFFcbELCNgfxhA==
X-Received: by 2002:ad4:4aa4:: with SMTP id i4mr11104285qvx.29.1620408694561;
        Fri, 07 May 2021 10:31:34 -0700 (PDT)
Received: from localhost.localdomain ([200.55.237.36])
        by smtp.googlemail.com with ESMTPSA id b2sm2966718qkk.135.2021.05.07.10.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 10:31:33 -0700 (PDT)
From:   Daniel Cordova A <danesc87@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, kailang@realtek.com, jhp@endlessos.org,
        kai.heng.feng@canonical.com, hui.wang@canonical.com,
        chenhuacai@kernel.org, linux-kernel@vger.kernel.org,
        Daniel Cordova A <danesc87@gmail.com>
Subject: [PATCH] ALSA: hda: fixup headset for ASUS GU502 laptop
Date:   Fri,  7 May 2021 12:31:16 -0500
Message-Id: <20210507173116.12043-1-danesc87@gmail.com>
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
index bd7bfd7c9ee7..2b18f078edc7 100644
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
@@ -8178,6 +8239,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
+	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E16737A71C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhEKMxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhEKMxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:53:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B09C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 05:51:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j10so2523330ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 05:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Vz3NVjeSduBFGcr7e4KNuJw+YQxjHIZNkFnnUo3vhA=;
        b=TfrLT7I8hBPUsbCgT5nmLrSnP1r7AhcYkJEB3XXNnc8qRQW9Q8HnoPYQGyuiQK2TbQ
         EbaJARNMC1mqSnRB/2XcZ5olBFCG8P97ocjZbFGdBWyqpV0ql08dGRPgcdB31t61zodP
         +L0p8pjCMHASUzN9j3WA9u3dEiiOc+15mKk4V8EnEV/Nny9eK78nOR9odhelbo2Cnukf
         0kKKLqlTKlMG00Azf2556mgpDOnXYS0RH8RYThM6giyQLFwpeFuJeWmV3u5RvksJkKbc
         G8ruV+xoxRHwSwGUK4yEsoo2+XEKFPsUYoM0se+KJEOFMxf1iG5DFmaU/AJSkRFLnMkC
         Xi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Vz3NVjeSduBFGcr7e4KNuJw+YQxjHIZNkFnnUo3vhA=;
        b=MWJuovmONKIuH6Qd3Tp42IyEj1hhNdyafgGtd/JsG2Pyj0DbeBrducdJh0YphLLw1h
         xVFGASi02wSLLKmPW8xb4L6qJcnTmfelH2TToV1z3c0sVwRuCw5S01LFrdQrg+gsfxs6
         8MdP+xp8P6bpRF0vmVHKbWKz3JtqL0x7XpuXREEZyvyfrLV29ha2ezV4p6dv92kXqDRS
         Olw8g6PpozqOfD3XtBj30wYCjGKA+D/1pL4lsvdXFOYrafG5BxTdzdn9HPzkQPIiOKrd
         VVXBqHnLOdRghKJgtEkRRT9RuCS1ZsTjLYVBIAUIL+Yp3C2ghYlYwtkMzKdisxd3zupo
         8ILQ==
X-Gm-Message-State: AOAM530vGp1wNWA3OrXN94gWKOqnsvC99Ydfp1KhmTgH42xVRphEPwP2
        BqY9HbsFAKaqiNZE3xzM/3U=
X-Google-Smtp-Source: ABdhPJyXRhNHpJwPFimIfNRvAdJwYclnTh5DYMJmV8PxCXAGY/nYbXtvLNcUy0Zh6uqXOd1GETbfTg==
X-Received: by 2002:a17:906:f56:: with SMTP id h22mr31470771ejj.366.1620737512992;
        Tue, 11 May 2021 05:51:52 -0700 (PDT)
Received: from spectre.. (host-79-47-116-73.retail.telecomitalia.it. [79.47.116.73])
        by smtp.gmail.com with ESMTPSA id h4sm13093391edv.97.2021.05.11.05.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:51:52 -0700 (PDT)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     Elia Devito <eliadevito@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Hui Wang <hui.wang@canonical.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek: Add fixup for HP Spectre x360 15-df0xxx
Date:   Tue, 11 May 2021 14:46:49 +0200
Message-Id: <20210511124651.4802-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <s5ho8dhd4b3.wl-tiwai@suse.de>
References: <s5ho8dhd4b3.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup to enable all 4 speaker on HP Spectre x360 15-df0xxx and probably
on similar models.

0x14 pin config override is required to enable all speakers and
alc285-speaker2-to-dac1 fixup to enable volume adjustment.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=189331
Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
v2: Put the quirk entry in the PCI SSID order

 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b4b71609dff1..3e269de84079 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6542,6 +6542,7 @@ enum {
 	ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST,
 	ALC295_FIXUP_ASUS_DACS,
 	ALC295_FIXUP_HP_OMEN,
+	ALC285_FIXUP_HP_SPECTRE_X360,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8099,6 +8100,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HP_LINE1_MIC1_LED,
 	},
+	[ALC285_FIXUP_HP_SPECTRE_X360] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x14, 0x90170110 }, /* enable top speaker */
+			{}
+		},
+		.chained = true,
+		.chain_id = ALC285_FIXUP_SPEAKER2_TO_DAC1,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -8259,6 +8269,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8497, "HP Envy x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32", ALC274_FIXUP_HP_ENVY_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8724, "HP EliteBook 850 G7", ALC285_FIXUP_HP_GPIO_LED),
@@ -8665,6 +8676,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC274_FIXUP_HP_MIC, .name = "alc274-hp-mic-detect"},
 	{.id = ALC245_FIXUP_HP_X360_AMP, .name = "alc245-hp-x360-amp"},
 	{.id = ALC295_FIXUP_HP_OMEN, .name = "alc295-hp-omen"},
+	{.id = ALC285_FIXUP_HP_SPECTRE_X360, .name = "alc285-hp-spectre-x360"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.31.1


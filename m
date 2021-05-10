Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250D5379534
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhEJRQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhEJRQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:16:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602BDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:15:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n2so25657155ejy.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jIuFuf8Zfs+fmLGUjbEH8ZtGFko41nDRxioSANkA/8=;
        b=uEs9tjg9MZlXMlSQ7QXwugYoZwYcsSKgPLBJw48pSKTBDkNLaPzDPjP1tKjacIzIj6
         ipHnA/6mWnM0PFh+DtNQherH10zY6acIPlf+Q7vsO1RkHp3eodkZaNveaB+juGlfZOyu
         LbZ/H9ytlwMwvkuFV3D4QrEI+EDfyK4S4u5gj0Y/iPR6fh6Cu9ADapSMsbromZ03tOoE
         4y/JRQ2Eiv4lWDDw4Ol8R166s7ywc0oI+h62xHOfkRq5Igx0xft0d7Ic+lNFjIJ0kjF4
         JJ7BFZAJs7x8OktMlIiC8p6Aq09VUgUj7M8GvU0hCJojQODibeL78EaQKquj0CQPPxIv
         p5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jIuFuf8Zfs+fmLGUjbEH8ZtGFko41nDRxioSANkA/8=;
        b=bjGgwb0eCqWPxHn3pFodQdJD4/ba5zRuDFMaXAGxUgEL/W5qCQs6qZsFWEiEZwNt3s
         igXG8jai/0CPPZ7wGv0R5pSSBKECjKeow2mmEar3AhIPMpJxLWfJQelAepcZaebLPgAV
         iQF6jWEpQOWPa7Vq43XYwaSr9uFG2teuysWF4q40sm+TcKaO7YqUhqK9M8jC118sK/RT
         sbPj4IrhpUmi4HHCQv/V0qkNPdymw4kjSGKUdd1gw1uoJ3aHsIAkl0rcMfc9jWP/J2rj
         1oMoRTkzBBzonaXaz6F2lqIK5F2BsuX7JJ01TQ3Sbq4bDWTFuqXNMIdHfjLspa41o1EF
         PEMQ==
X-Gm-Message-State: AOAM531gcIwxaHvJ0J/VWo9UzbBXMqqimOxGB/Y8rdYFs/QhmX03Dkuq
        OJvsF9fuqd+YhHcPyBvgd9/yWF03Dm9ruO/K
X-Google-Smtp-Source: ABdhPJzxy9lRCMnYTypkHKsuB+w88pAkFn4LYMnAB+gbRW/+PcMvWX8EpixdKA4dcdK2bjzwLQnVjg==
X-Received: by 2002:a17:907:ab2:: with SMTP id bz18mr3169358ejc.150.1620666907134;
        Mon, 10 May 2021 10:15:07 -0700 (PDT)
Received: from spectre.fritz.box (host-79-47-116-73.retail.telecomitalia.it. [79.47.116.73])
        by smtp.gmail.com with ESMTPSA id hz15sm980260ejc.57.2021.05.10.10.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:15:06 -0700 (PDT)
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
Subject: [PATCH] ALSA: hda/realtek: Add fixup for HP Spectre x360 15-df0xxx
Date:   Mon, 10 May 2021 19:13:33 +0200
Message-Id: <20210510171332.8313-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.31.1
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
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b4b71609dff1..be2a5cd2875d 100644
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
@@ -8278,6 +8288,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87f4, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
+	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884c, "HP EliteBook 840 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
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


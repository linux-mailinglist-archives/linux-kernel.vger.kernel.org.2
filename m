Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4443D14BD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 19:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbhGUQVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 12:21:34 -0400
Received: from mail.ispras.ru ([83.149.199.84]:35228 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhGUQVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:21:31 -0400
Received: from localhost.localdomain (unknown [46.188.10.168])
        by mail.ispras.ru (Postfix) with ESMTPSA id 01B0040D403D;
        Wed, 21 Jul 2021 17:02:04 +0000 (UTC)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hui Wang <hui.wang@canonical.com>,
        Kailang Yang <kailang@realtek.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Chris Chiu <chris.chiu@canonical.com>,
        PeiSen Hou <pshou@realtek.com>, alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek: add mic quirk for Acer SF314-42
Date:   Wed, 21 Jul 2021 20:01:41 +0300
Message-Id: <20210721170141.24807-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Acer Swift SF314-42 laptop is using Realtek ALC255 codec. Add a
quirk so microphone in a headset connected via the right-hand side jack
is usable.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Hui Wang <hui.wang@canonical.com>
Cc: Kailang Yang <kailang@realtek.com>
Cc: Jeremy Szu <jeremy.szu@canonical.com>
Cc: Jian-Hong Pan <jhp@endlessos.org>
Cc: Chris Chiu <chris.chiu@canonical.com>
Cc: PeiSen Hou <pshou@realtek.com>
Cc: alsa-devel@alsa-project.org
---
Hello,

Acer Swift SF314-42 laptop is using AMD Ryzen SoC audio with Realtek
ALC255 codec. The are three ALSA cards: HDMI audio, AMD ACP card, and
AMD HDA card. There is an internal stereo microphone connected to the
ACP card, and a mini-jack connected to the Realtek codec. There are no
LEDs.

I'd like to be able to use a mic+headphones headset. Unfortunately, out
of the box ALSA does not correctly detect the microphone input of the
Realtek codec.  The suggested patch fixes that, though I cannot be sure
it's 100% correct.

With the patch, the experience is unfortunately still not ideal. I have
noticed a couple of issues:

1) at high enough gain, recording the microphone is picking up what is
being played via the headphones; maybe it's supposed to be like that,
but it surprised me;

2) there is a very noticeable "pop" when plugging the headset in/out,
accompanied by

pcieport 0000:00:08.1: PME: Spurious native interrupt!
pcieport 0000:00:08.1: PME: Spurious native interrupt!

in dmesg. I'd appreciate info and any help about this issue.

Thanks.
Alexander

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ab5113cccffa..87ad8469dbc5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8191,6 +8191,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", ALC233_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x142b, "Acer Swift SF314-42", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1430, "Acer TravelMate B311R-31", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1466, "Acer Aspire A515-56", ALC255_FIXUP_ACER_HEADPHONE_AND_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),

base-commit: 62fb9874f5da54fdb243003b386128037319b219
-- 
2.31.1

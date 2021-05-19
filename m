Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E2738945B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355516AbhESRGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:06:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37086 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355502AbhESRGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:06:05 -0400
Received: from 61-220-137-34.hinet-ip.hinet.net ([61.220.137.34] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <jeremy.szu@canonical.com>)
        id 1ljPcV-0004HE-AE; Wed, 19 May 2021 17:04:32 +0000
From:   Jeremy Szu <jeremy.szu@canonical.com>
To:     tiwai@suse.com
Cc:     Jeremy Szu <jeremy.szu@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Hui Wang <hui.wang@canonical.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        PeiSen Hou <pshou@realtek.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] ALSA: hda/realtek: fix mute/micmute LEDs for HP 855 G8
Date:   Thu, 20 May 2021 01:03:53 +0800
Message-Id: <20210519170357.58410-1-jeremy.szu@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP EliteBook 855 G8 Notebook PC is using ALC285 codec which needs
ALC285_FIXUP_HP_MUTE_LED fixup to make it works. After applying the
fixup, the mute/micmute LEDs work good.

Signed-off-by: Jeremy Szu <jeremy.szu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 552e2cb73291..9d68f591c6bf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8291,6 +8291,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884c, "HP EliteBook 840 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645593ABA67
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhFQRRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:17:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56915 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhFQRRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:17:16 -0400
Received: from 36-226-162-78.dynamic-ip.hinet.net ([36.226.162.78] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <jeremy.szu@canonical.com>)
        id 1ltvbO-0002yH-JM; Thu, 17 Jun 2021 17:14:51 +0000
From:   Jeremy Szu <jeremy.szu@canonical.com>
To:     tiwai@suse.com
Cc:     Jeremy Szu <jeremy.szu@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook x360 830 G8
Date:   Fri, 18 Jun 2021 01:14:20 +0800
Message-Id: <20210617171422.16652-1-jeremy.szu@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP EliteBook x360 830 G8 using ALC285 codec which using 0x04 to
control mute LED and 0x01 to control micmute LED.
Therefore, add a quirk to make it works.

Signed-off-by: Jeremy Szu <jeremy.szu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dcd9bceace68..ae5963345093 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8330,6 +8330,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8847, "HP EliteBook x360 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884c, "HP EliteBook 840 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x886d, "HP ZBook Fury 17.3 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D8D44C32E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhKJOoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:44:13 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:56420
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231514AbhKJOoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:44:11 -0500
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D448C3F197;
        Wed, 10 Nov 2021 14:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636555283;
        bh=AmOia6mFVXePE5lwo8LpCWa2Ymdv43SwCIz0a9emYu0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=rAJ1bnjiSaLb0j5n09NYop4w/L9Q8P0VcaXV2OGa7ScfEte+XS6wglwb1CTID5kGt
         7DDlVRprwehlasN7bwg7Zc43RiSUWe1lgupLDDmvVoc42YDPu88rvUlkYVBx5gSiPz
         QWmbXOZ9bKQpR708jHaHzS0MA7X5ZBTUCoWCZDg5msy3vXPCmsx6Xzxm24WqGngHkM
         yv06yFRCF8Ms94/bi8lnRqk5zlIXiCqQ0zmGccR2oc5ePgekYnQE9goFIzoWuG5VNi
         3zRod26IfYouLeArlZo5YIcqG5ujHa+TpJWHfTRplgv9nbtmu9CzcvAEnnnhhG8+c7
         T2TqzBChZ5nEg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
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
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP EliteBook 840 G7 mute LED
Date:   Wed, 10 Nov 2021 22:40:32 +0800
Message-Id: <20211110144033.118451-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mute and micmute LEDs don't work on HP EliteBook 840 G7. The same
quirk for other HP laptops can let LEDs work, so apply it.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a6098c942aeb5..2f1727faec698 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8636,6 +8636,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8716, "HP Elite Dragonfly G2 Notebook PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8720, "HP EliteBook x360 1040 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8724, "HP EliteBook 850 G7", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8728, "HP EliteBook 840 G7", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8729, "HP", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8730, "HP ProBook 445 G7", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8736, "HP", ALC285_FIXUP_HP_GPIO_AMP_INIT),
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE4F3E5800
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbhHJKJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:09:49 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:45600
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230039AbhHJKJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:09:48 -0400
Received: from localhost.localdomain (61-220-137-37.HINET-IP.hinet.net [61.220.137.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 831763F107;
        Tue, 10 Aug 2021 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628590165;
        bh=x/Db548JcNjl7vdwhUu8F9KYkZB9HM7NmO3UOKZN8AY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ruG57TO9RatLz8T7uzz1DsNt2wybJDlCcLk5KYb7ypRiDn1Bd7dagg0GIUEGQPupL
         stPbMtKYuWoSknUevNiXrXiUaYQBZW9Gs6Jiwn9XZfyZvCCasFm1S/Z2/O1jnAltvr
         Eph2aWGxeIlYghNVXnQ/gHl21wJk11Xl7FRxjX3uR6U28IIwbRd9L3C07otGMQu8rb
         svlg0NbYqkqPsttqxUCYV3+tMz3cUZpm/IuVIVvxFd1oaLAcZWOTgZDwcJaabvpCau
         R4PMOCqGVBzN+uy5QED3XJEVC4x6aFf5eQXAULKmWgWB1dPhwOiCmt/dvKWc3VuYlC
         Dm7I9Hm421yMg==
From:   Jeremy Szu <jeremy.szu@canonical.com>
To:     tiwai@suse.com
Cc:     Jeremy Szu <jeremy.szu@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Chris Chiu <chris.chiu@canonical.com>,
        PeiSen Hou <pshou@realtek.com>, Luke D Jones <luke@ljones.dev>,
        Sami Loone <sami@loone.fi>,
        Werner Sembach <wse@tuxedocomputers.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook 650 G8 Notebook PC
Date:   Tue, 10 Aug 2021 18:08:45 +0800
Message-Id: <20210810100846.65844-1-jeremy.szu@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP ProBook 650 G8 Notebook PC is using ALC236 codec which is
using 0x02 to control mute LED and 0x01 to control micmute LED.
Therefore, add a quirk to make it works.

Signed-off-by: Jeremy Szu <jeremy.szu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4043a2362f27..a065260d0d20 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8431,6 +8431,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87f4, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
+	SND_PCI_QUIRK(0x103c, 0x8805, "HP ProBook 650 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8847, "HP EliteBook x360 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
-- 
2.25.1


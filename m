Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE5639BA71
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhFDOD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:03:57 -0400
Received: from srv6.fidu.org ([159.69.62.71]:37516 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhFDOD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:03:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id A9832C800BF;
        Fri,  4 Jun 2021 16:02:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id now7DJH372gl; Fri,  4 Jun 2021 16:02:09 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300E37F2e2A0038b625C68b541A92.dip0.t-ipconnect.de [IPv6:2003:e3:7f2e:2a00:38b6:25c6:8b54:1a92])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 5D798C800BE;
        Fri,  4 Jun 2021 16:02:09 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH] ALSA: hda/realtek: Change device names for quirks to barebone names
Date:   Fri,  4 Jun 2021 16:02:07 +0200
Message-Id: <20210604140207.8023-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the name string of several devices needing quirks to the Clevo-barebone
ones. Also make the names follow the same pattern for multiple Clevo names
referring to the same mainboard.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 sound/pci/hda/patch_realtek.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 552e2cb73291..39cf3667118c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8368,7 +8368,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x152d, 0x1082, "Quanta NL3", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x1558, 0x1323, "Clevo N130ZU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1558, 0x1325, "System76 Darter Pro (darp5)", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x1325, "Clevo N15[01][CW]U", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1401, "Clevo L140[CZ]U", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1403, "Clevo N140CU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1404, "Clevo N150CU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
@@ -8403,11 +8403,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x8521, "Clevo NH77D[CD]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x8535, "Clevo NH50D[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x8536, "Clevo NH79D[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1558, 0x8550, "System76 Gazelle (gaze14)", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1558, 0x8551, "System76 Gazelle (gaze14)", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1558, 0x8560, "System76 Gazelle (gaze14)", ALC269_FIXUP_HEADSET_MIC),
-	SND_PCI_QUIRK(0x1558, 0x8561, "System76 Gazelle (gaze14)", ALC269_FIXUP_HEADSET_MIC),
-	SND_PCI_QUIRK(0x1558, 0x8562, "Clevo NH[5|7][0-9]RZ[Q]", ALC269_FIXUP_DMIC),
+	SND_PCI_QUIRK(0x1558, 0x8550, "Clevo NH[57][0-9][ER][ACDH]Q", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x8551, "Clevo NH[57][0-9][ER][ACDH]Q", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x8560, "Clevo NH[57][0-9][ER][ACDH]Q", ALC269_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1558, 0x8561, "Clevo NH[57][0-9][ER][ACDH]Q", ALC269_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1558, 0x8562, "Clevo NH[57][0-9]RZ[Q]", ALC269_FIXUP_DMIC),
 	SND_PCI_QUIRK(0x1558, 0x8668, "Clevo NP50B[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x8680, "Clevo NJ50LU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x8686, "Clevo NH50[CZ]U", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
@@ -8418,8 +8418,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x9600, "Clevo N960K[PR]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x961d, "Clevo N960S[CDF]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x971d, "Clevo N970T[CDF]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1558, 0xa500, "Clevo NL53RU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1558, 0xa600, "Clevo NL5XNU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0xa500, "Clevo NL5[03]RU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0xa600, "Clevo NL50NU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb018, "Clevo NP50D[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb019, "Clevo NH77D[BE]Q", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb022, "Clevo NH77D[DC][QW]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3342F423E60
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhJFNGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhJFNGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:06:10 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDADC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 06:04:18 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id D7F68C800A8;
        Wed,  6 Oct 2021 15:04:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id YqVPxxQtB_uR; Wed,  6 Oct 2021 15:04:15 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 74B99C800A5;
        Wed,  6 Oct 2021 15:04:15 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for TongFang PHxTxX1
Date:   Wed,  6 Oct 2021 15:04:15 +0200
Message-Id: <20211006130415.538243-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This applies a SND_PCI_QUIRK(...) to the TongFang PHxTxX1 barebone. This
fixes the issue of the internal Microphone not working after booting
another OS.

When booting a certain another OS this barebone keeps some coeff settings
even after a cold shutdown. These coeffs prevent the microphone detection
from working in Linux, making the Laptop think that there is always an
external microphone plugged-in and therefore preventing the use of the
internal one.

The relevant indexes and values where gathered by naively diff-ing and
reading a working and a non-working coeff dump.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 sound/pci/hda/patch_realtek.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4407f7da57c4..55d3c9d85fd2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6449,6 +6449,24 @@ static void alc287_fixup_legion_15imhg05_speakers(struct hda_codec *codec,
 /* for alc285_fixup_ideapad_s740_coef() */
 #include "ideapad_s740_helper.c"
 
+static void alc256_fixup_tongfang_reset_persistent_settings(struct hda_codec *codec,
+							    const struct hda_fixup *fix,
+							    int action)
+{
+	/*
+	* A certain other OS sets these coeffs to different values. On at least one TongFang
+	* barebone these settings might survive even a cold reboot. So to restore a clean slate the
+	* values are explicitly reset to default here. Without this, the external microphone is
+	* always in a plugged-in state, while the internal microphone is always in an unplugged
+	* state, breaking the ability to use the internal microphone.
+	*/
+	alc_write_coef_idx(codec, 0x24, 0x0000);
+	alc_write_coef_idx(codec, 0x26, 0x0000);
+	alc_write_coef_idx(codec, 0x29, 0x3000);
+	alc_write_coef_idx(codec, 0x37, 0xfe05);
+	alc_write_coef_idx(codec, 0x45, 0x5089);
+}
+
 enum {
 	ALC269_FIXUP_GPIO2,
 	ALC269_FIXUP_SONY_VAIO,
@@ -6663,7 +6681,8 @@ enum {
 	ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS,
 	ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
 	ALC287_FIXUP_YOGA7_14ITL_SPEAKERS,
-	ALC287_FIXUP_13S_GEN2_SPEAKERS
+	ALC287_FIXUP_13S_GEN2_SPEAKERS,
+	ALC256_FIXUP_TONGFANG_RESET_PERSISTENT_SETTINGS,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8361,6 +8380,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE,
 	},
+	[ALC256_FIXUP_TONGFANG_RESET_PERSISTENT_SETTINGS] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc256_fixup_tongfang_reset_persistent_settings,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -8789,6 +8812,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 	SND_PCI_QUIRK(0x1c06, 0x2013, "Lemote A1802", ALC269_FIXUP_LEMOTE_A1802),
 	SND_PCI_QUIRK(0x1c06, 0x2015, "Lemote A190X", ALC269_FIXUP_LEMOTE_A190X),
+	SND_PCI_QUIRK(0x1d05, 0x1132, "TongFang PHxTxX1", ALC256_FIXUP_TONGFANG_RESET_PERSISTENT_SETTINGS),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
-- 
2.25.1


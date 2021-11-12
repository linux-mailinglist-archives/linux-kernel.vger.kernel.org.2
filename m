Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5CF44E556
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 12:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhKLLKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 06:10:00 -0500
Received: from srv6.fidu.org ([159.69.62.71]:33864 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233994AbhKLLJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 06:09:56 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id E3CEDC8009D;
        Fri, 12 Nov 2021 12:07:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id l3sTf6RsUn9l; Fri, 12 Nov 2021 12:07:04 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 8F553C8009C;
        Fri, 12 Nov 2021 12:07:04 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek: Add quirk for ASRock NUC Box 1100
Date:   Fri, 12 Nov 2021 12:07:04 +0100
Message-Id: <20211112110704.1022501-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This applies a SND_PCI_QUIRK(...) to the ASRock NUC Box 1100 series. This
fixes the issue of the headphone jack not being detected unless warm
rebooted from a certain other OS.

When booting a certain other OS some coeff settings are changed that enable
the audio jack. These settings are preserved on a warm reboot and can be
easily dumped.

The relevant indexes and values where gathered by naively diff-ing and
reading a working and a non-working coeff dump.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 sound/pci/hda/patch_realtek.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2f1727faec69..701c80ed83dc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6521,6 +6521,27 @@ static void alc256_fixup_tongfang_reset_persistent_settings(struct hda_codec *co
 	alc_write_coef_idx(codec, 0x45, 0x5089);
 }
 
+static const struct coef_fw alc233_fixup_no_audio_jack_coefs[] = {
+	WRITE_COEF(0x1a, 0x9003), WRITE_COEF(0x1b, 0x0e2b), WRITE_COEF(0x37, 0xfe06),
+	WRITE_COEF(0x38, 0x4981), WRITE_COEF(0x45, 0xd489), WRITE_COEF(0x46, 0x0074),
+	WRITE_COEF(0x49, 0x0149),
+	{}
+};
+
+static void alc233_fixup_no_audio_jack(struct hda_codec *codec,
+				       const struct hda_fixup *fix,
+				       int action)
+{
+	/*
+	 * The audio jack input and output is not detected on the ASRock NUC Box
+	 * 1100 series when cold booting without this fix. Warm rebooting from a
+	 * certain other OS makes the audio functional, as COEF settings are
+	 * preserved in this case. This fix sets these altered COEF values as
+	 * the default.
+	 */
+	alc_process_coef_fw(codec, alc233_fixup_no_audio_jack_coefs);
+}
+
 enum {
 	ALC269_FIXUP_GPIO2,
 	ALC269_FIXUP_SONY_VAIO,
@@ -6740,6 +6761,7 @@ enum {
 	ALC287_FIXUP_13S_GEN2_SPEAKERS,
 	ALC256_FIXUP_TONGFANG_RESET_PERSISTENT_SETTINGS,
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
+	ALC233_FIXUP_NO_AUDIO_JACK,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8460,6 +8482,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC,
 	},
+	[ALC233_FIXUP_NO_AUDIO_JACK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc233_fixup_no_audio_jack,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -8894,6 +8920,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511e, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
+	SND_PCI_QUIRK(0x1849, 0x1233, "ASRock NUC Box 1100", ALC233_FIXUP_NO_AUDIO_JACK),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
 	SND_PCI_QUIRK(0x1b35, 0x1235, "CZC B20", ALC269_FIXUP_CZC_B20),
 	SND_PCI_QUIRK(0x1b35, 0x1236, "CZC TMI", ALC269_FIXUP_CZC_TMI),
-- 
2.25.1


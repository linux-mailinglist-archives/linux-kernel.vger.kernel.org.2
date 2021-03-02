Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F4532A4F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349993AbhCBLpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 06:45:14 -0500
Received: from srv6.fidu.org ([159.69.62.71]:37672 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380366AbhCBL0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 06:26:37 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Mar 2021 06:26:36 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 9644BC800CD;
        Tue,  2 Mar 2021 12:25:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id lbnLkmpAJE1l; Tue,  2 Mar 2021 12:25:06 +0100 (CET)
Received: from [IPv6:2003:e3:7f23:4700:cc41:88a7:f2f8:d6b8] (p200300e37f234700CC4188a7F2f8D6b8.dip0.t-ipconnect.de [IPv6:2003:e3:7f23:4700:cc41:88a7:f2f8:d6b8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 52B51C800CB;
        Tue,  2 Mar 2021 12:25:06 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Intel NUC 10
To:     wse@tuxedocomputers.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@vger.kernel.org
Autocrypt: addr=wse@tuxedocomputers.com; keydata=
 mDMEX6ALvhYJKwYBBAHaRw8BAQdAG/kE3mlbV1YLpCU8iA7Pyq2eDq9LxzGQxcOZODh2Vnq0
 KFdlcm5lciBTZW1iYWNoIDx3c2VAdHV4ZWRvY29tcHV0ZXJzLmNvbT6IlgQTFggAPhYhBNzq
 jJqAsvWKK1h7bi7eQpXUvijKBQJfoAu+AhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMBAh4B
 AheAAAoJEC7eQpXUvijKzkEA/jblmQRWU/e18oo8J9GPHWOCRUA1WJLUt9lSye5cgl2vAP0Y
 q+EpkDRS+QqtIcIr3fVELwA4b/V1lVE2LW+plcmdCbg4BF+gC74SCisGAQQBl1UBBQEBB0Bc
 k3J9DVAB4ysrdDcKE7L9iAUjlWD+rsLh/5soPORqFQMBCAeIfgQYFggAJhYhBNzqjJqAsvWK
 K1h7bi7eQpXUvijKBQJfoAu+AhsMBQkJZgGAAAoJEC7eQpXUvijKBBYA/2DT2g26dpTU2Rbc
 lqviltu+woGZCd0GBfRgXuzUK0OfAQCwr8qPCl8uIsBgOsDmWIJYByG2ddwmXiAgBS1985bM Ag==
Message-ID: <447c7c3f-9e9b-bdbe-5c91-c6d8ab306173@tuxedocomputers.com>
Date:   Tue, 2 Mar 2021 12:25:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Werner Sembach <wse@tuxedocomputers.com>

ALSA: hda/realtek: Add quirk for Intel NUC 10

This adds a new SND_PCI_QUIRK(...) and applies it to the Intel NUC 10
devices. This fixes the issue of the devices not having audio input and
output on the headset jack because the kernel does not recognize when
something is plugged in.

The new quirk was inspired by the quirk for the Intel NUC 8 devices, but
it turned out that the NUC 10 uses another pin. This information was
acquired by black box testing likely pins.

Co-developed-by: Eckhart Mohr <e.mohr@tuxedocomputers.com>
Signed-off-by: Eckhart Mohr <e.mohr@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
Hi,
this is my second ever submitted kernel patch with the first one send just some minutes ago, feel free to criticise me if I made an error or missed a best practice bullet point.
Also: I'm unsure if this would fit the requirements for stable@vger.kernel.org and/or trivial@kernel.org, but I think not (correct me if I'm wrong).
Kind regards
Werner Sembach

From d281364b8ca6c054a0e5ce20caa599bf7d08160d Mon Sep 17 00:00:00 2001
From: Werner Sembach <wse@tuxedocomputers.com>
Date: Fri, 26 Feb 2021 13:54:30 +0100
Subject: [PATCH] Fix Intel NUC10 no output and input on headset jack

---
 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 290645516313..c14d624dbaf1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6362,6 +6362,7 @@ enum {
     ALC269_FIXUP_LEMOTE_A1802,
     ALC269_FIXUP_LEMOTE_A190X,
     ALC256_FIXUP_INTEL_NUC8_RUGGED,
+    ALC256_FIXUP_INTEL_NUC10,
     ALC255_FIXUP_XIAOMI_HEADSET_MIC,
     ALC274_FIXUP_HP_MIC,
     ALC274_FIXUP_HP_HEADSET_MIC,
@@ -7744,6 +7745,15 @@ static const struct hda_fixup alc269_fixups[] = {
         .chained = true,
         .chain_id = ALC269_FIXUP_HEADSET_MODE
     },
+    [ALC256_FIXUP_INTEL_NUC10] = {
+        .type = HDA_FIXUP_PINS,
+        .v.pins = (const struct hda_pintbl[]) {
+            { 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+            { }
+        },
+        .chained = true,
+        .chain_id = ALC269_FIXUP_HEADSET_MODE
+    },
     [ALC255_FIXUP_XIAOMI_HEADSET_MIC] = {
         .type = HDA_FIXUP_VERBS,
         .v.verbs = (const struct hda_verb[]) {
@@ -8183,6 +8193,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
     SND_PCI_QUIRK(0x1c06, 0x2013, "Lemote A1802", ALC269_FIXUP_LEMOTE_A1802),
     SND_PCI_QUIRK(0x1c06, 0x2015, "Lemote A190X", ALC269_FIXUP_LEMOTE_A190X),
     SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
+    SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
 
 #if 0
     /* Below is a quirk table taken from the old code.
-- 
2.25.1









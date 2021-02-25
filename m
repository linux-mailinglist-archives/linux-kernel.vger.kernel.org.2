Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F13324CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbhBYJX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:23:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58492 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbhBYJWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:22:02 -0500
Received: from mail-oo1-f72.google.com ([209.85.161.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lFCpj-00073y-3P
        for linux-kernel@vger.kernel.org; Thu, 25 Feb 2021 09:21:19 +0000
Received: by mail-oo1-f72.google.com with SMTP id n26so2628883oov.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=twjGv/8DgTHy0QTq2NWyH703FNvrGECchLAOZ9MyTgc=;
        b=dMQXPAjdytk/cMkexWMNFlYl4D81kAyR4djV0tU49JSIwEhu8R8LkMRQqSiTU3P8Lz
         iaWL5kPdSRvT3knYnB6w526zY4ZLyqQJh4MPh38CbBSCCdPyCLCoTpLvFmtHxsYORab7
         3G25AEHsfEdCwlknlnaEK2Dh7Uu41Iy2vwu27RYZKt2J3zxiDOpnNIxuMJgsck09mUu2
         yTuXFqwHQi+fOTCeYkRNimXO5i6/seyDB2gmKlbz7kq6p/LolPt0bUlNESJG5gGQLQHv
         suc5DetIoOWGtHpJDdEeXf1yPy3ma2DLYuE8W9L6jTzR9PuGapt0zFSwTxIRPhGDThMo
         NknQ==
X-Gm-Message-State: AOAM532HmQ4h2v6iGVPRYIunSKQXCnPb9SvwIKjHzVCfTfBLeGkPChxN
        yp3sbg3N38spaCk036sU1P5z0wjyonfH1MKCPTI2PclW0XWKNhFBIwpb+EmXpT6AJ7I/fE6V1jL
        kPKKgOTuwzt3udqLz6+P4DIbtRtO9FsnOwzfdsqViVSbVvAJ0T6FZ1hFI2Q==
X-Received: by 2002:a9d:3a34:: with SMTP id j49mr1482089otc.153.1614244878144;
        Thu, 25 Feb 2021 01:21:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDwDCbA8Y1lKOajJrLz84FE3mo8EJZPiS/emi1+68APzsus/rzd+ZoxxvYNANhxnD02ZnHhJJGJy9IhWdqpew=
X-Received: by 2002:a9d:3a34:: with SMTP id j49mr1482075otc.153.1614244877982;
 Thu, 25 Feb 2021 01:21:17 -0800 (PST)
MIME-Version: 1.0
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Thu, 25 Feb 2021 17:21:07 +0800
Message-ID: <CABTNMG0O_z1tOqb=dR44zgasSL5m73ABpu+bj2WKK0+QWY-EEw@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Enable MICs of Acer SWIFT with ALC256
To:     tiwai@suse.com, kailang@realtek.com, jhp@endlessos.org,
        kai.heng.feng@canonical.com, hui.wang@canonical.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Acer SWIFT Swift SF314-54/55 with ALC256 cannot detect the headset
microphone and suffers the noise problem in audio capture.

This patch enables the headset jack sense and fixes the noise problem with
aamix fixup.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 290645516313..57e4dbcd76a9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6372,6 +6372,8 @@ enum {
        ALC236_FIXUP_DELL_AIO_HEADSET_MIC,
        ALC282_FIXUP_ACER_DISABLE_LINEOUT,
        ALC255_FIXUP_ACER_LIMIT_INT_MIC_BOOST,
+       ALC256_FIXUP_ACER_SWIFT_NO_MIC_PRESENCE,
+       ALC256_FIXUP_ACER_SWIFT_DISABLE_AAMIX,
 };

 static const struct hda_fixup alc269_fixups[] = {
@@ -7815,6 +7817,22 @@ static const struct hda_fixup alc269_fixups[] = {
                .chained = true,
                .chain_id = ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
        },
+       [ALC256_FIXUP_ACER_SWIFT_NO_MIC_PRESENCE] = {
+               .type = HDA_FIXUP_PINS,
+               .v.pins = (const struct hda_pintbl[]) {
+                       { 0x19, 0x02a1113c }, /* use as headset mic,
without its own jack detect */
+                       { 0x1a, 0x90a1092f }, /* use as internal mic */
+                       { },
+               },
+               .chained = true,
+               .chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+       },
+       [ALC256_FIXUP_ACER_SWIFT_DISABLE_AAMIX] = {
+               .type = HDA_FIXUP_FUNC,
+               .v.func = alc_fixup_disable_aamix,
+               .chained = true,
+               .chain_id = ALC256_FIXUP_ACER_SWIFT_NO_MIC_PRESENCE
+       },
 };

 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7841,9 +7859,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
        SND_PCI_QUIRK(0x1025, 0x1246, "Acer Predator Helios 500",
ALC299_FIXUP_PREDATOR_SPK),
        SND_PCI_QUIRK(0x1025, 0x1247, "Acer vCopperbox",
ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
        SND_PCI_QUIRK(0x1025, 0x1248, "Acer Veriton N4660G",
ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE),
+       SND_PCI_QUIRK(0x1025, 0x1269, "Acer SWIFT SF314-54",
ALC256_FIXUP_ACER_SWIFT_DISABLE_AAMIX),
        SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G",
ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
        SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G",
ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
        SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G",
ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
+       SND_PCI_QUIRK(0x1025, 0x129c, "Acer SWIFT SF314-55",
ALC256_FIXUP_ACER_SWIFT_DISABLE_AAMIX),
        SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890",
ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
        SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21",
ALC233_FIXUP_ACER_HEADSET_MIC),
        SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T",
ALC255_FIXUP_ACER_HEADSET_MIC),
--
2.20.1

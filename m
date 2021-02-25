Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F1B324EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhBYLMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:12:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33607 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBYLLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:11:25 -0500
Received: from mail-oo1-f71.google.com ([209.85.161.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lFEXY-00070k-Ma
        for linux-kernel@vger.kernel.org; Thu, 25 Feb 2021 11:10:40 +0000
Received: by mail-oo1-f71.google.com with SMTP id u9so2760876oon.23
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 03:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adqpBJBQoN/ekIxgRIeg6Tz/2+czjMQCDVft8+bODmQ=;
        b=tFmNN5kohO6jVyvphQBfLHsl5Q5pu6Kc2P9pSUlDq6hbyADYPz0fu3tem4mOJ+KR9N
         NTSxWth3qMQgY/897SdFNX7aiI6bHpoi5udMeEPpWBAsnetQ1t1d3PV3HqPVF4KEC5jQ
         RQR4EQvG4aliKChrjkH1p2i4LabEQ1+E4pQe8AEZlTpt929Hkcq3qCjSiIbjdez7bkK3
         JljbMzCf9FuRptMBScl0BtLZg0bWu2hqSM0Gy+ncvquXZUoSTWioTVyR5iyuX+0eYyvT
         SPM8CrYkl2NiVYGNheNUMj7BDRwE0wenCYLztq9oMXqufhprNXOlDusahblfwFr4h/4T
         Zucg==
X-Gm-Message-State: AOAM533uTXQcMwKKVaM74zcXzqFYkkINS3gThKkE3pEoCNPUry/243kE
        GBIWLlTvX65XV8Nu3T+JuEAgKbFe+46XUmya6te8Q25OODdX51vtbFuEt/iDjAgd21tnaWsBUzD
        WjhZtr7/UVegOb5H4J7b3lYPSQqIhqwBq3Y7MAuOC+94Dezz0YfTiNEuPCg==
X-Received: by 2002:a9d:63ce:: with SMTP id e14mr1698596otl.347.1614251439741;
        Thu, 25 Feb 2021 03:10:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGdFb1JSvgHY0tRt2eEp/H6FrYE5YlpGCp9qxdPjsEHxqsp7WFFJxehys+K7m3nuV3PXVEAeRw17F3i9ZYkSE=
X-Received: by 2002:a9d:63ce:: with SMTP id e14mr1698582otl.347.1614251439544;
 Thu, 25 Feb 2021 03:10:39 -0800 (PST)
MIME-Version: 1.0
References: <CABTNMG0O_z1tOqb=dR44zgasSL5m73ABpu+bj2WKK0+QWY-EEw@mail.gmail.com>
 <s5hmtvsqypu.wl-tiwai@suse.de>
In-Reply-To: <s5hmtvsqypu.wl-tiwai@suse.de>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Thu, 25 Feb 2021 19:10:28 +0800
Message-ID: <CABTNMG2f-28bHuByU61iEBqvmYaREYwaQ=aVZkCLj7OW=Sjgaw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Enable MICs of Acer SWIFT with ALC256
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, kailang@realtek.com, jhp@endlessos.org,
        kai.heng.feng@canonical.com, hui.wang@canonical.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 5:32 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 25 Feb 2021 10:21:07 +0100,
> Chris Chiu wrote:
> >
> > The Acer SWIFT Swift SF314-54/55 with ALC256 cannot detect the headset
> > microphone and suffers the noise problem in audio capture.
> >
> > This patch enables the headset jack sense and fixes the noise problem with
> > aamix fixup.
> >
> > Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
>
> The patch seems broken due to the line break and cannot be applied
> cleanly.  Could you resubmit?
>
Talked to Jian-Hong who was working on SF314-55, the aamix disable
does not really make difference. And we don't have to quirk  0x1a since
the internal mic connects to intel SST audio. I'll make a V2 patch and
resubmit. Thanks.

>
> thanks,
>
> Takashi
>
>
> > ---
> >  sound/pci/hda/patch_realtek.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> > index 290645516313..57e4dbcd76a9 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -6372,6 +6372,8 @@ enum {
> >         ALC236_FIXUP_DELL_AIO_HEADSET_MIC,
> >         ALC282_FIXUP_ACER_DISABLE_LINEOUT,
> >         ALC255_FIXUP_ACER_LIMIT_INT_MIC_BOOST,
> > +       ALC256_FIXUP_ACER_SWIFT_NO_MIC_PRESENCE,
> > +       ALC256_FIXUP_ACER_SWIFT_DISABLE_AAMIX,
> >  };
> >
> >  static const struct hda_fixup alc269_fixups[] = {
> > @@ -7815,6 +7817,22 @@ static const struct hda_fixup alc269_fixups[] = {
> >                 .chained = true,
> >                 .chain_id = ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
> >         },
> > +       [ALC256_FIXUP_ACER_SWIFT_NO_MIC_PRESENCE] = {
> > +               .type = HDA_FIXUP_PINS,
> > +               .v.pins = (const struct hda_pintbl[]) {
> > +                       { 0x19, 0x02a1113c }, /* use as headset mic,
> > without its own jack detect */
> > +                       { 0x1a, 0x90a1092f }, /* use as internal mic */
> > +                       { },
> > +               },
> > +               .chained = true,
> > +               .chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
> > +       },
> > +       [ALC256_FIXUP_ACER_SWIFT_DISABLE_AAMIX] = {
> > +               .type = HDA_FIXUP_FUNC,
> > +               .v.func = alc_fixup_disable_aamix,
> > +               .chained = true,
> > +               .chain_id = ALC256_FIXUP_ACER_SWIFT_NO_MIC_PRESENCE
> > +       },
> >  };
> >
> >  static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> > @@ -7841,9 +7859,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> >         SND_PCI_QUIRK(0x1025, 0x1246, "Acer Predator Helios 500",
> > ALC299_FIXUP_PREDATOR_SPK),
> >         SND_PCI_QUIRK(0x1025, 0x1247, "Acer vCopperbox",
> > ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
> >         SND_PCI_QUIRK(0x1025, 0x1248, "Acer Veriton N4660G",
> > ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE),
> > +       SND_PCI_QUIRK(0x1025, 0x1269, "Acer SWIFT SF314-54",
> > ALC256_FIXUP_ACER_SWIFT_DISABLE_AAMIX),
> >         SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G",
> > ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G",
> > ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G",
> > ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> > +       SND_PCI_QUIRK(0x1025, 0x129c, "Acer SWIFT SF314-55",
> > ALC256_FIXUP_ACER_SWIFT_DISABLE_AAMIX),
> >         SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890",
> > ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21",
> > ALC233_FIXUP_ACER_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T",
> > ALC255_FIXUP_ACER_HEADSET_MIC),
> > --
> > 2.20.1
> >

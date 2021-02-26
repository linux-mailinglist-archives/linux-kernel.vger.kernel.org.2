Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3016B325BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 04:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBZD2C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 Feb 2021 22:28:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58669 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBZD17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 22:27:59 -0500
Received: from mail-ot1-f71.google.com ([209.85.210.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lFTlI-0001Gj-Vy
        for linux-kernel@vger.kernel.org; Fri, 26 Feb 2021 03:25:53 +0000
Received: by mail-ot1-f71.google.com with SMTP id e19so4074673ote.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 19:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5dSe8zF5ysy2b33N95lbtVXHHADDXkQLDsXBhp0dzqg=;
        b=smq3kATTrVhr5EDurRw0TDb/bbegdYPe0+dufFfA+U0yuuRaGrx8w3FoYaHeTXKFR9
         K/vixmQgsQ3c9nG+1sjokUuy7boKAjshzgfHN7VMYGJhOUrkvmaK7KCDk8tgeLWXG95x
         imb2Y02F2dw5ssy8jnUmjz3Tiwfy1/7rUyQMebJ4sVQL3m2ACKyzKG5/GMncx8l+YXdV
         t0CCmU/vIzRb84fhNSxLyD32Lv59WxSzKLXJIgNlU+549dj7OG2P9NXHb1GbDxLWGLpc
         jA/jpWTxKUmby3wMxNYAPkWYMLiarJl3Uw9s7QcTGCfsS2pliCLbrzKFgcTSx5ub1RMV
         CI0A==
X-Gm-Message-State: AOAM532fz28bJhD1zeQpClZiuLe19uhM8w21Bj46enbAqMDypl6vrKTN
        fCAlpouVRth8mtVrTJnNzsSevzTS0O/2quEU6OFGeptrOsa9h4x2tUKpXB6/e5hQN3carFJyAWw
        sjETkklS/gH+OI6njNtRyv5dFAIKHLGRBFFLik6yN25xZGx9oGDxoCNvzIA==
X-Received: by 2002:a9d:46e:: with SMTP id 101mr477574otc.303.1614309951896;
        Thu, 25 Feb 2021 19:25:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzenB3F1N/0F+4wtl0A9N7+V/VtvrhkANP5nLTJCfWtyooq+b85cQJ/0DGtq5TNWznUHI4k5+Vs6s6E0G9rqOU=
X-Received: by 2002:a9d:46e:: with SMTP id 101mr477564otc.303.1614309951706;
 Thu, 25 Feb 2021 19:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20210226010440.8474-1-chris.chiu@canonical.com> <CAPpJ_ed1VqLQxcfdNobqWSkgtE7xrWKu8jK0U6jxWF1m3THdaA@mail.gmail.com>
In-Reply-To: <CAPpJ_ed1VqLQxcfdNobqWSkgtE7xrWKu8jK0U6jxWF1m3THdaA@mail.gmail.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Fri, 26 Feb 2021 11:25:40 +0800
Message-ID: <CABTNMG1NDeotEskQaVXPFR7=HtPeOt6a=z49VS8L5QzdAyV4jw@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic of Acer SWIFT
 with ALC256
To:     Jian-Hong Pan <jhp@endlessos.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:06 AM Jian-Hong Pan <jhp@endlessos.org> wrote:
>
> <chris.chiu@canonical.com> 於 2021年2月26日 週五 上午9:04寫道：
> >
> > From: Chris Chiu <chris.chiu@canonical.com>
> >
> > The Acer SWIFT Swift SF314-54/55 laptops with ALC256 cannot detect
> > both the headset mic and the internal mic. Introduce new fixup
> > to enable the jack sense and the headset mic. However, the internal
> > mic actually connects to Intel SST audio. It still needs Intel SST
> > support to make internal mic capture work.
> >
> > Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> > ---
> >   v1 -> v2: remove unnecessary aamix fixup
> >
> >  sound/pci/hda/patch_realtek.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> > index 1927605f0f7e..4871507cd4bf 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -6406,6 +6406,7 @@ enum {
> >         ALC236_FIXUP_DELL_AIO_HEADSET_MIC,
> >         ALC282_FIXUP_ACER_DISABLE_LINEOUT,
> >         ALC255_FIXUP_ACER_LIMIT_INT_MIC_BOOST,
> > +       ALC256_FIXUP_ACER_HEADSET_MIC,
> >  };
> >
> >  static const struct hda_fixup alc269_fixups[] = {
> > @@ -7853,6 +7854,16 @@ static const struct hda_fixup alc269_fixups[] = {
> >                 .chained = true,
> >                 .chain_id = ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
> >         },
> > +       [ALC256_FIXUP_ACER_HEADSET_MIC] = {
> > +               .type = HDA_FIXUP_PINS,
> > +               .v.pins = (const struct hda_pintbl[]) {
> > +                       { 0x19, 0x02a1113c }, /* use as headset mic, without its own jack detect */
> > +                       { 0x1a, 0x90a1092f }, /* use as internal mic */
>
> Since NID 0x1a is an internal DMIC, should this connection type be 0h?
> Or, even the quirk of the internal DMIC is not needed for this case.
> Because, it is Intel SST DMIC that does not connect to Realtek HDA
> CODEC.  (Not sure for this one)
>
> The quirk of NID 0x19 is okay for me.
>
Actually I tried the existing ALC256_FIXUP_ACER_MIC_NO_PRESENT
which only quirk the 0x19, the jack sense works but the headset mic
is still absent. That's the reason why I still need the 0x1a as the internal
mic. I've verified the headset mic can be detected and work w/o problem.

Chris

> BR,
> Jian-Hong Pan
>
> > +                       { }
> > +               },
> > +               .chained = true,
> > +               .chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
> > +       },
> >  };
> >
> >  static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> > @@ -7879,9 +7890,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> >         SND_PCI_QUIRK(0x1025, 0x1246, "Acer Predator Helios 500", ALC299_FIXUP_PREDATOR_SPK),
> >         SND_PCI_QUIRK(0x1025, 0x1247, "Acer vCopperbox", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
> >         SND_PCI_QUIRK(0x1025, 0x1248, "Acer Veriton N4660G", ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE),
> > +       SND_PCI_QUIRK(0x1025, 0x1269, "Acer SWIFT SF314-54", ALC256_FIXUP_ACER_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> > +       SND_PCI_QUIRK(0x1025, 0x129c, "Acer SWIFT SF314-55", ALC256_FIXUP_ACER_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", ALC233_FIXUP_ACER_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
> > --
> > 2.20.1
> >

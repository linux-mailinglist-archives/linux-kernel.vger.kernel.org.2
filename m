Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09914325BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 04:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhBZD0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 22:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhBZD0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 22:26:03 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F2AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 19:25:23 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id z126so8404293oiz.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 19:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W+2l0NNpBq+Qnjv0WpsTeGDz60YASdGJlf+tLVmTgvc=;
        b=YBEth4sxGYqBIiQCyhilVOJ0JbkCO+uF4haEck5ajsPJeO1K653m1fwAJIIUKNnAcw
         GP40tWdbTPXJWPgr2DRhuW6hfpJlnOmZW66tNoO5SmWNJMlFWR0Haz4eKsbEQ5BCE8Dk
         VT5zTXRfng+f6D85XHxT44YinDHOQ1PUNVqSKzI/K1gUEM6qQrDra0ZbOgL1Rokd6Xmh
         Mry/8M2it6irfISUqz7VFA2/1YWDdT/CHJK3+VlpIf67pllwS4yplXlMJD/CZAFvoe5k
         BC7M8A3+32ZCZI+JKBFlGEQQ4cSgCac90CkW3gDRDU0LHIjyDNSNuC7CLFobMgJxA1+H
         jtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W+2l0NNpBq+Qnjv0WpsTeGDz60YASdGJlf+tLVmTgvc=;
        b=h1PaSy4yqt9h26qaASYF5Oh31wzZhs+MI8gDAUP1Nx/v6LyLJoVoVYaEYqPFKvT/dJ
         uefZAFu47wXM9WV6frjkDivkZlyZPidSOTRS20wayLZYyPmMHFSdGXHz2E3dZQuh+H4g
         RPpdZL4whq8IBtCyYYjjaffNmblsXo3HGMjfJZRDA7OVW3b0gihxSCjh+Eu+btCs+BiW
         x26Oy+rr+udyKVQXlLyyKgzay1k+zy39YYbD5FiQbEmTVkyDksyd2lfSHpoEKuL4YNz5
         j8ew/1ktKAFTaeAPLx+xmcRV02vtuZ/GB5yiEOtRtG/1ByUXpkORo82FaOppHzLbxfEV
         NI2Q==
X-Gm-Message-State: AOAM530ZEhRJxpT9M+wHC9oyUW2KNHJeYONFjp4SJA+ZJYfVJ1ikeCZF
        l4xsLshkjsBgIVfTw/RLBTi2eRKktnQ3mE3EHPb8AA==
X-Google-Smtp-Source: ABdhPJzyPtTIygEci9voqgMTRuN7aTKS/Y81Rz0yzBJA8+Ro1Vcge868eFGrYey0gANcDwkMZ7o8GGM0OFL4UwhMXQo=
X-Received: by 2002:aca:6289:: with SMTP id w131mr668302oib.69.1614309922143;
 Thu, 25 Feb 2021 19:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20210226010440.8474-1-chris.chiu@canonical.com> <CAPpJ_ed1VqLQxcfdNobqWSkgtE7xrWKu8jK0U6jxWF1m3THdaA@mail.gmail.com>
In-Reply-To: <CAPpJ_ed1VqLQxcfdNobqWSkgtE7xrWKu8jK0U6jxWF1m3THdaA@mail.gmail.com>
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Fri, 26 Feb 2021 11:24:21 +0800
Message-ID: <CAPpJ_ee4SNWJ3Zh6kEe_aMYLL_8tbApfMK4pvs2m2GfmhJmZgA@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic of Acer SWIFT
 with ALC256
To:     chris.chiu@canonical.com
Cc:     Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2021=E5=B9=B42=E6=9C=8826=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> <chris.chiu@canonical.com> =E6=96=BC 2021=E5=B9=B42=E6=9C=8826=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=889:04=E5=AF=AB=E9=81=93=EF=BC=9A
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
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realte=
k.c
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
> >  static const struct hda_fixup alc269_fixups[] =3D {
> > @@ -7853,6 +7854,16 @@ static const struct hda_fixup alc269_fixups[] =
=3D {
> >                 .chained =3D true,
> >                 .chain_id =3D ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
> >         },
> > +       [ALC256_FIXUP_ACER_HEADSET_MIC] =3D {
> > +               .type =3D HDA_FIXUP_PINS,
> > +               .v.pins =3D (const struct hda_pintbl[]) {
> > +                       { 0x19, 0x02a1113c }, /* use as headset mic, wi=
thout its own jack detect */
> > +                       { 0x1a, 0x90a1092f }, /* use as internal mic */
>
> Since NID 0x1a is an internal DMIC, should this connection type be 0h?
> Or, even the quirk of the internal DMIC is not needed for this case.
> Because, it is Intel SST DMIC that does not connect to Realtek HDA
> CODEC.  (Not sure for this one)
>
> The quirk of NID 0x19 is okay for me.

After more discussion and test with Chris, found the NID 0x1a quirk is
still needed.  Otherwise, the headset MIC 0x19 will not work any more.

So, I ack the version 2 patch.

Acked-by: Jian-Hong Pan <jhp@endlessos.org>

> > +                       { }
> > +               },
> > +               .chained =3D true,
> > +               .chain_id =3D ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
> > +       },
> >  };
> >
> >  static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {
> > @@ -7879,9 +7890,11 @@ static const struct snd_pci_quirk alc269_fixup_t=
bl[] =3D {
> >         SND_PCI_QUIRK(0x1025, 0x1246, "Acer Predator Helios 500", ALC29=
9_FIXUP_PREDATOR_SPK),
> >         SND_PCI_QUIRK(0x1025, 0x1247, "Acer vCopperbox", ALC269VC_FIXUP=
_ACER_VCOPPERBOX_PINS),
> >         SND_PCI_QUIRK(0x1025, 0x1248, "Acer Veriton N4660G", ALC269VC_F=
IXUP_ACER_MIC_NO_PRESENCE),
> > +       SND_PCI_QUIRK(0x1025, 0x1269, "Acer SWIFT SF314-54", ALC256_FIX=
UP_ACER_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIX=
UP_ACER_AIO_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIX=
UP_ACER_AIO_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIX=
UP_ACER_AIO_HEADSET_MIC),
> > +       SND_PCI_QUIRK(0x1025, 0x129c, "Acer SWIFT SF314-55", ALC256_FIX=
UP_ACER_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIX=
UP_ACER_AIO_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", ALC233=
_FIXUP_ACER_HEADSET_MIC),
> >         SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC25=
5_FIXUP_ACER_HEADSET_MIC),
> > --
> > 2.20.1
> >

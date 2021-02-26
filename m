Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5C3325B71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 03:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBZCGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 21:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBZCGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:06:41 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 18:06:01 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id o3so8227320oic.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 18:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TEurnvnOY0UmTThAshzFygi7pp659PSVZrpUu3wFGLI=;
        b=hROQH+eH59ynw+jEXUoBS0nUrg2rlQn1mDsc21mT6SdgqHwCZ8nkfIH1gSD9P5zl5N
         r5Fv7JHPDEiGIWRF5ZoAXuW3Zwba1oQ6CU5A85a8kK9j2S0T7mBWJqsUyeryI+qGJASp
         eN4V/WX+nSc0ROtexYEksc8y58dZgp2LKBJ4iSNuItO60HpGked6tt1HuzLdyYd+p89s
         gScgX+CRPW7nsc/Zv93TbMt/TptyXcxmqQ59pGK/bBxC5J+dOuHv9knzVH/g7CRHOojl
         yzxGRv9c6RlrY2bvjbP/FyFR2gWZJrFxVATpMfweVuUziXUAxfWPIc9Aix2tUdXs17Ae
         HLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TEurnvnOY0UmTThAshzFygi7pp659PSVZrpUu3wFGLI=;
        b=ZQyGER5AEdZZuvNraFpMFVvoYfOrd8po7JXVJiIIl1UMZDWLyYxZJZ1l/TptkdHpPI
         O4t/eNnACAC7vMbBcwahf+DIF7IdmMBkbFgwG1/YSLoOF8JvxsZAGW4ExcfQ2dxHzFff
         1QDVgSpvb+Bvrz/cPPtA3HX3RS4yTgJ+r8oioPJ8kQaohS5fOVXSxvGWD9i9e7Dy5RYt
         gPw+QmIhDXzopu4+2ts9UfFccWHX9cJlbcBipfcb29DmBm7vOm2qpWj97oWZnsKjOm6d
         tzJKDIsKFOKA8hUYSte6gCGbYvcRZcl92ppRtdFrPYB67CRyweUJgRtLR4MXZaarh/ot
         9NuQ==
X-Gm-Message-State: AOAM531v+Xg8EAvE1eb+lUH/rc23Y+3JVzg58EyiXPmz8V62TnwV94Sz
        GBhpZ/x/sg/AvG73POADHAsVJ1hw7F2l/oAVxae2Lk6Y6Y2HSrud
X-Google-Smtp-Source: ABdhPJwLbdjjSEpA9tPDJIp0UgD57ayyTMBSweHYSzyH1GU8UUElIgexqisJ4ZVko/j3oM0sqm+3BBahbvZXbhoIN+U=
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr541518oiw.161.1614305160603;
 Thu, 25 Feb 2021 18:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20210226010440.8474-1-chris.chiu@canonical.com>
In-Reply-To: <20210226010440.8474-1-chris.chiu@canonical.com>
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Fri, 26 Feb 2021 10:05:00 +0800
Message-ID: <CAPpJ_ed1VqLQxcfdNobqWSkgtE7xrWKu8jK0U6jxWF1m3THdaA@mail.gmail.com>
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

<chris.chiu@canonical.com> =E6=96=BC 2021=E5=B9=B42=E6=9C=8826=E6=97=A5 =E9=
=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=889:04=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Chris Chiu <chris.chiu@canonical.com>
>
> The Acer SWIFT Swift SF314-54/55 laptops with ALC256 cannot detect
> both the headset mic and the internal mic. Introduce new fixup
> to enable the jack sense and the headset mic. However, the internal
> mic actually connects to Intel SST audio. It still needs Intel SST
> support to make internal mic capture work.
>
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>   v1 -> v2: remove unnecessary aamix fixup
>
>  sound/pci/hda/patch_realtek.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c
> index 1927605f0f7e..4871507cd4bf 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6406,6 +6406,7 @@ enum {
>         ALC236_FIXUP_DELL_AIO_HEADSET_MIC,
>         ALC282_FIXUP_ACER_DISABLE_LINEOUT,
>         ALC255_FIXUP_ACER_LIMIT_INT_MIC_BOOST,
> +       ALC256_FIXUP_ACER_HEADSET_MIC,
>  };
>
>  static const struct hda_fixup alc269_fixups[] =3D {
> @@ -7853,6 +7854,16 @@ static const struct hda_fixup alc269_fixups[] =3D =
{
>                 .chained =3D true,
>                 .chain_id =3D ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
>         },
> +       [ALC256_FIXUP_ACER_HEADSET_MIC] =3D {
> +               .type =3D HDA_FIXUP_PINS,
> +               .v.pins =3D (const struct hda_pintbl[]) {
> +                       { 0x19, 0x02a1113c }, /* use as headset mic, with=
out its own jack detect */
> +                       { 0x1a, 0x90a1092f }, /* use as internal mic */

Since NID 0x1a is an internal DMIC, should this connection type be 0h?
Or, even the quirk of the internal DMIC is not needed for this case.
Because, it is Intel SST DMIC that does not connect to Realtek HDA
CODEC.  (Not sure for this one)

The quirk of NID 0x19 is okay for me.

BR,
Jian-Hong Pan

> +                       { }
> +               },
> +               .chained =3D true,
> +               .chain_id =3D ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
> +       },
>  };
>
>  static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {
> @@ -7879,9 +7890,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl=
[] =3D {
>         SND_PCI_QUIRK(0x1025, 0x1246, "Acer Predator Helios 500", ALC299_=
FIXUP_PREDATOR_SPK),
>         SND_PCI_QUIRK(0x1025, 0x1247, "Acer vCopperbox", ALC269VC_FIXUP_A=
CER_VCOPPERBOX_PINS),
>         SND_PCI_QUIRK(0x1025, 0x1248, "Acer Veriton N4660G", ALC269VC_FIX=
UP_ACER_MIC_NO_PRESENCE),
> +       SND_PCI_QUIRK(0x1025, 0x1269, "Acer SWIFT SF314-54", ALC256_FIXUP=
_ACER_HEADSET_MIC),
>         SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP=
_ACER_AIO_HEADSET_MIC),
>         SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP=
_ACER_AIO_HEADSET_MIC),
>         SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP=
_ACER_AIO_HEADSET_MIC),
> +       SND_PCI_QUIRK(0x1025, 0x129c, "Acer SWIFT SF314-55", ALC256_FIXUP=
_ACER_HEADSET_MIC),
>         SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIXUP=
_ACER_AIO_HEADSET_MIC),
>         SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", ALC233_F=
IXUP_ACER_HEADSET_MIC),
>         SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_=
FIXUP_ACER_HEADSET_MIC),
> --
> 2.20.1
>

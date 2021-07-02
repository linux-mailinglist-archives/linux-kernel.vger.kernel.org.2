Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E283BA2E7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhGBPuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 11:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhGBPuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 11:50:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1429FC061764
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 08:48:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f30so18908768lfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 08:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lDCZ35r3cnpcY9S0GsUiZu/amLaH60V4KX/TEJ4UKUM=;
        b=oa2GW1jVbowITBCBJVwfGsCxDmDEgGCcrTynqB729Q7jA7FpHuvxD6nxI9CE75ze+z
         +npPE/saOBXYNjFM5M8IHvMtAJfFkYvaKQ7611JTZf9NX82Wafe35vosqqPQRNQW3lhQ
         BNWPBbCWwuAWOJ8ltd5VCdTbO7siUrYdrSd5HD4vh0QySrUXp71irFGo9/caT8DodJru
         djY+jyT555ENJlzra4rXzyoVEiXvTBA71bHmT4xL63AnKNoyZn0JoV/Q7p/uv/vbK0AR
         RdmDty4MHvGCYy6VBLUrjTfCTZUP/bLIItAQjXjOO9uxx/HSvLIqi6Fyqz189RoiPEDV
         C18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lDCZ35r3cnpcY9S0GsUiZu/amLaH60V4KX/TEJ4UKUM=;
        b=b8Y3UtlOfB4y1UGmgmPgu97hMCUelG7OgfPWmuEpP4E7eTRcEivNnBWjsVDJPpkPNq
         zyUNJLboDpJKmgnhuSBAQ/UzWzPOzfD8COquhFBFoasCVI/oPMP74zd+L383NRYAHwAb
         EL3EACWJiQ3ZVFIAK8pcEXRKOZZHEGR2P7ojlCxT/ar4g91YaDKapuoc15ZxUEw+OX8w
         UTEF7DAdxK5UhVioNFwdc8XW9IBvgap9zVCGzxz9cIvgm7TXN4NjV3/gFyIru+qVGKIy
         C0C+aAS5s5Bx05oyGQr2HpLzg0a6Kr1WmnbdqEAjIFt8SeWnEGHPxaZar6QEfMS8rvrl
         STAA==
X-Gm-Message-State: AOAM532hxe8WsY13YsColEx1TfI2BaquleQbPIXniyn+qbzvbdtJUwgs
        H8exviJw5qL1U8U+TQ9v79pZWJC1LO8RYG4Nig4=
X-Google-Smtp-Source: ABdhPJxaJ1MHl10l/TGIjmQFKJfHPLCAA/6KRJFtndFuYy0CJD/5P1mnB4poiOcLTRWU82hJPa3ahlt3TCM2mgJ21Vk=
X-Received: by 2002:a05:6512:3499:: with SMTP id v25mr211060lfr.612.1625240882286;
 Fri, 02 Jul 2021 08:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <1625111646-3955-1-git-send-email-u0084500@gmail.com>
 <CAFRkauCNf6fP8zAz+0gY_Vzb_wCtVyYqLjw8s1T+t2s=bR0RQw@mail.gmail.com> <CADiBU3_dCNvZRwewiztB0UGFvDz3g5sw-q+95sg9akqte1YJsA@mail.gmail.com>
In-Reply-To: <CADiBU3_dCNvZRwewiztB0UGFvDz3g5sw-q+95sg9akqte1YJsA@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 2 Jul 2021 23:47:50 +0800
Message-ID: <CADiBU3-i2tg33iCjX83NEYAhYYabnHjL129+tOm9_h=MrPhraw@mail.gmail.com>
Subject: Re: [PATCH] regulator: rt5033: Use linear ranges to map all voltage selection
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=881=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:53=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Axel Lin <axel.lin@ingics.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=881=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8812:41=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> >
> >
> > cy_huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=881=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:54=E5=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> From: ChiYuan Huang <cy_huang@richtek.com>
> >>
> >> Instead of linear mapping, Use linear range to map all voltage selecti=
on.
> >>
> >> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >> ---
> >> Even though commit 6549c46af855 ("regulator: rt5033: Fix n_voltages se=
ttings for BUCK and LDO")
> >> can fix the linear mapping to the correct min/max voltage
> >> But there're still non-step ranges for the reserved value.
> >>
> >> To use the linear range can fix it for mapping all voltage selection.
> >> ---
> >>  drivers/regulator/rt5033-regulator.c | 23 +++++++++++++++--------
> >>  1 file changed, 15 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/regulator/rt5033-regulator.c b/drivers/regulator/=
rt5033-regulator.c
> >> index 0e73116..2ff607c 100644
> >> --- a/drivers/regulator/rt5033-regulator.c
> >> +++ b/drivers/regulator/rt5033-regulator.c
> >> @@ -13,6 +13,16 @@
> >>  #include <linux/mfd/rt5033-private.h>
> >>  #include <linux/regulator/of_regulator.h>
> >>
> >> +static const struct linear_range rt5033_buck_ranges[] =3D {
> >> +       REGULATOR_LINEAR_RANGE(1000000, 0, 20, 100000),
> >> +       REGULATOR_LINEAR_RANGE(3000000, 21, 31, 0),
> >> +};
> >> +
> >> +static const struct linear_range rt5033_ldo_ranges[] =3D {
> >> +       REGULATOR_LINEAR_RANGE(1200000, 0, 18, 100000),
> >> +       REGULATOR_LINEAR_RANGE(3000000, 19, 31, 0),
> >> +};
> >> +
> >>  static const struct regulator_ops rt5033_safe_ldo_ops =3D {
> >>         .is_enabled             =3D regulator_is_enabled_regmap,
> >>         .enable                 =3D regulator_enable_regmap,
> >> @@ -24,8 +34,7 @@ static const struct regulator_ops rt5033_buck_ops =
=3D {
> >>         .is_enabled             =3D regulator_is_enabled_regmap,
> >>         .enable                 =3D regulator_enable_regmap,
> >>         .disable                =3D regulator_disable_regmap,
> >> -       .list_voltage           =3D regulator_list_voltage_linear,
> >> -       .map_voltage            =3D regulator_map_voltage_linear,
> >> +       .list_voltage           =3D regulator_list_voltage_linear_rang=
e,
> >>         .get_voltage_sel        =3D regulator_get_voltage_sel_regmap,
> >>         .set_voltage_sel        =3D regulator_set_voltage_sel_regmap,
> >>  };
> >> @@ -39,9 +48,8 @@ static const struct regulator_desc rt5033_supported_=
regulators[] =3D {
> >>                 .ops            =3D &rt5033_buck_ops,
> >>                 .type           =3D REGULATOR_VOLTAGE,
> >>                 .owner          =3D THIS_MODULE,
> >> -               .n_voltages     =3D RT5033_REGULATOR_BUCK_VOLTAGE_STEP=
_NUM,
> >> -               .min_uV         =3D RT5033_REGULATOR_BUCK_VOLTAGE_MIN,
> >> -               .uV_step        =3D RT5033_REGULATOR_BUCK_VOLTAGE_STEP=
,
> >> +               .linear_ranges  =3D rt5033_buck_ranges,
> >> +               .n_linear_ranges =3D ARRAY_SIZE(rt5033_buck_ranges),
> >>
> >
> > If you want to use linear range here, you need to change RT5033_REGULAT=
OR_BUCK_VOLTAGE_STEP_NUM back to 32
> > rather than delete the .n_voltages setting.
>
> Sorry, I really forget the N_VOLTAGES.
> >
> > I'm fifty-fifty about the change because I don't see any benefit with c=
onverting to linear range (even though in theory it's correct).
> > The voltage of all entries in the second linear range is the *same* as =
the latest selector of the first linear range.
> > When the regulator core to choose the best selector, it will always sel=
ect the latest selector of the first linear range if it meets the requested=
 range anyway.
> > (Because the entries in the second linear range are not *better*, it's =
just the same.)
> >
> > If the initial version is this driver is using linear range then it's f=
ine.
> > But given the initial version is using linear so when I fix the n_volta=
ges setting I decide to not change it to linear range.
> > This makes it easier to fix older versions if necessary.
> > (I'm not sure if linear range is available in some old kernel versions,=
 the initial version of this driver was committed in 2014).
> >
> >
> From the regulator register in probe, it will get the current voltage
> from the IC.
> If the vout sel is not is over N_VOLTAGES, it will return the error numbe=
r.
>
> But as I think it's the side effect to change the vout step num.
> To use the linear range is just to guarantee all vout sel range are inclu=
ded.
>
> That's my initial thoughts.

Hi, Axel
   Like as you said,  the first revision is from 2014.
It is almost EOL for this product.
To fix this seems redundant.
Thx.
> > Regards,
> > Axel
> >

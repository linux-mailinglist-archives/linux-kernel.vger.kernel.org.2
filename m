Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AB032200F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhBVTXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:23:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233054AbhBVTQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:16:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF64165118;
        Mon, 22 Feb 2021 18:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614019250;
        bh=FGxvnhEiZdtEIFwNlh9p2vw8zFYiWQ8F2/ji5QGybDk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o17vjMIXFmg1nNg4qhQE+0IC/W+SF9BzYFFEUmvUwgP0zNXSRmKykCORaHVF9p2ID
         Y0cvnPSFS2W10mswB/fkK//RZA1SXmksgPZumWggr0p47PUk7RwSngMwxYB+6hWoN1
         pXF/lek8rfwsuC9F3mtYpjxPqGMfx/Z0rB97SyxTtWBpsDn9YrX/xLgnYwg1v1yia9
         dBKNCYWZoe44D2lY2CTOZC/ttQxt3Gp57E35elGco9kSrSrN7Gn6jNCL7mD4P7K4oB
         F8xef9dQQH+ldpSJsimkTvn71Az6RI6VKziMhFMY2bqAQ0nOMDBZP5hbExskm+f08h
         D+HUzf2CDuFvg==
Received: by mail-ej1-f48.google.com with SMTP id r17so4618316ejy.13;
        Mon, 22 Feb 2021 10:40:49 -0800 (PST)
X-Gm-Message-State: AOAM5302cc43mlK/DVgTIqm/iIWxlj7L560dnLLbgKW/WQL91twsI/KA
        0emxo2htF+drVSejNFJPJcF5W83eflnHtfATMeY=
X-Google-Smtp-Source: ABdhPJzaXVC2DvM4oFpMDq0yZw6KQI4Xsck0Cs0vUHPzVa8d1nIi+XpW2/JXhZmYymgo3rcaQCLk2m5Ys9psM7Cohi0=
X-Received: by 2002:a17:906:1c4f:: with SMTP id l15mr11249440ejg.148.1614019248445;
 Mon, 22 Feb 2021 10:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
 <20210217161052.877877-2-adrien.grassein@gmail.com> <20210219131825.niiftfm5r32qc6m3@kozik-lap>
 <CABkfQAH75N1k0bDEGzo0mRtoqP=-9p9hzBo43f6gQnSmGsXQUw@mail.gmail.com>
 <20210220191914.pir3ep3utz6uwyrb@kozik-lap> <CABkfQAGyr_ntKMR3Ht0CVZY7zLiBcRN3-WeWiZQ-BTzXHqSF3w@mail.gmail.com>
In-Reply-To: <CABkfQAGyr_ntKMR3Ht0CVZY7zLiBcRN3-WeWiZQ-BTzXHqSF3w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 22 Feb 2021 19:40:35 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfb69J+r7WdJMPbMsqaJuKYxKy6BwtEhmPFrEiZz8L8LQ@mail.gmail.com>
Message-ID: <CAJKOXPfb69J+r7WdJMPbMsqaJuKYxKy6BwtEhmPFrEiZz8L8LQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 at 00:47, Adrien Grassein <adrien.grassein@gmail.com> w=
rote:
>
> Le sam. 20 f=C3=A9vr. 2021 =C3=A0 20:19, Krzysztof Kozlowski <krzk@kernel=
.org> a =C3=A9crit :
> >
> > On Fri, Feb 19, 2021 at 03:03:55PM +0100, Adrien Grassein wrote:
> > > Le ven. 19 f=C3=A9vr. 2021 =C3=A0 14:18, Krzysztof Kozlowski <krzk@ke=
rnel.org> a =C3=A9crit :
> > > >
> > > > On Wed, Feb 17, 2021 at 05:10:45PM +0100, Adrien Grassein wrote:
> > > > > Add usdhc3 description which corresponds to the wifi/bt chip
> > > > >
> > > > > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > > > > ---
> > > > >  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 31 +++++++++++++=
++++++
> > > > >  1 file changed, 31 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts=
 b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > > > index c0c384d76147..212dc9e5e85d 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > > > @@ -9,6 +9,17 @@
> > > > >  / {
> > > > >       model =3D "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
> > > > >       compatible =3D "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
> > > > > +
> > > > > +     reg_wlan_vmmc: regulator-wlan-vmmc {
> > > > > +             compatible =3D "regulator-fixed";
> > > > > +             pinctrl-names =3D "default";
> > > > > +             pinctrl-0 =3D <&pinctrl_reg_wlan_vmmc>;
> > > > > +             regulator-name =3D "reg_wlan_vmmc";
> > > > > +             regulator-min-microvolt =3D <3300000>;
> > > > > +             regulator-max-microvolt =3D <3300000>;
> > > > > +             gpio =3D <&gpio3 20 GPIO_ACTIVE_HIGH>;
> > > > > +             enable-active-high;
> > > > > +     };
> > > > >  };
> > > > >
> > > > >  &A53_0 {
> > > > > @@ -206,6 +217,20 @@ &usdhc2 {
> > > > >       status =3D "okay";
> > > > >  };
> > > > >
> > > > > +/* wlan */
> > > > > +&usdhc3 {
> > > > > +     bus-width =3D <4>;
> > > > > +     sdhci-caps-mask =3D <0x2 0x0>;
> > > > > +     non-removable;
> > > > > +     pinctrl-names =3D "default", "state_100mhz", "state_200mhz"=
;
> > > > > +     pinctrl-0 =3D <&pinctrl_usdhc3>;
> > > > > +     pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> > > > > +     pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> > > > > +     vmmc-supply =3D <&reg_wlan_vmmc>;
> > > > > +     vqmmc-1-8-v;
> > > >
> > > > There is no such property in the bindings.
> > > >
> > >
> > > Sorry, I copied a property from the FSL kernel.
> > > I will fix this with a "fixed-regulator".
> >
> > I would assume this goes from PMIC, so check your schematics. There is
> > little point in adding a fixed regulator which is non-controllable.
>
> No, the 1.8V is issued directly from the alimentation stage.
> So we can't control it.
>
> > I think bindings don't require it.
> After reading some code, I can say that vqmmc is not mandatory but it
> helped to find out
> the caps of the mmc host. In this case, we only support 1.8V on vqmmc.
> It avoids driver to guess it (and avoid bad behaviour on any future chang=
e).

If the supply (hardware) is really 1.8 V then indeed your approach is
good. So let's keep that one.

Best regards,
Krzysztof

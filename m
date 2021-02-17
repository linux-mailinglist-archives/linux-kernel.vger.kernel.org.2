Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C5131DBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhBQOoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbhBQOoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:44:19 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0887EC061574;
        Wed, 17 Feb 2021 06:43:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v22so1381937edx.13;
        Wed, 17 Feb 2021 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TpDThfztLQKczc6Q821rns/OCQX7B0FVsYhPx4xk8RM=;
        b=GnU7hZ3tlGqCZQ/mw1pmbs3J94uU+pH5RJ3rTm9U8Hjh+NI6+1493pd+EuNJcRo9Zd
         z43DeDsOcGzSVV+mj8euHupNnqlF2QkeSdBVhEtshsCAglEgPIOqdc1gN4QKlussvVHX
         Gfkzh4nSdSKw1NDGYBnO/9Hr6qIOZPJdDaBdl1H7wXWAKOvoY76IPF08g50NlU2GkAWN
         CBQaa+RheBgDAPPl/DUQvsbNy+LiAWJs0Cm/22V63eWCaCnTMZnPwqF9P0L6BExoRm3Q
         54VLPOyyb6sI7PzavxpA7TL7FOLsThVlHqkuNUTBiB5ELk8yhfZ7mYeN4k7CkFJO2BI+
         vPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TpDThfztLQKczc6Q821rns/OCQX7B0FVsYhPx4xk8RM=;
        b=VuHWQmxiQrOHk4XgrptEBnevWC1cbMt703NQ9ZlcQ87b12dA5JGtAkpQZHtBi3hFsB
         rAeObOAFvt97wLlvMMvSfiwwF1VzRyiGTwokFqYvO82LDsz2Bokenmbpz8r0z7CYv4dG
         O/zD6vO6jIBJ+blCfxMZJfDZAOWx7vMVZVfvVXFvRNwiJc4XjryNssC1Yon1lawL2qhE
         ysdB7hclNGqu9QpJmc3m0NzSKunS2SPQE2SH2v9MfE0+LzxfDcGmb+JWRju2Jk6kkvap
         RHaYeVkMWEcoZ0kYbSNSkfLV72Dn2AF/oM6SDxxhLhsj9feVgnxgL7lCr5nE/8QjYW9c
         zUMw==
X-Gm-Message-State: AOAM533q+OdOK7jQa6Xg18Kh/KdFLxqxdmksWO/xYPl/ILzuyAtzUjl8
        pDmM+BoFOnDGwg84/u+5MBj6NciDNAzaVH9mzww=
X-Google-Smtp-Source: ABdhPJxFS84AzKvCp09lAImICSP3HGykH+N0PyDA/sQY8yMWfym6+So+btt+AsW8qqxJ6emcGQ+ZhaON0KeldrcRF28=
X-Received: by 2002:a50:ef0f:: with SMTP id m15mr27709575eds.175.1613573017535;
 Wed, 17 Feb 2021 06:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
 <20210215231943.36910-2-adrien.grassein@gmail.com> <20210217115814.zfwhd5fwb2ibygt3@kozik-lap>
In-Reply-To: <20210217115814.zfwhd5fwb2ibygt3@kozik-lap>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Wed, 17 Feb 2021 15:43:26 +0100
Message-ID: <CABkfQAGyushYbaYkmfGdNjw3Ssaw7DgLJ5iomJPtRdHS0Rbobg@mail.gmail.com>
Subject: Re: [PATCH 1/8] arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
To:     Krzysztof Kozlowski <krzk@kernel.org>
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

Hello,

Thanks for your review and your time.

Le mer. 17 f=C3=A9vr. 2021 =C3=A0 12:58, Krzysztof Kozlowski <krzk@kernel.o=
rg> a =C3=A9crit :
>
> On Tue, Feb 16, 2021 at 12:19:36AM +0100, Adrien Grassein wrote:
> > Add usdhc3 description which corresponds to the wifi/bt chip
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > ---
> >  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arc=
h/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > index c0c384d76147..bf20a40bcda0 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > @@ -9,6 +9,18 @@
> >  / {
> >       model =3D "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
> >       compatible =3D "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
> > +
> > +     reg_wlan_vmmc: regulator-wlan-vmmc {
> > +             compatible =3D "regulator-fixed";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_reg_wlan_vmmc>;
> > +             regulator-name =3D "reg_wlan_vmmc";
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             gpio =3D <&gpio3 20 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +             startup-delay-us =3D <70000>;
>
> That's quite a startup time... and it happens is the same as in bindings
> example. Do you really need it or it was just copied?
>
> I actually don't mind it, just poking at various things. :)
>

It was a copy/paste. I've just retested without this, it works.

> > +     };
> >  };
> >
> >  &A53_0 {
> > @@ -206,6 +218,19 @@ &usdhc2 {
> >       status =3D "okay";
> >  };
> >
> > +/* wlan */
> > +&usdhc3 {
> > +     bus-width =3D <4>;
> > +     sdhci-caps-mask =3D <0x2 0x0>;
> > +     non-removable;
> > +     pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> > +     pinctrl-0 =3D <&pinctrl_usdhc3>;
> > +     pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> > +     pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> > +     vmmc-supply =3D <&reg_wlan_vmmc>;
>
> What about vqmmc?
>

It was missing, thanks,

> Best regards,
> Krzysztof

Best regards,
Adrien

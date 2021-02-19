Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC531FA44
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhBSOEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhBSOEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:04:48 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373C8C061574;
        Fri, 19 Feb 2021 06:04:08 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id do6so13519759ejc.3;
        Fri, 19 Feb 2021 06:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AZI2iccSfJassoZUchSLTN+9RSlhKEgQr/601NHNhqM=;
        b=uB1mOH1GWhstJ0Abb7jCXLtD0rOXL6+M+7oK9ytD9msvjwoVsD6pdVX/xQozY/6B0y
         3PEZuOIAszeIOWQ9/pul28a5gkAJah3T5BFW52xOsj/KFkdZcyAMgZsBO6fP7H9mJvZN
         QycxGFqzG3o49nTkwtoyNKRXqotaTnd0FdFyCJ/NQsaol+3xwX+fmNhHTgUVaYFStrzZ
         kVR3K+oCVxEXLNWrIeH1KYdM+lrP0K4MO4uZzR8893uesWHf1IU6r1S4s92YKZ6My5hX
         8OUbZj+m/UsktXSZ32XHAZsQuIszGc1EzkjoZWCBMynKWe5CP0HXnZ/mamGwHGR6Rc7y
         k46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AZI2iccSfJassoZUchSLTN+9RSlhKEgQr/601NHNhqM=;
        b=uHEB/KcszjZx+SoHCIgXw/HDddbIM1kCaaU3fIZxyS9vnC/fKhS8MNDbgvkoHovOOd
         te6NRfastbb854IKaphiy1exTtHJaYAsGNENVJeyFTfBU+6UfyYIVqYFux+2mJdnc45V
         eo1bDRuQLNu1XNBtZHlkEx/NNPGK3EE977ZPbMHRDedPM63HebzqKGYAXjpq0aXz380H
         75Jxnbkfh1Y6MR29XRsA1IFYOPMW7wQVInVxt7wLvDFZHg4MhsLU3wS1oVjL8amTE4gO
         q6GNjZKT6hPBbJnuIuHitqPTsqVLBgtQdE10ZD8bAdOcY9GMm3gI4E6xJx9bp+lxKkvO
         kFWA==
X-Gm-Message-State: AOAM533Z8t9yXyEj2UDaJUoX1uTpHHP7GfcO25cT1B6J35mg95FjU6nb
        mzHrqRK2D8NKnSdJgF4CJ5nkW6QAf0GE8z1MMPY=
X-Google-Smtp-Source: ABdhPJx26kP73QigtfzKqypsBvnLzgTPbtqMs7K6VYW13sqMlkO5rs6vCh8JEsoGNKOsP6udY9+YltzGS2XfDy95lWE=
X-Received: by 2002:a17:906:c1c1:: with SMTP id bw1mr9112218ejb.86.1613743446540;
 Fri, 19 Feb 2021 06:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
 <20210217161052.877877-2-adrien.grassein@gmail.com> <20210219131825.niiftfm5r32qc6m3@kozik-lap>
In-Reply-To: <20210219131825.niiftfm5r32qc6m3@kozik-lap>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Fri, 19 Feb 2021 15:03:55 +0100
Message-ID: <CABkfQAH75N1k0bDEGzo0mRtoqP=-9p9hzBo43f6gQnSmGsXQUw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
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

Le ven. 19 f=C3=A9vr. 2021 =C3=A0 14:18, Krzysztof Kozlowski <krzk@kernel.o=
rg> a =C3=A9crit :
>
> On Wed, Feb 17, 2021 at 05:10:45PM +0100, Adrien Grassein wrote:
> > Add usdhc3 description which corresponds to the wifi/bt chip
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > ---
> >  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arc=
h/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > index c0c384d76147..212dc9e5e85d 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > @@ -9,6 +9,17 @@
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
> > +     };
> >  };
> >
> >  &A53_0 {
> > @@ -206,6 +217,20 @@ &usdhc2 {
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
> > +     vqmmc-1-8-v;
>
> There is no such property in the bindings.
>

Sorry, I copied a property from the FSL kernel.
I will fix this with a "fixed-regulator".

> Best regards,
> Krzysztof

Thanks,
Adrien

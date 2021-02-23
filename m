Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E47C3228FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 11:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhBWKpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 05:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhBWKpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 05:45:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2710FC06174A;
        Tue, 23 Feb 2021 02:45:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id d2so25265364edq.10;
        Tue, 23 Feb 2021 02:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AHsE9a1YsM89AysbkR4TKMICvTUi7WCLD0u7dNRVOnc=;
        b=sMgxB6vA+AuytYH3Q6zxWjwvYdLGpx4aaxGsisarPa+A3/oifFf1DQ0+I+t2Fm5Sp+
         /IkC4IvCkq66PO44eHlaruamEtdDnoevhKBQ4rn9yjVx+CPXzpQj3LBaGHTEbsPs7/e9
         nPfb3Ja2MpKQGy8/CKDLu9dSnX54AHqiHoLlj59DQHqsKAsWS3THouGSGvJHdL9ncai4
         ZDmG00edM0JznvzqE+JOsGwYUD9wDj0It+85eAEgTRpppKF6owxhyD8TjrCoT4RjcWKa
         f7MizsEapS4hXRtpSViNx5DpFuzKcsHzSP+FGh5zAkipu+kXjH4D2jEFfbmaMeiKktyS
         Vf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AHsE9a1YsM89AysbkR4TKMICvTUi7WCLD0u7dNRVOnc=;
        b=AepkMGmDSXJElSlWQSmD11NoUVDDScbkpWonOk+Bf+fecnvg78Wm8KYhlaKS7vbSyh
         4y3RqFKz5Z3JVSzWNNgXaXUb7kW5vo5qGlbqk+68nb7Lj+lV6PwWFUqnvmyN9NZwiUNf
         OK+4d3fEd70vTvsm1rMkUrjlUlg7G8/4LwQicExDQhroO0hbrj+CAgd/PlvuNx1KJ2YX
         h7MKxlKQaGgPaxh1Zwq5UYx3U+fNtFbVBRvoEJ+If/wD/ET4hkyx1rdSkKKiFysGJtYy
         IeDUeM1v083JNNFkyRpDPNcqKxoFRGVLzBXF+wBUhw/XntBgat5v4fAWP2C38N8SmiYn
         4LPQ==
X-Gm-Message-State: AOAM533s9pWhylpRWwlgqafjsZ17F+DFppZL+VdQnqutNwBg/bP/gv6i
        CjrAMGTVc6OC5MUqdZJWWanavdh9roa32R4IudN9IXxE
X-Google-Smtp-Source: ABdhPJzQcIkxe4N3TjSZewfJK2PBe2QwAQSzpKSUS1ItVyBGWrb9rYjGxLtX6fPM80pelKxJgEEfbWM6TTVqNwOeV0s=
X-Received: by 2002:a05:6402:c15:: with SMTP id co21mr27312441edb.115.1614077105917;
 Tue, 23 Feb 2021 02:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
 <20210217161052.877877-2-adrien.grassein@gmail.com> <20210219131825.niiftfm5r32qc6m3@kozik-lap>
 <CABkfQAH75N1k0bDEGzo0mRtoqP=-9p9hzBo43f6gQnSmGsXQUw@mail.gmail.com>
 <20210220191914.pir3ep3utz6uwyrb@kozik-lap> <CABkfQAGyr_ntKMR3Ht0CVZY7zLiBcRN3-WeWiZQ-BTzXHqSF3w@mail.gmail.com>
 <CAJKOXPfb69J+r7WdJMPbMsqaJuKYxKy6BwtEhmPFrEiZz8L8LQ@mail.gmail.com>
In-Reply-To: <CAJKOXPfb69J+r7WdJMPbMsqaJuKYxKy6BwtEhmPFrEiZz8L8LQ@mail.gmail.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Tue, 23 Feb 2021 11:44:55 +0100
Message-ID: <CABkfQAG8n3AGdamKZbNx9Q5N_6SB5S4=+nj4zuLP_Xk7zxF-cw@mail.gmail.com>
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

Le lun. 22 f=C3=A9vr. 2021 =C3=A0 19:40, Krzysztof Kozlowski <krzk@kernel.o=
rg> a =C3=A9crit :
>
> On Mon, 22 Feb 2021 at 00:47, Adrien Grassein <adrien.grassein@gmail.com>=
 wrote:
> >
> > Le sam. 20 f=C3=A9vr. 2021 =C3=A0 20:19, Krzysztof Kozlowski <krzk@kern=
el.org> a =C3=A9crit :
> > >
> > > On Fri, Feb 19, 2021 at 03:03:55PM +0100, Adrien Grassein wrote:
> > > > Le ven. 19 f=C3=A9vr. 2021 =C3=A0 14:18, Krzysztof Kozlowski <krzk@=
kernel.org> a =C3=A9crit :
> > > > >
> > > > > On Wed, Feb 17, 2021 at 05:10:45PM +0100, Adrien Grassein wrote:
> > > > > > Add usdhc3 description which corresponds to the wifi/bt chip
> > > > > >
> > > > > > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > > > > > ---
> > > > > >  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 31 +++++++++++=
++++++++
> > > > > >  1 file changed, 31 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.d=
ts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > > > > index c0c384d76147..212dc9e5e85d 100644
> > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > > > > @@ -9,6 +9,17 @@
> > > > > >  / {
> > > > > >       model =3D "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
> > > > > >       compatible =3D "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm=
";
> > > > > > +
> > > > > > +     reg_wlan_vmmc: regulator-wlan-vmmc {
> > > > > > +             compatible =3D "regulator-fixed";
> > > > > > +             pinctrl-names =3D "default";
> > > > > > +             pinctrl-0 =3D <&pinctrl_reg_wlan_vmmc>;
> > > > > > +             regulator-name =3D "reg_wlan_vmmc";
> > > > > > +             regulator-min-microvolt =3D <3300000>;
> > > > > > +             regulator-max-microvolt =3D <3300000>;
> > > > > > +             gpio =3D <&gpio3 20 GPIO_ACTIVE_HIGH>;
> > > > > > +             enable-active-high;
> > > > > > +     };
> > > > > >  };
> > > > > >
> > > > > >  &A53_0 {
> > > > > > @@ -206,6 +217,20 @@ &usdhc2 {
> > > > > >       status =3D "okay";
> > > > > >  };
> > > > > >
> > > > > > +/* wlan */
> > > > > > +&usdhc3 {
> > > > > > +     bus-width =3D <4>;
> > > > > > +     sdhci-caps-mask =3D <0x2 0x0>;
> > > > > > +     non-removable;
> > > > > > +     pinctrl-names =3D "default", "state_100mhz", "state_200mh=
z";
> > > > > > +     pinctrl-0 =3D <&pinctrl_usdhc3>;
> > > > > > +     pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> > > > > > +     pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> > > > > > +     vmmc-supply =3D <&reg_wlan_vmmc>;
> > > > > > +     vqmmc-1-8-v;
> > > > >
> > > > > There is no such property in the bindings.
> > > > >
> > > >
> > > > Sorry, I copied a property from the FSL kernel.
> > > > I will fix this with a "fixed-regulator".
> > >
> > > I would assume this goes from PMIC, so check your schematics. There i=
s
> > > little point in adding a fixed regulator which is non-controllable.
> >
> > No, the 1.8V is issued directly from the alimentation stage.
> > So we can't control it.
> >
> > > I think bindings don't require it.
> > After reading some code, I can say that vqmmc is not mandatory but it
> > helped to find out
> > the caps of the mmc host. In this case, we only support 1.8V on vqmmc.
> > It avoids driver to guess it (and avoid bad behaviour on any future cha=
nge).
>
> If the supply (hardware) is really 1.8 V then indeed your approach is
> good. So let's keep that one.
>

To be sure to understand well: should I keep the fixed regulator?
Thanks,

> Best regards,
> Krzysztof

Best regards,
Adrien

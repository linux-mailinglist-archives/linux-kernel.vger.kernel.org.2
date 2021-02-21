Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E2F320E97
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 00:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhBUXr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 18:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbhBUXrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 18:47:49 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33397C061574;
        Sun, 21 Feb 2021 15:47:09 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g3so19622143edb.11;
        Sun, 21 Feb 2021 15:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bJIAtmO8Hab9V++l/vJOBTqLNhVwE9QuyRHZ5pv7/rQ=;
        b=DkJOonPNeNiziz9OFoyDzyqSF3bYXq2R3YxCYIvboVB0UimoDjvkRee0bEfYPcEli1
         d2U1NUXF9FIVduYVTHdZ+Vn9qJ0BvBCB6cIx1GE454GBPAdfbWJIt8kA02DqMqMPCdJG
         w8ZWou+ZfRaVe2oUZ713dXIN9WCjjjp3HYrG4V0NKOEIyasN4krU+euI339lWguLCziv
         zJT6PqJFZfJ75p9SjGYEDhTMMY+hd1EboWMtkMYlXJVfP1ueuek8VaBXZcf9BApMrv5E
         izH18rbT6E9LUmZvO/2JDhMKIYQ4caS3WyJAj7cJ4TAt7WOCbWkxvvbZM2SLEHOrH8Ao
         zv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bJIAtmO8Hab9V++l/vJOBTqLNhVwE9QuyRHZ5pv7/rQ=;
        b=aPKMFUTuJyTDUS39HuoW91XOmn/zvjMocZ2jS6gIfcSttNP3EyxKN3Qy0eALIIXOTx
         khLgoHV+6L1K/EW6gIdHLMaA34saEuNhR+SPN9fZLlTgrpSsQyZ5pYk3cfkiMndXQ9mb
         1xas6KEOMrSbV4rJ46HlEEqnaYvW6pSvZclaTTVlOSLA2R4lOc7r2j5Kc2ku3vjzEWlB
         ri9MUkLDw2lSD1mvDgEQ/1ncaAu3tJqPY9fhQT3maMorNd3VxszV8tqbXhdx8O7EPZZF
         t1+ZE8bytImUT/35JU6U9XmReHtfUSuzydYiZG6vhRThMkbQCyDVzRyMstr6A0/yu1H3
         pkYA==
X-Gm-Message-State: AOAM533ndoMjuXP/WPrOUizwTBWSgIAJCeGHki8INkMJde72gop5fPZr
        lli71gzR6SL/HbFaADziXcDuIhgPVrJ+sWRMUMsESHObkVA=
X-Google-Smtp-Source: ABdhPJzw6s59F8zvCdYjEOZFsKuG5KWXdM7/iFUBsjpeFojaRfISCn7+/NUQKU+N3CSU/hxRUjTOqbLYWB8IEoYaqok=
X-Received: by 2002:a05:6402:1d9b:: with SMTP id dk27mr4738460edb.209.1613951227974;
 Sun, 21 Feb 2021 15:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
 <20210217161052.877877-2-adrien.grassein@gmail.com> <20210219131825.niiftfm5r32qc6m3@kozik-lap>
 <CABkfQAH75N1k0bDEGzo0mRtoqP=-9p9hzBo43f6gQnSmGsXQUw@mail.gmail.com> <20210220191914.pir3ep3utz6uwyrb@kozik-lap>
In-Reply-To: <20210220191914.pir3ep3utz6uwyrb@kozik-lap>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Mon, 22 Feb 2021 00:46:57 +0100
Message-ID: <CABkfQAGyr_ntKMR3Ht0CVZY7zLiBcRN3-WeWiZQ-BTzXHqSF3w@mail.gmail.com>
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

Le sam. 20 f=C3=A9vr. 2021 =C3=A0 20:19, Krzysztof Kozlowski <krzk@kernel.o=
rg> a =C3=A9crit :
>
> On Fri, Feb 19, 2021 at 03:03:55PM +0100, Adrien Grassein wrote:
> > Le ven. 19 f=C3=A9vr. 2021 =C3=A0 14:18, Krzysztof Kozlowski <krzk@kern=
el.org> a =C3=A9crit :
> > >
> > > On Wed, Feb 17, 2021 at 05:10:45PM +0100, Adrien Grassein wrote:
> > > > Add usdhc3 description which corresponds to the wifi/bt chip
> > > >
> > > > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > > > ---
> > > >  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 31 +++++++++++++++=
++++
> > > >  1 file changed, 31 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b=
/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > > index c0c384d76147..212dc9e5e85d 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > > @@ -9,6 +9,17 @@
> > > >  / {
> > > >       model =3D "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
> > > >       compatible =3D "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
> > > > +
> > > > +     reg_wlan_vmmc: regulator-wlan-vmmc {
> > > > +             compatible =3D "regulator-fixed";
> > > > +             pinctrl-names =3D "default";
> > > > +             pinctrl-0 =3D <&pinctrl_reg_wlan_vmmc>;
> > > > +             regulator-name =3D "reg_wlan_vmmc";
> > > > +             regulator-min-microvolt =3D <3300000>;
> > > > +             regulator-max-microvolt =3D <3300000>;
> > > > +             gpio =3D <&gpio3 20 GPIO_ACTIVE_HIGH>;
> > > > +             enable-active-high;
> > > > +     };
> > > >  };
> > > >
> > > >  &A53_0 {
> > > > @@ -206,6 +217,20 @@ &usdhc2 {
> > > >       status =3D "okay";
> > > >  };
> > > >
> > > > +/* wlan */
> > > > +&usdhc3 {
> > > > +     bus-width =3D <4>;
> > > > +     sdhci-caps-mask =3D <0x2 0x0>;
> > > > +     non-removable;
> > > > +     pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> > > > +     pinctrl-0 =3D <&pinctrl_usdhc3>;
> > > > +     pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> > > > +     pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> > > > +     vmmc-supply =3D <&reg_wlan_vmmc>;
> > > > +     vqmmc-1-8-v;
> > >
> > > There is no such property in the bindings.
> > >
> >
> > Sorry, I copied a property from the FSL kernel.
> > I will fix this with a "fixed-regulator".
>
> I would assume this goes from PMIC, so check your schematics. There is
> little point in adding a fixed regulator which is non-controllable.

No, the 1.8V is issued directly from the alimentation stage.
So we can't control it.

> I think bindings don't require it.
After reading some code, I can say that vqmmc is not mandatory but it
helped to find out
the caps of the mmc host. In this case, we only support 1.8V on vqmmc.
It avoids driver to guess it (and avoid bad behaviour on any future change)=
.

>
> Best regards,
> Krzysztof
>

Thanks,
Adrien

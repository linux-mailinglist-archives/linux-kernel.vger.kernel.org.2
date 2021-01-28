Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226C13079FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 16:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhA1Pnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 10:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhA1Pn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 10:43:27 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70389C061574;
        Thu, 28 Jan 2021 07:42:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a10so8414254ejg.10;
        Thu, 28 Jan 2021 07:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FWJ83HCQaL80L1ZnLvcN1K1leS0A03enGGNXNA1KTfI=;
        b=ZtnjNsbblKPXOq5apWYlZ++0CNkJ4h6FSdOmIbrVU1ccVXi+sbet/pibDaPM7n/iM4
         YplxVZkU2sqwkV05DDbJZxQj0JV6ZZ8EGupN1pRG1FRdrn/WX9OauU0hQsRtvTuWHGkr
         5zhngchKpf2UiSPm19/2XOAduNGIYyJe43dfMBldWc/DlOlbNa1gT2kcV6digqN2Wtqx
         M50NGKNS6F3faeF6xc5E2LEL+DPgZmirUMGWlTe/6TXn+ML/oWnAsAmSyyop6ogXFWOw
         IljbmrQZwC/H9CFYiti4AVe1scu+PNvRlwwBTddTnJ77W7Vsu8bSTNRYgrL+pP7pmhq1
         IEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FWJ83HCQaL80L1ZnLvcN1K1leS0A03enGGNXNA1KTfI=;
        b=F+fxvL/DgnYAC3W4xI1gJAVhaGsnQ23mFc/bnYUZSBuoipWFGj769V3k7c0caWk/Ln
         /nhOVXIqQ5D6fHRgqF/I3nMe+JJheO+gxaRBH+/9F5lG9tV1Ti5hP+FXatCVmQ6zGEiq
         KyS9ofZAc09CkdQCcHlXtHUW38lkZOiJeU7wWiJNGO1VXhp8iBTRmXZOy4rikVskwB0o
         rYO2+v7hn+AvRs2GZzEIThLufqW9HUcyPZTOW22m5mgZscLHwOpKVH7Jwjj5B9VAKJea
         g0OEEQrTy17i/H/bEEpT3lv7i90Misy1UftFVZGnpuswQPtjsS2UE2fGLpqpqo4Ysfsj
         vJEA==
X-Gm-Message-State: AOAM530L7eKtyaMc3oGjwlEGsDVud4Y+ic21Dqk/i+qNg4hz3+CCvSny
        cbN3dF8Oy6tjyBIH2YAKolJKZMkL/0NjCoI9gOQ=
X-Google-Smtp-Source: ABdhPJyEaOOD93nsEfBTGyV/t0Vi+UOzbqHsFiPvTBwA1P9TSs2+QpbeI1KCx+vt78Uj9BQlOK5nmNOyFJww/+g9Q3A=
X-Received: by 2002:a17:906:5f9a:: with SMTP id a26mr12455912eju.87.1611848566214;
 Thu, 28 Jan 2021 07:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20210126215511.1056600-1-adrien.grassein@gmail.com> <YBK8hAxvjJBuMdl2@p1g2>
In-Reply-To: <YBK8hAxvjJBuMdl2@p1g2>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Thu, 28 Jan 2021 16:42:35 +0100
Message-ID: <CABkfQAEzuGB+5eufR0qQgJ2s_zzR56fB8cuGLF+ZLmaToMLnTw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq-nitrogen: add USB support
To:     Gary Bisson <gary.bisson@boundarydevices.com>
Cc:     Troy Kisky <troy.kisky@boundarydevices.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gary,


Le jeu. 28 janv. 2021 =C3=A0 14:30, Gary Bisson
<gary.bisson@boundarydevices.com> a =C3=A9crit :
>
> Hi Adrien,
>
> Thanks for improving Nitrogen upstream, much appreciated.
>
> On Tue, Jan 26, 2021 at 10:55:11PM +0100, Adrien Grassein wrote:
> > add USB support for imx8mq-nitrogen. It consists
> > in 2 phys: OTG and host.
> >
> > The OTG port uses a dedicated regulator for vbus.
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > ---
> >  .../boot/dts/freescale/imx8mq-nitrogen.dts    | 36 +++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/a=
rm64/boot/dts/freescale/imx8mq-nitrogen.dts
> > index 81d269296610..fb8acd83a280 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> > @@ -34,6 +34,17 @@ power {
> >               };
> >       };
> >
> > +     reg_usb_otg_vbus: regulator-usb-otg-vbus {
> > +             compatible =3D "regulator-fixed";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_reg_usbotg_vbus>;
> > +             regulator-name =3D "usb_otg_vbus";
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +             gpio =3D <&gpio1 12 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +     };
> > +
> >       reg_vref_0v9: regulator-vref-0v9 {
> >               compatible =3D "regulator-fixed";
> >               regulator-name =3D "vref-0v9";
> > @@ -190,6 +201,25 @@ &uart2 {
> >       status =3D "okay";
> >  };
> >
> > +&usb_dwc3_0 {
> > +     dr_mode =3D "otg";
> > +     status =3D "okay";
>
> Please add a pinctrl here to mux GPIO1_IO13 as over current pin.
> But I confirm the port is working.

OK, I will do a new version of the patch.

>
> > +};
> > +
> > +&usb3_phy0 {
> > +     vbus-supply =3D <&reg_usb_otg_vbus>;
> > +     status =3D "okay";
> > +};
> > +
> > +&usb_dwc3_1 {
> > +     dr_mode =3D "host";
> > +     status =3D "okay";
> > +};
>
> The Host port doesn't work for me. This is because of the missing reset
> signal. Maybe it's time to revive the gpio-reset driver [1]?

On my side, all the ports are working correctly without any
intervention from the user.
(I have a Nitrogen 8M rev 3.0 and I test with a simple keyboard).

>
> Anyway, here is how to fix the USB Host ports:
> # gpioset 0 14=3D1
>
> I guess it'd be best to have a proper reset solution before merging the
> host port addition.
>

Maybe I can add the reset signal to the DW3 driver?
I guess that Boundary is not the only board maker to use a resettable USB H=
UB.


> Regards,
> Gary
>
> [1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/137483438=
4-8071-1-git-send-email-p.zabel@pengutronix.de/

Thanks,
Adrien

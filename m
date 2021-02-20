Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678AC3206DE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 20:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBTTUD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 20 Feb 2021 14:20:03 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37949 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTTT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:19:59 -0500
Received: by mail-ed1-f42.google.com with SMTP id s11so16615603edd.5;
        Sat, 20 Feb 2021 11:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OBKL52x1c+0wtBbYVRakXBkOcTFo42BB6g8G38t5+3w=;
        b=ZuzjdN0IkhSLeo3ZDnyf0ZaEoeIdVXkYwBIaz/3fYBDR3+0FZuv3paz135VNUlMId4
         M2izgsLgussNK28qlom5K12cOg6qn7OTpCMN+BPBlldnlpGWPkLhNeKIc2f4ccPIXBlI
         mgSpkgy+rm1p9F/uK6LRqRJxRK+r0R2mfa3cqdU4JcLNvCvUPnS5GRvPLIq53Yvci+Qb
         NdzF9LuYr4cMj114LAY21D/dTCtqyfIyPPGdieo23FDDWvRb7b9vnlvy+Kd+i+GvnVmz
         Sacb9rGdDsOe69pkO0HSaP4VUdUyoN8TEROGMutNbnxHtJnXlinO3PhxxhgtaC8ySEkm
         SXjw==
X-Gm-Message-State: AOAM532+hs1c0NV3TpXtY1FnmUkkTmMPUNTK2F6U2c9p3utZz9idtKDY
        IsgqlScHsi8fPQyHt5G2XCOmc2MuJ8Q=
X-Google-Smtp-Source: ABdhPJwcQ7jmMKc3nguM404IJLKp3QhifbcjgDcH43iCNTW/Pm4ga706Kg6F+Bjpt68nSxKeuZk/9Q==
X-Received: by 2002:a05:6402:190a:: with SMTP id e10mr15292700edz.110.1613848757108;
        Sat, 20 Feb 2021 11:19:17 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id r23sm6843913ejd.56.2021.02.20.11.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 11:19:16 -0800 (PST)
Date:   Sat, 20 Feb 2021 20:19:14 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
Message-ID: <20210220191914.pir3ep3utz6uwyrb@kozik-lap>
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
 <20210217161052.877877-2-adrien.grassein@gmail.com>
 <20210219131825.niiftfm5r32qc6m3@kozik-lap>
 <CABkfQAH75N1k0bDEGzo0mRtoqP=-9p9hzBo43f6gQnSmGsXQUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CABkfQAH75N1k0bDEGzo0mRtoqP=-9p9hzBo43f6gQnSmGsXQUw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 03:03:55PM +0100, Adrien Grassein wrote:
> Le ven. 19 févr. 2021 à 14:18, Krzysztof Kozlowski <krzk@kernel.org> a écrit :
> >
> > On Wed, Feb 17, 2021 at 05:10:45PM +0100, Adrien Grassein wrote:
> > > Add usdhc3 description which corresponds to the wifi/bt chip
> > >
> > > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > > ---
> > >  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 31 +++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > index c0c384d76147..212dc9e5e85d 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > @@ -9,6 +9,17 @@
> > >  / {
> > >       model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
> > >       compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
> > > +
> > > +     reg_wlan_vmmc: regulator-wlan-vmmc {
> > > +             compatible = "regulator-fixed";
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&pinctrl_reg_wlan_vmmc>;
> > > +             regulator-name = "reg_wlan_vmmc";
> > > +             regulator-min-microvolt = <3300000>;
> > > +             regulator-max-microvolt = <3300000>;
> > > +             gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
> > > +             enable-active-high;
> > > +     };
> > >  };
> > >
> > >  &A53_0 {
> > > @@ -206,6 +217,20 @@ &usdhc2 {
> > >       status = "okay";
> > >  };
> > >
> > > +/* wlan */
> > > +&usdhc3 {
> > > +     bus-width = <4>;
> > > +     sdhci-caps-mask = <0x2 0x0>;
> > > +     non-removable;
> > > +     pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > > +     pinctrl-0 = <&pinctrl_usdhc3>;
> > > +     pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> > > +     pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> > > +     vmmc-supply = <&reg_wlan_vmmc>;
> > > +     vqmmc-1-8-v;
> >
> > There is no such property in the bindings.
> >
> 
> Sorry, I copied a property from the FSL kernel.
> I will fix this with a "fixed-regulator".

I would assume this goes from PMIC, so check your schematics. There is
little point in adding a fixed regulator which is non-controllable.
I think bindings don't require it.

Best regards,
Krzysztof


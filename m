Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2503E3541E5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 13:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbhDEL4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 07:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233778AbhDEL4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 07:56:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49874613B2;
        Mon,  5 Apr 2021 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617623796;
        bh=qD0D8WJ+lKgn1aSNGRrMa7S04oUn0rYr1F45lHkry/8=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=grZdC7ijpY1lPm1OzB+Ap4hhqBk1646Ne/QNClL1tj4bVhkGMMkTgaw+LQLAIfzkj
         ftW1KmF0x4JjgtfUIo4BY/lkUhR7n1wCzQi9xQl3vinFi5R/DoNomN+KplwaOYUnAx
         P3wSX1TMQvB2eB7yykUc6fyLpLMKasbAcHz3XYqKP9vwkIA2sJwSz8VYvSPs0ayxxi
         U4gngg4bafEuPPXldR3kvtA5CtWIti13xscPaTwNgQYBRMZYe8PzV9FQ9LPiurkfx4
         jbg6SfzH9QtXxv2ul5b4iYCnIRnbLCczsSplkVZ53ddRw/sIkTDGPybA7hU1MVtI83
         eNrj5Kcslqnag==
Received: by mail-lf1-f49.google.com with SMTP id 12so16914329lfq.13;
        Mon, 05 Apr 2021 04:56:35 -0700 (PDT)
X-Gm-Message-State: AOAM532mpBUCAwgHOs5bYnzq84s2VZt9gM6j00BDfHWUAjV3UUgfo0TH
        1ufmto3QN4RQavEnsai/Z+2FlS/l+rNPd4jQnM0=
X-Google-Smtp-Source: ABdhPJwyUesL4g5lSOGAcVCqL7ntODZwSA2VUpWJDrzGbvihgoTOYhadpu89RuJjTOFujFsjdeHrDEdGzko2qkzu0KQ=
X-Received: by 2002:ac2:46ee:: with SMTP id q14mr17318622lfo.303.1617623793546;
 Mon, 05 Apr 2021 04:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210405093423.16149-1-cnsztl@gmail.com> <c12341c8-8590-8314-d59b-3d5903041491@gmail.com>
In-Reply-To: <c12341c8-8590-8314-d59b-3d5903041491@gmail.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 5 Apr 2021 19:56:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v65vdH-6h-y_SLUqSqgAOh3+2=BHV8hgABbKcEF23GBWkg@mail.gmail.com>
Message-ID: <CAGb2v65vdH-6h-y_SLUqSqgAOh3+2=BHV8hgABbKcEF23GBWkg@mail.gmail.com>
Subject: Re: [PATCH v2] rockchip: enabled LAN port on NanoPi R2S
To:     Johan Jonker <jbx6244@gmail.com>, Tianling Shen <cnsztl@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        David Bauer <mail@david-bauer.net>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 5, 2021 at 7:03 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi Tianling,
>
> On 4/5/21 11:34 AM, Tianling Shen wrote:
> > From: David Bauer <mail@david-bauer.net>
> >
> > Enable the USB3 port on the FriendlyARM NanoPi R2S.
> > This is required for the USB3 attached LAN port to work.
> >
> > Signed-off-by: David Bauer <mail@david-bauer.net>
> > [added device node for USB Ethernet controller]
> > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> > ---
> >  .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> > index faf496d789cf..18936b393d9d 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> > @@ -13,6 +13,10 @@
> >       model = "FriendlyElec NanoPi R2S";
> >       compatible = "friendlyarm,nanopi-r2s", "rockchip,rk3328";
> >
> > +     aliases {
> > +             ethernet1 = &r8153;
> > +     };
> > +
> >       chosen {
> >               stdout-path = "serial2:1500000n8";
> >       };
> > @@ -37,6 +41,16 @@
> >               };
> >       };
> >
>
> > +     vcc_rtl8153: vcc-rtl8153-regulator {
>
> sort nodename
>
> > +             compatible = "regulator-fixed";
> > +             gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&rtl8153_en_drv>;
> > +             regulator-always-on;
>
> > +             regulator-name = "vcc_rtl8153";
>
> exception to the sort rule
> sort regulator-name above all other regulator properties
>
> > +             enable-active-high;
>
> sort
>
> ----
> Heiko's sort rules:
>
> compatible
> reg
> interrupts
> [alphabetical]
> status [if needed]
>
> ----
>
> > +     };
> > +
> >       leds {
> >               compatible = "gpio-leds";
> >               pinctrl-0 = <&lan_led_pin>,  <&sys_led_pin>, <&wan_led_pin>;
> > @@ -265,6 +279,12 @@
> >                       };
> >               };
> >       };
> > +
> > +     usb {
> > +             rtl8153_en_drv: rtl8153-en-drv {
> > +                     rockchip,pins = <2 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> > +             };
> > +     };
> >  };
> >
> >  &io_domains {
> > @@ -364,6 +384,18 @@
> >       dr_mode = "host";
> >  };
> >
> > +&usbdrd3 {
> > +     dr_mode = "host";
> > +     status = "okay";
> > +
>
> > +     r8153: usb-eth@2 {
>
> With YAML undocumented additional properties and nodes generate
> notifications.
> We need a change in the documents below for that.
> rockchip,dwc3.yaml > usb-drd.yaml > usb.yaml
>
> Is there a standard for the usb-eth nodename?

The USB devices binding seems to specify "device" and then
"interface" sub-nodes.

> > +             compatible = "realtek,rtl8153";
>
> Since a while Rob has improved has scripts.
> There's no escape anymore.
> Add a YAML document to this serie for "realtek,rtl8153".

Actually it should be "usbbda,8153", which conforms to

    Documentation/devicetree/bindings/usb/usb-device.yaml

Giving "realtek,rtl8153" to the kernel will not help it match any
device.

ChenYu

> Improve checking for undocumented compatible strings
> https://github.com/devicetree-org/dt-schema/commit/93e7ada8d53af099074cb5d53f7caa12835784e0
>
> > +             reg = <2>;
>
> Why 2 ?
>
> > +
>
> > +             local-mac-address = [ 00 00 00 00 00 00 ]; /* Filled in by U-Boot */
>
> This is a private property.
> In a generic dts that's up to the user.
>
> > +     };
> > +};
> > +
> >  &usb_host0_ehci {
> >       status = "okay";
> >  };
> >
>

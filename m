Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94D7355338
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343757AbhDFMKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343759AbhDFMKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:10:35 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E388C061756;
        Tue,  6 Apr 2021 05:10:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v140so4553449lfa.4;
        Tue, 06 Apr 2021 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0FXSTiM7GC4Mvwuv2T0oynhHNDd7L5en4InWzjAui8=;
        b=immwf48ORJKbTnbiusrILWixOG0SjnZnU9YsXi79NfCDXcOLmUuRT1TsielKwFzHRf
         Q0UFpaJ08oq0o9TvShdrZ4y3scfNFZbr1RmMFzwVE3qZo8u15YbEuSJukLC1Poe+26eE
         w7KRKoVL+KN5ShIDhGdc4DbyURCW1fAo9d8IB2k6TiX20Gwi/DDNmeb/JL4sCev+sf8i
         kHElm7txv2YKTsQucNpYG2gZndEnTjBAMLxIF6d2Zm9bmYE3MQnv8T6vkdt5ESZfGGpM
         X3zkBX9nBP3ZSqqoqQ0wpPmiLBtqmEvYqsEmeXaW3PtBzQ5n0wPNkABvzmdHj48Yz7V5
         PeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0FXSTiM7GC4Mvwuv2T0oynhHNDd7L5en4InWzjAui8=;
        b=k7QKbpvFinQDgamQHXqn5AJjm7CvnmcASr7nNtndgxQRjOOE1TDphSW7ARUgyAHfat
         ku7hcxPXZLY01FdXMlTYN5coU0+kREC63Wfeilj3Dx+bAwGnlYfS+j/2QzGBOdqCzKzg
         dMzFhk95YvuUdTJA2uSIn4WYNvwTcO5rkbD/U2nHe+ltIUncsYhZ3/7VbbmmTtw152o5
         5QwT44c+mcjOButdeiIvkj/VNoa8IIsB9w1im5w5j3ABA6/zToz9bU2iD1XpGlrNZRdE
         3qJnyqDux6+mYzTfFerf5n0P5HH35p9+yFzc1JG9oJvN084vmuEjc5Y89FxzYpFUscjC
         6riw==
X-Gm-Message-State: AOAM533bgVEA6+mnpu+vR25w1XneQZpCba6FmqK40y4wXQpQhQKJMXjC
        pjo48u4te7Cgs+eNUHGWar3SHGIX7JEKwG6tvpk=
X-Google-Smtp-Source: ABdhPJy5j7Oe8GDmvwGPYJBow20bn4HG2AffSOHb5q7QrCTnk5XtXrtLuRd9Vm9lhM9/OaOc98uquqs4FenNXOVGvNM=
X-Received: by 2002:ac2:5ca7:: with SMTP id e7mr20852931lfq.646.1617711026053;
 Tue, 06 Apr 2021 05:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210405093423.16149-1-cnsztl@gmail.com> <c12341c8-8590-8314-d59b-3d5903041491@gmail.com>
In-Reply-To: <c12341c8-8590-8314-d59b-3d5903041491@gmail.com>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Tue, 6 Apr 2021 20:10:14 +0800
Message-ID: <CAOP2_Tjm9k0n_=_8+kZhFh_xC7o+ne1EWiL2UKWGXpUY+L2vRA@mail.gmail.com>
Subject: Re: [PATCH v2] rockchip: enabled LAN port on NanoPi R2S
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        David Bauer <mail@david-bauer.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 2021-04-05 19:03, Johan Jonker <jbx6244@gmail.com> wrote:
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

Thank you very much, and I will update it in v3.

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
>
> > +             compatible = "realtek,rtl8153";
>
> Since a while Rob has improved has scripts.
> There's no escape anymore.
> Add a YAML document to this serie for "realtek,rtl8153".

This is actually added by another patch[1], but doesn't go to upstream yet.
I'll ask David if he would like to submit it.

Kindly ping David.

1:
https://github.com/openwrt/openwrt/blob/master/target/linux/rockchip/patches-5.10/002-net-usb-r8152-add-LED-configuration-from-OF.patch
https://github.com/openwrt/openwrt/blob/master/target/linux/rockchip/patches-5.10/003-dt-bindings-net-add-RTL8152-binding-documentation.patch

>
> Improve checking for undocumented compatible strings
> https://github.com/devicetree-org/dt-schema/commit/93e7ada8d53af099074cb5d53f7caa12835784e0
>
> > +             reg = <2>;
>
> Why 2 ?
>

This is the device number on the USB bus.

> > +
>
> > +             local-mac-address = [ 00 00 00 00 00 00 ]; /* Filled in by U-Boot */
>
> This is a private property.
> In a generic dts that's up to the user.

Okay I will drop this.

Thanks,
Tianling.

>
> > +     };
> > +};
> > +
> >  &usb_host0_ehci {
> >       status = "okay";
> >  };
> >
>

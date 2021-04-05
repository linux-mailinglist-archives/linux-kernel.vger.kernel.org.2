Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06CF353C87
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 10:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhDEIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 04:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhDEIxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 04:53:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E755C061756;
        Mon,  5 Apr 2021 01:53:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m12so16420904lfq.10;
        Mon, 05 Apr 2021 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66eFVhQITP6e2usZV3iYiCUliC2/qX94Zfl0FBPlH+E=;
        b=jHQ5A0edCkKm5HoDaDPKf6B8a1YXnkOdSPvlBlN2Spux/3ltSMbcP6KXqChhp9EYq3
         4LQ4kz9NpZshwWki7t2apmP11IqkNWNTMEGjGlg6rCPKGZd9O0KCFbofu2zBU49eXcNR
         e61qB6J0tINAcwaWb/xpt29tYpB2xBFNUUV40N2naZq73Bze2o/U1hciIROWOSO+gex+
         5QjjBcw37bdIiXDQSMLhJ+sSglEIgwFO2jEYYS9ECNzDcq6N2eennielubP2BoHkRigt
         Q4DIx80ENP8l+9sSTSetzw3JQVvY5ZGJJiEOVoEv2h8mHF1iDHNdiQJBNs6v6e7bNVzD
         FwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66eFVhQITP6e2usZV3iYiCUliC2/qX94Zfl0FBPlH+E=;
        b=IOAgTVqKrhTSGIrTIXLdYhZkJ0BGfQtwm5N7hc/53pSaMTlkS9t10URtkhZgJSztXS
         PKBqXn8e5e0Xp2crctnNfwntAoB0vBx12NMWMBLDQXTl5RmOQzyIBP2CQR9pc5Ak1hww
         OJoA39cVM8Dc81dnTOCxq73qWaNLsMVjCxB9JK2IP41P7Ymj22vri1DRVyOs0P6zG7yd
         AjVdyqttIsY36W++08a3E8e7mB+nUNdGgcpX9f3yNDi3TZ39HVcu3zfOHEV+ux0/LaPO
         X7AD94V4Z5ow7Of3ucZfrljE1sDqQ8cTq3v1+86aJYS6rUxQzLHoeYRqxfserMcfcdh7
         RgUA==
X-Gm-Message-State: AOAM530ewxgkzebXRxxEZ8tlO+N1QZlj88+fM/NVAehxB9jCpd/+M0mE
        N5efYF15ueZA1g3XLzt9+IqdLlVGw2WtD/+nhGU=
X-Google-Smtp-Source: ABdhPJxs9e9v8ObaK3QKnr4HhThJ4aLtN8wUIQCUc0ikxB4S7f9zjUR1pK6SDQ0nr63G1kHQTkUuQxWor4QjB4KTdHM=
X-Received: by 2002:ac2:5f19:: with SMTP id 25mr17650197lfq.328.1617612788906;
 Mon, 05 Apr 2021 01:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210405074459.4217-1-cnsztl@gmail.com> <CAGb2v66K3SFSkm9T_D6X5o7jSYOoYpYeS_yMp1k6nMonmjiHZA@mail.gmail.com>
In-Reply-To: <CAGb2v66K3SFSkm9T_D6X5o7jSYOoYpYeS_yMp1k6nMonmjiHZA@mail.gmail.com>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Mon, 5 Apr 2021 16:52:57 +0800
Message-ID: <CAOP2_Th4+ZXtYfrr2kWnnuuzzS-HdNvN6FVtMj=5-nk4QTOvnQ@mail.gmail.com>
Subject: Re: [PATCH] rockchip: enabled LAN port on NanoPi R2S
To:     wens@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
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

Hi Chen-Yu,

On 2021-04-05 16:14, Chen-Yu Tsai <wens@kernel.org> wrote:
>
> Hi,
>
> On Mon, Apr 5, 2021 at 3:46 PM Tianling Shen <cnsztl@gmail.com> wrote:
> >
> > From: David Bauer <mail@david-bauer.net>
> >
> > Enable the USB3 port on the FriendlyARM NanoPi R2S.
> > This is required for the USB3 attached LAN port to work.
> >
> > Signed-off-by: David Bauer <mail@david-bauer.net>
> > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> > ---
> >  .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> > index faf496d789cf..6ba9799a95c5 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> > @@ -37,6 +37,18 @@
> >                 };
> >         };
> >
> > +       vcc_rtl8153: vcc-rtl8153-regulator {
> > +               compatible = "regulator-fixed";
> > +               gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&rtl8153_en_drv>;
> > +               regulator-always-on;
> > +               regulator-name = "vcc_rtl8153";
> > +               regulator-min-microvolt = <5000000>;
> > +               regulator-max-microvolt = <5000000>;
>
> This is just a simple switch, not an actual regulator.
> It would make more sense to drop the voltage range and
> instead have the implementation pass-through voltage
> constraints from its parent.

Thanks, I'll remove them in v2.

>
> > +               enable-active-high;
> > +       };
> > +
> >         leds {
> >                 compatible = "gpio-leds";
> >                 pinctrl-0 = <&lan_led_pin>,  <&sys_led_pin>, <&wan_led_pin>;
> > @@ -265,6 +277,12 @@
> >                         };
> >                 };
> >         };
> > +
> > +       usb {
> > +               rtl8153_en_drv: rtl8153-en-drv {
> > +                       rockchip,pins = <2 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> > +               };
> > +       };
> >  };
> >
> >  &io_domains {
> > @@ -364,6 +382,11 @@
> >         dr_mode = "host";
> >  };
> >
> > +&usbdrd3 {
> > +       dr_mode = "host";
> > +       status = "okay";
>
> Please also add a device node for the actual Ethernet controller, and
> set up an aliases node for it, so that the bootloader has some place
> to fill in a MAC address.

But there's no valid (unique) MAC address for both this or on-board ethernet...
They're non-existent in design.

Thanks,
Tianling.

>
>
> ChenYu
>
> > +};
> > +
> >  &usb_host0_ehci {
> >         status = "okay";
> >  };
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3A8425904
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbhJGRPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243197AbhJGRPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:15:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2C8D61245;
        Thu,  7 Oct 2021 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633626802;
        bh=qgaRkKylb5I7rL0mEhfxEXR9XIrcqAJxFLzv8e5JG88=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=lPcFKMPJUrxSO2zGApX5vGLRmoUwVi1rdOpOD3HfzJbMF+yI9oi2WdKUxwAAvxkju
         mBDvBA417YhzIJK49U8r65LworeDV+XmeyC3s8I2x0Hbw20xkpzj+yDB2LIMYoOyI+
         HC0//WOEPilcK42nhhU7OgFBHFHmugMvBWRDpqquR4CIAF7sSQDcOZvCQB/pFKPEUQ
         dq9bATZJMgXocUJVJkst7F1y2DwsFfQqmwZN1/ixej4FLkorfteMHcc0WQ8NlEs7sq
         jI23jNUOwTKzWAVE7x7PlEUCYw9x3Lj4Hrn8cpDOM7dbBF5TKbdVW4bK+4zY7GXmh7
         7q0wwUN5CR8cg==
Received: by mail-vs1-f48.google.com with SMTP id o124so7559770vsc.6;
        Thu, 07 Oct 2021 10:13:22 -0700 (PDT)
X-Gm-Message-State: AOAM533CbuWftBxnJG6O9ueAe27qyoOI7BjntgrTa7rBiCSlWcB9e7wf
        cKSGK0BvojXf+QAByemInp0jlmg04g8kkxSrMi8=
X-Google-Smtp-Source: ABdhPJz4d+CxciE86cm0an+klVYy8vZNXeGzVO8rMl/54qPRzymGwVMpiZwmLxviwztCIOJoXCPLvCq5C4v+XIgxJVY=
X-Received: by 2002:a67:c284:: with SMTP id k4mr5637887vsj.24.1633626802047;
 Thu, 07 Oct 2021 10:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210920175647.13008-1-wens@kernel.org> <64f06ddb-cde6-d71a-7920-41c485a1d3fb@arm.com>
In-Reply-To: <64f06ddb-cde6-d71a-7920-41c485a1d3fb@arm.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Fri, 8 Oct 2021 01:13:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v67dixQ7BH+YoBVWEJFup9FdgvrDaCZACEYidPuD4pB7YQ@mail.gmail.com>
Message-ID: <CAGb2v67dixQ7BH+YoBVWEJFup9FdgvrDaCZACEYidPuD4pB7YQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: nanopi4: decrease Bluetooth UART
 baud rate
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 6:49 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-09-20 18:56, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The RK3399 does not seem to be able to properly generate the required
> > 64 MHz clock for the UART to operate at 4MBd.
> >
> > Drop the baud rate down to 3MBd, which can be used as the clock
> > controller is able to produce a 48 MHz clock.
>
> Hmm, I've been running mine this way (with DMA) for ages now :/

I guess you have extra patches on top for DMA? I sent another patch
to hook up DMA.

> Looking at clk_summary, clk_uart0_src ends up at 800MHz off CPLL (same
> as several other significant clocks), with clk_uart0 at an exact 64MHz
> as a division of that. I stuck a scope on the UART pins of the module
> and all the edges look nicely lined up to 250ns intervals.

Could you provide a partial dump of /sys/kernel/debug/clk/clk_summary ?
Just the bits related to uart0 should be enough.

Mine is also running from CPLL, but ends up at 1843200 Hz, which seems
like the clock rate used for 115200 baud:

 xin24m                              24       24        0    24000000
        0     0  50000         Y
    pll_cpll                          1        1        0   800000000
        0     0  50000         Y
       cpll                           7       15        0   800000000
        0     0  50000         Y
          clk_uart0_src               1        1        0   800000000
        0     0  50000         Y
             clk_uart0_div            1        1        0   800000000
        0     0  50000         Y
                clk_uart0_frac        1        1        0     1843200
        0     0  50000         Y
                   clk_uart0          1        1        0     1843200
        0     0  50000         Y

I also observe a couple error messages:

Bluetooth: hci0: BCM: failed to write clock (-56)
Bluetooth: hci0: Failed to set baudrate
Bluetooth: hci0: BCM: chip id 130
Bluetooth: hci0: BCM: features 0x0f
Bluetooth: hci0: BCM4345C5
Bluetooth: hci0: BCM4345C5 (003.006.006) build 0000
Bluetooth: hci0: BCM4345C5 'brcm/BCM4345C5.hcd' Patch
Bluetooth: hci0: BCM: failed to write clock (-56)
Bluetooth: hci0: BCM4345C5 Ampak_CL1.5 UART 37.4 MHz BT 5.0 [Version:
Version: 0033.0080]
Bluetooth: hci0: BCM4345C5 (003.006.006) build 0080

So I think my UART is actually still running at its initial speed.

Another thing is that the Rockchip datasheet says something about the
denominator has to be 20 times larger than the nominator for a stable clock.

> This is with a 5.11.4 kernel, though - I wonder if the recent fractional
> divider changes in the clock driver have changed anything?

I tried reverting the three patches but that didn't make a difference.

Regards
ChenYu


>
> > Fixes: 3e2f0bb72be3 ("arm64: dts: rockchip: Add nanopi4 bluetooth")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> > index 8c0ff6c96e03..45ff053b119d 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> > @@ -699,7 +699,7 @@ bluetooth {
> >               device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
> >               host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> >               shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> > -             max-speed = <4000000>;
> > +             max-speed = <3000000>;
> >               pinctrl-names = "default";
> >               pinctrl-0 = <&bt_reg_on_h &bt_host_wake_l &bt_wake_l>;
> >               vbat-supply = <&vcc3v3_sys>;
> >

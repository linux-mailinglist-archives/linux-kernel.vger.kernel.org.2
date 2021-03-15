Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FBE33C556
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhCOSOS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Mar 2021 14:14:18 -0400
Received: from mail-vk1-f180.google.com ([209.85.221.180]:35797 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhCOSNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:13:54 -0400
Received: by mail-vk1-f180.google.com with SMTP id k27so3034337vki.2;
        Mon, 15 Mar 2021 11:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ttnIf4YpTk5H8GW6m3wchGnU61LNhA8jE6rda8jNi0=;
        b=DYq+kIPwNsa9eKlgRfMuHJBf8/TyQ1FsvEVt6A8n6Ont4dG8VzXTTvwKcKdtmicF5E
         AfN8nRcG8ZXizXAeuKuRYGBPNn2HE8zZjdk9SAKFXBaLOxPbx6PAY6Gp7dN6cAMznR6e
         w0UyQvvefTMaa2h1wysoWzRSJboIaeD0JlQxGH8BVKde9SihlKZth024Iu3G12EHqSqV
         OM6Q4VSZxPc43UkxheyC+j7dH+lUkmG7w2ZN2kRm0ub2HrXYuIEGufmAZXabL1LJxe7S
         LJKrjYe4YkGP2G7djrYrySHzD55QoClPPAUd3uQ0w8LJn74Wuz561FmmqG9XIPlvLhHR
         RNzw==
X-Gm-Message-State: AOAM531jWBzthl7cCgSNwAu1i2dCPrqUYj80dfZE7x5OCz8/GYlKD5al
        PvKVRCkQHUQqCFhoGIrnFrlIdXAoagPd6bevsSkCfplWofE=
X-Google-Smtp-Source: ABdhPJxmHPKCl6/KoLKCjWWHH1nzlyZhAfvkJCSsrW+k5JNup2itpowFYOpAeB2fpNRiP5LlvOmVxUysr23ztte+kQo=
X-Received: by 2002:ac5:cbee:: with SMTP id i14mr5887786vkn.1.1615832033240;
 Mon, 15 Mar 2021 11:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210313032515.12590-1-cnsztl@gmail.com> <67b314e7-92b9-8025-1a41-9b7da6ff2249@arm.com>
 <CAMuHMdX9F0fgi2-N01cck=AvgtByq3sSpdgLrCu5MDrkkc-KXw@mail.gmail.com> <17376355.sWSEgdgrri@diego>
In-Reply-To: <17376355.sWSEgdgrri@diego>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Mar 2021 19:13:41 +0100
Message-ID: <CAMuHMdWYrS=YT7F7erM-e6xhDME4judx-T7rdFGi7CpW1_iqkg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rockchip: rk3399: Add support for FriendlyARM
 NanoPi R4S
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, CN_SZTL <cnsztl@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Bauer <mail@david-bauer.net>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Marty Jones <mj8263788@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Mon, Mar 15, 2021 at 5:52 PM Heiko Stübner <heiko@sntech.de> wrote:
> Am Montag, 15. März 2021, 17:38:37 CET schrieb Geert Uytterhoeven:
> > On Mon, Mar 15, 2021 at 5:32 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > > On 2021-03-13 13:22, CN_SZTL wrote:
> > > > Robin Murphy <robin.murphy@arm.com> 于2021年3月13日周六 下午7:55写道：
> > > >>
> > > >> On 2021-03-13 03:25, Tianling Shen wrote:
> > > >>> +     gpio-leds {
> > > >>> +             compatible = "gpio-leds";
> > > >>> +             pinctrl-0 = <&lan_led_pin>, <&sys_led_pin>, <&wan_led_pin>;
> > > >>> +             pinctrl-names = "default";
> > > >>> +
> > > >>> +             lan_led: led-0 {
> > > >>> +                     gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
> > > >>> +                     label = "nanopi-r4s:green:lan";
> > > >>> +             };
> > > >>> +
> > > >>> +             sys_led: led-1 {
> > > >>> +                     gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> > > >>> +                     label = "nanopi-r4s:red:sys";
> > > >>> +                     default-state = "on";
> > > >>> +             };
> > > >>> +
> > > >>> +             wan_led: led-2 {
> > > >>> +                     gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> > > >>> +                     label = "nanopi-r4s:green:wan";
> > > >>> +             };
> > >
> > > Nit: (apologies for overlooking it before) there isn't an obvious
> > > definitive order for the LEDs, but the order here is certainly not
> > > consistent with anything. The most logical would probably be sys, wan,
> >
> > Looks like alphabetical sort order to me ;-)
>
> yep ... led-0, led-1, led-2 looks pretty sorted ;-)

Actually I had "lan, sys, wan" in mind ;-)

> Generally I'd prefer sorting by node-names ... especially as the phandle
> is sort of optional for most things - and they sometimes come and go
> in dt-files.

The node names are sorted, too, as you've just pointed out...

Personally, I'm not so fond of the <foo>-%u node names, and prefer
<foo>-<function>.  With the former, it's way too easy to have a silent
override in your .dts(i) stack.
Cfr. commit 45f5d5a9e34d3fe4 ("arm64: dts: renesas: r8a77995: draak:
Fix backlight regulator name")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

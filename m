Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC64833C24C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhCOQjA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Mar 2021 12:39:00 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:34293 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhCOQit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:38:49 -0400
Received: by mail-vs1-f49.google.com with SMTP id m18so16693947vsa.1;
        Mon, 15 Mar 2021 09:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6+LwVnTq5aoTVvp7lLwT2APEy4pRL3wg/ASDpHleT/s=;
        b=Nx2je6utkvXK8HH/6j21CxE7Xhw2tGgAmuSnvei/GunDizwHc8Wy9hrMknDdWYfhUy
         T8yMcWie1ILfC4Z7r+gvZ0YWerQImKpuQBlEItlr0O5z7zMCZPharIie8RsoMPPXrvrs
         Yhc8RzA3OaWMk7i1K+9+Xym92NMjrm/cA/XwDCziMUWg5+LSurlPqXzhiMW5xp+CqEH4
         Rx+dcn5s9sWb0xzE2jexn7Sxi5SdNJ2fIn0fTMpr/wuydtwuD9H8UZ3slP8Re47eDfNj
         Eo5iKraP2+gaBojk0gTQTzu+jIfkzPoHc7hMFcQKQoFwwbB67j8KKGJm1wTezHMCkkHY
         LsgQ==
X-Gm-Message-State: AOAM532ttMiG0OzKSaYPwfD6O7Z/XpVd1/OWQU6aMVcOjf7dF15qUruu
        6tjNSFv2gbyBIghJlyDpCIxtlcmAR8xoLmH4gGE=
X-Google-Smtp-Source: ABdhPJzfAqlF9iGvUShaEseAew7ZXcO0CNa4CHm34L7ON9NjOQurRH7m5yhRaLJ1Y/s8808zZcDNFQVOP89G9nuhlnQ=
X-Received: by 2002:a67:ef0e:: with SMTP id j14mr13895505vsr.40.1615826329149;
 Mon, 15 Mar 2021 09:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210313032515.12590-1-cnsztl@gmail.com> <20210313032515.12590-2-cnsztl@gmail.com>
 <1f7f1a11-0b9b-b2e4-efbc-193f61d62832@arm.com> <CAOP2_TgUQH9H9vuESek7KjStxu=idaBxX=S5Q7_=Mn=D_s-=JA@mail.gmail.com>
 <67b314e7-92b9-8025-1a41-9b7da6ff2249@arm.com>
In-Reply-To: <67b314e7-92b9-8025-1a41-9b7da6ff2249@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Mar 2021 17:38:37 +0100
Message-ID: <CAMuHMdX9F0fgi2-N01cck=AvgtByq3sSpdgLrCu5MDrkkc-KXw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rockchip: rk3399: Add support for FriendlyARM
 NanoPi R4S
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     CN_SZTL <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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

Hi Robin,

On Mon, Mar 15, 2021 at 5:32 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2021-03-13 13:22, CN_SZTL wrote:
> > Robin Murphy <robin.murphy@arm.com> 于2021年3月13日周六 下午7:55写道：
> >>
> >> On 2021-03-13 03:25, Tianling Shen wrote:
> >>> +     gpio-leds {
> >>> +             compatible = "gpio-leds";
> >>> +             pinctrl-0 = <&lan_led_pin>, <&sys_led_pin>, <&wan_led_pin>;
> >>> +             pinctrl-names = "default";
> >>> +
> >>> +             lan_led: led-0 {
> >>> +                     gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
> >>> +                     label = "nanopi-r4s:green:lan";
> >>> +             };
> >>> +
> >>> +             sys_led: led-1 {
> >>> +                     gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> >>> +                     label = "nanopi-r4s:red:sys";
> >>> +                     default-state = "on";
> >>> +             };
> >>> +
> >>> +             wan_led: led-2 {
> >>> +                     gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> >>> +                     label = "nanopi-r4s:green:wan";
> >>> +             };
>
> Nit: (apologies for overlooking it before) there isn't an obvious
> definitive order for the LEDs, but the order here is certainly not
> consistent with anything. The most logical would probably be sys, wan,

Looks like alphabetical sort order to me ;-)

> lan since that's both in order of GPIO number and how they are
> physically positioned relative to each other on the board/case (although
> you could also argue for wan, lan, sys in that regard, depending on how
> you look at it).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFF633C287
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhCOQxY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Mar 2021 12:53:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:35506 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233468AbhCOQxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:53:06 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lLqSI-0001JB-1E; Mon, 15 Mar 2021 17:52:34 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     CN_SZTL <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        David Bauer <mail@david-bauer.net>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <uwe@kleine-koenig.org>,
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
Subject: Re: [PATCH v3 2/2] rockchip: rk3399: Add support for FriendlyARM NanoPi R4S
Date:   Mon, 15 Mar 2021 17:52:32 +0100
Message-ID: <17376355.sWSEgdgrri@diego>
In-Reply-To: <CAMuHMdX9F0fgi2-N01cck=AvgtByq3sSpdgLrCu5MDrkkc-KXw@mail.gmail.com>
References: <20210313032515.12590-1-cnsztl@gmail.com> <67b314e7-92b9-8025-1a41-9b7da6ff2249@arm.com> <CAMuHMdX9F0fgi2-N01cck=AvgtByq3sSpdgLrCu5MDrkkc-KXw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. März 2021, 17:38:37 CET schrieb Geert Uytterhoeven:
> Hi Robin,
> 
> On Mon, Mar 15, 2021 at 5:32 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > On 2021-03-13 13:22, CN_SZTL wrote:
> > > Robin Murphy <robin.murphy@arm.com> 于2021年3月13日周六 下午7:55写道：
> > >>
> > >> On 2021-03-13 03:25, Tianling Shen wrote:
> > >>> +     gpio-leds {
> > >>> +             compatible = "gpio-leds";
> > >>> +             pinctrl-0 = <&lan_led_pin>, <&sys_led_pin>, <&wan_led_pin>;
> > >>> +             pinctrl-names = "default";
> > >>> +
> > >>> +             lan_led: led-0 {
> > >>> +                     gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
> > >>> +                     label = "nanopi-r4s:green:lan";
> > >>> +             };
> > >>> +
> > >>> +             sys_led: led-1 {
> > >>> +                     gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> > >>> +                     label = "nanopi-r4s:red:sys";
> > >>> +                     default-state = "on";
> > >>> +             };
> > >>> +
> > >>> +             wan_led: led-2 {
> > >>> +                     gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> > >>> +                     label = "nanopi-r4s:green:wan";
> > >>> +             };
> >
> > Nit: (apologies for overlooking it before) there isn't an obvious
> > definitive order for the LEDs, but the order here is certainly not
> > consistent with anything. The most logical would probably be sys, wan,
> 
> Looks like alphabetical sort order to me ;-)

yep ... led-0, led-1, led-2 looks pretty sorted ;-)

Generally I'd prefer sorting by node-names ... especially as the phandle
is sort of optional for most things - and they sometimes come and go
in dt-files.


Heiko



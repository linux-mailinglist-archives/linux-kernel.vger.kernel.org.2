Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B4536B22D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 13:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhDZLPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhDZLO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:14:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BD9C061574;
        Mon, 26 Apr 2021 04:14:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b23so5107756lfv.8;
        Mon, 26 Apr 2021 04:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52Uf4pbv7Be7r8HttTVBFMD00su27oeNctOk9bOo0UY=;
        b=WZbwdqoQ3ErwD7gH9wCfRSN2wCxbqy8q/m56bvnvzvN9lyi7BddE5JwwX950cIl3Uj
         8QfUE5nHiaVx/uXzgdphq+fbOICZIs+FFar5Qcb5PWfvrmhHzLWJWbxjH82UJMKtdztO
         rdAtmyDcCsB/N991TcZH9jHv9u6dpKMWxIaD7Ufm1scRSArbj2sXGO8Y1CioQ4DS016B
         z1Veh3w95ezVgOmhNzReTF8+CCduRwIRbVCB5BEdwKSM/AYV81jIi60uf6N9xcKCiF3k
         tzlw8M/E9Co6758w7cnjuDdYMsIEuADqGinzpBy1QXXAIfdZXGkP9ajLuI4SyHOmmUwM
         8s8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52Uf4pbv7Be7r8HttTVBFMD00su27oeNctOk9bOo0UY=;
        b=C2opcYDW833usyzxgRQ353qM5lr8SzXTlNCcB2A8l0vCjUgGQaBrRVTXDcXph3LxmK
         2iAxdi1K1Rb/jDw3IMPDebMi+DxtYBHYfE1lw7Q+veR3BGB2uDOOzo852/LKT/7Q3d3b
         mw0La+iMAZMW16dgZSWZrKlYp89BH6ytIammFZWDwqDjp2I1furteRJkBIftLfdjqbUq
         BmVLsNIIHOvQ8uJ4KA8WKOpjDg4BK1k4V5cUxD/lcU+86S89QDLWug5kM2x88c7HCzr0
         9gf88gwawkgZV2uTPCdJfb2ZKfI0d4QmaWJhjgSxftJfnXhIaCdc8GpD1Y0r1h/N441i
         FEgg==
X-Gm-Message-State: AOAM531RYfCCoD2ROL1J2rHy2bQWV3gYHNHBE5MiDvSnoLvSq/4L1d+K
        xrlaLOEp71O/wGlRYTh3uZcEpslej7scOkOX2J8=
X-Google-Smtp-Source: ABdhPJxXN+68YbSNClsnO/fCPEyWZI/DyXI7kHstDwSzwjedC7Xg9vSTmr7z44uw6hw6V1vrUlP4rpfz71JTDG/eGkE=
X-Received: by 2002:a05:6512:3b92:: with SMTP id g18mr12306758lfv.646.1619435654269;
 Mon, 26 Apr 2021 04:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210319051627.814-1-cnsztl@gmail.com> <161640742725.808893.3666594351389773587.b4-ty@sntech.de>
 <20210425213321.GF10996@amd> <CAOP2_ThcRMkgSm872q2By=gALoK-qAjq92FtNQkDO999pZR8kg@mail.gmail.com>
 <20210426110316.GA13974@duo.ucw.cz>
In-Reply-To: <20210426110316.GA13974@duo.ucw.cz>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Mon, 26 Apr 2021 19:14:03 +0800
Message-ID: <CAOP2_Tixnza0w8x7-viZAgV1fSysuJ5ht_Ri1kyMEgZ9yabOhQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Marty Jones <mj8263788@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Bauer <mail@david-bauer.net>,
        Johan Jonker <jbx6244@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 26, 2021 at 7:03 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> > > > > - Fixed format of LED nodes
> > > > >
> > > > > Changes in v5:
> > > > > - Dropped the empty PCIe node
> > > > > - Dropped useless `/delete-property/`
> > > > > - Renamed LED nodes
> > > > >
> > > > > [...]
> > > >
> > > > Applied, thanks!
> > > >
> > > > [1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
> > > >       commit: 1003888415e83e15ddb63d1d96189b4f2c5f1d48
> > > > [2/2] rockchip: rk3399: Add support for FriendlyARM NanoPi R4S
> > > >       commit: db792e9adbf85ffc9d6b0b060ac3c8e3148c8992
> > >
> > > Sorry for late review, but:
> > >
> > >
> > > +                       label = "red:sys";
> > >
> > > This should be red:power based on the discussion in earlier threads.
> >
> > However based on the introduction from FriendlyELEC[1], this is not
> > the "power" lamp...
> > "LEDs: 1 x power LED and 3 x GPIO Controlled LED (SYS, LAN, WAN)"
>
> It is always on, and "sys" is not a valid function.
>
> I'd suggest labeling it as "red:power". Feel free to make other
> suggestion but lets keep existing functions.

I see, thank you very much!
I'll submit a patch later.

Thanks,
Tianling.

>                                                                 Pavel
> --
> http://www.livejournal.com/~pavelmachek

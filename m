Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DFA33E882
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 05:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCQEji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 00:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCQEjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:39:07 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A10C06174A;
        Tue, 16 Mar 2021 21:39:06 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 16so1503103ljc.11;
        Tue, 16 Mar 2021 21:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxzVzaQfgXYz8ydNKeFmWagcL6oo0NX1A8C+kfVFZQ8=;
        b=DseltBcrTEORJTvKX7i8YctxoVG0MXqz2BT28bVNnuRX9NYat3Gy8T7o51GsDK7HNs
         HxOlvl0xfPJIQgP1F5WA0gijlc6MdSJcQgVjjVmCt8Q6Tu/ykVghG1Kxwy0VsyvVYnq8
         I51VHmRaQwApankQRB9H9eH9sHt4yezvZYO7Uv/2K3kLh0Jb1v76YLKv27FmrKocMn5w
         /btsOtcofrj/6hZTZ8s6dVI56Kj+EY7G+ol/VBc4FpfPRKKckITNsXf1JdGFyv2CzoO/
         8RhvWXY6tuG+D4zcxf1cXOtTzf2f/oY1xMvEhYoGe7Ts5lQrYfJYCGJtUvp93fTM/TDm
         eKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxzVzaQfgXYz8ydNKeFmWagcL6oo0NX1A8C+kfVFZQ8=;
        b=eWgWCMUvQjE298kqqEIOhKJfbBklhT5WFh+qWHaBnMHBOfHx4dzbTGuWgwMs9l2Yz0
         El/uoCRVVXLVIfoCDr+bJ2c0qcjDuTAZzmm1FO2JKbqt+mrOmJhfVDx4D8kgyNXbh/07
         57NP7CjUbhzKo8OdLW2j4d/Y9EKzkRNKCF81J5NAFdi+W6UyfXFolmLSdb0+vR52EVgw
         E/dfy6MiHkAeXVOPXLCapHG31swDcxQNfKNe8/8t6CRENht6C4jIdDJ66pLRWU91yUf5
         lYA6bnsq4EF/5ISJVu6fI5jAHhVxJryh2cJAtZyr0+52FZ0KpHuL6x0wq3KQECjGAf+S
         lLqA==
X-Gm-Message-State: AOAM532o9l3OAFqgEjwVPJJOUh/OKeN0j/yI7ynlP74SpYFF7KhHqcAu
        QXTi8hJWNzkvzarnjoQE6BZ6Q/FbuOfiH87H+XY=
X-Google-Smtp-Source: ABdhPJx5411lQBzPrOF8A4yvPEiz6jFoToaQnrsy9XR0MrguKzg+imDJnV7handvwz7nhSmLs1CXJI4hpO5h2e05h0g=
X-Received: by 2002:a2e:a54b:: with SMTP id e11mr1182129ljn.458.1615955945356;
 Tue, 16 Mar 2021 21:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdWYrS=YT7F7erM-e6xhDME4judx-T7rdFGi7CpW1_iqkg@mail.gmail.com>
 <20210316150033.15987-1-cnsztl@gmail.com> <CAMuHMdU+agaOdf4hQhn5JQDHCbuWm3dETJu01baxfDAY=nikow@mail.gmail.com>
 <20210316193839.GA28184@duo.ucw.cz>
In-Reply-To: <20210316193839.GA28184@duo.ucw.cz>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Wed, 17 Mar 2021 12:38:53 +0800
Message-ID: <CAOP2_TjFtBqBP8wOY-wxSd89yYuYF4bwqWCP4c6FXNMNH=2t-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rockchip: rk3399: Add support for FriendlyARM
 NanoPi R4S
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Johan Jonker <jbx6244@gmail.com>,
        David Bauer <mail@david-bauer.net>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Marty Jones <mj8263788@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 2021-03-17 03:38, Pavel Machek <pavel@ucw.cz> wrote:
>
> On Tue 2021-03-16 16:34:50, Geert Uytterhoeven wrote:
> > Hi Tianling,
> >
> > CC Jacek, Pavel
> >
> > On Tue, Mar 16, 2021 at 4:00 PM Tianling Shen <cnsztl@gmail.com> wrote:
> > > On 2021-03-16 02:23 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > Personally, I'm not so fond of the <foo>-%u node names, and prefer
> > > > <foo>-<function>.  With the former, it's way too easy to have a silent
> > > > override in your .dts(i) stack.
> > > > Cfr. commit 45f5d5a9e34d3fe4 ("arm64: dts: renesas: r8a77995: draak:
> > > > Fix backlight regulator name")
> > >
> > > How about using `lan-led`, `sys-led` and `wan-led` here?
> >
> > Documentation/devicetree/bindings/leds/leds-gpio.yaml says "led-%u"
> > is the preferred form, but that anything containing "led" as a substring
> > is accepted.  So I'd go for "led-lan" etc.
> >
> > BTW, you can validate your DTB against the leds-gpio DT bindings
> > by running:
> >
> >     make dtbs_check
> > DT_SCHEMA_FILES=Documentation/devicetree/bindings/leds/leds-gpio.yaml
> >
> > Background info for CCed parties:
> >
> https://lore.kernel.org/linux-arm-kernel/20210316150033.15987-1-cnsztl@gmail.com/
>
> I don't care much either way, lan-0 is okay as is lan-led.
>
> but...
>
> +                       label = "nanopi-r4s:green:lan";
> +                       label = "nanopi-r4s:red:sys";
> +                       label = "nanopi-r4s:green:wan";
>
>
> It would be good to have common labels, that means LED_FUNCTION_LAN,
> LED_FUNCTION_WAN, and figuring out something better than "sys",
> possibly LED_FUNCTION_FAULT?

LED_FUNCTION_POWER for "sys" would be fine, I think.

However, Documentation/leds/leds-class.rst says the form of naming is
"devicename:color:function",
and according to the given examples, as well as other dts(i), would it
be okay to use `green:lan`
etc. as the lable?

>
> Thanks,
>                                                                 Pavel
>
> --
> http://www.livejournal.com/~pavelmachek

Thanks,
Tianling.

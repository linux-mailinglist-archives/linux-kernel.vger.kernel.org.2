Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452CB36B1B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhDZKkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhDZKj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:39:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9EAC061574;
        Mon, 26 Apr 2021 03:39:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r128so60549943lff.4;
        Mon, 26 Apr 2021 03:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hiUwGg544H+HpznYYXJv68XSHdlUYpy5D+8CQkUlj0U=;
        b=qNnxpBlS2UY6t+013G1lfx4Z4IYDbYK1qSBayYhJ0rWUUigAidudrl5Hao04sR4Qiv
         2tEuDkxpY1D5hWmx/f7npFZA068qtEZu0VIWMt6BXlHiWEOTM8yO7GP50o77cZTiI5cB
         Vrc0WHumBQJjSRbu8dt98YxMdrj+iYGYbxE7C5PApceYxB4+E85yisYG6LkXFcVQVYZ8
         JfYnvXuX7vCP+Hnd54uOblrUUzo1g2ZA6RTcVDnvod47+VblmU+z2w7TKkdAbRxxXLf2
         4VtIWm7DPP9pURGmWKr/VQUdGiLxPuGD+47yra9ZQj3X3TgjRDG4ugE/qtcynceWHBaQ
         517A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hiUwGg544H+HpznYYXJv68XSHdlUYpy5D+8CQkUlj0U=;
        b=mqm1+pE6ATGEaCF8zR47DL3waJNb5ntLXpGEHewW7+YtxB8a4TfdT7Gsjr/FjM1vXQ
         EoT4GwaFTNmc575atqyTkxEcoy6qy5WFrybAR7KV62yDBbz6G7CYt/V8nR+YSxRW4D7c
         zKs8+9D9s+DrxCs7Z3uhpyrLzHbO2DLeMvsvzK71ttDs0Z155I34FS9cCHacTGDaJmrZ
         Ln2b3qSa6nemHnUTCZI4EnwdlUkty+HJE+ySB6w787gRfmnbgSK63eAemSpLuDVlTALV
         wDSJgHYbyD1OtJPl0NuOM4VY6gR/U1/6UlnrdGxRKOca8jTcLe/73KorWkKkeAVauX/B
         pBAw==
X-Gm-Message-State: AOAM530ZBDzygfFYepQR9A2MVrnvC6fOvL+trYuCibhwsshRTarWbGUC
        mQojy79rVBFwZ9iEefHnSyBUw9n/k1iNrYfvWqc=
X-Google-Smtp-Source: ABdhPJxP0wgBv+BXU3aQlZWWWwAZg71hs0fFXOXF55vd+8peBeYGKvnojsRq/fmLNFf2geu6+Mge6SXeoEzR5mf+kHA=
X-Received: by 2002:a19:b81:: with SMTP id 123mr12252945lfl.553.1619433553826;
 Mon, 26 Apr 2021 03:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210319051627.814-1-cnsztl@gmail.com> <161640742725.808893.3666594351389773587.b4-ty@sntech.de>
 <20210425213321.GF10996@amd>
In-Reply-To: <20210425213321.GF10996@amd>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Mon, 26 Apr 2021 18:39:03 +0800
Message-ID: <CAOP2_ThcRMkgSm872q2By=gALoK-qAjq92FtNQkDO999pZR8kg@mail.gmail.com>
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

Hi Pavel,

On Mon, Apr 26, 2021 at 5:33 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > Changes in v6:
> > > - Fixed format of LED nodes
> > >
> > > Changes in v5:
> > > - Dropped the empty PCIe node
> > > - Dropped useless `/delete-property/`
> > > - Renamed LED nodes
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
> >       commit: 1003888415e83e15ddb63d1d96189b4f2c5f1d48
> > [2/2] rockchip: rk3399: Add support for FriendlyARM NanoPi R4S
> >       commit: db792e9adbf85ffc9d6b0b060ac3c8e3148c8992
>
> Sorry for late review, but:
>
>
> +                       label = "red:sys";
>
> This should be red:power based on the discussion in earlier threads.

However based on the introduction from FriendlyELEC[1], this is not
the "power" lamp...
"LEDs: 1 x power LED and 3 x GPIO Controlled LED (SYS, LAN, WAN)"

1. https://wiki.friendlyarm.com/wiki/index.php/NanoPi_R4S#Hardware_Spec

Thanks,
Tianling.

>
> Thanks,
>                                                                         Pavel
> --
> http://www.livejournal.com/~pavelmachek

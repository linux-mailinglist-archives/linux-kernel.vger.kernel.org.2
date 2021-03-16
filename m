Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0278433D996
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbhCPQjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbhCPQi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:38:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E27C06174A;
        Tue, 16 Mar 2021 09:38:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k9so63434295lfo.12;
        Tue, 16 Mar 2021 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HavWasjxV9NQ1oI4iDdWCtYqPVYFm4z7qKSkYjITAbU=;
        b=I6yNUVH/2EruY7ZLi2CzCRDe4KA1Ei1x7yCHvFlZImPsmyOwJSzqSUMvidbSIQHZ5C
         R+vzT0NWXTG7wmaER0xMugBaTZzSMpnFsd/X4Vyp0wr9vPXsURfLOQZrufspTFVK483M
         NJ7AYjafaVs3bAotWjP97ntjTWKKRAzoZSF2V/GU6qOqcgewa+fuXuwoTxgLH84XJhvp
         PAdDAtN8dNRUlIcOopu15y0FewGtcCaZjlOjarmAHxrQGJSdK2dir57pHVhI1wWXZ7st
         VNuoAhRuXNdVJDCSXYjoAr1SOvxZyQzcjVDwk1fffR5ZR4Tx+EJkLWyOm69m4rmLAlAt
         +cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HavWasjxV9NQ1oI4iDdWCtYqPVYFm4z7qKSkYjITAbU=;
        b=YG2i+jzfmvChRwtBQ05z0dXvqiF9ADTNKXmzMAfiuMVuBd+xmMI1tMCPWJymbOSbxs
         sWLYUy5CR5o3FKOF+46LvJ7vwEFY+MxoV75mCEky5qOjJbO4diKkVbsokzn7uPEwrLMJ
         njDutPZYOh16ofpobp33OPce9t87+QdZ5KgoTXmV4u5MBHMUwbvmMwTeBwq0ZK63Mlzk
         Y3KkTZ/XQ3eMvzjuITOzIZJmzqQqH5XqoemBD14v1UZtV95yipm7eU+a7MvlVxFpZVPI
         Cz28n+AoGhHeo8qZ/xYaQN3K5bhQKzZN17iFnon+pluiFrJFvprtXzjy6jB+3T/ADL18
         vqEg==
X-Gm-Message-State: AOAM532qXpB3g06SUIvPwhEe6ZoSnLC130MYRDCuCbpUoCc9Zvgi+LYj
        GXCGvBi9/R6MFeoO3/Bu4pSJRINs7zW244k+NoI=
X-Google-Smtp-Source: ABdhPJw4u+xt7+sbHoua05Z3aaUK0a22EuFY82JHHu0pg1Wc73HeDFvQhMj7MCdPu36LP//hg7Uby0M6MugcoHoFxFY=
X-Received: by 2002:a05:6512:ad3:: with SMTP id n19mr11974682lfu.328.1615912735697;
 Tue, 16 Mar 2021 09:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdWYrS=YT7F7erM-e6xhDME4judx-T7rdFGi7CpW1_iqkg@mail.gmail.com>
 <20210316150033.15987-1-cnsztl@gmail.com> <CAMuHMdU+agaOdf4hQhn5JQDHCbuWm3dETJu01baxfDAY=nikow@mail.gmail.com>
In-Reply-To: <CAMuHMdU+agaOdf4hQhn5JQDHCbuWm3dETJu01baxfDAY=nikow@mail.gmail.com>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Wed, 17 Mar 2021 00:38:43 +0800
Message-ID: <CAOP2_TheFHfPZYXm0jYV-a-FOudtqFXmTxDi_pb+_Yt5E_W2YA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rockchip: rk3399: Add support for FriendlyARM
 NanoPi R4S
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
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
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-16 11:35, Geert Uytterhoeven <geert@linux-m68k.org> wrote=EF=BC=
=9A
>
> Hi Tianling,
>
> CC Jacek, Pavel
>
> On Tue, Mar 16, 2021 at 4:00 PM Tianling Shen <cnsztl@gmail.com> wrote:
> > On 2021-03-16 02:23 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > Personally, I'm not so fond of the <foo>-%u node names, and prefer
> > > <foo>-<function>.  With the former, it's way too easy to have a silen=
t
> > > override in your .dts(i) stack.
> > > Cfr. commit 45f5d5a9e34d3fe4 ("arm64: dts: renesas: r8a77995: draak:
> > > Fix backlight regulator name")
> >
> > How about using `lan-led`, `sys-led` and `wan-led` here?
>
> Documentation/devicetree/bindings/leds/leds-gpio.yaml says "led-%u"
> is the preferred form, but that anything containing "led" as a substring
> is accepted.  So I'd go for "led-lan" etc.
>
> BTW, you can validate your DTB against the leds-gpio DT bindings
> by running:
>
>     make dtbs_check
> DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/leds/leds-gpio.yaml
>

Thank you so much!
I renamed them to `led-lan` etc., and the result of dtbs_check seems fine.

> Background info for CCed parties:
> https://lore.kernel.org/linux-arm-kernel/20210316150033.15987-1-cnsztl@gm=
ail.com/
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

Tianling.

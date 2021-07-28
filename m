Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8663D89AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhG1IV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:21:58 -0400
Received: from mail-vk1-f170.google.com ([209.85.221.170]:38511 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbhG1IV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:21:56 -0400
Received: by mail-vk1-f170.google.com with SMTP id k124so292056vke.5;
        Wed, 28 Jul 2021 01:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yoCkO99kgbo6iNFJCPB9hwYY0ETTMuSEc015zhPeQ4=;
        b=CSUQ6Xp7MIiYiOyLeV7ehqUdlgFDWK/mpfAABiu4C1feiK7W4yI8tg0nbgOO5LQLsP
         rtzu5ztlEBpJe/CG5b78/8bUDCOjrbXAuwimR3Qa3gqei6AqP6XPRwTJQrssyU1vEbi+
         NwV0TNVoFcFVCvKW0Qa6AZlIatoqgM9kaLuwjuLYZom1rFq1taf4tGX7/G9L+g3Y6KBR
         2Fl+IvJTNgJSn+PTgTE5itA5vFkRUcwT5UJv132PKqVrn85IyZ88TNyc2xW2OkKGt6Hb
         L/XyP8+TvdcPSI1jAnCg4Ewelnbmf6IigFjQP0BUNXliK29Xk6xfoakMrpWVVMFbz7WI
         OTNw==
X-Gm-Message-State: AOAM531HvRqOSDt+cAUgC3i1xEYUuBCVEzxIzo6VEu6qmYaisXootOZt
        OLQQl3JRc7lZd6yivHLqVCa+BPZk3hCqZFYNyUI=
X-Google-Smtp-Source: ABdhPJyWBoWEgvEHaDFhVnRanGUz34OpgjBijFlUQxzQqRUc/jAO3Nsk1dj3Typp58sDq4dVptKaRYsggixkhO8G7Mk=
X-Received: by 2002:ac5:c956:: with SMTP id s22mr17928824vkm.2.1627460514192;
 Wed, 28 Jul 2021 01:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <61002766.1c69fb81.8f53.9f6a@mx.google.com> <c52f6cfb-1316-dd6a-46fa-17abfcc4bf18@collabora.com>
 <CAMuHMdUi_=xnvYFgiWXxSyrfoMn0JJCcH+TXFUh+1JUf=4u87A@mail.gmail.com>
In-Reply-To: <CAMuHMdUi_=xnvYFgiWXxSyrfoMn0JJCcH+TXFUh+1JUf=4u87A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Jul 2021 10:21:43 +0200
Message-ID: <CAMuHMdW4iyRTxuhjhAEpaHfD=Y8_nUF0Cv+A_H=ci5Je_dC-Hw@mail.gmail.com>
Subject: Re: renesas/master bisection: baseline-nfs.bootrr.rockchip-usb2phy0-probed
 on rk3399-gru-kevin
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     kernelci-results@groups.io, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maciej Matuszczyk <maccraft123mc@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Cameron Nemo <cnemo@tutanota.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Helen Koike <helen.koike@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC kernelci@groups.io
dropped kernelci-reports@groups.io ("500 This message has been flagged as spam")
dropped Jacob ("550 jacob2.chen@rock-chips.com:user not exist")

On Wed, Jul 28, 2021 at 10:17 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Guillaume et al,
>
> On Wed, Jul 28, 2021 at 8:05 AM Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
> > Please see the bisection report below about usb2phy failing to
> > probe on rk3399-gru-kevin.
> >
> > Reports aren't automatically sent to the public while we're
> > trialing new bisection features on kernelci.org but this one
> > looks valid.
>
> Thanks for your report!
>
> > The bisection was run in the Renesas tree but the same regression
> > is present in mainline for both usb2phy0 and usb2phy1 devices:
>
> Exactly, the faulty commit is part of v5.14-rc1.
>
> > > Breaking commit found:
> > >
> > > -------------------------------------------------------------------------------
> > > commit 8c3d64251ac5c5a3d10364f6b07d3603ac1e7b4a
> > > Author: Johan Jonker <jbx6244@gmail.com>
> > > Date:   Tue Jun 1 18:47:59 2021 +0200
> > >
> > >     arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
>
> P.S. KernelCI is sending lots of reports to linux-reneas-soc[1] for
>      (a) issues on non-Renesas platforms[2], and
>      (b) issues not originating in the renesas-devel tree, like this one.
>
> Suggestions for improvement:
>   1. If a regression is detected in an upstream tree, there is no
>      need to report it for downstream trees, unless it affects
>      the downstream tree, or originated there.
>   2. If a regression is detected for a platform, there is no need
>      to report it for different platform trees, unless it originated
>      there.
>
> BTW, I do look at the reports for Renesas platforms, but usually I
> don't see what's wrong, and the same platform works fine locally.
> Note that yesterday and today I get "Error while loading data from the
> server (error code: 500). Please contact the website administrator".
>
> Thanks!
>
> [1] https://lore.kernel.org/linux-renesas-soc/?q=kernelci.org
> [2] https://lore.kernel.org/linux-renesas-soc/60ff86ff.1c69fb81.dfe6f.6a7c@mx.google.com/
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

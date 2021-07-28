Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E17E3D89A1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhG1ISO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:18:14 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:38883 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbhG1ISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:18:08 -0400
Received: by mail-vs1-f51.google.com with SMTP id x21so950333vsx.5;
        Wed, 28 Jul 2021 01:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwCU+Eu84DnWRK3vkj89T+ZL/Mh4GvPua6wFwjOjcMQ=;
        b=Nc5BrZu+HASwsIlLVDroce3So7A4j8lx7uC28e/Qubm5tAxrW1Rp/j4Fg3MkY0bIfV
         Zw1FuzJVtdasJSABDMeBKFkdaMGljME68o8iSbcT1u+NuFCNCUVtXSCTQn4ka0E4LL/K
         80IJSXNNXF7ERGFQDO9xynKBRJmTywU+iVtcii6fVzhndy2RROUkWvQH5Afwnux4+OhV
         PpPHwsdl6IH3EkwGaQHLeU7BVjlCxz0iGSmH4IB2ypb9dp4sgnANe7kerzbp0u2ByEU0
         chQTsRrMUDYPV4kUjEja0icDzgujwhaDp6NmjV8YvnbO6UEfIomNaeA3HGMFG7uOUGaH
         ECtw==
X-Gm-Message-State: AOAM533mVm6IYG5ub0QEZoVxiUOYxTeqkWdRSLejFQxT/ya3+ZEyAV12
        D9XndMe4QWfWoWUKpcG0IFT7+L8oG/j9c2rLJ/s=
X-Google-Smtp-Source: ABdhPJwIUDsII3SejHJxzSmk/bkhxl9Icb17oXkKmflZ21Vn7HvK9bBU3SyX+qWPcfBcMDNw4EsmYdKyyp+F3yDWtrM=
X-Received: by 2002:a05:6102:4a3:: with SMTP id r3mr9332291vsa.42.1627460286189;
 Wed, 28 Jul 2021 01:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <61002766.1c69fb81.8f53.9f6a@mx.google.com> <c52f6cfb-1316-dd6a-46fa-17abfcc4bf18@collabora.com>
In-Reply-To: <c52f6cfb-1316-dd6a-46fa-17abfcc4bf18@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Jul 2021 10:17:55 +0200
Message-ID: <CAMuHMdUi_=xnvYFgiWXxSyrfoMn0JJCcH+TXFUh+1JUf=4u87A@mail.gmail.com>
Subject: Re: renesas/master bisection: baseline-nfs.bootrr.rockchip-usb2phy0-probed
 on rk3399-gru-kevin
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     kernelci-results@groups.io, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maciej Matuszczyk <maccraft123mc@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
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

Hi Guillaume et al,

On Wed, Jul 28, 2021 at 8:05 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
> Please see the bisection report below about usb2phy failing to
> probe on rk3399-gru-kevin.
>
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.

Thanks for your report!

> The bisection was run in the Renesas tree but the same regression
> is present in mainline for both usb2phy0 and usb2phy1 devices:

Exactly, the faulty commit is part of v5.14-rc1.

> > Breaking commit found:
> >
> > -------------------------------------------------------------------------------
> > commit 8c3d64251ac5c5a3d10364f6b07d3603ac1e7b4a
> > Author: Johan Jonker <jbx6244@gmail.com>
> > Date:   Tue Jun 1 18:47:59 2021 +0200
> >
> >     arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2

P.S. KernelCI is sending lots of reports to linux-reneas-soc[1] for
     (a) issues on non-Renesas platforms[2], and
     (b) issues not originating in the renesas-devel tree, like this one.

Suggestions for improvement:
  1. If a regression is detected in an upstream tree, there is no
     need to report it for downstream trees, unless it affects
     the downstream tree, or originated there.
  2. If a regression is detected for a platform, there is no need
     to report it for different platform trees, unless it originated
     there.

BTW, I do look at the reports for Renesas platforms, but usually I
don't see what's wrong, and the same platform works fine locally.
Note that yesterday and today I get "Error while loading data from the
server (error code: 500). Please contact the website administrator".

Thanks!

[1] https://lore.kernel.org/linux-renesas-soc/?q=kernelci.org
[2] https://lore.kernel.org/linux-renesas-soc/60ff86ff.1c69fb81.dfe6f.6a7c@mx.google.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

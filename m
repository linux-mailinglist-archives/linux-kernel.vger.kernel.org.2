Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C3F3D1FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 10:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhGVHzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 03:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 03:55:00 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0F2C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 01:35:35 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id x192so7178718ybe.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KllKHw6d+WPSOXpmvy15856ZmrjGsxW2iASdgvJx0nE=;
        b=IddLDRIXkQ8kAFb2rpcmLJS7qqi7RmdEnwI9rN3QPJguzsqXl5MXdswc1RQ7/MtkCQ
         YZQZ0XYxJo8WbCzaOsIsn4f/oYB5fNwqpqgmrJrSpnnAFhJ9nn75BnPGnUVYNxSDKts0
         OHyBUaqtV0BF9gXsqPoG6YL3QzF+Y9FuZsq7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KllKHw6d+WPSOXpmvy15856ZmrjGsxW2iASdgvJx0nE=;
        b=bSflgCq8Qgr9l8u9er37WPtg9VCMXWXsRXyvW0pPHwbXOg0wNe2FZbSSSF2FIrBpi4
         eUVshoJQ92S+VPzFmhp9vhUGtfoAGFrNCLvBfAzXSvcOSxpRBk3l6p2pJj1htAPUtomv
         gpXWRjdl9pzZJd1yDECuUMEiYmh7NSdJySOquuFpjtQAMdKpRYX4Io4fmpLLrjYmQNtC
         JeGBai1rNBxsKw6zLHxMV39Nuv2Wnp/LWWwJ2m9m/xsCMHi1JeXzKsN0Jma+yniTi886
         naiZTT6pLo1NFGQXviVuC1CgpPyLt/ziaETecexy9Fnz8NUv/p5kzJW6RcKtUHjabnrd
         RbzA==
X-Gm-Message-State: AOAM533sFFsJRTcmcLriqDQgDH00uhH9aIJIUe3G7TYKUIsqH3y5VhmC
        jg/thrCV+F8AVXN0TTsC9Hsl6YgB4YctuQMR0UQV
X-Google-Smtp-Source: ABdhPJyLR7b0ZrhBWqk7asdINPvehj9f9K1NUxr0+x/0+EepcQ/CJdz9tdgPDIjR+LSRsU2sVJTkGvqTuxlqCrijzzo=
X-Received: by 2002:a05:6902:1142:: with SMTP id p2mr48483545ybu.147.1626942934542;
 Thu, 22 Jul 2021 01:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <87bl6yrcmd.fsf@igel.home> <mhng-e14c3232-cc4d-4146-8c93-c60ec81ed272@palmerdabbelt-glaptop>
In-Reply-To: <mhng-e14c3232-cc4d-4146-8c93-c60ec81ed272@palmerdabbelt-glaptop>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 22 Jul 2021 01:35:23 -0700
Message-ID: <CAOnJCU+Ss0cO1mqr=GDVnpxV075uR+KipSnr7dN93099dAH+vQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] riscv: add VMAP_STACK overflow detection
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, tongtiangen@huawei.com,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 11:12 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 19 Jul 2021 00:23:06 PDT (-0700), schwab@linux-m68k.org wrote:
> > On Jul 19 2021, tongtiangen wrote:
> >
> >> On 2021/7/17 14:55, Andreas Schwab wrote:
> >>> Please use
> >>> https://download.opensuse.org/repositories/home:/Andreas_Schwab:/riscv:/jeos/images/openSUSE-Tumbleweed-RISC-V-JeOS-efi.riscv64.raw.xz
> >>> and run it in qemu with u-boot as kernel.
> >>>
> >>> Andreas.
> >>>
> >>
> >> Hi andreas:
> >> I used today's latest mainline code and .config provided by you, and I
> >> can't reproduce this panic.
> >
> > Did you test it like I said above?
> >
> > Andreas.
>
> I'm getting this on and off, with just
>
> CONFIG_VMAP_STACK=y
>
> on top of defconfig, when running on QEMU.  It's not showing up right
> now: I'd thought it was an issue with that initrd patch, but it went
> away when I re-ran the tests so I'm guessing it's something
> non-deterministic.  I'll try to take a look if it comes back.
>

I got it very frequently on beagleV with the following branch & config.
https://github.com/esmil/linux/commits/beaglev

beaglev_defconfig

Disabling CONFIG_VMAP_STACK avoids the crash.

> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish

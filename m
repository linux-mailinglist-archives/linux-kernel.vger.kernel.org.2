Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B9B34010E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhCRId3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCRIdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:33:04 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4EBC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:33:03 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f124so1203074qkj.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iEev52rWGRb+H14tkihKM80QH51NH2IA18V5Wly4ffE=;
        b=GOZ4AHjvee8ebwihZyOxSoVyL1VXcoIY7SrqjQ3fGJ2psoj+OKQGpk2oGcMVpRoc/M
         m3kagdaoTzyKEkjESDCbIr6NxxVYvq2YMP0jQxxs4fDVZi2jOfYtUjD0E3dPb7t08gJu
         HUFxeBeu8iwUKOeJfZGW9z9gTckIxNyCNjtHhO9pdMEBpURzHafcyby/MBMPvMrnHHI/
         dVLAK4t2AXYx7vM53A205RBi5Hz0MXYgHsXBmaKVIuTyASKbdUIBEbD1nv14ZTnkIfnB
         ncTXV2liC/A73r4oimNS466wHa0IfGmDuEisub7nXLEBri1s8Lo4fUl1b+knRd7HfgYj
         Zr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iEev52rWGRb+H14tkihKM80QH51NH2IA18V5Wly4ffE=;
        b=ildbcEiBiCiO+tLds4vcmmsh0MBtIKPAlQBfaqxIGRv3VQaz8+4gRIFbEkzqp4mZou
         u3YT5ztJ7gbqT1mUgfzZozInoB5A8T6Fr9ba0V/M37uJto0Lrc4MQd2o2XaLb1+H+1I8
         N0fIlY6bAkp+6TkwhZeyDue5v1ZvFIeT6iPO1mRjwnSlv+i+yuHKJHFQKph47s3l7HNx
         oE4WQ4YPJTY0R/P0l6wZNxv/ByntWdta0b6R9TVRkTkIMPL/psiAZ4g6hKR1n7UVcjg8
         OhlcKj10WKtQgJtaCrDrA5aujXazQhVtGgr7mlj1nLyfeajdS0VY+XYtJnK6w95MtZtK
         ydgg==
X-Gm-Message-State: AOAM532UY6OQWXhKGSDP/RzXYTrGPlh8b7q11naPM19fYR8PseYXbZYx
        83mgA8WUm9jLx4JKU4WVNL3CUWMFKt+nZZXpdqqXdw==
X-Google-Smtp-Source: ABdhPJyd/l1rc1ltx2W/w7dBCyPt70y35W4uD9UlIH5yNvw16G2OdFapDJ1ECXfO7EZfdXJ4nRKHYmnERa+cnUybbQ0=
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr3042928qkx.501.1616056382595;
 Thu, 18 Mar 2021 01:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <20210311123315.GF37303@C02TD0UTHF1T.local> <CACT4Y+ZPO7D1hGHZvuBQ52Vy2W7UUSW+YFE-Ax6-NMDnmrKTBA@mail.gmail.com>
 <20210317184538.GB2508@C02TD0UTHF1T.local>
In-Reply-To: <20210317184538.GB2508@C02TD0UTHF1T.local>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 18 Mar 2021 09:32:51 +0100
Message-ID: <CACT4Y+ZEfd2PeKaCTfg=LaHgQga+6c_Wz4BObkRDvW-AM2_aLg@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 7:45 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Mar 11, 2021 at 05:56:46PM +0100, Dmitry Vyukov wrote:
> > On Thu, Mar 11, 2021 at 1:33 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > FWIW, I keep my fuzzing config fragment in my fuzzing/* branches on
> > > git.kernel.org, and for comparison my fragment for v5.12-rc1 is:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=fuzzing/5.12-rc1&id=6d9f7f8a2514fe882823fadbe7478228f71d7ab1
> > >
> > > ... I'm not sure whether there's anything in that which is novel to you.
> >
> > Hi Mark,
> >
> > I've learned about DEBUG_TIMEKEEPING which we had disabled. I am enabling it.
> > We also have CONTEXT_TRACKING_FORCE disabled. I don't completely
> > understand what it's doing. Is it also "more debug checks" type of
> > config?
>
> Context tracking tracks user<->kernel transitions, and tries to disable
> RCU when it is not needed (e.g. while a CPU is in usersspace), to avoid
> the need to perturb that CPU with IPIs and so on. Normally this is not
> enabled unless CPUs are set aside for NOHZ usage, as there's some
> expense in doing this tracking. I haven't measured how expensive it is
> in practice.
>
> CONTEXT_TRACKING_FORCE enables that tracking regardless of whether any
> CPUs are set aside for NOHZ usage, and makes it easier to find bugs in
> that tracking code, or where it is not being used correctly (e.g. missed
> calls, or called in the wrong places).
>
> I added it to my debug fragment back when I fixed the arm64 entry code
> accounting for lockdep, and I keep it around to make sure that we don't
> accidentally regress any of that.

Looks like a debug config we should enable on syzbot. I am enabling it in:
https://github.com/google/syzkaller/pull/2500/commits/8ebea47133e458293e3c71e1189e18052286393d
Thanks

> > FWIW we have more debug configs:
> > https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/debug.yml
> > https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/base.yml
> > https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/kasan.yml
> > https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/kmemleak.yml

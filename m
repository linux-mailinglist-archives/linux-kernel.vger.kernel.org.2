Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C616D3A80FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhFONnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhFONm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:42:56 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1548C061148
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:40:21 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id c8so18843729ybq.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bninJQzLYLiLyEZnoHibEA952wacAzi8eRw8B/sbgM=;
        b=tkEyXCty7/BpQtj1Wvr1kO/TdoIz6mfhYnF3xuyQct2w+VqmXOP2h3PVtbFkvEUcvb
         bT0GUBP3kcNDI9NxSzrz7jhTknQeri8H8fYo0+dqQekekc+gwvf1M2HFQOO3pnv83FGw
         wA1rrCc7UrQITnD2vSl2xlSpIkopCWvSQVXdmR3LNBGl23pl3ZHknYF2wZqH55CFKKpN
         fn2q2NOfgfw15qtqduaa89gLfbMN08bddIqkh0LLWBLve0GnyBURHAocpQCdIowF0GIl
         AnoIB3AvOL7h53cZNkrvY45oe8pVJBD1L1O1mutkMLc8f3miUh6E7TGtZpuCeBX37dN4
         dRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bninJQzLYLiLyEZnoHibEA952wacAzi8eRw8B/sbgM=;
        b=D/cw8YvCU4R+qy6pQyOg3bONg49vFASSBwTy9Fkhs9HchcTM+lJvoSbkCa0uKEte3N
         +yEGhrycDspnK5Uxyr0dOdrV+mzRrXhG+YAQ7EvBZvsSXesRT6WeWquonDmG+q9yqR1i
         NV1xIDptjV5zWTgEBh57LmlWVB20xXH99JghGAUL5ty75++GaEJFQ0uhxxL/CeHJmfNG
         EvFeWRgFdHfJ6ob6dVS0r7pYGUe5kUGqnRW7WWYk7CXyQzaS6h+1B3NJO3ffFLY4FNwk
         tNm+WYeV8y/Tr3oJ2XCXV73WbvxIjp52Ii8MqgmuyCZqK8wfHfpGKsT95jCPoeTSi4y5
         X+nQ==
X-Gm-Message-State: AOAM531k5c5avregspR+ukhbS63ea2uxH0pAnXUhdWnFt5VqLOIY7Fe3
        6MfKDAEAQ77+I8hSBcyAL1GZd/rD1/yLCgGXaaE=
X-Google-Smtp-Source: ABdhPJyTm2ZJXQyVMUO7d5Y5CMDVt9qLpiRiCe7z8HVFKMkCu1YnhvD6pp2syW7qpbTCcJlgi7aCj5QHIIb3vk3ptiI=
X-Received: by 2002:a25:b701:: with SMTP id t1mr22019966ybj.517.1623764421204;
 Tue, 15 Jun 2021 06:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210522232256.00003f08@garyguo.net> <mhng-fdda10f7-fc83-4654-a0b2-e9c86b92c37e@palmerdabbelt-glaptop>
 <17637b10e71b41b89126cbb1b2fa61cf@AcuMS.aculab.com> <20210525153431.0000508d@garyguo.net>
In-Reply-To: <20210525153431.0000508d@garyguo.net>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 15 Jun 2021 21:40:10 +0800
Message-ID: <CAEUhbmXvYdVSsY3oH=XdyT2fOC1X9=-Rh0P1Q5TP1DcmzFfRrQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix memmove and optimise memcpy when misalign
To:     Gary Guo <gary@garyguo.net>
Cc:     David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "nylon7@andestech.com" <nylon7@andestech.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 10:37 PM Gary Guo <gary@garyguo.net> wrote:
>
> On Sun, 23 May 2021 17:12:23 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
>
> > From: Palmer Dabbelt
> > > Sent: 23 May 2021 02:47
> > ...
> > > IMO the right way to go here is to just move to C-based string
> > > routines, at least until we get to the point where we're seriously
> > > optimizing for specific processors.  We went with the C-based
> > > string rountines in glibc as part of the upstreaming process and
> > > found only some small performance differences when compared to the
> > > hand-written assembly, and they're way easier to maintain.
>
> I prefer C versions as well, and actually before commit 04091d6 we are
> indeed using the generic C version. The issue is that 04091d6
> introduces an assembly version that's very broken. It does not offer
> and performance improvement to the C version, and breaks all processors
> without hardware misalignment support (yes, firmware is expected to
> trap and handle these, but they are painfully slow).
>
> I noticed the issue because I ran Linux on my own firmware and found
> that kernel couldn't boot. I didn't implement misalignment emulation at
> that time (and just send the trap to the supervisor).

Similarly, I noticed exactly the same issue as what you saw on
mainline U-Boot SPL that it suddenly does not boot on SiFive
Unleashed. Bisect leads to the commit that brought the kernel buggy
assembly mem* version into U-Boot.

> Because 04091d6 is accepted, my assumption is that we need an assembly
> version.

That's my understanding as well. I thought kernel folks prefer
hand-written assembly over pure C :)

> So I spent some time writing, testing and optimising the assembly.

Thank you for the fix!

>
> > >
> > > IIRC Linux only has trivial C string routines in lib, I think the
> > > best way to go about that would be to higher performance versions
> > > in there. That will allow other ports to use them.
> >
> > I certainly wonder how much benefit these massively unrolled
> > loops have on modern superscaler processors - especially those
> > with any form of 'out of order' execution.
> >
> > It is often easy to write assembler where all the loop
> > control instructions happen in parallel with the memory
> > accesses - which cannot be avoided.
> > Loop unrolling is so 1970s.
> >
> > Sometimes you need to unroll once.
> > And maybe interleave the loads and stores.
> > But after that you can just be trashing the i-cache.
>
> I didn't introduce the loop unrolling though. The loop unrolled
> assembly is there before this patch, and I didn't even change the
> unroll factor. I only added a path to handle misaligned case.
>
> There are a lot of diffs because I did made some changes to the
> register allocation so that the code is more optimal. I also made a few
> cleanups and added a few comments. It might be easier to review if you
> apply the patch locally and just look at the file.

I would vote to apply this patch, unless we wanted to do "git revert
04091d6", but that would break KASAN I guess?

Regards,
Bin

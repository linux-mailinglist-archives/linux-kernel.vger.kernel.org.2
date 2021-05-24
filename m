Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF3838F3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 21:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhEXTeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 15:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbhEXTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 15:34:19 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCEBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 12:32:50 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id w206so7933078ybg.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYka7qvCrcJU8Em4l3NhmhKnLm9g5PqEfLQWSjQZDlQ=;
        b=LofD4uMbAUk7pk2j9vx3bE4G1qAfo7dILNxp8FLk+PWXy8N6gQCaZcxJ3681iuFoxJ
         mV8XB6rd+p8VRvXkb+93kEXhqb9R3t/3vzadFkIeqxPpAFpXQfIjFrUnEwubdSMBDCSW
         L8N2MQ6RI695HawGT/Zwp1C6iiJnrjpA+xqk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYka7qvCrcJU8Em4l3NhmhKnLm9g5PqEfLQWSjQZDlQ=;
        b=qe8Icxu1Y0IOaq1I3g5OsJIU9/cbmawCFzqTXd0+x2q6Yp1bwRoplwoTFnqcKuQsNA
         2mZzl0hyuZPz08ADo4+mYWHBUWjpKOppQGKyyhZZX+CkcOHJsUT2gI/BYcY1lq0aLdCn
         PjNt0oqj581G6l50i2S1GpdEiWwAs687aVbnMaDAFhCKBq5i9deFw/O+qlVp5SIFzGao
         PSfcHU1cVOHFJWMnF/MCQxSHgz7oFWb7PE2ucYznF5jpS4OAZylo4xTodiyaQgvEnPyb
         1YJEZpRPQacIngoZcxmiD9K5OACdRa7RKtdgmZ8Er8oG62TOzbjrTtbIGqO+5hOd3ALU
         U1aQ==
X-Gm-Message-State: AOAM5305M/eP0+P30pr5s+dm+kehwxI8mnpbegOk9+0arUs7hXNQO8SA
        VKT2kTAkX7DGM5LN+4FzjjoCHhKeTVxroG1mSFpeUTHZ78Q=
X-Google-Smtp-Source: ABdhPJxdsQHMvsH4dno8sUybs/q+RK8dePva6brNnXtbhDmlmG1HKJnI7SaPIO7icqB4Xl7KP0cqbtrsD3H5MSemmEY=
X-Received: by 2002:a25:7745:: with SMTP id s66mr17955046ybc.302.1621884769648;
 Mon, 24 May 2021 12:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAM4kBBJqF=AxTu50PF=EshLSyqn0=yeC2dwf4JJj_Grsi_Tccg@mail.gmail.com>
 <mhng-1c10179a-d96b-4cf1-860a-03f0313ac980@palmerdabbelt-glaptop>
In-Reply-To: <mhng-1c10179a-d96b-4cf1-860a-03f0313ac980@palmerdabbelt-glaptop>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Mon, 24 May 2021 21:32:38 +0200
Message-ID: <CAM4kBBK1BJSE-LeDiEJL-z+tgZMi6Zcb+6AnnQiB8ceaU98k0w@mail.gmail.com>
Subject: Re: [PATCH] riscv: code patching only works on !XIP_KERNEL
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 7:15 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 10 May 2021 11:19:30 PDT (-0700), vitaly.wool@konsulko.com wrote:
> > On Mon, May 10, 2021 at 6:35 PM Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
> >>
> >> From: Jisheng Zhang <jszhang@kernel.org>
> >>
> >> Some features which need code patching such as KPROBES, DYNAMIC_FTRACE
> >> KGDB can only work on !XIP_KERNEL. Add dependencies for these features
> >> that rely on code patching.
> >
> > Since we can define extra RW sections to place some tiny code bits in
> > RAM, I would suggest that you hold back this patch for a while.
> > I am not going to support the idea of e. g. compiling KGDB support
> > into a XIP kernel, but disabling the whole HAVE_ARCH_JUMP_LABEL is
> > hardly the way to go.
>
> Do you have any updates on this?  The SOC_SIFIVE disable thread floated
> back to the top of my inbox and I didn't see anything there.  I'd prefer
> to avoid chasing around Kconfig disables for a bunch of stuff that we're
> just going to fix soon, but if this is going to be a big change then
> it's likely for next cycle anyway so in that case I'll start picking up
> these compile disable patches.

Sorry, was caught up in fixing other stuff but now I'm on it so expect
some updates soon.

Best regards,
   Vitaly

> Not trying to rush any thing here, just don't want to have a bunch of
> broken configs.
>
> >
> > Best regards,
> >    Vitaly
> >
> >> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> >> ---
> >> Hi,
> >>
> >> Currently, the RISCV_ERRATA_ALTERNATIVE also only works on !XIP_KERNEL
> >> but from the maillist it seem there's effort to make the co-exist, so
> >> I drop RISCV_ERRATA_ALTERNATIVE dependency on !XIP_KERNEL.
> >>
> >> Thanks
> >>
> >>  arch/riscv/Kconfig | 18 +++++++++---------
> >>  1 file changed, 9 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> index a8ad8eb76120..61320b94ef97 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -60,11 +60,11 @@ config RISCV
> >>         select GENERIC_TIME_VSYSCALL if MMU && 64BIT
> >>         select HANDLE_DOMAIN_IRQ
> >>         select HAVE_ARCH_AUDITSYSCALL
> >> -       select HAVE_ARCH_JUMP_LABEL
> >> -       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> >> +       select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
> >> +       select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
> >>         select HAVE_ARCH_KASAN if MMU && 64BIT
> >>         select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
> >> -       select HAVE_ARCH_KGDB
> >> +       select HAVE_ARCH_KGDB if !XIP_KERNEL
> >>         select HAVE_ARCH_KGDB_QXFER_PKT
> >>         select HAVE_ARCH_MMAP_RND_BITS if MMU
> >>         select HAVE_ARCH_SECCOMP_FILTER
> >> @@ -79,9 +79,9 @@ config RISCV
> >>         select HAVE_GCC_PLUGINS
> >>         select HAVE_GENERIC_VDSO if MMU && 64BIT
> >>         select HAVE_IRQ_TIME_ACCOUNTING
> >> -       select HAVE_KPROBES
> >> -       select HAVE_KPROBES_ON_FTRACE
> >> -       select HAVE_KRETPROBES
> >> +       select HAVE_KPROBES if !XIP_KERNEL
> >> +       select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> >> +       select HAVE_KRETPROBES if !XIP_KERNEL
> >>         select HAVE_PCI
> >>         select HAVE_PERF_EVENTS
> >>         select HAVE_PERF_REGS
> >> @@ -230,11 +230,11 @@ config ARCH_RV64I
> >>         bool "RV64I"
> >>         select 64BIT
> >>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
> >> -       select HAVE_DYNAMIC_FTRACE if MMU && $(cc-option,-fpatchable-function-entry=8)
> >> +       select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
> >>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> >> -       select HAVE_FTRACE_MCOUNT_RECORD
> >> +       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> >>         select HAVE_FUNCTION_GRAPH_TRACER
> >> -       select HAVE_FUNCTION_TRACER
> >> +       select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> >>         select SWIOTLB if MMU
> >>
> >>  endchoice
> >> --
> >> 2.31.0
> >>
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv

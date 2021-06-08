Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28F639EFF0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhFHHxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:53:23 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:33478 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHHxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:53:18 -0400
Received: by mail-yb1-f182.google.com with SMTP id f84so28980463ybg.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 00:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8g+n5AML5PljiDCegHsvih9SEy8efhICuai6L8BGBUE=;
        b=nJJOieLC/1VhUJmZzUybokGWR7fMNatynKBoA6cSS/33nHFPq30ZQurXPDKfJ6LbXE
         7iQdfu++aHO+V0Zq7Eecstk6B6VO+4fHkh6XRt6Ag/gKqMmniZwV6lZebr5k+iOTddG+
         y18832CVmEJqOf5WGJDv3RzpnDRYO0iKr06tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8g+n5AML5PljiDCegHsvih9SEy8efhICuai6L8BGBUE=;
        b=ctvCHOdG6tUh8Tsr1nvUVHjpWR2kyitCDJlDOoemGW1TQzuPJewryKT3dkhU7t17ew
         kWs+RtejeANOKgwW1KcVKpKud3PJxUs4z/B05EHpaIOLs7Xu1hJjC0FT2a+jMPL0HQkg
         OvL/wEa3Mi2L/vDTkXV9wbsOoGX23TvN4cBOXMCWfGEwd9TYMDuHFC3GGePHiocChfs3
         MyO1MuZqcgR5OEIJkUxjg2Qss+SF44R0kWFHPf5Z5PN1wo8IPacrLFHk/SdZZtWZ40v4
         WWOsZUV/5kEeg8+xYcxcRXa7Azs6wJ2qtZ7cr03UgleZnk9NliM0e32bQKLOmLfP7+Q6
         8hCw==
X-Gm-Message-State: AOAM531WB6rAVKF67JdzqCWkTwB8Y8TlKhRXxAZnHSK1JoH5jH3HzTTP
        +TLt03kFY7V9toAsJIQJcgaC8kjHCTRCyIvf5OWGQQ==
X-Google-Smtp-Source: ABdhPJwIOus3Qe/WS3a064zEuaGmv2mRKdZ5WOOuE4ethcP2p6wPz6SsIHX4LhK1wbA5AnbsDDPbG6Z9/pFF3etp/+g=
X-Received: by 2002:a25:c092:: with SMTP id c140mr30735812ybf.117.1623138611344;
 Tue, 08 Jun 2021 00:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAM4kBBJqF=AxTu50PF=EshLSyqn0=yeC2dwf4JJj_Grsi_Tccg@mail.gmail.com>
 <mhng-1c10179a-d96b-4cf1-860a-03f0313ac980@palmerdabbelt-glaptop>
 <CAM4kBBK1BJSE-LeDiEJL-z+tgZMi6Zcb+6AnnQiB8ceaU98k0w@mail.gmail.com> <20210608152406.36a973d0@xhacker.debian>
In-Reply-To: <20210608152406.36a973d0@xhacker.debian>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Tue, 8 Jun 2021 09:50:00 +0200
Message-ID: <CAM4kBBL9pobU73oX8WJbEph90GWJPy1nHmUHfwByJry9+GsyJw@mail.gmail.com>
Subject: Re: [PATCH] riscv: code patching only works on !XIP_KERNEL
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Tue, Jun 8, 2021 at 9:24 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> On Mon, 24 May 2021 21:32:38 +0200
> Vitaly Wool <vitaly.wool@konsulko.com> wrote:
>
>
> >
> >
> > On Sat, May 22, 2021 at 7:15 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > >
> > > On Mon, 10 May 2021 11:19:30 PDT (-0700), vitaly.wool@konsulko.com wrote:
> > > > On Mon, May 10, 2021 at 6:35 PM Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
> > > >>
> > > >> From: Jisheng Zhang <jszhang@kernel.org>
> > > >>
> > > >> Some features which need code patching such as KPROBES, DYNAMIC_FTRACE
> > > >> KGDB can only work on !XIP_KERNEL. Add dependencies for these features
> > > >> that rely on code patching.
> > > >
> > > > Since we can define extra RW sections to place some tiny code bits in
> > > > RAM, I would suggest that you hold back this patch for a while.
> > > > I am not going to support the idea of e. g. compiling KGDB support
> > > > into a XIP kernel, but disabling the whole HAVE_ARCH_JUMP_LABEL is
> > > > hardly the way to go.
> > >
> > > Do you have any updates on this?  The SOC_SIFIVE disable thread floated
> > > back to the top of my inbox and I didn't see anything there.  I'd prefer
> > > to avoid chasing around Kconfig disables for a bunch of stuff that we're
> > > just going to fix soon, but if this is going to be a big change then
> > > it's likely for next cycle anyway so in that case I'll start picking up
> > > these compile disable patches.
> >
> > Sorry, was caught up in fixing other stuff but now I'm on it so expect
> > some updates soon.
>
> Hi Vitaly,
>
> Based on your "[PATCH] riscv: xip: support runtime trap patching", IMHO, it
> solves ERRATA patching issue(And it makes use of the fact that the ERRATA
> only touches traps at the moment), but can't make code patching tech such as
> KPROBES, DYNAMIC_FTRACE etc. work properly, so my patch is still needed.

At this point it is needed, yes.

The thing is, I thought I'd go with one problem at a time, so I posted
the patch which solves build issues for SOC_SIFIVE and XIP, and
runtime patching for ERRATA (and I hope it gets accepted and makes its
way into -stable, too).
I gathered that addressing your issue had lower priority and so it's
still underway. All in all, I don't mind going on with your patch,
when the initial issue is addressed, we may want to revert some part
of it but I guess that would be ok with you, wouldn't it?

Best regards,
   Vitaly

> What do you think?
>
> Regards
>
> >
> > Best regards,
> >    Vitaly
> >
> > > Not trying to rush any thing here, just don't want to have a bunch of
> > > broken configs.
> > >
> > > >
> > > > Best regards,
> > > >    Vitaly
> > > >
> > > >> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > >> ---
> > > >> Hi,
> > > >>
> > > >> Currently, the RISCV_ERRATA_ALTERNATIVE also only works on !XIP_KERNEL
> > > >> but from the maillist it seem there's effort to make the co-exist, so
> > > >> I drop RISCV_ERRATA_ALTERNATIVE dependency on !XIP_KERNEL.
> > > >>
> > > >> Thanks
> > > >>
> > > >>  arch/riscv/Kconfig | 18 +++++++++---------
> > > >>  1 file changed, 9 insertions(+), 9 deletions(-)
> > > >>
> > > >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > >> index a8ad8eb76120..61320b94ef97 100644
> > > >> --- a/arch/riscv/Kconfig
> > > >> +++ b/arch/riscv/Kconfig
> > > >> @@ -60,11 +60,11 @@ config RISCV
> > > >>         select GENERIC_TIME_VSYSCALL if MMU && 64BIT
> > > >>         select HANDLE_DOMAIN_IRQ
> > > >>         select HAVE_ARCH_AUDITSYSCALL
> > > >> -       select HAVE_ARCH_JUMP_LABEL
> > > >> -       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> > > >> +       select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
> > > >> +       select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
> > > >>         select HAVE_ARCH_KASAN if MMU && 64BIT
> > > >>         select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
> > > >> -       select HAVE_ARCH_KGDB
> > > >> +       select HAVE_ARCH_KGDB if !XIP_KERNEL
> > > >>         select HAVE_ARCH_KGDB_QXFER_PKT
> > > >>         select HAVE_ARCH_MMAP_RND_BITS if MMU
> > > >>         select HAVE_ARCH_SECCOMP_FILTER
> > > >> @@ -79,9 +79,9 @@ config RISCV
> > > >>         select HAVE_GCC_PLUGINS
> > > >>         select HAVE_GENERIC_VDSO if MMU && 64BIT
> > > >>         select HAVE_IRQ_TIME_ACCOUNTING
> > > >> -       select HAVE_KPROBES
> > > >> -       select HAVE_KPROBES_ON_FTRACE
> > > >> -       select HAVE_KRETPROBES
> > > >> +       select HAVE_KPROBES if !XIP_KERNEL
> > > >> +       select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> > > >> +       select HAVE_KRETPROBES if !XIP_KERNEL
> > > >>         select HAVE_PCI
> > > >>         select HAVE_PERF_EVENTS
> > > >>         select HAVE_PERF_REGS
> > > >> @@ -230,11 +230,11 @@ config ARCH_RV64I
> > > >>         bool "RV64I"
> > > >>         select 64BIT
> > > >>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
> > > >> -       select HAVE_DYNAMIC_FTRACE if MMU && $(cc-option,-fpatchable-function-entry=8)
> > > >> +       select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
> > > >>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> > > >> -       select HAVE_FTRACE_MCOUNT_RECORD
> > > >> +       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > > >>         select HAVE_FUNCTION_GRAPH_TRACER
> > > >> -       select HAVE_FUNCTION_TRACER
> > > >> +       select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> > > >>         select SWIOTLB if MMU
> > > >>
> > > >>  endchoice
> > > >> --
> > > >> 2.31.0
> > > >>
> > > >>
> > > >>
> > > >> _______________________________________________

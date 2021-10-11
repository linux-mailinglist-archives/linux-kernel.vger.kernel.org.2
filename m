Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E5F4292B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbhJKPC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbhJKPC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:02:28 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4836C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 08:00:27 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so5275576otr.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DGpeO8Luc9doQYqA/bXw4zWcqIaLqf3yim6ESEFJoU=;
        b=S1EkJWl3MLs2f6FBu5UGz22+FLKPqLD9S7CXDWmrePxbzNmhw8MtPp/+7IjQFZTtXM
         pfIkf52LAl9qGQXxWLzsnvhnjWtAe7TvAnJmXpj2suuBdaPTVi1VJaLD0zmaENna4PuZ
         zLkHtETHYfC9FwrQ/CpqTSna8FB58FWAeD+EdQAoak6BwQB04XZ/y6P3OvHLZ9AX7Wz/
         93jr5Hx66bOON11K4x6ea5RDGeimcLZ3/KJpE861GzoQER7oeIwLSR9A2R/uF1E9Ht6d
         z4mDNyg4bshCSTFJOK5ZBh3v/D75vD16yRDH4BtNw/LPnTAPl3OOot319cAaDPC59BN5
         Kqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DGpeO8Luc9doQYqA/bXw4zWcqIaLqf3yim6ESEFJoU=;
        b=v8LUB1yNXyogRo8R5973cJLm8P8Gghji3i0vYci0r+bH5UDjFMPQfbHB/exN3kZYCk
         Uq8JJmGCnZgwd24D//Y8RFsy18K+GGELbjegEkqoYbaRSz3fhrQ7QsKiJNpjmb9CwvbR
         9/YCA4QyS2Yl1mL/gup/PihT5b8mFJMwKzeHXwwo/NTdzNoapyZzVs8fTQQQoX9BpDlM
         o9TUwW881+jsm7OQG1frbZB329HNH+QPwWWZUTDXoZ3KtYLWXyEJ4VKeMX67GLqv88Ax
         yIxIxn+z/WpzgwdustwnwhZGB0OX9Y6Ybx+yRtnfgUhvMVnXoBZohCvIDGVax8o9Egma
         lNWA==
X-Gm-Message-State: AOAM530zpizOl7bKyM2cSxU7565iQ3OgMp3Krkps+RU/Ni1H4qsSdMZQ
        RWIUKdMfZph/Af/gKoTgSi9yYtPW6pjByXC5oHqbEA==
X-Google-Smtp-Source: ABdhPJzqsJKb/Ru0jsZmK2bQG3Y1mcmodAMVEzd9DemmptGnoeUHWUCJm9Lb/f0zxWDh8oFbvgni5nt8pc6H0601jqk=
X-Received: by 2002:a05:6830:402c:: with SMTP id i12mr7413612ots.319.1633964426757;
 Mon, 11 Oct 2021 08:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <YWLwUUNuRrO7AxtM@arighi-desktop> <CANpmjNOw--ZNyhmn-GjuqU+aH5T98HMmBoCM4z=JFvajC913Qg@mail.gmail.com>
 <YWPaZSX4WyOwilW+@arighi-desktop> <CANpmjNMFFFa=6toZJXqo_9hzv05zoD0aXA4D_K93rfw58cEw3w@mail.gmail.com>
 <YWPjZv7ClDOE66iI@arighi-desktop> <CACT4Y+b4Xmev7uLhASpHnELcteadhaXCBkkD5hO2YNP5M2451g@mail.gmail.com>
 <YWQCknwPcGlOBfUi@arighi-desktop> <YWQJe1ccZ72FZkLB@arighi-desktop>
 <CANpmjNNtCf+q21_5Dj49c4D__jznwFbBFrWE0LG5UnC__B+fKA@mail.gmail.com> <YWRNVTk9N8K0RMst@arighi-desktop>
In-Reply-To: <YWRNVTk9N8K0RMst@arighi-desktop>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Oct 2021 17:00:15 +0200
Message-ID: <CACT4Y+bZGK75S+cyeQda-oHmeDVeownwOj2imQbPYi0dRY18+A@mail.gmail.com>
Subject: Re: BUG: soft lockup in __kmalloc_node() with KFENCE enabled
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 at 16:42, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> On Mon, Oct 11, 2021 at 12:03:52PM +0200, Marco Elver wrote:
> > On Mon, 11 Oct 2021 at 11:53, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > On Mon, Oct 11, 2021 at 11:23:32AM +0200, Andrea Righi wrote:
> > > ...
> > > > > You seem to use the default 20s stall timeout. FWIW syzbot uses 160
> > > > > secs timeout for TCG emulation to avoid false positive warnings:
> > > > > https://github.com/google/syzkaller/blob/838e7e2cd9228583ca33c49a39aea4d863d3e36d/dashboard/config/linux/upstream-arm64-kasan.config#L509
> > > > > There are a number of other timeouts raised as well, some as high as
> > > > > 420 seconds.
> > > >
> > > > I see, I'll try with these settings and see if I can still hit the soft
> > > > lockup messages.
> > >
> > > Still getting soft lockup messages even with the new timeout settings:
> > >
> > > [  462.663766] watchdog: BUG: soft lockup - CPU#2 stuck for 430s! [systemd-udevd:168]
> > > [  462.755758] watchdog: BUG: soft lockup - CPU#3 stuck for 430s! [systemd-udevd:171]
> > > [  924.663765] watchdog: BUG: soft lockup - CPU#2 stuck for 861s! [systemd-udevd:168]
> > > [  924.755767] watchdog: BUG: soft lockup - CPU#3 stuck for 861s! [systemd-udevd:171]
> >
> > The lockups are expected if you're hitting the TCG bug I linked. Try
> > to pass '-enable-kvm' to the inner qemu instance (my bad if you
> > already have), assuming that's somehow easy to do.
>
> If I add '-enable-kvm' I can triggering other random panics (almost
> immediately), like this one for example:
>
> [21383.189976] BUG: kernel NULL pointer dereference, address: 0000000000000098
> [21383.190633] #PF: supervisor read access in kernel mode
> [21383.191072] #PF: error_code(0x0000) - not-present page
> [21383.191529] PGD 0 P4D 0
> [21383.191771] Oops: 0000 [#1] SMP NOPTI
> [21383.192113] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15-rc4
> [21383.192757] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> [21383.193414] RIP: 0010:wb_timer_fn+0x44/0x3c0
> [21383.193855] Code: 41 8b 9c 24 98 00 00 00 41 8b 94 24 b8 00 00 00 41 8b 84 24 d8 00 00 00 4d 8b 74 24 28 01 d3 01 c3 49 8b 44 24 60 48 8b 40 78 <4c> 8b b8 98 00 00 00 4d 85 f6 0f 84 c4 00 00 00 49 83 7c 24 30 00
> [21383.195366] RSP: 0018:ffffbcd140003e68 EFLAGS: 00010246
> [21383.195842] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
> [21383.196425] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9a3521f4fd80
> [21383.197010] RBP: ffffbcd140003e90 R08: 0000000000000000 R09: 0000000000000000
> [21383.197594] R10: 0000000000000004 R11: 000000000000000f R12: ffff9a34c75c4900
> [21383.198178] R13: ffff9a34c3906de0 R14: 0000000000000000 R15: ffff9a353dc18c00
> [21383.198763] FS:  0000000000000000(0000) GS:ffff9a353dc00000(0000) knlGS:0000000000000000
> [21383.199558] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [21383.200212] CR2: 0000000000000098 CR3: 0000000005f54000 CR4: 00000000000006f0
> [21383.200930] Call Trace:
> [21383.201210]  <IRQ>
> [21383.201461]  ? blk_stat_free_callback_rcu+0x30/0x30
> [21383.202692]  blk_stat_timer_fn+0x138/0x140
> [21383.203180]  call_timer_fn+0x2b/0x100
> [21383.203666]  __run_timers.part.0+0x1d1/0x240
> [21383.204227]  ? kvm_clock_get_cycles+0x11/0x20
> [21383.204815]  ? ktime_get+0x3e/0xa0
> [21383.205309]  ? native_apic_msr_write+0x2c/0x30
> [21383.205914]  ? lapic_next_event+0x20/0x30
> [21383.206412]  ? clockevents_program_event+0x94/0xf0
> [21383.206873]  run_timer_softirq+0x2a/0x50
> [21383.207260]  __do_softirq+0xcb/0x26f
> [21383.207647]  irq_exit_rcu+0x8c/0xb0
> [21383.208010]  sysvec_apic_timer_interrupt+0x7c/0x90
> [21383.208464]  </IRQ>
> [21383.208713]  asm_sysvec_apic_timer_interrupt+0x12/0x20
>
> I think that systemd autotest used to use -enable-kvm, but then they
> removed it, because it was introducing too many problems in the nested
> KVM context. I'm not sure about the nature of those problems though, I
> can investigate a bit and see if I can understand what they were
> exactly.

This looks like just a plain bug in wb_timer_fn, not something related
to virtualization.
Do you have this fix?
https://syzkaller.appspot.com/bug?extid=aa0801b6b32dca9dda82

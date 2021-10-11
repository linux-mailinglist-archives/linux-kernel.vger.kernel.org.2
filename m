Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A324292F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhJKPSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhJKPSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:18:42 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77952C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 08:16:42 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so22169135otb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etYgg+h2O5V3SwL5gD13pIM27MsV6K0L3L1sqF1wYTE=;
        b=el38wyOt6M4eOeshwmiPoV7jMG5ZX6uvIFaNnvNoSJYlaEEJhW2pZPAWYzAg454+LD
         1E5js8LOfImu5A1wtJiHp6RfkDoqcMXVa7wnE66jUxr7VQNkJBG/hDq/rfVVcSj6oUGO
         2uDquzaB0K4L2mod1iI7TG7b8zmA/0AMXCqQmdBYvGrF9Qvp71qj8/O2IKRhH6ijvE2l
         vB+AoW3OuMTrolDnGAfnkKMHWAXmWmZHenMyNVlQXP7zuXY8OgTCulNHtvsYjOnGEex5
         RNguP7gYMbN75QetPxH3xlevB6ew5ulzPIyVe6V311Fa09+4UsjP4cpUxUzJqRJyppIb
         pNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etYgg+h2O5V3SwL5gD13pIM27MsV6K0L3L1sqF1wYTE=;
        b=1FBWd2aXaFpTCIm/cPPNDGHj+18PdcWOcouhxxGrEHGTRy9t/uhd2bWJzgs/xxt1na
         AqahorMMTtLtT2boIUM41lD5sF1Dfqxv4LraVIc9e2iD4180sy8Fa0f3XOn5n7pbpfXi
         3YGYhUYgRP00chIjWzrTHMItvnbih/lbvh1kk+doI/OTaDNv7yRtWnbbr5VEusRac913
         uRxJYUbB08uoA0fwWTB0uxRGaz+HKoRoGGv8Y/dubF2gIvl7P9VQClXSzAke+cmufQ6B
         lj4d5bI2xrNm+I1GQR/03rvlVNAqGu8JoQjhADlqGXQqmSSTc+JRqPw4Z9WwhNL8y+LW
         Hvag==
X-Gm-Message-State: AOAM530XMYDwwjeDafxR5UIIdwEIGpGXwFnkBiUTUotzfxJLKFn3lRkN
        OtW7hokpNA9Z3EhNEWx+uzMidEq1Tx5asM5smXeVowMjNA8l7Llt
X-Google-Smtp-Source: ABdhPJy3IwrhJ7udHn/k4mW8pPjAGJ7Y5Fqmen34KA6kKWe57E+fesp4mtWBLidlT1RKOa4qSiZheM5CxtVOr2PEVAc=
X-Received: by 2002:a05:6830:402c:: with SMTP id i12mr7503223ots.319.1633965401529;
 Mon, 11 Oct 2021 08:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNOw--ZNyhmn-GjuqU+aH5T98HMmBoCM4z=JFvajC913Qg@mail.gmail.com>
 <YWPaZSX4WyOwilW+@arighi-desktop> <CANpmjNMFFFa=6toZJXqo_9hzv05zoD0aXA4D_K93rfw58cEw3w@mail.gmail.com>
 <YWPjZv7ClDOE66iI@arighi-desktop> <CACT4Y+b4Xmev7uLhASpHnELcteadhaXCBkkD5hO2YNP5M2451g@mail.gmail.com>
 <YWQCknwPcGlOBfUi@arighi-desktop> <YWQJe1ccZ72FZkLB@arighi-desktop>
 <CANpmjNNtCf+q21_5Dj49c4D__jznwFbBFrWE0LG5UnC__B+fKA@mail.gmail.com>
 <YWRNVTk9N8K0RMst@arighi-desktop> <CACT4Y+bZGK75S+cyeQda-oHmeDVeownwOj2imQbPYi0dRY18+A@mail.gmail.com>
 <YWRUBxS0hGGDkeU4@arighi-desktop>
In-Reply-To: <YWRUBxS0hGGDkeU4@arighi-desktop>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Oct 2021 17:16:30 +0200
Message-ID: <CACT4Y+ZATYYpX6wJ_i1ig6ZhA3kwuH_8eC51spkd+0x3ZxX0ow@mail.gmail.com>
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

On Mon, 11 Oct 2021 at 17:11, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> On Mon, Oct 11, 2021 at 05:00:15PM +0200, Dmitry Vyukov wrote:
> > On Mon, 11 Oct 2021 at 16:42, Andrea Righi <andrea.righi@canonical.com> wrote:
> > >
> > > On Mon, Oct 11, 2021 at 12:03:52PM +0200, Marco Elver wrote:
> > > > On Mon, 11 Oct 2021 at 11:53, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > On Mon, Oct 11, 2021 at 11:23:32AM +0200, Andrea Righi wrote:
> > > > > ...
> > > > > > > You seem to use the default 20s stall timeout. FWIW syzbot uses 160
> > > > > > > secs timeout for TCG emulation to avoid false positive warnings:
> > > > > > > https://github.com/google/syzkaller/blob/838e7e2cd9228583ca33c49a39aea4d863d3e36d/dashboard/config/linux/upstream-arm64-kasan.config#L509
> > > > > > > There are a number of other timeouts raised as well, some as high as
> > > > > > > 420 seconds.
> > > > > >
> > > > > > I see, I'll try with these settings and see if I can still hit the soft
> > > > > > lockup messages.
> > > > >
> > > > > Still getting soft lockup messages even with the new timeout settings:
> > > > >
> > > > > [  462.663766] watchdog: BUG: soft lockup - CPU#2 stuck for 430s! [systemd-udevd:168]
> > > > > [  462.755758] watchdog: BUG: soft lockup - CPU#3 stuck for 430s! [systemd-udevd:171]
> > > > > [  924.663765] watchdog: BUG: soft lockup - CPU#2 stuck for 861s! [systemd-udevd:168]
> > > > > [  924.755767] watchdog: BUG: soft lockup - CPU#3 stuck for 861s! [systemd-udevd:171]
> > > >
> > > > The lockups are expected if you're hitting the TCG bug I linked. Try
> > > > to pass '-enable-kvm' to the inner qemu instance (my bad if you
> > > > already have), assuming that's somehow easy to do.
> > >
> > > If I add '-enable-kvm' I can triggering other random panics (almost
> > > immediately), like this one for example:
> > >
> > > [21383.189976] BUG: kernel NULL pointer dereference, address: 0000000000000098
> > > [21383.190633] #PF: supervisor read access in kernel mode
> > > [21383.191072] #PF: error_code(0x0000) - not-present page
> > > [21383.191529] PGD 0 P4D 0
> > > [21383.191771] Oops: 0000 [#1] SMP NOPTI
> > > [21383.192113] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15-rc4
> > > [21383.192757] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> > > [21383.193414] RIP: 0010:wb_timer_fn+0x44/0x3c0
> > > [21383.193855] Code: 41 8b 9c 24 98 00 00 00 41 8b 94 24 b8 00 00 00 41 8b 84 24 d8 00 00 00 4d 8b 74 24 28 01 d3 01 c3 49 8b 44 24 60 48 8b 40 78 <4c> 8b b8 98 00 00 00 4d 85 f6 0f 84 c4 00 00 00 49 83 7c 24 30 00
> > > [21383.195366] RSP: 0018:ffffbcd140003e68 EFLAGS: 00010246
> > > [21383.195842] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
> > > [21383.196425] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9a3521f4fd80
> > > [21383.197010] RBP: ffffbcd140003e90 R08: 0000000000000000 R09: 0000000000000000
> > > [21383.197594] R10: 0000000000000004 R11: 000000000000000f R12: ffff9a34c75c4900
> > > [21383.198178] R13: ffff9a34c3906de0 R14: 0000000000000000 R15: ffff9a353dc18c00
> > > [21383.198763] FS:  0000000000000000(0000) GS:ffff9a353dc00000(0000) knlGS:0000000000000000
> > > [21383.199558] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [21383.200212] CR2: 0000000000000098 CR3: 0000000005f54000 CR4: 00000000000006f0
> > > [21383.200930] Call Trace:
> > > [21383.201210]  <IRQ>
> > > [21383.201461]  ? blk_stat_free_callback_rcu+0x30/0x30
> > > [21383.202692]  blk_stat_timer_fn+0x138/0x140
> > > [21383.203180]  call_timer_fn+0x2b/0x100
> > > [21383.203666]  __run_timers.part.0+0x1d1/0x240
> > > [21383.204227]  ? kvm_clock_get_cycles+0x11/0x20
> > > [21383.204815]  ? ktime_get+0x3e/0xa0
> > > [21383.205309]  ? native_apic_msr_write+0x2c/0x30
> > > [21383.205914]  ? lapic_next_event+0x20/0x30
> > > [21383.206412]  ? clockevents_program_event+0x94/0xf0
> > > [21383.206873]  run_timer_softirq+0x2a/0x50
> > > [21383.207260]  __do_softirq+0xcb/0x26f
> > > [21383.207647]  irq_exit_rcu+0x8c/0xb0
> > > [21383.208010]  sysvec_apic_timer_interrupt+0x7c/0x90
> > > [21383.208464]  </IRQ>
> > > [21383.208713]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> > >
> > > I think that systemd autotest used to use -enable-kvm, but then they
> > > removed it, because it was introducing too many problems in the nested
> > > KVM context. I'm not sure about the nature of those problems though, I
> > > can investigate a bit and see if I can understand what they were
> > > exactly.
> >
> > This looks like just a plain bug in wb_timer_fn, not something related
> > to virtualization.
> > Do you have this fix?
> > https://syzkaller.appspot.com/bug?extid=aa0801b6b32dca9dda82
>
> Yes, it looks like I have this:
>
>  d152c682f03c block: add an explicit ->disk backpointer to the request_queue

Then there is another bug in wb_timer_fn I guess...

Don't know if this is the same or something else:
https://lore.kernel.org/lkml/CAHbLzkrdGva2dzO36r62LKv_ip5trbMK0BO3vCeSBk2_7OE-zA@mail.gmail.com/

There also were some data races in this function:
https://groups.google.com/g/syzkaller-upstream-moderation/search?q=wb_timer_fn

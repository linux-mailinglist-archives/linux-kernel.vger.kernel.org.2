Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CEC3387F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhCLIxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhCLIwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:52:40 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CAFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:52:40 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id g185so23523855qkf.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffAL3sjGN6geUsKlH5W9TsVAcj7fMupCYXIrnt2cbms=;
        b=Bf5Sb8a/ek/e8kgkz5ons6B0bTFlB9XEj77yqiDrZoDxN50nz+QuBwvCPqvBDRDyYg
         ecrbYT8bJ4SlCpFvvxbqYtp10B1wumDs7ue0UkzA/a/Q44vILEy2v/whtGXRcZsFuvNl
         I5KcELSZy2NbEQrWzlqTZOOxBwmyl387VH5oB9I/YRtNVig0SasR6Wxc3Mec9tj7mvvr
         +IEgq2eqbYXIIz/7lEKeNIhtmyHAoOGIxAWF7tFIKzL+cLjybPtfosQsp0XQPvsEoDmO
         D1gwLJV9wJoLj5Pk2xfFcYisahfz5WnPY9N61UHuVS/2Bv03iX4/r+v44qrMPiEcpqei
         6vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffAL3sjGN6geUsKlH5W9TsVAcj7fMupCYXIrnt2cbms=;
        b=svCoswCRABPtzR3cVZgEmZOe7d4fqYj9k01x421PDnZP7h8V4ZYt4jEAFtlhKYN3ZB
         e9WpFCNyn2wSJy1ADTQqP+amjskbz9mA6WZStwqU/snYFS1/x5BTcjaS4P+bwaC9AmXo
         5kfHZyCDf/mXfQPNG7qvk6ViwpsBISQjqY1rq1c+JiaGXWWy7p7GJvWUbxCqhDwagpDi
         PcNroE+uE9wFGAhLhbJhmdP5NQwu0FQRGp0V7MJMPVN/NPEacqdw0h5hiivGZkSujK7h
         pwH05JEGFU+4AVoP8AT1oY3yMyJqmDxgkSRFPFtK2apiSjepKKCXv9wzGrGRbT+fUmqD
         vwJQ==
X-Gm-Message-State: AOAM5323risDsnfTG5EBfyCnghQfvvhoAFqupu9A3pDZDdL2Fc5yMtgw
        y8eNYJnEkriIArZR2BfMnyC44tp/NqXRec+hEdAwjA==
X-Google-Smtp-Source: ABdhPJxSicRqCBLH0Y391UcpMU8ZQD2MHW2jqNNjlGoJmzi2OJgutjEJRj1qCDJBuoAkJKcHBOCxvcdgsLZoW7+cylI=
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr11183032qkx.501.1615539159552;
 Fri, 12 Mar 2021 00:52:39 -0800 (PST)
MIME-Version: 1.0
References: <000000000000dbf8ee05bd518c23@google.com>
In-Reply-To: <000000000000dbf8ee05bd518c23@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Mar 2021 09:52:28 +0100
Message-ID: <CACT4Y+bUM4ZGnV3OF9QAdGGoKyJ=xf04wZFtL765QU1XAoYYyg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in huge_pmd_set_accessed
To:     syzbot <syzbot+edb1179c837e79cc2fc3@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 8:07 AM syzbot
<syzbot+edb1179c837e79cc2fc3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    05a59d79 Merge git://git.kernel.org:/pub/scm/linux/kernel/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b8820ad00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=750735fdbc630971
> dashboard link: https://syzkaller.appspot.com/bug?extid=edb1179c837e79cc2fc3
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+edb1179c837e79cc2fc3@syzkaller.appspotmail.com

Kernel produced corrupted output, there is actually kvm_wait frame.

#syz dup: WARNING in kvm_wait

> ------------[ cut here ]------------
> raw_local_irq_restore() called with IRQs enabled
> WARNING: CPU: 1 PID: 8400 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> Modules linked in:
> CPU: 1 PID: 8400 Comm: syz-fuzzer Not tainted 5.12.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> Code: be ff cc cc cc cc cc cc cc cc cc cc cc 80 3d 11 d1 ad 04 00 74 01 c3 48 c7 c7 20 79 6b 89 c6 05 00 d1 ad 04 01 e8 75 5b be ff <0f> 0b c3 48 39 77 10 0f 84 97 00 00 00 66 f7 47 22 f0 ff 74 4b 48
> RSP: 0000:ffffc90001737ac8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff88801992a840 RCX: 0000000000000000
> RDX: ffff8880223d0200 RSI: ffffffff815b4435 RDI: fffff520002e6f4b
> RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff815ad19e R11: 0000000000000000 R12: 0000000000000003
> R13: ffffed1003325508 R14: 0000000000000001 R15: ffff8880b9d36000
> FS:  000000c00002e890(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Call Trace:
>  pv_wait arch/x86/include/asm/paravirt.h:564 [inline]
>  pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
>  __pv_queued_spin_lock_slowpath+0x8b8/0xb40 kernel/locking/qspinlock.c:508
>  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:554 [inline]
>  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
>  queued_spin_lock include/asm-generic/qspinlock.h:85 [inline]
>  do_raw_spin_lock+0x200/0x2b0 kernel/locking/spinlock_debug.c:113
>  spin_lock include/linux/spinlock.h:354 [inline]
>  pmd_lock include/linux/mm.h:2264 [inline]
>  huge_pmd_set_accessed+0x103/0x320 mm/huge_memory.c:1265
>  handle_mm_fault+0x1bc/0x7e0 mm/memory.c:4549
>  handle_page_fault arch/x86/mm/fault.c:1475 [inline]
>  exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1531
> RIP: 0033:0x59072c
> Code: 48 8d 05 97 25 3e 00 48 89 44 24 08 e8 6d 54 ea ff 90 e8 07 a1 ed ff eb a5 cc cc cc cc cc 8b 44 24 10 48 8b 4c 24 08 89 41 24 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 48 8b
> RSP: 002b:000000c0002e97b0 EFLAGS: 00010286
> RAX: 0000000000004ef5 RBX: 0000000000004ef5 RCX: 0000000000d85fe0
> RBP: 000000c0002e9890 R08: 0000000000004ef4 R09: 000000000059c5a0
> R13: 00aaaaaaaaaaaaaa R14: 000000000093f064 R15: 0000000000000038
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

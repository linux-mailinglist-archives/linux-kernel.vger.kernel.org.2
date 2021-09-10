Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64444067BD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhIJHft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhIJHfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:35:48 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62B2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:34:37 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id bi4so1766443oib.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VzJcLlZdw5d6SucUkv011Tx3+9MpvlSVesKT1t7kQ4=;
        b=oXHQEES47599+dxzC1c92J+yT4uoaA1tdQRN1MMhhkn8jTyjK26S2JpEdWX5fjKGUI
         brlVPN+1tA27w7ex7eQ1wL17ChlgJiHEQ4cAI+ZRDmW7uDtlOQGDm3pgVf/PwWuUq7F7
         GqWayfuILRvR/HQAQpC0fIaedCBJyouNHIqH71rYVxSeonZyDVOAECb9/XvAuquVtAiZ
         fv7Snm4Dk6BfRJlBs/7IsQFgwaYilaHds3ELd0U7bUILBkU/iP9hs0JGmhbyYm+g06kl
         g99Zv4dISW6n7M7IvSJT5wzq8oPNZvG54+2IDuM6pBYDWUX+3B1B34Srpqj1XHv2l/+M
         8Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VzJcLlZdw5d6SucUkv011Tx3+9MpvlSVesKT1t7kQ4=;
        b=KX8XDPyHowxIMmUkergt/M1B8U0rXqbYf4IbGZ68/ZWuHOveDUvx/liMPrbBZVCwxd
         LHTdYZOV9Z6Lve23isFL43zM1CW3bd0CBaaxWBXLgsKdJR1UhIUyBu1S59+PpBF8yASN
         qUmOcrUunMOncpdlIa80rbw3rIrZfJGBr+Zf+A4AQv/A2f0J91RqwxS1KPzzCNmot/fK
         gMHrpvmotWN9PrTTnTK3EDGnD2zXaIpUmbM2YR48waSdW1t0ZxLfuEorOmb2v+e9qr3G
         hLWDVksFJBEx+uMR0UsBo4A4d4NrZxxwvyyvwW5akkPpjPtlq11EVM90pXx52lCRn5pu
         Oiug==
X-Gm-Message-State: AOAM533YSrQQeuDmh8Kb2kBuRNvgi+NmqVIO6JLNuTPCM7JR7nxTrNho
        V5ZV+FFoUTrs4NeWGIpmVjz/kSRpODvJRHaPkJGbRg==
X-Google-Smtp-Source: ABdhPJwvwrFwO7TK/1gB2mC/2/PETyll3eCPRRFR6DT2soG/F8UgkbTVjc+XR3PN4ejP5TTMQlQAvP92eOyfMNI3G04=
X-Received: by 2002:aca:4344:: with SMTP id q65mr3175015oia.70.1631259276843;
 Fri, 10 Sep 2021 00:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000071b5b105cb994728@google.com>
In-Reply-To: <00000000000071b5b105cb994728@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 10 Sep 2021 09:34:25 +0200
Message-ID: <CANpmjNOuPyF4z28V=J=JjxV25QhY-vMtE+7OCZbweWFx01my3Q@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: panic_on_warn set (3)
To:     syzbot <syzbot+8d41ad9c88279d71f7c9@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz invalid

Corrupt report. (syzbot somehow failed to parse the report?)

Same use-after-free bug as this:
https://lore.kernel.org/all/000000000000d6b66705cb2fffd4@google.com/T/#u
which still seems unfixed...

On Fri, 10 Sept 2021 at 02:34, syzbot
<syzbot+8d41ad9c88279d71f7c9@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ac08b1c68d1b Merge tag 'pci-v5.15-changes' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16144a63300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=16e23f04679ec35e
> dashboard link: https://syzkaller.appspot.com/bug?extid=8d41ad9c88279d71f7c9
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136aedb5300000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8d41ad9c88279d71f7c9@syzkaller.appspotmail.com
>
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
>  kthread+0x3e5/0x4d0 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> ==================================================================
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 22 Comm: kdevtmpfs Not tainted 5.14.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
>  panic+0x2b0/0x6dd kernel/panic.c:232
>  kfence_report_error.cold+0x304/0xa56 mm/kfence/report.c:264
>  kfence_handle_page_fault+0x203/0x630 mm/kfence/core.c:880
>  page_fault_oops+0x1c5/0x6b0 arch/x86/mm/fault.c:686
>  kernelmode_fixup_or_oops+0x219/0x280 arch/x86/mm/fault.c:755
>  __bad_area_nosemaphore+0x36d/0x400 arch/x86/mm/fault.c:801
>  do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1200
>  handle_page_fault arch/x86/mm/fault.c:1473 [inline]
>  exc_page_fault+0x155/0x180 arch/x86/mm/fault.c:1531
>  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:568
> RIP: 0010:kvm_fastop_exception+0xf6a/0x1058
> Code: d3 ed e9 ef d4 6e f8 49 8d 0e 48 83 e1 f8 4c 8b 21 41 8d 0e 83 e1 07 c1 e1 03 49 d3 ec e9 45 e2 6e f8 49 8d 4d 00 48 83 e1 f8 <4c> 8b 21 41 8d 4d 00 83 e1 07 c1 e1 03 49 d3 ec e9 35 ec 6e f8 bd
> RSP: 0018:ffffc90000dcfae8 EFLAGS: 00010282
> RAX: 0000003361736376 RBX: ffff88806f1e3068 RCX: ffff88823bd14020
> RDX: ffffed100de3c614 RSI: 0000000000000005 RDI: 0000000000000007
> RBP: 0000000000000005 R08: 0000000000000000 R09: ffff88806f1e3098
> R10: ffffed100de3c613 R11: 0000000000000000 R12: ffff88823bd14020
> R13: ffff88823bd14020 R14: ffff88806f1e3098 R15: dffffc0000000000
>  d_lookup+0xd8/0x170 fs/dcache.c:2370
>  lookup_dcache+0x1e/0x130 fs/namei.c:1520
>  __lookup_hash+0x29/0x180 fs/namei.c:1543
>  kern_path_locked+0x17e/0x320 fs/namei.c:2567
>  handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
>  kthread+0x3e5/0x4d0 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> Kernel Offset: disabled
> ----------------
> Code disassembly (best guess):
>    0:   d3 ed                   shr    %cl,%ebp
>    2:   e9 ef d4 6e f8          jmpq   0xf86ed4f6
>    7:   49 8d 0e                lea    (%r14),%rcx
>    a:   48 83 e1 f8             and    $0xfffffffffffffff8,%rcx
>    e:   4c 8b 21                mov    (%rcx),%r12
>   11:   41 8d 0e                lea    (%r14),%ecx
>   14:   83 e1 07                and    $0x7,%ecx
>   17:   c1 e1 03                shl    $0x3,%ecx
>   1a:   49 d3 ec                shr    %cl,%r12
>   1d:   e9 45 e2 6e f8          jmpq   0xf86ee267
>   22:   49 8d 4d 00             lea    0x0(%r13),%rcx
>   26:   48 83 e1 f8             and    $0xfffffffffffffff8,%rcx
> * 2a:   4c 8b 21                mov    (%rcx),%r12 <-- trapping instruction
>   2d:   41 8d 4d 00             lea    0x0(%r13),%ecx
>   31:   83 e1 07                and    $0x7,%ecx
>   34:   c1 e1 03                shl    $0x3,%ecx
>   37:   49 d3 ec                shr    %cl,%r12
>   3a:   e9 35 ec 6e f8          jmpq   0xf86eec74
>   3f:   bd                      .byte 0xbd
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches

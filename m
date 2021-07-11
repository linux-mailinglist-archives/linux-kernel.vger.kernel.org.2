Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92B63C39F3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 05:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhGKDOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 23:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhGKDOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 23:14:35 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C584FC0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 20:11:48 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a6so14192755qka.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 20:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=FYH6ATq7FHOXW/X4DnloCfvnlJAn9MwFXfGQVu7Hso4=;
        b=tjHgGuwFIk2xLUp6o48M9Qq15tplqm7jinR8MpWpkDtTuc4m4dPj74SkoLO/LOJ/MK
         XIKRm4nkegMopFjgNIlR3ccaLVZDQgIaKzP8WI2AYI/X67GPdo5jzUY6EBnJCkbvqNTB
         CymyiP4eO+EdBRDrt51V3oBmqDNgqThN+03CEWdv/WAjyIrW3Bns4cNWCnUWF9q4qfwu
         kBjjRxxNENMW+5kFLDJgnbGXHEZ1AUFD59mMPocHXtADOp1VjAGUfCTapMsxOPEaYV3f
         kAGNvtUTdIT7yHVcPGHItiaYQp9MCyuq2DtUtBYuiWreYCFznSnhaxS25Lt3Y9ZzQHEF
         VqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=FYH6ATq7FHOXW/X4DnloCfvnlJAn9MwFXfGQVu7Hso4=;
        b=XWvFVmLBzYS5Fy3abDsm2jvtoRg9fw3Mrp+Jrk4Hm3if3DKBmk1hEEAZOV/N96NdPH
         gbK9+iWMZ+gHUIaw6rPkup3EkhNPnruTDyGqLcS1eCpsl+MvXTqeX0Eel0TPAIpdgIGf
         w2tJDGxIfEWgUblaUVF+qrk64ZOVlKpG0pfegFavo638MEGQS1UImhuZrfdhDDtFRZb7
         fNchglR+YPdCVT8QvuAYQVHc7eNYwuoIjIWa1bSqcdNtk7isQtzuRjY1LQBTBoR9N4u+
         ZnOwj2W+ohGpYLeIO3u6wT/+BusJitCmJN/SXM2SwzYVaOiEod3BQImf99Zq2bCeFxaQ
         Abmw==
X-Gm-Message-State: AOAM5326bUmzMOzwdk77bIu62hwEamilH6L8Xgfcv8tLRZ41/APzRNIB
        w2GExBgQonnKdTZJB8z8w1OTgMyrDIBUjg==
X-Google-Smtp-Source: ABdhPJzLxjPZgeb7xzaLsOCjsSNu4+CeUImMSNpjDXeNrteJVLBTD8SOcOOCpvB0BhcKh20+oYgKtg==
X-Received: by 2002:a37:9504:: with SMTP id x4mr45038909qkd.235.1625973107504;
        Sat, 10 Jul 2021 20:11:47 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c197sm90475qke.33.2021.07.10.20.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 20:11:47 -0700 (PDT)
Date:   Sat, 10 Jul 2021 20:11:34 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 __munlock_pagevec
In-Reply-To: <00000000000069f57705c6cc2e81@google.com>
Message-ID: <842ce777-3c5-5bec-c641-a683a0c21797@google.com>
References: <00000000000069f57705c6cc2e81@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2021, syzbot wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ee268dee Add linux-next specific files for 20210707
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13ed30d2300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=59e1e3bbc3afca75
> dashboard link: https://syzkaller.appspot.com/bug?extid=cf9c548279bff83b0c97
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a25ee4300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f81928300000

I have checked with that C reproducer: this issue is in Linus's
current tree; but as expected, it is already fixed by
mm-rmap-fix-new-bug-premature-return-from-page_mlock_one.patch
in mmotm.

Hugh

> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cf9c548279bff83b0c97@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at include/linux/pagemap.h:674
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 8467, name: syz-executor631
> 1 lock held by syz-executor631/8467:
>  #0: ffff8880343e0978 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:359 [inline]
>  #0: ffff8880343e0978 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: map_pte mm/page_vma_mapped.c:52 [inline]
>  #0: ffff8880343e0978 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: page_vma_mapped_walk+0xd87/0x24f0 mm/page_vma_mapped.c:261
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 0 PID: 8467 Comm: syz-executor631 Not tainted 5.13.0-next-20210707-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
>  ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9171
>  lock_page include/linux/pagemap.h:674 [inline]
>  __munlock_pagevec+0xa22/0x2340 mm/mlock.c:314
>  munlock_vma_pages_range+0x9d7/0xf00 mm/mlock.c:475
>  munlock_vma_pages_all mm/internal.h:354 [inline]
>  unlock_range mm/mmap.c:2811 [inline]
>  exit_mmap+0x47a/0x620 mm/mmap.c:3188
>  __mmput+0x122/0x470 kernel/fork.c:1152
>  mmput+0x58/0x60 kernel/fork.c:1173
>  exit_mm kernel/exit.c:501 [inline]
>  do_exit+0xae2/0x2a60 kernel/exit.c:812
>  do_group_exit+0x125/0x310 kernel/exit.c:922
>  __do_sys_exit_group kernel/exit.c:933 [inline]
>  __se_sys_exit_group kernel/exit.c:931 [inline]
>  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x43e969
> Code: Unable to access opcode bytes at RIP 0x43e93f.
> RSP: 002b:00007ffce2d3a7a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 00000000004b02f0 RCX: 000000000043e969
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004b02f0
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
> 
> =============================
> [ BUG: Invalid wait context ]
> 5.13.0-next-20210707-syzkaller #0 Tainted: G        W        
> -----------------------------
> syz-executor631/8467 is trying to lock:
> ffff888035ea6000 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: i_mmap_lock_read include/linux/fs.h:514 [inline]
> ffff888035ea6000 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: rmap_walk_file+0x52f/0x710 mm/rmap.c:2337
> other info that might help us debug this:
> context-{4:4}
> 1 lock held by syz-executor631/8467:
>  #0: ffff8880343e0978 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:359 [inline]
>  #0: ffff8880343e0978 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: map_pte mm/page_vma_mapped.c:52 [inline]
>  #0: ffff8880343e0978 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: page_vma_mapped_walk+0xd87/0x24f0 mm/page_vma_mapped.c:261
> stack backtrace:
> CPU: 0 PID: 8467 Comm: syz-executor631 Tainted: G        W         5.13.0-next-20210707-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
>  print_lock_invalid_wait_context kernel/locking/lockdep.c:4666 [inline]
>  check_wait_context kernel/locking/lockdep.c:4727 [inline]
>  __lock_acquire.cold+0x213/0x3ab kernel/locking/lockdep.c:4965
>  lock_acquire kernel/locking/lockdep.c:5625 [inline]
>  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
>  down_read+0x9a/0x440 kernel/locking/rwsem.c:1353
>  i_mmap_lock_read include/linux/fs.h:514 [inline]
>  rmap_walk_file+0x52f/0x710 mm/rmap.c:2337
>  rmap_walk+0x10d/0x190 mm/rmap.c:2366
>  page_mlock+0x448/0x650 mm/rmap.c:2029
>  __munlock_isolated_page+0x88/0x410 mm/mlock.c:122
>  __munlock_pagevec+0xd7f/0x2340 mm/mlock.c:322
>  munlock_vma_pages_range+0x9d7/0xf00 mm/mlock.c:475
>  munlock_vma_pages_all mm/internal.h:354 [inline]
>  unlock_range mm/mmap.c:2811 [inline]
>  exit_mmap+0x47a/0x620 mm/mmap.c:3188
>  __mmput+0x122/0x470 kernel/fork.c:1152
>  mmput+0x58/0x60 kernel/fork.c:1173
>  exit_mm kernel/exit.c:501 [inline]
>  do_exit+0xae2/0x2a60 kernel/exit.c:812
>  do_group_exit+0x125/0x310 kernel/exit.c:922
>  __do_sys_exit_group kernel/exit.c:933 [inline]
>  __se_sys_exit_group kernel/exit.c:931 [inline]
>  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x43e969
> Code: Unable to access opcode bytes at RIP 0x43e93f.
> RSP: 002b:00007ffce2d3a7a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 00000000004b02f0 RCX: 000000000043e969
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004b02f0
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
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

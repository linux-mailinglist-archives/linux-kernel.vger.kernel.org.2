Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EBB3B9100
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbhGALNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbhGALNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:13:20 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C4BC061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 04:10:49 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d9so3790254qtx.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=loo3kxtDTTKC5s2MMEWFo7j8wTG4bg5yCpaYGdH8riY=;
        b=Ek+morMnKxr0IV041StrTMph3Ms98f/s+qhTrKHFgygi1QAMr7nn++UO9QLFp4dE9B
         p/prz+R+xBmWyFkrp8mXr2t350qhMREoJ1bdpAM6XUqhoAZh/5krtmLhiJ45SpIvpj61
         z3SSlK9y54f5um8x/hpUUnWVKeGmP8HHw2v0p6T4hHYYJ4YIfgtzjG7mUFZgbd1rcfWB
         4jCMw4l+ZaJQayVgzrAOjRHylQr5mWprbDaV32cHu5vSXdorIaumQ7JavjWF0dqLOFjW
         nRzXBd4ruI6KP9PFNL24mqUr2Si2g2NNPyDZsD0sO6JceRci17h2G0Sa0mP4/POzDuqP
         x5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=loo3kxtDTTKC5s2MMEWFo7j8wTG4bg5yCpaYGdH8riY=;
        b=FFEi7NVcBsX1SN5ihAo2zAvAww8NhBswNjFAR8IhF4jvuKBEl5Vrw3wBNNm86oWF6O
         7kNK5N/cBF7H2NPH/c5/3P0Kq2CPEh29TAFWV5CnE5lUZUX1MYj/dD9+Fxe6bkxjpkta
         QVolgAUHCn/S5DxxixH/6A74NrpiF9ENedRMJsqlj0mXBr9CgjCt+NAjDs2CCEkiiT1W
         d7uP0q86kaHB76u/qkJU3vakooIeAeuaULXXeQMrAY1zTbYxv+l8mqjko13XO7ANEfMT
         /bHXjBiptfWjKYQVpj2AocQhZzdx+AlysxaM3jlYAYOt6m5RrjcajpxFZQ3rZxB44M6u
         XdBw==
X-Gm-Message-State: AOAM5339vIB9b8hPHXzd4VFWfCgnwnDgqEGVjw+KiZZcuBNnB9UObNl7
        +mUjPBLbf95f2kH2xD7uKEc8WfN5PiE+LQLPdgoqFg==
X-Google-Smtp-Source: ABdhPJw/0EamXfh/j7t+H+mp9gUQT3O1bYWaR8eKuAXnrbZHBpWA+38NZ9XojzrSggr5XtoZYkUoTznKcMVHZnCIyYo=
X-Received: by 2002:a05:622a:15cc:: with SMTP id d12mr35964132qty.67.1625137848606;
 Thu, 01 Jul 2021 04:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009e7f6405c60dbe3b@google.com>
In-Reply-To: <0000000000009e7f6405c60dbe3b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 1 Jul 2021 13:10:37 +0200
Message-ID: <CACT4Y+ZY4sOXQ0F5cumzpwo2V8TLN+kDAj=eAYWX4f5sqg993w@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: BUG: sleeping function called from
 invalid context in stack_depot_save
To:     syzbot <syzbot+e45919db2eab5e837646@syzkaller.appspotmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 1:00 PM syzbot
<syzbot+e45919db2eab5e837646@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    dbe69e43 Merge tag 'net-next-5.14' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1216d478300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=47e4697be2f5b985
> dashboard link: https://syzkaller.appspot.com/bug?extid=e45919db2eab5e837646
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e45919db2eab5e837646@syzkaller.appspotmail.com

+kasan-dev@ for for stack_depot_save warning

> BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 8436, name: syz-fuzzer
> INFO: lockdep is turned off.
> irq event stamp: 0
> hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> hardirqs last disabled at (0): [<ffffffff814406db>] copy_process+0x1e1b/0x74c0 kernel/fork.c:2061
> softirqs last  enabled at (0): [<ffffffff8144071c>] copy_process+0x1e5c/0x74c0 kernel/fork.c:2065
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> CPU: 1 PID: 8436 Comm: syz-fuzzer Tainted: G        W         5.13.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
>  ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
>  prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
>  __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
>  alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
>  stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
>  save_stack+0x15e/0x1e0 mm/page_owner.c:120
>  __set_page_owner+0x50/0x290 mm/page_owner.c:181
>  prep_new_page mm/page_alloc.c:2445 [inline]
>  __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
>  alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
>  vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
>  __vmalloc_area_node mm/vmalloc.c:2845 [inline]
>  __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2947
>  __vmalloc_node mm/vmalloc.c:2996 [inline]
>  vzalloc+0x67/0x80 mm/vmalloc.c:3066
>  n_tty_open+0x16/0x170 drivers/tty/n_tty.c:1914
>  tty_ldisc_open+0x9b/0x110 drivers/tty/tty_ldisc.c:464
>  tty_ldisc_setup+0x43/0x100 drivers/tty/tty_ldisc.c:781
>  tty_init_dev.part.0+0x1f4/0x610 drivers/tty/tty_io.c:1461
>  tty_init_dev include/linux/err.h:36 [inline]
>  tty_open_by_driver drivers/tty/tty_io.c:2102 [inline]
>  tty_open+0xb16/0x1000 drivers/tty/tty_io.c:2150
>  chrdev_open+0x266/0x770 fs/char_dev.c:414
>  do_dentry_open+0x4c8/0x11c0 fs/open.c:826
>  do_open fs/namei.c:3361 [inline]
>  path_openat+0x1c0e/0x27e0 fs/namei.c:3494
>  do_filp_open+0x190/0x3d0 fs/namei.c:3521
>  do_sys_openat2+0x16d/0x420 fs/open.c:1195
>  do_sys_open fs/open.c:1211 [inline]
>  __do_sys_openat fs/open.c:1227 [inline]
>  __se_sys_openat fs/open.c:1222 [inline]
>  __x64_sys_openat+0x13f/0x1f0 fs/open.c:1222
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4af20a
> Code: e8 3b 82 fb ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 4c 8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24 48
> RSP: 002b:000000c0003293f8 EFLAGS: 00000216 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 000000c00001e800 RCX: 00000000004af20a
> RDX: 0000000000000000 RSI: 000000c0001a5a50 RDI: ffffffffffffff9c
> RBP: 000000c000329470 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000216 R12: 00000000000001a6
> R13: 00000000000001a5 R14: 0000000000000200 R15: 000000c00029c280
> can: request_module (can-proto-0) failed.
> can: request_module (can-proto-0) failed.
> can: request_module (can-proto-0) failed.
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

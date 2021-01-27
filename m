Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9C3061B0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhA0RQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbhA0RPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:15:06 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9427BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:14:25 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id k193so2427055qke.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6E0YcVhaztWuKg3937K9sNFRPevDh+0eHVqBQSevYNk=;
        b=h8S755V7zwmgGcaFbiKUR3sWxxfQn0ZnHz/rm1J2rdEd2L/XJnSBd6RDJb3X1Hei8T
         +2byYqz+f1096gNJrnOI4QX2orrVz3hdZgG6yKwHXiRRR4JBZ6VYeDEfQfOdUrUjMdnv
         IEAOMKmzmNedLHah87IbOqnGbONPy20E4PXkEA4J+vBIOGSMvO7lWTutq5A7dYBMpmXq
         /88i3OUOwprMT53mO925dO/xTvy1SlRxCXLamvnQSaCVEGDJel4zbdS5Nf3I7z+js07n
         DMhqkLmDtEpFJYPHGuKqU0IuJbCNMBIORXTs0Icf6KTske1Jhtl7VbqOZNvF5WqdRP4a
         kewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6E0YcVhaztWuKg3937K9sNFRPevDh+0eHVqBQSevYNk=;
        b=tldQYsOB9HhAThoIfx9LFMP31yWGhTUdZbSyqQZXG+TYgC2beE3J2k7911OD/s0CTq
         AbYmJMSv5mBbuut2mbKVkzFtN7jUWcMpldN+MfSGufy2P8YWh+NLLyqUB27Gfo0qR7li
         MBY2AVYs9cQrz1QKCBJ2dKL/F5KCsFUaF1Dae6jysMxElOfgGmo/mVSH1yp8Tky7z55/
         Ualda3/R28yzAy3ZjijKsqXRh84OkFveT050W5yj6QyTSEiYNmhOCWzAHEwEgYL7jkRr
         7Rn/HRV4f/BHOAKs7fR3JQCo23Y1A9WKvqz9Uy4DIK3FEu7rBNRe4rN1lGVbH/cRSxTV
         IMOA==
X-Gm-Message-State: AOAM533EsqCbzSyH7z7YYFq6eMi0oXooIQdgO6rPi+k3hwfYjNMLSvAQ
        SildWyqeA3aDFixRllkQMs73+imQDalvc4NdtABBxA==
X-Google-Smtp-Source: ABdhPJxr3K+64gWqDEo+BzdmCSsByMO/kgU+o1NX+84vzrhHxTRWjWxkv503gl07BifHhIgqzTk+PJdYRJyqOTzFzLo=
X-Received: by 2002:a05:620a:711:: with SMTP id 17mr10449651qkc.501.1611767664536;
 Wed, 27 Jan 2021 09:14:24 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008d396205b9e4adee@google.com>
In-Reply-To: <0000000000008d396205b9e4adee@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Jan 2021 18:14:13 +0100
Message-ID: <CACT4Y+ZisDCO0w9O57tOp+7FL6VqJiFdxaRJ739rjW5z52PeXg@mail.gmail.com>
Subject: Re: KASAN: invalid-access Read in kmem_cache_destroy
To:     syzbot <syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com>
Cc:     amit.kachhap@arm.com, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, mbenes@suse.cz,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 5:58 PM syzbot
<syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12eb4ad8d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ad43be24faf1194c
> dashboard link: https://syzkaller.appspot.com/bug?extid=2a52b6c31dbefb1e9d9f
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com

This happens on arm64 instance with MTE enabled.
I don't see any corresponding reports on x86_64. So I would assume
it's a generic latent bug, or probably more likely a bug in MTE
support.

> loop0: detected capacity change from 131072 to 0
> F2FS-fs (loop0): Found nat_bits in checkpoint
> ==================================================================
> BUG: KASAN: invalid-access in kmem_cache_destroy+0x34/0x174 mm/slab_common.c:492
> Read at addr fbff00000cd1ef40 by task syz-executor.0/8859
> Pointer tag: [fb], memory tag: [fe]
>
> CPU: 0 PID: 8859 Comm: syz-executor.0 Not tainted 5.11.0-rc5-syzkaller-00037-g2ab38c17aac1 #0
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x0/0x1b0 arch/arm64/kernel/stacktrace.c:117
>  show_stack+0x1c/0x70 arch/arm64/kernel/stacktrace.c:196
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0xd0/0x12c lib/dump_stack.c:120
>  print_address_description+0x70/0x29c mm/kasan/report.c:230
>  __kasan_report mm/kasan/report.c:396 [inline]
>  kasan_report+0x104/0x200 mm/kasan/report.c:413
>  report_tag_fault arch/arm64/mm/fault.c:311 [inline]
>  do_tag_recovery arch/arm64/mm/fault.c:325 [inline]
>  __do_kernel_fault+0x17c/0x1c0 arch/arm64/mm/fault.c:369
>  do_bad_area arch/arm64/mm/fault.c:462 [inline]
>  do_tag_check_fault+0x78/0x8c arch/arm64/mm/fault.c:717
>  do_mem_abort+0x44/0xbc arch/arm64/mm/fault.c:793
>  el1_abort+0x40/0x6c arch/arm64/kernel/entry-common.c:118
>  el1_sync_handler+0xb0/0xcc arch/arm64/kernel/entry-common.c:209
>  el1_sync+0x70/0x100 arch/arm64/kernel/entry.S:656
>  kmem_cache_destroy+0x34/0x174 mm/slab_common.c:492
>  f2fs_recover_fsync_data+0x60c/0x1cc0 fs/f2fs/recovery.c:869
>  f2fs_fill_super+0x174c/0x1e8c fs/f2fs/super.c:3804
>  mount_bdev+0x1c4/0x1f0 fs/super.c:1366
>  f2fs_mount+0x1c/0x30 fs/f2fs/super.c:3962
>  legacy_get_tree+0x34/0x64 fs/fs_context.c:592
>  vfs_get_tree+0x2c/0xf0 fs/super.c:1496
>  do_new_mount fs/namespace.c:2881 [inline]
>  path_mount+0x3e8/0xaf0 fs/namespace.c:3211
>  do_mount fs/namespace.c:3224 [inline]
>  __do_sys_mount fs/namespace.c:3432 [inline]
>  __se_sys_mount fs/namespace.c:3409 [inline]
>  __arm64_sys_mount+0x1a8/0x2fc fs/namespace.c:3409
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
>  el0_svc_common.constprop.0+0x74/0x190 arch/arm64/kernel/syscall.c:159
>  do_el0_svc+0x78/0x90 arch/arm64/kernel/syscall.c:198
>  el0_svc+0x14/0x20 arch/arm64/kernel/entry-common.c:365
>  el0_sync_handler+0x1a8/0x1b0 arch/arm64/kernel/entry-common.c:381
>  el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:699
>
> Allocated by task 8858:
>  stack_trace_save+0x50/0x80 kernel/stacktrace.c:121
>  kasan_save_stack+0x2c/0x60 mm/kasan/common.c:38
>  kasan_set_track mm/kasan/common.c:46 [inline]
>  set_alloc_info mm/kasan/common.c:401 [inline]
>  ____kasan_kmalloc+0xe8/0x160 mm/kasan/common.c:429
>  __kasan_slab_alloc+0x20/0x30 mm/kasan/common.c:437
>  kasan_slab_alloc include/linux/kasan.h:209 [inline]
>  slab_post_alloc_hook mm/slab.h:512 [inline]
>  slab_alloc_node mm/slub.c:2892 [inline]
>  slab_alloc mm/slub.c:2900 [inline]
>  kmem_cache_alloc+0x1b0/0x310 mm/slub.c:2905
>  kmem_cache_zalloc include/linux/slab.h:672 [inline]
>  create_cache mm/slab_common.c:246 [inline]
>  kmem_cache_create_usercopy+0x148/0x2ac mm/slab_common.c:352
>  kmem_cache_create+0x20/0x30 mm/slab_common.c:410
>  f2fs_kmem_cache_create fs/f2fs/f2fs.h:2411 [inline]
>  f2fs_recover_fsync_data+0x7c/0x1cc0 fs/f2fs/recovery.c:790
>  f2fs_fill_super+0x174c/0x1e8c fs/f2fs/super.c:3804
>  mount_bdev+0x1c4/0x1f0 fs/super.c:1366
>  f2fs_mount+0x1c/0x30 fs/f2fs/super.c:3962
>  legacy_get_tree+0x34/0x64 fs/fs_context.c:592
>  vfs_get_tree+0x2c/0xf0 fs/super.c:1496
>  do_new_mount fs/namespace.c:2881 [inline]
>  path_mount+0x3e8/0xaf0 fs/namespace.c:3211
>  do_mount fs/namespace.c:3224 [inline]
>  __do_sys_mount fs/namespace.c:3432 [inline]
>  __se_sys_mount fs/namespace.c:3409 [inline]
>  __arm64_sys_mount+0x1a8/0x2fc fs/namespace.c:3409
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
>  el0_svc_common.constprop.0+0x74/0x190 arch/arm64/kernel/syscall.c:159
>  do_el0_svc+0x78/0x90 arch/arm64/kernel/syscall.c:198
>  el0_svc+0x14/0x20 arch/arm64/kernel/entry-common.c:365
>  el0_sync_handler+0x1a8/0x1b0 arch/arm64/kernel/entry-common.c:381
>  el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:699
>
> Freed by task 8858:
>  stack_trace_save+0x50/0x80 kernel/stacktrace.c:121
>  kasan_save_stack+0x2c/0x60 mm/kasan/common.c:38
>  kasan_set_track+0x2c/0x40 mm/kasan/common.c:46
>  kasan_set_free_info+0x24/0x30 mm/kasan/hw_tags.c:178
>  ____kasan_slab_free.constprop.0+0x184/0x1c0 mm/kasan/common.c:362
>  __kasan_slab_free+0x14/0x20 mm/kasan/common.c:369
>  kasan_slab_free include/linux/kasan.h:192 [inline]
>  slab_free_hook mm/slub.c:1547 [inline]
>  slab_free_freelist_hook+0x9c/0x190 mm/slub.c:1580
>  slab_free mm/slub.c:3143 [inline]
>  kmem_cache_free+0xa0/0x460 mm/slub.c:3159
>  slab_kmem_cache_release+0x34/0x4c mm/slab_common.c:479
>  kmem_cache_release+0x18/0x24 mm/slub.c:5535
>  kobject_cleanup lib/kobject.c:705 [inline]
>  kobject_release lib/kobject.c:736 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x74/0x11c lib/kobject.c:753
>  sysfs_slab_release+0x2c/0x40 mm/slub.c:5659
>  shutdown_cache mm/slab_common.c:466 [inline]
>  kmem_cache_destroy+0x134/0x174 mm/slab_common.c:498
>  f2fs_recover_fsync_data+0x60c/0x1cc0 fs/f2fs/recovery.c:869
>  f2fs_fill_super+0x174c/0x1e8c fs/f2fs/super.c:3804
>  mount_bdev+0x1c4/0x1f0 fs/super.c:1366
>  f2fs_mount+0x1c/0x30 fs/f2fs/super.c:3962
>  legacy_get_tree+0x34/0x64 fs/fs_context.c:592
>  vfs_get_tree+0x2c/0xf0 fs/super.c:1496
>  do_new_mount fs/namespace.c:2881 [inline]
>  path_mount+0x3e8/0xaf0 fs/namespace.c:3211
>  do_mount fs/namespace.c:3224 [inline]
>  __do_sys_mount fs/namespace.c:3432 [inline]
>  __se_sys_mount fs/namespace.c:3409 [inline]
>  __arm64_sys_mount+0x1a8/0x2fc fs/namespace.c:3409
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
>  el0_svc_common.constprop.0+0x74/0x190 arch/arm64/kernel/syscall.c:159
>  do_el0_svc+0x78/0x90 arch/arm64/kernel/syscall.c:198
>  el0_svc+0x14/0x20 arch/arm64/kernel/entry-common.c:365
>  el0_sync_handler+0x1a8/0x1b0 arch/arm64/kernel/entry-common.c:381
>  el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:699
>
> The buggy address belongs to the object at ffff00000cd1ef00
>  which belongs to the cache kmem_cache of size 216
> The buggy address is located 64 bytes inside of
>  216-byte region [ffff00000cd1ef00, ffff00000cd1efd8)
> The buggy address belongs to the page:
> page:0000000028de1119 refcount:1 mapcount:0 mapping:0000000000000000 index:0xf0ff00000cd1ec00 pfn:0x4cd1e
> flags: 0x1ffffc000000200(slab)
> raw: 01ffffc000000200 dead000000000100 dead000000000122 f1ff000004001000
> raw: f0ff00000cd1ec00 000000008010000a 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff00000cd1ed00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>  ffff00000cd1ee00: f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 fe fe
> >ffff00000cd1ef00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>                                ^
>  ffff00000cd1f000: f4 f4 f4 f4 fe fe fe fe f9 f9 f9 f9 fe fe fe fe
>  ffff00000cd1f100: f9 f9 f9 f9 fe fe fe fe f1 f1 f1 f1 fe fe fe fe
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000008d396205b9e4adee%40google.com.

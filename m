Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF9F371270
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhECI22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhECI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:28:26 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F95C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 01:27:33 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x8so4304561qkl.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gvW+fIFuwRmL3iI4aswueq3yVS6l6eXCxLvWIVs7usg=;
        b=geXVZQ2icewnd6bmAXx5gSRqScPVUewy3/pA56ufZTk23EaIMjMK+4mLwMZfZzioId
         rS/lsblzKqVcMH9pwa0ZnByZZc0QJs8+X4bKJoztYJYre+IpQR1s+s5L3ewBHJbGzlxr
         BN41cgPi4ID74uDmXlT2gf2ls7ajSq+dEDNE3I36JHeoXlX+XGsxe5Ff2qLGb4AyXYCt
         IaYQXv4A9UYQfeutRqijTUwnX75OXxCdXGLhjRoIA0j05LyuQ08L/RJ0sTOYAFpvUO7n
         4JdCw3zmi06NxhmdhPNiYkavkBaxLrDHiEz9IlSPVWmG7z5lRoFQOLS8p8FLN3l3idnb
         kAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvW+fIFuwRmL3iI4aswueq3yVS6l6eXCxLvWIVs7usg=;
        b=G+8Wlc14oOrFhA08kr2iPIM1/7Pc310cpf4XgnXiZDSuiSV7Tv+vI4DMHBKt2UfYSa
         CxLz5YQDUEDJCRH8SR3nT7jMhGiHS/QEYS42STtsp1FCfISBaMA//1kJcDUsDfflvcTE
         4viD6hhL/bc7cdXzr68ae6s0JvAzzDBqdK1OiTzQeWY5MyALY+Lc9I+VjpmCgO6oKbTL
         On4THim9+lDNrsiNHM5jKnQMhr/JZtQ19nbhoPbnUtiMtw5NzHEjypq20P91kIrj9sXL
         cX/Xa+5Fh3HTCoElNN4r0Yscq4OecOJzNsz02RXCxhoPCA+SQd+1ZOvLBb5/1qaPKkxG
         3ATA==
X-Gm-Message-State: AOAM533WhhspPycrU2HRJwST+arLNP0av76g080X6dH5EdyJPuNOmhIF
        3jHynon8FJCgZv05HI2y9fqsYhayYZgf4QiaE+mJHDIt5xLsmw==
X-Google-Smtp-Source: ABdhPJzABcCe9MTFn8MqxE4trlLAzKhCt0lIRLq4eZgwsW8pk7EfBsW+hzQVjWAfbC1af9WHXd8muCHkik9DbbKXsC8=
X-Received: by 2002:a37:4042:: with SMTP id n63mr17708797qka.501.1620030452655;
 Mon, 03 May 2021 01:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003f654905c168b09d@google.com>
In-Reply-To: <0000000000003f654905c168b09d@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 May 2021 10:27:21 +0200
Message-ID: <CACT4Y+Zi_femntmu0qtUz1q1gbxs-0VNrLUULzY1bd+hrBngHA@mail.gmail.com>
Subject: Re: [syzbot] KFENCE: use-after-free in kmem_cache_destroy
To:     syzbot <syzbot+9d90dad32dd9727ed084@syzkaller.appspotmail.com>
Cc:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 10:24 AM syzbot
<syzbot+9d90dad32dd9727ed084@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f19ca5d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=53fdf14defd48c56
> dashboard link: https://syzkaller.appspot.com/bug?extid=9d90dad32dd9727ed084
> compiler:       Debian clang version 11.0.1-2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9d90dad32dd9727ed084@syzkaller.appspotmail.com

This looks like a bug in F2FS.
Interestingly this was detected by ARM MTE before but was
mis-root-caused I think:
https://lore.kernel.org/lkml/0000000000008d396205b9e4adee@google.com/
This can't be detected by KASAN directly because it doesn't instrument
mm/slab*. This can only be detected by MTE/KFENCE.


> ==================================================================
> BUG: KFENCE: use-after-free write in kmem_cache_destroy+0x1f/0x120 mm/slab_common.c:486
>
> Use-after-free write at 0xffff88823bc16040 (in kfence-#10):
>  kmem_cache_destroy+0x1f/0x120 mm/slab_common.c:486
>  f2fs_recover_fsync_data+0x75b0/0x8380 fs/f2fs/recovery.c:869
>  f2fs_fill_super+0x9393/0xa420 fs/f2fs/super.c:3945
>  mount_bdev+0x26c/0x3a0 fs/super.c:1367
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592
>  vfs_get_tree+0x86/0x270 fs/super.c:1497
>  do_new_mount fs/namespace.c:2905 [inline]
>  path_mount+0x196f/0x2be0 fs/namespace.c:3235
>  do_mount fs/namespace.c:3248 [inline]
>  __do_sys_mount fs/namespace.c:3456 [inline]
>  __se_sys_mount+0x2f9/0x3b0 fs/namespace.c:3433
>  do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> kfence-#10 [0xffff88823bc16000-0xffff88823bc160df, size=224, cache=kmem_cache] allocated by task 15453:
>  kmem_cache_zalloc include/linux/slab.h:676 [inline]
>  create_cache mm/slab_common.c:247 [inline]
>  kmem_cache_create_usercopy+0x12a/0x2f0 mm/slab_common.c:350
>  kmem_cache_create+0xf/0x20 mm/slab_common.c:405
>  f2fs_kmem_cache_create fs/f2fs/f2fs.h:2463 [inline]
>  f2fs_recover_fsync_data+0x1f0/0x8380 fs/f2fs/recovery.c:790
>  f2fs_fill_super+0x9393/0xa420 fs/f2fs/super.c:3945
>  mount_bdev+0x26c/0x3a0 fs/super.c:1367
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592
>  vfs_get_tree+0x86/0x270 fs/super.c:1497
>  do_new_mount fs/namespace.c:2905 [inline]
>  path_mount+0x196f/0x2be0 fs/namespace.c:3235
>  do_mount fs/namespace.c:3248 [inline]
>  __do_sys_mount fs/namespace.c:3456 [inline]
>  __se_sys_mount+0x2f9/0x3b0 fs/namespace.c:3433
>  do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> freed by task 15448:
>  kobject_cleanup+0x1c9/0x280 lib/kobject.c:705
>  shutdown_cache mm/slab_common.c:463 [inline]
>  kmem_cache_destroy+0x93/0x120 mm/slab_common.c:492
>  f2fs_recover_fsync_data+0x75b0/0x8380 fs/f2fs/recovery.c:869
>  f2fs_fill_super+0x9393/0xa420 fs/f2fs/super.c:3945
>  mount_bdev+0x26c/0x3a0 fs/super.c:1367
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592
>  vfs_get_tree+0x86/0x270 fs/super.c:1497
>  do_new_mount fs/namespace.c:2905 [inline]
>  path_mount+0x196f/0x2be0 fs/namespace.c:3235
>  do_mount fs/namespace.c:3248 [inline]
>  __do_sys_mount fs/namespace.c:3456 [inline]
>  __se_sys_mount+0x2f9/0x3b0 fs/namespace.c:3433
>  do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> CPU: 0 PID: 15453 Comm: syz-executor.0 Not tainted 5.12.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:kmem_cache_destroy+0x1f/0x120 mm/slab_common.c:488
> Code: 0f 1f 84 00 00 00 00 00 0f 1f 00 48 85 ff 0f 84 09 01 00 00 41 57 41 56 53 48 89 fb 48 c7 c7 b8 07 dc 8c 31 f6 e8 b1 c3 00 08 <ff> 4b 40 0f 85 c0 00 00 00 48 89 df e8 20 a2 14 00 48 89 df e8 18
> RSP: 0018:ffffc900030af320 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff88823bc16000 RCX: 0000000000000001
> RDX: 0000000000000001 RSI: 0000000000000008 RDI: 0000000000000001
> RBP: ffffc900030af870 R08: dffffc0000000000 R09: fffffbfff19b80f8
> R10: fffffbfff19b80f8 R11: 0000000000000000 R12: ffff88808c3a4000
> R13: dffffc0000000000 R14: 0000000000000000 R15: 1ffff92000615eb0
> FS:  00007f60a5228700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88823bc16040 CR3: 000000001ccd8000 CR4: 00000000001526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  f2fs_recover_fsync_data+0x75b0/0x8380 fs/f2fs/recovery.c:869
>  f2fs_fill_super+0x9393/0xa420 fs/f2fs/super.c:3945
>  mount_bdev+0x26c/0x3a0 fs/super.c:1367
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592
>  vfs_get_tree+0x86/0x270 fs/super.c:1497
>  do_new_mount fs/namespace.c:2905 [inline]
>  path_mount+0x196f/0x2be0 fs/namespace.c:3235
>  do_mount fs/namespace.c:3248 [inline]
>  __do_sys_mount fs/namespace.c:3456 [inline]
>  __se_sys_mount+0x2f9/0x3b0 fs/namespace.c:3433
>  do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x467b1a
> Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f60a5227fa8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 0000000000467b1a
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f60a5228000
> RBP: 00007f60a5228040 R08: 00007f60a5228040 R09: 0000000020000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
> R13: 0000000020000100 R14: 00007f60a5228000 R15: 0000000020014b00
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000003f654905c168b09d%40google.com.

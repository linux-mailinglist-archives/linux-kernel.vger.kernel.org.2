Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D484239E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbhJFIqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbhJFIqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:46:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2522CC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:45:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so1759049pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CsCbYjz8dFz00N87257DDnN4ifuXdxMfNWH4KsglU/8=;
        b=du3XiuPXZsJp3KNSSLGlhwG2xCw1DtESyh3x3vyqD4E7NLXDeuj8fRaNex4c2GEqpQ
         WnlFnjcNxbDBT7yj+F88RnSfyqQ04AYuOig/1kVotz97lv/9y4t6zI7Fb6+eIvhPmHr8
         7J9HNBC2Ddci9lxwAtUq505xNbhP6nMDFNGV6rDPMebVdEHPnfAYuL8NWuSmEplK9lzS
         6mYN4q5GOlr9VMekfpk7f3wka+8KKNf2EglxrD6AOMZovsEwrzvBd0QwXYPRGvRP0qY9
         9j2Svl7PyfcLeXhpiaT2EwEeVQea/UnJ3PgRmwRMYRaRXvLSARqjar6pSmTHWa38pWBx
         qnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CsCbYjz8dFz00N87257DDnN4ifuXdxMfNWH4KsglU/8=;
        b=pNHkBU9X5HwWWOGLgdh9QyA9UsCe0nBtyXbMzoJBXQE7nW9yT+LULM/KbTWbygg74u
         c2wQeEFJLIX3ARGyTTcWexQMRaUfNrisfx7bG7eWfObFrk2AlIhk36e50aZo/REeDtlq
         oezfXsqvlR4ghfEt25Fh1YqfIXBojhTZ3/P2u/zd+CsZF2xWVrXRfMTasBKnqEbGWG35
         nRxnZEfYrMnLuiPpnR8UoBPC+hvEmJ1RuDvIkHhPXOKzDNr6LLjpZbjosrn9tMswVtkj
         Ipf5w69LgpPwsOmsfJmDD9HkuCYQxxl5I5TDSXABexDpYx1C1jHW6gwYrqGV8RBKTHwT
         YiIw==
X-Gm-Message-State: AOAM533mlx/qn3sT3pBPBS+IVhpfe1w/aeJD+9fnCT1uQMLjLt9fFqBR
        Ypa+Zg5iZN/03XZb/NVNZK4Y7hrWEzjx0UJ3jAw7uYep63Ef8uE=
X-Google-Smtp-Source: ABdhPJzMmEs1ZhGyHEZwEduVCp/vaUPJr7zme16UC0oAK7UArY3e1SHJ+JoKRVO8RiWgaNHvTI9P8l7Biaqo9uo6VGE=
X-Received: by 2002:a17:903:2341:b0:13e:ae30:412 with SMTP id
 c1-20020a170903234100b0013eae300412mr9876635plh.15.1633509900415; Wed, 06 Oct
 2021 01:45:00 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 6 Oct 2021 16:44:49 +0800
Message-ID: <CACkBjsYganRrN=WjgcotH1RdZ99_6mPuy=GhsFrq2CUNOUrpbA@mail.gmail.com>
Subject: kernel BUG in jfs_evict_inode
To:     jfs-discussion@lists.sourceforge.net, shaggy@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 0513e464f900 Merge tag 'perf-tools-fixes-for-v5.15-2021-09-27'
git tree: upstream
console output:
https://drive.google.com/file/d/1NSVdsjViaEUbSeaWVC-UYThJlWp0lvVW/view?usp=sharing
kernel config: https://drive.google.com/file/d/1Jqhc4DpCVE8X7d-XBdQnrMoQzifTG5ho/view?usp=sharing
C reproducer: https://drive.google.com/file/d/184Rm6ijCSvoPQ5yHX7LOzbjXVtx7lyvN/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/12c_LoGNiQQOutVwi3b2XL83fDTG_BpdB/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

------------[ cut here ]------------
kernel BUG at fs/jfs/inode.c:168!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 2759 Comm: syz-executor Not tainted 5.15.0-rc3+ #21
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:jfs_evict_inode+0x157/0x1a0 fs/jfs/inode.c:168
Code: 83 78 28 00 74 0d e8 48 b5 7f ff 48 89 df e8 c0 de 00 00 e8 3b
b5 7f ff 48 89 df e8 33 25 b1 ff e9 fb fe ff ff e8 29 b5 7f ff <0f> 0b
e8 22 b5 7f ff 48 89 df e8 1a 34 00 00 eb b4 e8 13 b5 7f ff
RSP: 0018:ffffc90000867d68 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888018cb41a8 RCX: 0000000000000000
RDX: ffff8880167ec500 RSI: ffffffff81b7dc37 RDI: ffff888018cb41a8
RBP: ffffffff81b7dae0 R08: 0000000000000001 R09: 0000000000000001
R10: ffffc90000867ce8 R11: 0000000000000001 R12: ffffffff84964600
R13: ffffffff853a64cd R14: ffff88801a91d980 R15: ffff88801a91d000
FS:  00000000025cb940(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc3c3d0da4 CR3: 0000000016458000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 evict+0xfd/0x1e0 fs/inode.c:588
 dispose_list+0x61/0x90 fs/inode.c:621
 evict_inodes+0x194/0x1f0 fs/inode.c:671
 generic_shutdown_super+0x45/0x170 fs/super.c:454
 kill_block_super+0x2c/0x60 fs/super.c:1395
 deactivate_locked_super+0x43/0x80 fs/super.c:335
 deactivate_super+0x53/0x80 fs/super.c:366
 cleanup_mnt+0x138/0x1b0 fs/namespace.c:1137
 task_work_run+0x86/0xd0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x271/0x280 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x40/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46c777
Code: ff d0 48 89 c7 b8 3c 00 00 00 0f 05 48 c7 c1 bc ff ff ff f7 d8
64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc3c3d14d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000046c777
RDX: 0000000000404e22 RSI: 0000000000000002 RDI: 00007ffc3c3d15a0
RBP: 00007ffc3c3d15a0 R08: 00000000025d5033 R09: 000000000000000b
R10: 00000000fffffffb R11: 0000000000000246 R12: 00000000004e38c6
R13: 00007ffc3c3d2650 R14: 00007ffc3c3d264c R15: 0000000000000010
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace a937ecc93c68ee05 ]---
RIP: 0010:jfs_evict_inode+0x157/0x1a0 fs/jfs/inode.c:168
Code: 83 78 28 00 74 0d e8 48 b5 7f ff 48 89 df e8 c0 de 00 00 e8 3b
b5 7f ff 48 89 df e8 33 25 b1 ff e9 fb fe ff ff e8 29 b5 7f ff <0f> 0b
e8 22 b5 7f ff 48 89 df e8 1a 34 00 00 eb b4 e8 13 b5 7f ff
RSP: 0018:ffffc90000867d68 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888018cb41a8 RCX: 0000000000000000
RDX: ffff8880167ec500 RSI: ffffffff81b7dc37 RDI: ffff888018cb41a8
RBP: ffffffff81b7dae0 R08: 0000000000000001 R09: 0000000000000001
R10: ffffc90000867ce8 R11: 0000000000000001 R12: ffffffff84964600
R13: ffffffff853a64cd R14: ffff88801a91d980 R15: ffff88801a91d000
FS:  00000000025cb940(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc3c3d0da4 CR3: 0000000016458000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554

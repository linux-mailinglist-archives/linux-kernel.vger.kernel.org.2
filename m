Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD0B43BF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbhJ0Bkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhJ0Bkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:40:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51384C061570;
        Tue, 26 Oct 2021 18:38:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k2-20020a17090ac50200b001a218b956aaso864042pjt.2;
        Tue, 26 Oct 2021 18:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=oYQVmMJEoaZXJx1iKV6fcufM5Yl2qMlRosIGlfzyPlU=;
        b=bNsqkIWVoVMFeZa1vRGFiIDhiVzMn/Id4C9vIP+rktDQwZdzeilXjcIn97SzbyZlIR
         1V9spmKxX/OVxdtDFA2Bb0xTTY+6eb7pVchezAe/N/40duF3MtWcAINQdCbCk3NeXIo1
         LczfMvLR29KbLHce+QmOHwLpfWGf0Rwz1h6wzoyUzBdxfw70bY2gNmO9BzEkoYapucMr
         ZUZANyPdzPTrBWjB1cCem37hmdpl4a5xrDBaHVGwLtu5cdAgnfxfSyBoMLQpvmxYtXm5
         ixy0adXkLWr2RiJAD0llqIFgytyDTApfolTazbz26GPIZ6PWSDYZBqxF9jyRG8SDP4/H
         5MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oYQVmMJEoaZXJx1iKV6fcufM5Yl2qMlRosIGlfzyPlU=;
        b=K2Tv53HCxvF26LK65DD9/5kdkKFlBhoONwEeAJHYmIQnMIIedOIpyOdM6BO1Do89Yq
         OQ0XHjjfCww+NXklEZsLhP7/yGAJPUSsB0LIKJvxIg4iEYNRAlyrsJjh0JWYH4Lnz6+K
         JaicvzVL3z+GAexGwiIQbjNNvRYKWKbhoCjsL4nwweVujg/Ee16grZmnHBnKjKPZb06l
         fZ2tgmm94xop3M2870J67LKdXAh5pTAyKs+dCY46IaRG0/rlxIzmx4QIfLU8nRN1sgvQ
         hp6uTE6qpcTJf1+zzMAIEoCRkvw3NhFhxtUWUADO+4dh/SSQzRZm0M6CKQmqt7mn5jLV
         cgMg==
X-Gm-Message-State: AOAM533x7HGYao/SymJW/e5fKHp11iIQpDlIFlj4Bbd6EjxGL8KXeAhT
        MLy5yMU3AFQogZY1H9VJc8vC9aInvV3xlB/jvoZtfiZz0umULVcWWw==
X-Google-Smtp-Source: ABdhPJxiH3dKp0MG13LU2NMoeyhmg1JgXw3tMa+YW0ty4p0V3Pi6v6hOWnuZohNY2BZDlMQQ0473hRrMuqvWaGJUsOM=
X-Received: by 2002:a17:90a:a78f:: with SMTP id f15mr2561040pjq.106.1635298702649;
 Tue, 26 Oct 2021 18:38:22 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 27 Oct 2021 09:38:09 +0800
Message-ID: <CACkBjsaFTVOA-dhRuw8OLG8GWjTPy3yR9sSVXGD46as7i2-rUg@mail.gmail.com>
Subject: kernel BUG in nilfs_mdt_destroy
To:     konishi.ryusuke@gmail.com, linux-nilfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 519d81956ee2 Linux 5.15-rc6
git tree: upstream
console output:
https://drive.google.com/file/d/1kiBZK6oiSXPTCnvaFCepaFbsxSfO1KTC/view?usp=sharing
kernel config: https://drive.google.com/file/d/12PUnxIM1EPBgW4ZJmI7WJBRaY1lA83an/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

loop15: detected capacity change from 0 to 4081
NILFS (loop15): broken superblock, retrying with spare superblock
(blocksize = 1024)
NILFS (loop15): broken superblock, retrying with spare superblock
(blocksize = 2048)
NILFS (loop15): mounting unchecked fs
NILFS (loop15): recovery complete
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 PID: 16429 Comm: syz-executor Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail.cold+0x5/0xa lib/fault-inject.c:146
 should_failslab+0x5/0x10 mm/slab_common.c:1328
 slab_pre_alloc_hook mm/slab.h:494 [inline]
 slab_alloc_node mm/slub.c:3120 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 kmem_cache_alloc+0x62/0x340 mm/slub.c:3219
 kmem_cache_zalloc include/linux/slab.h:711 [inline]
 lsm_inode_alloc security/security.c:593 [inline]
 security_inode_alloc+0x34/0x160 security/security.c:1018
 inode_init_always+0x603/0xe50 fs/inode.c:170
 alloc_inode+0x82/0x1e0 fs/inode.c:244
 new_inode_pseudo+0x14/0xe0 fs/inode.c:938
 new_inode+0x1b/0x40 fs/inode.c:967
 nilfs_new_inode+0xca/0x7e0 fs/nilfs2/inode.c:333
 nilfs_create+0xfe/0x300 fs/nilfs2/namei.c:85
 lookup_open+0xfae/0x13a0 fs/namei.c:3282
 open_last_lookups fs/namei.c:3352 [inline]
 path_openat+0xa93/0x2710 fs/namei.c:3558
 do_filp_open+0x1c1/0x290 fs/namei.c:3588
 do_sys_openat2+0x61b/0x9a0 fs/open.c:1200
 do_sys_open+0xc3/0x140 fs/open.c:1216
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f13bd8dcc4d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f13bae44c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f13bda030a0 RCX: 00007f13bd8dcc4d
RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000020005580
RBP: 00007f13bae44c90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000a
R13: 00007ffd7026ebdf R14: 00007ffd7026ed80 R15: 00007f13bae44dc0
page:ffffea0000053000 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x14c0
flags: 0xfff00000001000(reserved|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000001000 ffffea0000053008 ffffea0000053008 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(!PageCompound(page))
page_owner info is not present (never set?)
------------[ cut here ]------------
kernel BUG at mm/slub.c:3516!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 16429 Comm: syz-executor Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:free_nonslab_page mm/slub.c:3516 [inline]
RIP: 0010:free_nonslab_page mm/slub.c:3512 [inline]
RIP: 0010:kfree+0x6d1/0x700 mm/slub.c:4540
Code: 5e 41 5f e9 31 f3 ff ff 0f 0b 48 c7 c6 80 6c 18 8b 4c 89 e7 e8
20 c3 ec ff 0f 0b 48 c7 c6 58 14 1a 8b 4c 89 e7 e8 0f c3 ec ff <0f> 0b
e8 b8 8b 75 07 e9 26 ff ff ff 8b 75 1c 48 89 df e8 48 f2 28
RSP: 0018:ffffc90004dff680 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffffffff814c0d90 RCX: 0000000000040000
RDX: ffffc90001ac1000 RSI: ffff888024289c80 RDI: 0000000000000002
RBP: ffff8881088d0200 R08: ffffffff81bd5321 R09: 0000000000000000
R10: 0000000000000005 R11: ffffed100c7c3f53 R12: ffffea0000053000
R13: ffff888033efd8c8 R14: ffff88801d8c2000 R15: ffff888033efd8f0
FS:  00007f13bae45700(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000400000 CR3: 0000000016eed000 CR4: 0000000000350ef0
Call Trace:
 nilfs_mdt_destroy+0x59/0x80 fs/nilfs2/mdt.c:486
 nilfs_free_inode+0x3e/0x60 fs/nilfs2/super.c:167
 i_callback+0x3f/0x70 fs/inode.c:226
 alloc_inode+0x13e/0x1e0 fs/inode.c:251
 new_inode_pseudo+0x14/0xe0 fs/inode.c:938
 new_inode+0x1b/0x40 fs/inode.c:967
 nilfs_new_inode+0xca/0x7e0 fs/nilfs2/inode.c:333
 nilfs_create+0xfe/0x300 fs/nilfs2/namei.c:85
 lookup_open+0xfae/0x13a0 fs/namei.c:3282
 open_last_lookups fs/namei.c:3352 [inline]
 path_openat+0xa93/0x2710 fs/namei.c:3558
 do_filp_open+0x1c1/0x290 fs/namei.c:3588
 do_sys_openat2+0x61b/0x9a0 fs/open.c:1200
 do_sys_open+0xc3/0x140 fs/open.c:1216
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f13bd8dcc4d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f13bae44c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f13bda030a0 RCX: 00007f13bd8dcc4d
RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000020005580
RBP: 00007f13bae44c90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000a
R13: 00007ffd7026ebdf R14: 00007ffd7026ed80 R15: 00007f13bae44dc0
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 07725c0702aaad66 ]---
RIP: 0010:free_nonslab_page mm/slub.c:3516 [inline]
RIP: 0010:free_nonslab_page mm/slub.c:3512 [inline]
RIP: 0010:kfree+0x6d1/0x700 mm/slub.c:4540
Code: 5e 41 5f e9 31 f3 ff ff 0f 0b 48 c7 c6 80 6c 18 8b 4c 89 e7 e8
20 c3 ec ff 0f 0b 48 c7 c6 58 14 1a 8b 4c 89 e7 e8 0f c3 ec ff <0f> 0b
e8 b8 8b 75 07 e9 26 ff ff ff 8b 75 1c 48 89 df e8 48 f2 28
RSP: 0018:ffffc90004dff680 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffffffff814c0d90 RCX: 0000000000040000
RDX: ffffc90001ac1000 RSI: ffff888024289c80 RDI: 0000000000000002
RBP: ffff8881088d0200 R08: ffffffff81bd5321 R09: 0000000000000000
R10: 0000000000000005 R11: ffffed100c7c3f53 R12: ffffea0000053000
R13: ffff888033efd8c8 R14: ffff88801d8c2000 R15: ffff888033efd8f0
FS:  00007f13bae45700(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000400000 CR3: 0000000016eed000 CR4: 0000000000350ef0

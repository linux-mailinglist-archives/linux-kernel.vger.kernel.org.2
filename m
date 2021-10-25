Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C2943945B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhJYLAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 07:00:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33618 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbhJYK7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 06:59:49 -0400
Received: by mail-io1-f71.google.com with SMTP id f19-20020a6b6213000000b005ddc4ce4deeso8667081iog.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 03:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UgzLiOp3iosmtzBxr4JSPZBO9gLvzYtB+2EUMFiDcFQ=;
        b=FbwaxRoNns3UFYVPZKPCTL4tUQnWcvzvUME2ZtqOQWhxskDPNi2h5LJYAM30Hav535
         /QGvqO/DsPODHgI5gvZPJzpflexa6bhpEkJWFtK95OmoNBgOojF7NPLSNL3aN/YbY9Cv
         DI/12yP27e8DSGSm9M8kX8C+GNuHbnDg8KBxF1Fj3yDo8Kv8m+CqIAyRSuGOfY/OUE2e
         dOobC4zSpBeeGUHPvmWUeZmLVqR7SbUs2wXSytiOg7keh5xdJt85xaVq0vR+QVJbdYB5
         0gX524qT4fz3i/ShDystPM7rlPphYUUQCTf0f169aNeDZGglhEws07ef/4m+16IN0ufa
         iSwA==
X-Gm-Message-State: AOAM532bAT81nIB0saFlAs4TmhLznJiWp4idw1PrVRkm8qsRFhFKDBqy
        YZBr60uUFSiP+0hdBHywmX+4m3ii7iunfujdHrMCBcChDwj8
X-Google-Smtp-Source: ABdhPJx89xRpBxetAUfz3j3ZtFt5oLVCsC8YeYG1sd1KsAgGYXxsrh4ArfZ665nl9PSmaTNbfZYVpUGs4dhT0uNPQQpf1Jln0PDW
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c2:: with SMTP id l2mr9734505ios.147.1635159447226;
 Mon, 25 Oct 2021 03:57:27 -0700 (PDT)
Date:   Mon, 25 Oct 2021 03:57:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000cdf805cf2b3aca@google.com>
Subject: [syzbot] general protection fault in kernfs_link_sibling (2)
From:   syzbot <syzbot+268cf7634519ba63ae9f@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3196a52aff93 Add linux-next specific files for 20211021
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=173006af300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb0e2a8a3e9b63e2
dashboard link: https://syzkaller.appspot.com/bug?extid=268cf7634519ba63ae9f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+268cf7634519ba63ae9f@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000002d99e: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x000000000016ccf0-0x000000000016ccf7]
CPU: 1 PID: 5579 Comm: syz-executor.4 Not tainted 5.15.0-rc6-next-20211021-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:rb_set_parent_color include/linux/rbtree_augmented.h:165 [inline]
RIP: 0010:__rb_insert lib/rbtree.c:179 [inline]
RIP: 0010:rb_insert_color+0x134/0x7a0 lib/rbtree.c:436
Code: 3c 02 00 0f 85 0f 05 00 00 4d 85 ed 48 89 6b 08 74 26 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 49 89 ec 48 c1 ea 03 49 83 cc 01 <80> 3c 02 00 0f 85 49 05 00 00 4d 89 65 00 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc90003ea7798 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: ffff88800014e698 RCX: ffffc9000d798000
RDX: 000000000002d99e RSI: ffff88800014b410 RDI: ffff888000167ed0
RBP: ffff888000167ec0 R08: 0000000041ffb936 R09: 0000000000000001
R10: ffffffff81f389ec R11: 0000000000000000 R12: ffff888000167ec1
R13: 000000000016ccf0 R14: ffff88800014e6a0 R15: ffff88800014e698
FS:  00007f8bebf7a700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe92f5aec18 CR3: 000000001f77c000 CR4: 00000000003506e0
Call Trace:
 <TASK>
 kernfs_link_sibling+0x2a7/0x470 fs/kernfs/dir.c:370
 kernfs_add_one+0x218/0x4c0 fs/kernfs/dir.c:745
 __kernfs_create_file+0x29c/0x350 fs/kernfs/file.c:1014
 sysfs_add_file_mode_ns+0x20f/0x3f0 fs/sysfs/file.c:294
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x322/0xb10 fs/sysfs/group.c:148
 internal_create_groups.part.0+0x90/0x140 fs/sysfs/group.c:188
 internal_create_groups fs/sysfs/group.c:184 [inline]
 sysfs_create_groups+0x25/0x50 fs/sysfs/group.c:214
 setup_gid_attrs drivers/infiniband/core/sysfs.c:1170 [inline]
 ib_setup_port_attrs+0x3e7/0x5c0 drivers/infiniband/core/sysfs.c:1442
 add_one_compat_dev+0x517/0x7f0 drivers/infiniband/core/device.c:968
 rdma_dev_init_net+0x28b/0x480 drivers/infiniband/core/device.c:1184
 ops_init+0xaf/0x470 net/core/net_namespace.c:140
 setup_net+0x40f/0xa30 net/core/net_namespace.c:326
 copy_net_ns+0x318/0x760 net/core/net_namespace.c:470
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x445/0x920 kernel/fork.c:3125
 __do_sys_unshare kernel/fork.c:3196 [inline]
 __se_sys_unshare kernel/fork.c:3194 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3194
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8beea04a39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8bebf7a188 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f8beeb07f60 RCX: 00007f8beea04a39
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000060000000
RBP: 00007f8beea5ec5f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd7df61abf R14: 00007f8bebf7a300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 2eb565b9d4312bbc ]---
RIP: 0010:rb_set_parent_color include/linux/rbtree_augmented.h:165 [inline]
RIP: 0010:__rb_insert lib/rbtree.c:179 [inline]
RIP: 0010:rb_insert_color+0x134/0x7a0 lib/rbtree.c:436
Code: 3c 02 00 0f 85 0f 05 00 00 4d 85 ed 48 89 6b 08 74 26 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 49 89 ec 48 c1 ea 03 49 83 cc 01 <80> 3c 02 00 0f 85 49 05 00 00 4d 89 65 00 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc90003ea7798 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: ffff88800014e698 RCX: ffffc9000d798000
RDX: 000000000002d99e RSI: ffff88800014b410 RDI: ffff888000167ed0
RBP: ffff888000167ec0 R08: 0000000041ffb936 R09: 0000000000000001
R10: ffffffff81f389ec R11: 0000000000000000 R12: ffff888000167ec1
R13: 000000000016ccf0 R14: ffff88800014e6a0 R15: ffff88800014e698
FS:  00007f8bebf7a700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe92f5aec18 CR3: 000000001f77c000 CR4: 00000000003506e0
----------------
Code disassembly (best guess):
   0:	3c 02                	cmp    $0x2,%al
   2:	00 0f                	add    %cl,(%rdi)
   4:	85 0f                	test   %ecx,(%rdi)
   6:	05 00 00 4d 85       	add    $0x854d0000,%eax
   b:	ed                   	in     (%dx),%eax
   c:	48 89 6b 08          	mov    %rbp,0x8(%rbx)
  10:	74 26                	je     0x38
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df
  1c:	4c 89 ea             	mov    %r13,%rdx
  1f:	49 89 ec             	mov    %rbp,%r12
  22:	48 c1 ea 03          	shr    $0x3,%rdx
  26:	49 83 cc 01          	or     $0x1,%r12
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 49 05 00 00    	jne    0x57d
  34:	4d 89 65 00          	mov    %r12,0x0(%r13)
  38:	48                   	rex.W
  39:	b8 00 00 00 00       	mov    $0x0,%eax
  3e:	00 fc                	add    %bh,%ah


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

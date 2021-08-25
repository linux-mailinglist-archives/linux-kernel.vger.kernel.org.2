Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB6A3F7B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbhHYRUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:20:11 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:50073 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242231AbhHYRUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:20:10 -0400
Received: by mail-il1-f197.google.com with SMTP id a15-20020a92444f000000b0022473393120so139035ilm.16
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0X1sbyRsKylsTNGKxaPe4MOXT3J577kzoaufgTkocVQ=;
        b=YqQFgBXpLokxl/Ia5HxNNxvP9RoyHMXMo2Ii1SPhqk1rm+nE9/caZzeBkE6Xxop/wt
         COqM17OyCuC3RF+3k8i2hkwg0ChAjlCXfkzMKDRjqlHoLHgoXaHqy4kQA7DVHBgRo++A
         5RrhggQCCxm97CBa0O47311qlVuwYpwbd7SrqAqtZSn3kQm0bVDH5HvteGeHSYZWYW29
         OJO04ItAInjZr5+F1mtyvBF0GYFAdeCwbx/7bMAoDfLHWniJpnhVrPRQbKQaVYLLamao
         7X6WVk8Fa1QvfmKk7njoTnQJNdpaNhyd5tqqg6z6TMTz43SPJ7ZXejqh1PFS3qnSfF5B
         /FNQ==
X-Gm-Message-State: AOAM533CkdyrzccMrFxoY6lrhNw8xNXfPRUZkXycvFNoLxLhRHJOaT65
        IwmdVPp/FwKqzHqAqSehF/eIvriII9W9TyRS2vnP1AnaUnL8
X-Google-Smtp-Source: ABdhPJz3xDwqLH+vTlOyy6wQxM2Mzilkf12t++UGJY7AAhfx1UIZL2Y1E2MoNWWfFIp67K62oKRUfIv6NBF0YHoFDlFkpfjG4y6m
MIME-Version: 1.0
X-Received: by 2002:a92:3012:: with SMTP id x18mr11200166ile.249.1629911964068;
 Wed, 25 Aug 2021 10:19:24 -0700 (PDT)
Date:   Wed, 25 Aug 2021 10:19:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a234e905ca657369@google.com>
Subject: [syzbot] general protection fault in __kernfs_remove
From:   syzbot <syzbot+c2626481ddf079d354c8@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fa54d366a6e4 Merge tag 'acpi-5.14-rc7' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102ca5c5300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3205625db2f96ac9
dashboard link: https://syzkaller.appspot.com/bug?extid=c2626481ddf079d354c8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2626481ddf079d354c8@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000002447c: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x00000000001223e0-0x00000000001223e7]
CPU: 1 PID: 15312 Comm: syz-executor.5 Not tainted 5.14.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:rb_set_parent_color include/linux/rbtree_augmented.h:165 [inline]
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:286 [inline]
RIP: 0010:rb_erase+0x21a/0x1210 lib/rbtree.c:443
Code: ea 03 80 3c 02 00 0f 85 b8 0f 00 00 49 89 5e 08 48 85 c9 74 4f 48 89 ca 48 83 cd 01 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 a2 0f 00 00 48 b8 00 00 00 00 00 fc ff df 48 89
RSP: 0018:ffffc90001d87968 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880001224c8 RCX: 00000000001223e0
RDX: 000000000002447c RSI: ffff8880001224c8 RDI: 1ffff110000244b6
RBP: ffff8880001224c9 R08: 0000000000000001 R09: 0000000000000002
R10: ffffffff81f18b5a R11: 0000000000000001 R12: 0000000000000001
R13: ffff888000122780 R14: 0000000000000000 R15: ffff888000122898
FS:  0000000002138400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa88952b000 CR3: 000000008e5ee000 CR4: 00000000001506e0
Call Trace:
 kernfs_unlink_sibling fs/kernfs/dir.c:398 [inline]
 __kernfs_remove+0x637/0xa90 fs/kernfs/dir.c:1332
 kernfs_remove_by_name_ns+0x51/0xb0 fs/kernfs/dir.c:1517
 kernfs_remove_by_name include/linux/kernfs.h:593 [inline]
 remove_files+0x96/0x1c0 fs/sysfs/group.c:28
 sysfs_remove_group+0x87/0x170 fs/sysfs/group.c:289
 netdev_queue_update_kobjects+0x302/0x450 net/core/net-sysfs.c:1668
 remove_queue_kobjects net/core/net-sysfs.c:1767 [inline]
 netdev_unregister_kobject+0x15b/0x1f0 net/core/net-sysfs.c:1917
 unregister_netdevice_many+0xd21/0x1790 net/core/dev.c:11120
 unregister_netdevice_queue+0x2dd/0x3c0 net/core/dev.c:11027
 unregister_netdevice include/linux/netdevice.h:2969 [inline]
 __tun_detach+0x10ad/0x13d0 drivers/net/tun.c:670
 tun_detach drivers/net/tun.c:687 [inline]
 tun_chr_close+0xc4/0x180 drivers/net/tun.c:3397
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4193fb
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffe5a6c3d80 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00000000004193fb
RDX: 0000000000570c90 RSI: ffffffff892ab478 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000001b2f527494
R10: 00000000000017a2 R11: 0000000000000293 R12: 00000000002bfecd
R13: 00000000000003e8 R14: 000000000056bf80 R15: 00000000002bfe8e
Modules linked in:
---[ end trace b5f9ab27060c4917 ]---
RIP: 0010:rb_set_parent_color include/linux/rbtree_augmented.h:165 [inline]
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:286 [inline]
RIP: 0010:rb_erase+0x21a/0x1210 lib/rbtree.c:443
Code: ea 03 80 3c 02 00 0f 85 b8 0f 00 00 49 89 5e 08 48 85 c9 74 4f 48 89 ca 48 83 cd 01 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 a2 0f 00 00 48 b8 00 00 00 00 00 fc ff df 48 89
RSP: 0018:ffffc90001d87968 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880001224c8 RCX: 00000000001223e0
RDX: 000000000002447c RSI: ffff8880001224c8 RDI: 1ffff110000244b6
RBP: ffff8880001224c9 R08: 0000000000000001 R09: 0000000000000002
R10: ffffffff81f18b5a R11: 0000000000000001 R12: 0000000000000001
R13: ffff888000122780 R14: 0000000000000000 R15: ffff888000122898
FS:  0000000002138400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fda00030410 CR3: 000000008e5ee000 CR4: 00000000001506f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
   6:	85 b8 0f 00 00 49    	test   %edi,0x4900000f(%rax)
   c:	89 5e 08             	mov    %ebx,0x8(%rsi)
   f:	48 85 c9             	test   %rcx,%rcx
  12:	74 4f                	je     0x63
  14:	48 89 ca             	mov    %rcx,%rdx
  17:	48 83 cd 01          	or     $0x1,%rbp
  1b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  22:	fc ff df
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 a2 0f 00 00    	jne    0xfd5
  33:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3a:	fc ff df
  3d:	48                   	rex.W
  3e:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

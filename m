Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A2E452539
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354827AbhKPBrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:47:48 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:53039 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380274AbhKPBkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 20:40:23 -0500
Received: by mail-il1-f197.google.com with SMTP id h12-20020a056e021b8c00b0026e094f4a33so11684473ili.19
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 17:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=G8s7pBJk6DU8vEv2fxrdzyM2ONgukdnmY5ftYCulr0k=;
        b=LeVwSLzUD7pPPg2C9Q4HtavAHEoBWeMc69zo4lnLegJt4fKMITF5LyS9Fg6pSPakrH
         F4sXcVZq/ToQrGuMk+KVTyZTG9bmhr4xaROqM5ZHleYnNHdB3Lm5kqN0hnZypSKW9xqZ
         /Uo3JudtkwOq3CZco8fIRx6HH9A6lXBplxw9zKgSgUiQXXv53NxnMzSN5A5bu1fIl4tj
         wYZ5AdIIZSR1o8fQchaqc0ZYv7drL5WOeFw7rDVLJjOgYhnBn7dAReFytByNFsZU3xfg
         lCo/ehAuDcUoy0838Kz2UGDbHIHv0i2mWTunMfsVSEk3aFOl0G0huBwLsnm3LCWZ50BL
         gcsA==
X-Gm-Message-State: AOAM532G9uN2dAjdXGvH8KTbcMcoa+7p54zCwBR0qowTshFdFxTpJ3Ib
        aZh3iyKz0rQEYyIOAweORty/DUu68gxcxEWBwlBurV6owagd
X-Google-Smtp-Source: ABdhPJw83Fcdf+/ywlFvOJV/bmI85xC4a5BNT2UKmIa0p+y5GXdNpDQu9ZBZ9dGszJoAvWcCo1/NCQaWA2Px0minv5/ckIcPy4/6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160c:: with SMTP id t12mr1979436ilu.308.1637026647237;
 Mon, 15 Nov 2021 17:37:27 -0800 (PST)
Date:   Mon, 15 Nov 2021 17:37:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbe95405d0ddf785@google.com>
Subject: [syzbot] INFO: trying to register non-static key in __kernfs_remove
From:   syzbot <syzbot+2d096db761e653901064@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ca2ef2d9f2aa Merge tag 'kcsan.2021.11.11a' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13147542b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7259f0deb293aa
dashboard link: https://syzkaller.appspot.com/bug?extid=2d096db761e653901064
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d096db761e653901064@syzkaller.appspotmail.com

device veth0_macvtap left promiscuous mode
device veth1_vlan left promiscuous mode
device veth0_vlan left promiscuous mode
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 1054 Comm: kworker/u4:5 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:951 [inline]
 register_lock_class+0xf79/0x10c0 kernel/locking/lockdep.c:1263
 __lock_acquire+0x105/0x54a0 kernel/locking/lockdep.c:4906
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 kernfs_drain fs/kernfs/dir.c:470 [inline]
 __kernfs_remove+0x885/0xab0 fs/kernfs/dir.c:1351
 kernfs_remove_by_name_ns+0x4f/0xa0 fs/kernfs/dir.c:1544
 kernfs_remove_by_name include/linux/kernfs.h:570 [inline]
 sysfs_unmerge_group+0xe3/0x160 fs/sysfs/group.c:368
 rpm_sysfs_remove drivers/base/power/sysfs.c:826 [inline]
 dpm_sysfs_remove+0x79/0xb0 drivers/base/power/sysfs.c:835
 device_del+0x20c/0xd60 drivers/base/core.c:3558
 unregister_netdevice_many+0xd1f/0x1790 net/core/dev.c:11104
 default_device_exit_batch+0x2fa/0x3c0 net/core/dev.c:11607
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:171
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:593
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc000000020c: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000000001060-0x0000000000001067]
CPU: 1 PID: 1054 Comm: kworker/u4:5 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:idr_remove+0x22/0x50 lib/idr.c:154
Code: 84 00 00 00 00 00 66 90 55 48 89 fd 53 48 89 f3 e8 e3 ba 82 fd 48 8d 7d 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 04 3c 03 7e 15 8b 45 50 48 89 ef 31 d2 48 29
RSP: 0018:ffffc900055af6c8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000063555 RCX: 0000000000000000
RDX: 000000000000020c RSI: ffffffff83f50b8d RDI: 0000000000001060
RBP: 0000000000001010 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000ab5ece R11: 0000000000000004 R12: ffff88800010fe80
R13: 0000000000000000 R14: ffff88800010feb8 R15: 0000000080000001
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe27b454008 CR3: 000000000b68e000 CR4: 00000000003506e0
Call Trace:
 <TASK>
 kernfs_put.part.0+0x294/0x540 fs/kernfs/dir.c:537
 kernfs_put+0x42/0x50 fs/kernfs/dir.c:513
 __kernfs_remove+0x725/0xab0 fs/kernfs/dir.c:1372
 kernfs_remove_by_name_ns+0x4f/0xa0 fs/kernfs/dir.c:1544
 kernfs_remove_by_name include/linux/kernfs.h:570 [inline]
 remove_files+0x96/0x1c0 fs/sysfs/group.c:28
 sysfs_remove_group+0x87/0x170 fs/sysfs/group.c:288
 sysfs_remove_groups fs/sysfs/group.c:312 [inline]
 sysfs_remove_groups+0x5c/0xa0 fs/sysfs/group.c:304
 device_remove_groups drivers/base/core.c:2480 [inline]
 device_remove_attrs+0xcb/0x170 drivers/base/core.c:2680
 device_del+0x4fa/0xd60 drivers/base/core.c:3580
 unregister_netdevice_many+0xd1f/0x1790 net/core/dev.c:11104
 default_device_exit_batch+0x2fa/0x3c0 net/core/dev.c:11607
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:171
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:593
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Modules linked in:
---[ end trace be4fbae9b304820b ]---
RIP: 0010:idr_remove+0x22/0x50 lib/idr.c:154
Code: 84 00 00 00 00 00 66 90 55 48 89 fd 53 48 89 f3 e8 e3 ba 82 fd 48 8d 7d 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 04 3c 03 7e 15 8b 45 50 48 89 ef 31 d2 48 29
RSP: 0018:ffffc900055af6c8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000063555 RCX: 0000000000000000
RDX: 000000000000020c RSI: ffffffff83f50b8d RDI: 0000000000001060
RBP: 0000000000001010 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000ab5ece R11: 0000000000000004 R12: ffff88800010fe80
R13: 0000000000000000 R14: ffff88800010feb8 R15: 0000000080000001
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe27b454008 CR3: 000000000b68e000 CR4: 00000000003506e0
----------------
Code disassembly (best guess):
   0:	84 00                	test   %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 00                	add    %al,(%rax)
   6:	66 90                	xchg   %ax,%ax
   8:	55                   	push   %rbp
   9:	48 89 fd             	mov    %rdi,%rbp
   c:	53                   	push   %rbx
   d:	48 89 f3             	mov    %rsi,%rbx
  10:	e8 e3 ba 82 fd       	callq  0xfd82baf8
  15:	48 8d 7d 50          	lea    0x50(%rbp),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 04                	je     0x36
  32:	3c 03                	cmp    $0x3,%al
  34:	7e 15                	jle    0x4b
  36:	8b 45 50             	mov    0x50(%rbp),%eax
  39:	48 89 ef             	mov    %rbp,%rdi
  3c:	31 d2                	xor    %edx,%edx
  3e:	48                   	rex.W
  3f:	29                   	.byte 0x29


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

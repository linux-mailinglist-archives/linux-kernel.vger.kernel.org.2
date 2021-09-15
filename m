Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A76C40CB53
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhIORBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:01:43 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:56303 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhIORBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:01:41 -0400
Received: by mail-io1-f70.google.com with SMTP id o128-20020a6bbe86000000b005bd06eaeca6so2390732iof.22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WpQiM7yPPBzy/YqCZIrX7qSuV7LU5wW0z461NNWyFYA=;
        b=A0qTnU0hwLdRVr4vd7NEmmW7xc56188O1ZvC1dCWb2PkK5jQwVaApDg9lPvr4Q0Uf8
         34Q+GqGx9zajytEvKB2OrS2er/dShm5aHs8zl+IYm8pP6/GJuD1wnAJeC3yLSDqkOTpk
         eS4SqdNkqU8OoTNv+j8w/6a5aD+APL97g3Bx1/YCkLn9LmUtp2wuIL3t+4yxY8dHDsQ3
         Ny/M3rANfD554pHCk7p4FKB+QyPxFXhwI6ZSqOU8I8k1cqdeo+VxCfKIraUzzHsWvrVG
         06JkxYkAXNZ/HPRwA8TXHBC26qmiSeX2Pu3t6qSVReguphZ3nz3ozNM2wkegIk0mfT6t
         sq9A==
X-Gm-Message-State: AOAM5326dL68hQQC5fNp2CwxAXVbTKgxhguPw673VHYBCv/trDseTThC
        QlUeE2vdhXnHifdpNXir5aE1Db4QRr6hXPFdny5tTp7hcILJ
X-Google-Smtp-Source: ABdhPJx7JUsDEI+nzhKKD1NTgnCoXis5dpPaRXZM0CxbTfms7nvAMynBvig551US5ueaGgjnycRazkW8AbXePSPQSsecxnKEqePo
MIME-Version: 1.0
X-Received: by 2002:a6b:ce17:: with SMTP id p23mr870546iob.90.1631725222508;
 Wed, 15 Sep 2021 10:00:22 -0700 (PDT)
Date:   Wed, 15 Sep 2021 10:00:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000423e0a05cc0ba2c4@google.com>
Subject: [syzbot] WARNING in __init_work
From:   syzbot <syzbot+d6c75f383e01426a40b4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    926de8c4326c Merge tag 'acpi-5.15-rc1-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17aa010d300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c3d15ee2073a2a2
dashboard link: https://syzkaller.appspot.com/bug?extid=d6c75f383e01426a40b4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6c75f383e01426a40b4@syzkaller.appspotmail.com

ODEBUG: object ffffc90000fd8bc8 is NOT on stack ffffc900022a0000, but annotated.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 2971 at lib/debugobjects.c:548 debug_object_is_on_stack lib/debugobjects.c:545 [inline]
WARNING: CPU: 1 PID: 2971 at lib/debugobjects.c:548 __debug_object_init.cold+0x252/0x2e5 lib/debugobjects.c:607
Modules linked in:
CPU: 1 PID: 2971 Comm: systemd-udevd Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:548 [inline]
RIP: 0010:__debug_object_init.cold+0x252/0x2e5 lib/debugobjects.c:607
Code: 00 48 8d 7b 20 48 89 fa 48 c1 ea 03 80 3c 02 00 74 05 e8 c0 3e bb f8 48 8b 53 20 4c 89 e6 48 c7 c7 c0 a7 e3 89 e8 a1 34 f2 ff <0f> 0b e9 3f 9f dc fa 48 b8 00 01 00 00 00 00 ad de 48 89 ef 48 89
RSP: 0018:ffffc90000fd89f8 EFLAGS: 00010286
RAX: 0000000000000050 RBX: ffff88801f3f2180 RCX: 0000000000000000
RDX: ffff88801f3f2180 RSI: ffffffff815cef88 RDI: fffff520001fb131
RBP: ffff88801f3f2180 R08: 0000000000000050 R09: 0000000000000000
R10: ffffffff815c8cfe R11: 0000000000000000 R12: ffffc90000fd8bc8
R13: 1ffff920001fb14e R14: ffffffff9040c580 R15: ffffffff9040c578
FS:  00007f35a6cd88c0(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000014a53ad CR3: 000000001fc51000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __init_work+0x2d/0x50 kernel/workqueue.c:519
 synchronize_rcu_expedited+0x392/0x620 kernel/rcu/tree_exp.h:847
 bdi_remove_from_list mm/backing-dev.c:938 [inline]
 bdi_unregister+0x177/0x5a0 mm/backing-dev.c:946
 release_bdi+0xa1/0xc0 mm/backing-dev.c:968
 kref_put include/linux/kref.h:65 [inline]
 bdi_put+0x72/0xa0 mm/backing-dev.c:976
 bdev_free_inode+0x116/0x220 fs/block_dev.c:819
 i_callback+0x3f/0x70 fs/inode.c:224
 rcu_do_batch kernel/rcu/tree.c:2508 [inline]
 rcu_core+0x7ab/0x1470 kernel/rcu/tree.c:2743
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:27 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:197
Code: 01 f0 4d 89 03 e9 63 fd ff ff b9 ff ff ff ff ba 08 00 00 00 4d 8b 03 48 0f bd ca 49 8b 45 00 48 63 c9 e9 64 ff ff ff 0f 1f 00 <65> 8b 05 c9 ab 8c 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b
RSP: 0018:ffffc900022a79d8 EFLAGS: 00000202
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffff88801f3f2180 RDI: 0000000000000003
RBP: ffffc900022a7b48 R08: 0000000000000000 R09: 0000000000000005
R10: ffffffff83a87292 R11: 000000000000001f R12: ffff888020928180
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 tomoyo_check_path_acl security/tomoyo/file.c:260 [inline]
 tomoyo_check_path_acl+0xbe/0x210 security/tomoyo/file.c:252
 tomoyo_check_acl+0x13c/0x450 security/tomoyo/domain.c:175
 tomoyo_path_permission security/tomoyo/file.c:586 [inline]
 tomoyo_path_permission+0x1ff/0x3a0 security/tomoyo/file.c:573
 tomoyo_path_perm+0x2f0/0x400 security/tomoyo/file.c:838
 security_inode_getattr+0xcf/0x140 security/security.c:1333
 vfs_getattr fs/stat.c:157 [inline]
 vfs_statx+0x164/0x390 fs/stat.c:225
 vfs_fstatat fs/stat.c:243 [inline]
 vfs_lstat include/linux/fs.h:3356 [inline]
 __do_sys_newlstat+0x91/0x110 fs/stat.c:398
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f35a5b4a335
Code: 69 db 2b 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 83 ff 01 48 89 f0 77 30 48 89 c7 48 89 d6 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 03 f3 c3 90 48 8b 15 31 db 2b 00 f7 d8 64 89
RSP: 002b:00007ffd7b867ca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 0000563eb9e97120 RCX: 00007f35a5b4a335
RDX: 00007ffd7b867ce0 RSI: 00007ffd7b867ce0 RDI: 0000563eb9e96120
RBP: 00007ffd7b867da0 R08: 00007f35a5e092e8 R09: 0000000000001010
R10: 00007f35a5e08b58 R11: 0000000000000246 R12: 0000563eb9e96120
R13: 0000563eb9e9614a R14: 0000563eb9e8dce1 R15: 0000563eb9e8dcea
----------------
Code disassembly (best guess):
   0:	01 f0                	add    %esi,%eax
   2:	4d 89 03             	mov    %r8,(%r11)
   5:	e9 63 fd ff ff       	jmpq   0xfffffd6d
   a:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
   f:	ba 08 00 00 00       	mov    $0x8,%edx
  14:	4d 8b 03             	mov    (%r11),%r8
  17:	48 0f bd ca          	bsr    %rdx,%rcx
  1b:	49 8b 45 00          	mov    0x0(%r13),%rax
  1f:	48 63 c9             	movslq %ecx,%rcx
  22:	e9 64 ff ff ff       	jmpq   0xffffff8b
  27:	0f 1f 00             	nopl   (%rax)
* 2a:	65 8b 05 c9 ab 8c 7e 	mov    %gs:0x7e8cabc9(%rip),%eax        # 0x7e8cabfa <-- trapping instruction
  31:	89 c1                	mov    %eax,%ecx
  33:	48 8b 34 24          	mov    (%rsp),%rsi
  37:	81 e1 00 01 00 00    	and    $0x100,%ecx
  3d:	65                   	gs
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9063705D9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 08:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhEAGJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 02:09:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:57162 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhEAGJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 02:09:06 -0400
Received: by mail-io1-f72.google.com with SMTP id y20-20020a6bd8140000b02903e6787c4986so71028iob.23
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 23:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QY3ro5vJAuKZcXJFutAbvXy9Ia4spy8FSXQM0sKzA2o=;
        b=MmcRn2OEN5dt7VVIi8HJ1i7NSUrPYMypzbiYgrW6a7+BYsIDzzUUNnCwkThiiL3DUb
         WuHWBikko/VHtuyvjUVkUYkhFOqo4m2+OxwuLkajTuRr/4R5kMOU4M3LwEyuUplnb/6O
         PlMGk2j+f6uKv00p+c5gAIkHNpzv93sxxMzhD4SH1ufpoLkWMu9Dker1l7GVl8vjncrb
         jYSi8579S9AgFm4eGg7QQQws/TR3vUy+JNclzW3aL3F22addlcDuvxZ7Qd0eBrMjLWRR
         qI80Jyvjcv3sWvaARs9WRCksJmlT6sj3hwIfLA2rv7vPurCKSJiE0lXYBqfoOxPZ8l7N
         g98g==
X-Gm-Message-State: AOAM533sNBG4PofAcCi0s+ipF7yvSApkODmY1A10UvOWIhSLpESVY0jB
        u78tGOyEYOrm66BU/145ua4vCqPfU6R69lY3BmTLX/5SYzwg
X-Google-Smtp-Source: ABdhPJwuuqf5VV+V00mQs202MmayRDhx21Bc0SwnQcRDlXBjYSIFtj/nJBTTt6A4syijuBfLuLMsPgHqiJO1SfL+UtskZiC6b8qD
MIME-Version: 1.0
X-Received: by 2002:a5d:9a8c:: with SMTP id c12mr6914300iom.166.1619849296648;
 Fri, 30 Apr 2021 23:08:16 -0700 (PDT)
Date:   Fri, 30 Apr 2021 23:08:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eaa2f805c13e8def@google.com>
Subject: [syzbot] KMSAN: uninit-value in __mpol_equal
From:   syzbot <syzbot+b1d978f749455b49537a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, glider@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4ebaab5f kmsan: drop unneeded references to kmsan_context_..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10f34961d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=647ca0f5bbe7703a
dashboard link: https://syzkaller.appspot.com/bug?extid=b1d978f749455b49537a
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1d978f749455b49537a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __mpol_equal+0x617/0x690 mm/mempolicy.c:2340
CPU: 0 PID: 20507 Comm: syz-executor.4 Not tainted 5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 __mpol_equal+0x617/0x690 mm/mempolicy.c:2340
 mpol_equal include/linux/mempolicy.h:108 [inline]
 vma_merge+0x47e/0x2210 mm/mmap.c:1187
 mbind_range mm/mempolicy.c:830 [inline]
 do_mbind+0x19c9/0x38c0 mm/mempolicy.c:1350
 kernel_mbind mm/mempolicy.c:1478 [inline]
 __do_sys_mbind mm/mempolicy.c:1485 [inline]
 __se_sys_mbind+0x3a6/0x3c0 mm/mempolicy.c:1481
 __x64_sys_mbind+0x6e/0x90 mm/mempolicy.c:1481
 do_syscall_64+0x9f/0x140 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd2ba516188 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 000000000056c008 RCX: 00000000004665f9
RDX: 0000000000002001 RSI: 0000000000800000 RDI: 0000000020001000
RBP: 00000000004bfbb9 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c008
R13: 0000000000a9fb1f R14: 00007fd2ba516300 R15: 0000000000022000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_poison_shadow+0x5c/0xf0 mm/kmsan/kmsan.c:104
 kmsan_slab_alloc+0x8e/0xe0 mm/kmsan/kmsan_hooks.c:76
 slab_alloc_node mm/slub.c:2922 [inline]
 slab_alloc mm/slub.c:2931 [inline]
 kmem_cache_alloc+0x895/0x1030 mm/slub.c:2936
 mpol_new mm/mempolicy.c:302 [inline]
 do_mbind+0x8d5/0x38c0 mm/mempolicy.c:1306
 kernel_mbind mm/mempolicy.c:1478 [inline]
 __do_sys_mbind mm/mempolicy.c:1485 [inline]
 __se_sys_mbind+0x3a6/0x3c0 mm/mempolicy.c:1481
 __x64_sys_mbind+0x6e/0x90 mm/mempolicy.c:1481
 do_syscall_64+0x9f/0x140 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x44/0xae
=====================================================
=====================================================
BUG: KMSAN: uninit-value in __mpol_equal+0x617/0x690 mm/mempolicy.c:2340
CPU: 0 PID: 20507 Comm: syz-executor.4 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 __mpol_equal+0x617/0x690 mm/mempolicy.c:2340
 mpol_equal include/linux/mempolicy.h:108 [inline]
 vma_merge+0x47e/0x2210 mm/mmap.c:1187
 mbind_range mm/mempolicy.c:830 [inline]
 do_mbind+0x19c9/0x38c0 mm/mempolicy.c:1350
 kernel_mbind mm/mempolicy.c:1478 [inline]
 __do_sys_mbind mm/mempolicy.c:1485 [inline]
 __se_sys_mbind+0x3a6/0x3c0 mm/mempolicy.c:1481
 __x64_sys_mbind+0x6e/0x90 mm/mempolicy.c:1481
 do_syscall_64+0x9f/0x140 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd2ba516188 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 000000000056c008 RCX: 00000000004665f9
RDX: 0000000000002001 RSI: 0000000000800000 RDI: 0000000020001000
RBP: 00000000004bfbb9 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c008
R13: 0000000000a9fb1f R14: 00007fd2ba516300 R15: 0000000000022000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_poison_shadow+0x5c/0xf0 mm/kmsan/kmsan.c:104
 kmsan_slab_alloc+0x8e/0xe0 mm/kmsan/kmsan_hooks.c:76
 slab_alloc_node mm/slub.c:2922 [inline]
 slab_alloc mm/slub.c:2931 [inline]
 kmem_cache_alloc+0x895/0x1030 mm/slub.c:2936
 mpol_new mm/mempolicy.c:302 [inline]
 do_mbind+0x8d5/0x38c0 mm/mempolicy.c:1306
 kernel_mbind mm/mempolicy.c:1478 [inline]
 __do_sys_mbind mm/mempolicy.c:1485 [inline]
 __se_sys_mbind+0x3a6/0x3c0 mm/mempolicy.c:1481
 __x64_sys_mbind+0x6e/0x90 mm/mempolicy.c:1481
 do_syscall_64+0x9f/0x140 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x44/0xae
=====================================================
=====================================================
BUG: KMSAN: uninit-value in __mpol_equal+0x617/0x690 mm/mempolicy.c:2340
CPU: 0 PID: 20507 Comm: syz-executor.4 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 __mpol_equal+0x617/0x690 mm/mempolicy.c:2340
 mpol_equal include/linux/mempolicy.h:108 [inline]
 vma_merge+0x47e/0x2210 mm/mmap.c:1187
 mbind_range mm/mempolicy.c:830 [inline]
 do_mbind+0x19c9/0x38c0 mm/mempolicy.c:1350
 kernel_mbind mm/mempolicy.c:1478 [inline]
 __do_sys_mbind mm/mempolicy.c:1485 [inline]
 __se_sys_mbind+0x3a6/0x3c0 mm/mempolicy.c:1481
 __x64_sys_mbind+0x6e/0x90 mm/mempolicy.c:1481
 do_syscall_64+0x9f/0x140 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd2ba516188 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 000000000056c008 RCX: 00000000004665f9
RDX: 0000000000002001 RSI: 0000000000800000 RDI: 0000000020001000
RBP: 00000000004bfbb9 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c008
R13: 0000000000a9fb1f R14: 00007fd2ba516300 R15: 0000000000022000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_poison_shadow+0x5c/0xf0 mm/kmsan/kmsan.c:104
 kmsan_slab_alloc+0x8e/0xe0 mm/kmsan/kmsan_hooks.c:76
 slab_alloc_node mm/slub.c:2922 [inline]
 slab_alloc mm/slub.c:2931 [inline]
 kmem_cache_alloc+0x895/0x1030 mm/slub.c:2936
 mpol_new mm/mempolicy.c:302 [inline]
 do_mbind+0x8d5/0x38c0 mm/mempolicy.c:1306
 kernel_mbind mm/mempolicy.c:1478 [inline]
 __do_sys_mbind mm/mempolicy.c:1485 [inline]
 __se_sys_mbind+0x3a6/0x3c0 mm/mempolicy.c:1481
 __x64_sys_mbind+0x6e/0x90 mm/mempolicy.c:1481
 do_syscall_64+0x9f/0x140 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x44/0xae
=====================================================
=====================================================
BUG: KMSAN: uninit-value in __mpol_equal mm/mempolicy.c:2340 [inline]
BUG: KMSAN: uninit-value in mpol_equal include/linux/mempolicy.h:108 [inline]
BUG: KMSAN: uninit-value in mbind_range mm/mempolicy.c:836 [inline]
BUG: KMSAN: uninit-value in do_mbind+0x2ee6/0x38c0 mm/mempolicy.c:1350
CPU: 0 PID: 20507 Comm: syz-executor.4 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 __mpol_equal mm/mempolicy.c:2340 [inline]
 mpol_equal include/linux/mempolicy.h:108 [inline]
 mbind_range mm/mempolicy.c:836 [inline]
 do_mbind+0x2ee6/0x38c0 mm/mempolicy.c:1350
 kernel_mbind mm/mempolicy.c:1478 [inline]
 __do_sys_mbind mm/mempolicy.c:1485 [inline]
 __se_sys_mbind+0x3a6/0x3c0 mm/mempolicy.c:1481
 __x64_sys_mbind+0x6e/0x90 mm/mempolicy.c:1481
 do_syscall_64+0x9f/0x140 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd2ba516188 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 000000000056c008 RCX: 00000000004665f9
RDX: 0000000000002001 RSI: 0000000000800000 RDI: 0000000020001000
RBP: 00000000004bfbb9 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c008
R13: 0000000000a9fb1f R14: 00007fd2ba516300 R15: 0000000000022000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_poison_shadow+0x5c/0xf0 mm/kmsan/kmsan.c:104
 kmsan_slab_alloc+0x8e/0xe0 mm/kmsan/kmsan_hooks.c:76
 slab_alloc_node mm/slub.c:2922 [inline]
 slab_alloc mm/slub.c:2931 [inline]
 kmem_cache_alloc+0x895/0x1030 mm/slub.c:2936
 mpol_new mm/mempolicy.c:302 [inline]
 do_mbind+0x8d5/0x38c0 mm/mempolicy.c:1306
 kernel_mbind mm/mempolicy.c:1478 [inline]
 __do_sys_mbind mm/mempolicy.c:1485 [inline]
 __se_sys_mbind+0x3a6/0x3c0 mm/mempolicy.c:1481
 __x64_sys_mbind+0x6e/0x90 mm/mempolicy.c:1481
 do_syscall_64+0x9f/0x140 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x44/0xae
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

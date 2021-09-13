Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009094082C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 04:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhIMCL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 22:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhIMCL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 22:11:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D2BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 19:10:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id bg1so4792527plb.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 19:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZvVxn8pL+iI6t8R7NmYVdXO0Brz/XoAQIcu1Xk8F1ng=;
        b=ZksVkbkkOCRrkrU2//0Gis6vo6harvbGtPPX0T26y5g/xkpDMSUwspdHwhootlfpAW
         2Y3XiG62jAQl05XH0kE70+WsrcrKODOuV4R5upPr3197VFIigvNaWTS+a0Zl7Scs0/xM
         W1JWcrygn+Amp5L7Mv0GhQqgfbYpFPiDJ9P/yRzVkYGRQ1d4onGzUpizkT4A9zSv6F+F
         y4RYUQg5VpegEl50bLa0whNo9UmDXCOZ0McqWwWMjo/1eilXIOvWG9X0PCPTfIoQbeIq
         Hpn858Ts3KPwkW8MBnZdpG7GWkvHhwyxtalgKw0zrpowXZXyt0l6AT0aYq/F2obbqywc
         Mjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZvVxn8pL+iI6t8R7NmYVdXO0Brz/XoAQIcu1Xk8F1ng=;
        b=wCLPpx3yO4XNfjnjoiP9PKNAHWFCbQ4W+uzZdctjMhxZSD6CZVmNUaCwG6UwWlHiOq
         rk6xfc3VAFEeVDL9Cm+EYVE7NPs09JJF1BRPROMp3lVIsosDexHuN/kXJZAm2RdjNEyx
         xRuQXZdPLQVhVGYxDt2c6lnqDBcvry7xw+hAGCYsifsItCj0c4jDLnAVgHglt0DkSGTA
         C0QDBBGHhKY+y4kcjwzbwG/66iNHaZFgHTSyNHKobR7sQynUV9GC+UTpDaBm2HDKZXIh
         CHvb0UO96W+1x2wyR+E272fZ2R4XB5VQh1LUs92QN7rplTUl6Vtnqfi/58DrKzdmT7we
         +ILg==
X-Gm-Message-State: AOAM530RmILXPEu7rI2K/sJB7cT6HMv2a/jPnOxfBnYrjcsR4OP0KpRc
        kruSe7xgvXw7v+S65fivFHsbejOEqJJIytd29Q==
X-Google-Smtp-Source: ABdhPJzCsnaBka6TcWQGARlZCFJHJTdwtyDMb4rQ5qiDt5h6X2fXUupiiXJGDRmrH84om21xC3d7VLpcxJutlmSj+A4=
X-Received: by 2002:a17:90a:b794:: with SMTP id m20mr9538924pjr.178.1631499011826;
 Sun, 12 Sep 2021 19:10:11 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 13 Sep 2021 10:10:01 +0800
Message-ID: <CACkBjsZmvmL8FJbXeY5BkBQ33h1qYPv=15KVaVN3ZATng6_L3g@mail.gmail.com>
Subject: INFO: task hung in do_read_cache_page
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 4b93c544e90e-thunderbolt: test: split up test cases
git tree: upstream
console output:
https://drive.google.com/file/d/1maGu7OQMMnheEq18g-XJRrSvPIRLyIae/view?usp=sharing
kernel config: https://drive.google.com/file/d/1c0u2EeRDhRO-ZCxr9MP2VvAtJd6kfg-p/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1pf2nzNzl2hUxO6EJ1Vp4uqeAmr9tG4Pw/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1CZekMFes8O7FmLULOkxLnovMGWNFtI47/view?usp=sharing
Similar report:
https://groups.google.com/g/syzkaller-bugs/c/mt4E4qKbC5c/m/m-gbLPjIAgAJ

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task systemd-udevd:8866 blocked for more than 143 seconds.
      Not tainted 5.14.0+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-udevd   state:D stack:27760 pid: 8866 ppid:  4957 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 io_schedule+0x17/0x70 kernel/sched/core.c:8389
 wait_on_page_bit_common+0x57c/0xf10 mm/filemap.c:1356
 wait_on_page_bit mm/filemap.c:1417 [inline]
 wait_on_page_locked include/linux/pagemap.h:689 [inline]
 do_read_cache_page+0x26d/0x1440 mm/filemap.c:3504
 read_mapping_page include/linux/pagemap.h:515 [inline]
 read_part_sector+0xfa/0x610 block/partitions/core.c:725
 adfspart_check_ICS+0x9d/0xc90 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:147 [inline]
 blk_add_partitions block/partitions/core.c:610 [inline]
 bdev_disk_changed block/partitions/core.c:696 [inline]
 bdev_disk_changed+0x778/0x1140 block/partitions/core.c:663
 blkdev_get_whole+0x206/0x270 fs/block_dev.c:1092
 blkdev_get_by_dev fs/block_dev.c:1234 [inline]
 blkdev_get_by_dev+0x456/0x900 fs/block_dev.c:1200
 blkdev_open+0x154/0x2b0 fs/block_dev.c:1329
 do_dentry_open+0x4c8/0x11d0 fs/open.c:822
 do_open fs/namei.c:3426 [inline]
 path_openat+0x1c99/0x2710 fs/namei.c:3559
 do_filp_open+0x1c1/0x290 fs/namei.c:3586
 do_sys_openat2+0x61b/0x9a0 fs/open.c:1200
 do_sys_open+0xc3/0x140 fs/open.c:1216
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f93afce1840
RSP: 002b:00007fffa94a51e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000561916cb8c20 RCX: 00007f93afce1840
RDX: 0000561914d49fe3 RSI: 00000000000a0800 RDI: 0000561916cb9af0
RBP: 00007fffa94a5360 R08: 0000561914d49670 R09: 0000000000000010
R10: 00007f93afa5bd70 R11: 0000000000000246 R12: 00007fffa94a52b0
R13: 0000561916cb51f0 R14: 0000000000000003 R15: 000000000000000e
INFO: task syz-executor:9701 blocked for more than 143 seconds.
      Not tainted 5.14.0+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:28568 pid: 9701 ppid:  5747 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
 blkdev_put+0x98/0x6f0 fs/block_dev.c:1351
 blkdev_close+0x8c/0xb0 fs/block_dev.c:1403
 __fput+0x288/0x9f0 fs/file_table.c:280
 task_work_run+0xe0/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x28d/0x2a0 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x41a04b
RSP: 002b:00007ffc87900cd0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000041a04b
RDX: 0000001b32e20000 RSI: ffffffff81649386 RDI: 0000000000000004
RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000001d16
R10: 00000000851efd1a R11: 0000000000000293 R12: 000000000059cc20
R13: 000000000059cc20 R14: 00000000005a0588 R15: 000000000012a34a
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 1236 Comm: khungtaskd Not tainted 5.14.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1e1/0x220 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xcc8/0x1010 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 3
CPU: 3 PID: 12169 Comm: systemd-journal Not tainted 5.14.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:jhash2 include/linux/jhash.h:129 [inline]
RIP: 0010:hash_stack lib/stackdepot.c:181 [inline]
RIP: 0010:stack_depot_save+0xc6/0x510 lib/stackdepot.c:273
Code: 04 41 31 f8 44 89 c7 44 29 c0 41 01 d8 c1 c7 06 31 f8 89 df 89
c3 29 c7 44 01 c0 c1 c3 08 31 fb 89 df 41 29 d8 01 c3 c1 c7 10 <41> 31
f8 44 29 c0 89 c7 44 89 c0 41 01 d8 c1 c8 0d 31 f8 89 c7 29
RSP: 0018:ffffc9000236fb00 EFLAGS: 00000a07
RAX: 000000005088c019 RBX: 000000007c4037db RCX: ffffc9000236fb88
RDX: 0000000000000cc0 RSI: 000000000000000a RDI: 0000000077c22bb7
RBP: 0000000000000008 R08: 00000000eca356b5 R09: fffffbfff1adbb1b
R10: ffffffff8d6dd8d7 R11: fffffbfff1adbb1a R12: ffffc9000236fb70
R13: 0000000000000cc0 R14: 0000000000000001 R15: 0000000000000cc0
FS:  00007fc8786ad8c0(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc874c2b000 CR3: 000000010e66a000 CR4: 0000000000350ee0
Call Trace:
 kasan_save_stack+0x32/0x40 mm/kasan/common.c:40
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 __kasan_slab_alloc+0x83/0xb0 mm/kasan/common.c:467
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook+0x4d/0x4b0 mm/slab.h:519
 slab_alloc_node mm/slub.c:2959 [inline]
 slab_alloc mm/slub.c:2967 [inline]
 kmem_cache_alloc+0x15d/0x350 mm/slub.c:2972
 prepare_creds+0x3f/0x7b0 kernel/cred.c:262
 access_override_creds fs/open.c:351 [inline]
 do_faccessat+0x3f4/0x850 fs/open.c:415
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc8779699c7
Code: 83 c4 08 48 3d 01 f0 ff ff 73 01 c3 48 8b 0d c8 d4 2b 00 f7 d8
64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 15 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d a1 d4 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffce5c6d768 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00007ffce5c70790 RCX: 00007fc8779699c7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000558daf0c49a3
RBP: 00007ffce5c6d8b0 R08: 0000558daf0ba3e5 R09: 0000000000000018
R10: 0000000000000069 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000558dafce8d60 R15: 00007ffce5c6dda0
NMI backtrace for cpu 0 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 0 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
NMI backtrace for cpu 2 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 2 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 2 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
----------------
Code disassembly (best guess):
   0: 04 41                add    $0x41,%al
   2: 31 f8                xor    %edi,%eax
   4: 44 89 c7              mov    %r8d,%edi
   7: 44 29 c0              sub    %r8d,%eax
   a: 41 01 d8              add    %ebx,%r8d
   d: c1 c7 06              rol    $0x6,%edi
  10: 31 f8                xor    %edi,%eax
  12: 89 df                mov    %ebx,%edi
  14: 89 c3                mov    %eax,%ebx
  16: 29 c7                sub    %eax,%edi
  18: 44 01 c0              add    %r8d,%eax
  1b: c1 c3 08              rol    $0x8,%ebx
  1e: 31 fb                xor    %edi,%ebx
  20: 89 df                mov    %ebx,%edi
  22: 41 29 d8              sub    %ebx,%r8d
  25: 01 c3                add    %eax,%ebx
  27: c1 c7 10              rol    $0x10,%edi
* 2a: 41 31 f8              xor    %edi,%r8d <-- trapping instruction
  2d: 44 29 c0              sub    %r8d,%eax
  30: 89 c7                mov    %eax,%edi
  32: 44 89 c0              mov    %r8d,%eax
  35: 41 01 d8              add    %ebx,%r8d
  38: c1 c8 0d              ror    $0xd,%eax
  3b: 31 f8                xor    %edi,%eax
  3d: 89 c7                mov    %eax,%edi
  3f: 29                    .byte 0x29%

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F06312440
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 13:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBGMU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 07:20:57 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:55937 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhBGMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 07:20:53 -0500
Received: by mail-io1-f71.google.com with SMTP id a2so9715610iod.22
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 04:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SBPGOTn91b4Z5D23iB2EveGU6DUiNpnFMY8VQCP0puU=;
        b=r6+qzZlUg05SuB0iF1DiXCrLQJTXiFlggOuu5D0az4kEd6UZ1GSbPguDzeDtYbZ5i/
         5Oj9b41GyOFlkgFUw5ZnRhcNL5bwh+/+/L+88Z/9Ql3fv8V9+faMF+/MVuFqkrr+YJj1
         k+gnzWV/bCS/R65GeSBXdSF8EgiAvzhRuGVGpAQN9gituuI4sP5QXhIdBi/fY4dDRj32
         gEH7HnZei6e/RBFguLTMH6jIvPPRHVQk+kzGDjo1Lk/MmTFwClmXre3g3nqDORT1fyOs
         +HltmLvzuuCCiTYbAVrLFe0CBo5mzqUl+U5kyNIe7tnTBEl4TWwQ9tryf00HHT8j6d9f
         wBPQ==
X-Gm-Message-State: AOAM530hP/JrLtW1rA0kxaja+lxU35hzcLjmEJkp7cFFZVAtpLsxLQVw
        ew+WTZFimca1azul12nDf3cOQT++meJH/Js3O681H5ZVqyTQ
X-Google-Smtp-Source: ABdhPJy/5CxtNjfzovOzR5ELMccOtNMpIBWZLDYC6VPm3EcVez8yhVPedxTo2XUsy5PwgOKGKS6asqbAsMdF5i0bOa0BgBxuQD1q
MIME-Version: 1.0
X-Received: by 2002:a6b:8dc4:: with SMTP id p187mr11700541iod.147.1612700412430;
 Sun, 07 Feb 2021 04:20:12 -0800 (PST)
Date:   Sun, 07 Feb 2021 04:20:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000364d5505babe13f5@google.com>
Subject: KMSAN: uninit-value in bpf_iter_prog_supported
From:   syzbot <syzbot+580f4f2a272e452d55cb@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    73d62e81 kmsan: random: prevent boot-time reports in _mix_..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17ac5f64d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df698232b2ac45c9
dashboard link: https://syzkaller.appspot.com/bug?extid=580f4f2a272e452d55cb
compiler:       Debian clang version 11.0.1-2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+580f4f2a272e452d55cb@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bpf_iter_prog_supported+0x3dd/0x6a0 syzkaller/managers/upstream-kmsan-gce-386/kernel/kernel/bpf/bpf_iter.c:329
CPU: 0 PID: 18494 Comm: bpf_preload Not tainted 5.10.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack syzkaller/managers/upstream-kmsan-gce-386/kernel/lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 syzkaller/managers/upstream-kmsan-gce-386/kernel/lib/dump_stack.c:118
 kmsan_report+0xfb/0x1e0 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/kmsan/kmsan_instr.c:197
 bpf_iter_prog_supported+0x3dd/0x6a0 syzkaller/managers/upstream-kmsan-gce-386/kernel/kernel/bpf/bpf_iter.c:329
 check_attach_btf_id syzkaller/managers/upstream-kmsan-gce-386/kernel/kernel/bpf/verifier.c:11772 [inline]
 bpf_check+0x11872/0x1c380 syzkaller/managers/upstream-kmsan-gce-386/kernel/kernel/bpf/verifier.c:11900
 bpf_prog_load syzkaller/managers/upstream-kmsan-gce-386/kernel/kernel/bpf/syscall.c:2210 [inline]
 __do_sys_bpf+0x17483/0x1aee0 syzkaller/managers/upstream-kmsan-gce-386/kernel/kernel/bpf/syscall.c:4399
 __se_sys_bpf+0x8e/0xa0 syzkaller/managers/upstream-kmsan-gce-386/kernel/kernel/bpf/syscall.c:4357
 __x64_sys_bpf+0x4a/0x70 syzkaller/managers/upstream-kmsan-gce-386/kernel/kernel/bpf/syscall.c:4357
 do_syscall_64+0x9f/0x140 syzkaller/managers/upstream-kmsan-gce-386/kernel/arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fb70b5ab469
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffdbb4cde38 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 000000000065b110 RCX: 00007fb70b5ab469
RDX: 0000000000000078 RSI: 00007ffdbb4cdef0 RDI: 0000000000000005
RBP: 00007ffdbb4cdef0 R08: 0000001000000017 R09: 0000000000000000
R10: 00007ffdbb4ce0e8 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdbb4cdf20 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_poison_shadow+0x5c/0xf0 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/kmsan/kmsan.c:104
 kmsan_slab_alloc+0x8d/0xe0 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/kmsan/kmsan_hooks.c:76
 slab_alloc_node syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/slub.c:2906 [inline]
 slab_alloc syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/slub.c:2915 [inline]
 kmem_cache_alloc_trace+0x893/0x1000 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/slub.c:2932
 kmalloc syzkaller/managers/upstream-kmsan-gce-386/kernel/./include/linux/slab.h:552 [inline]
 bpf_iter_reg_target+0x81/0x3f0 syzkaller/managers/upstream-kmsan-gce-386/kernel/kernel/bpf/bpf_iter.c:276
 bpf_sk_storage_map_iter_init+0x6a/0x85 syzkaller/managers/upstream-kmsan-gce-386/kernel/net/core/bpf_sk_storage.c:870
 do_one_initcall+0x362/0x8d0 syzkaller/managers/upstream-kmsan-gce-386/kernel/init/main.c:1220
 do_initcall_level+0x1e7/0x35a syzkaller/managers/upstream-kmsan-gce-386/kernel/init/main.c:1293
 do_initcalls+0x127/0x1cb syzkaller/managers/upstream-kmsan-gce-386/kernel/init/main.c:1309
 do_basic_setup+0x33/0x36 syzkaller/managers/upstream-kmsan-gce-386/kernel/init/main.c:1329
 kernel_init_freeable+0x238/0x38b syzkaller/managers/upstream-kmsan-gce-386/kernel/init/main.c:1529
 kernel_init+0x1f/0x840 syzkaller/managers/upstream-kmsan-gce-386/kernel/init/main.c:1418
 ret_from_fork+0x1f/0x30 syzkaller/managers/upstream-kmsan-gce-386/kernel/arch/x86/entry/entry_64.S:296
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

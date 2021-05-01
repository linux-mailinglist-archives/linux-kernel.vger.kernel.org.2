Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E443705C5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 07:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhEAFwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 01:52:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38428 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhEAFwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 01:52:05 -0400
Received: by mail-io1-f70.google.com with SMTP id v1-20020a5d94810000b02903e0f4d732b4so66430ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 22:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=diU0RNkAZollR/UrfKoeFvOTmJ41JtW3kpnG7nzIye4=;
        b=HuQTgteMiVL5BuLzyQoYYjba/XtEbgCjmRL2eFk1EBU8Gvts4Ukdb3+B4CqRodMma1
         Y6v2iirpSa/Z2OQszW+GdJqab419X/DvyULP7wloNtWFK6rpJDCUEaboD7luGjuZYJen
         06GaLt0kDjBQFLq46KN/l7HGgb0+hydEbEDmBjkAQ0YkXAWzVchJfyXy1zhrU18768gx
         Tw7HxDIp4UiV35hO6i2tHpknHa3b8GN/OvhD7j9IzFlTKsYpdlexnpfVTADiJkCWJAMD
         5IeUzIZIFyXUv7WjXmkEeBjPklVeEH0p9kc8JG4/rWZuib+H9XZlRS8ADczVIRv6fBU0
         Y8zA==
X-Gm-Message-State: AOAM53089HYL/KNfbRy7vOqStTDK+tWzen/ziBcCQCqi25/DwgJsIsUw
        8FaVxidi6P+fJTfrxYbj6u6F5FW6mFiJ7BbshwJtGE7sRXJb
X-Google-Smtp-Source: ABdhPJwtMxjHUuqXVYXVlLQ77T5B4K3t2pi07rUtT0Z+ek7e9SxkH3ZKKqcRXNa5CTthibApvwZDyxYs5Jzsx5dy9bMcuvi71Otn
MIME-Version: 1.0
X-Received: by 2002:a92:c26a:: with SMTP id h10mr7042919ild.294.1619848275818;
 Fri, 30 Apr 2021 22:51:15 -0700 (PDT)
Date:   Fri, 30 Apr 2021 22:51:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011fd4305c13e51c7@google.com>
Subject: [syzbot] KASAN: user-memory-access Read in do_syscall_trace_enter
From:   syzbot <syzbot+e00eb4c4f40728f9bcde@syzkaller.appspotmail.com>
To:     aou@eecs.berkeley.edu, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        luto@amacapital.net, oleg@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, syzkaller-bugs@googlegroups.com,
        wad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    18a3c5f7 Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=14fa7ca5d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=105967f18e189a79
dashboard link: https://syzkaller.appspot.com/bug?extid=e00eb4c4f40728f9bcde
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e00eb4c4f40728f9bcde@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: user-memory-access in test_bit include/asm-generic/bitops/non-atomic.h:106 [inline]
BUG: KASAN: user-memory-access in cpumask_test_cpu include/linux/cpumask.h:373 [inline]
BUG: KASAN: user-memory-access in trace_sys_enter include/trace/events/syscalls.h:18 [inline]
BUG: KASAN: user-memory-access in do_syscall_trace_enter+0x24c/0x5ae arch/riscv/kernel/ptrace.c:255
Read of size 8 at addr 000000000118e9ae by task syz-executor.1/3237

CPU: 1 PID: 3237 Comm: syz-executor.1 Not tainted 5.12.0-rc8-syzkaller-00194-g18a3c5f7abfd #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffe000009708>] walk_stackframe+0x0/0x23c arch/riscv/kernel/traps.c:202
[<ffffffe002a631dc>] dump_backtrace+0x40/0x4e arch/riscv/kernel/stacktrace.c:113
[<ffffffe002a6320c>] show_stack+0x22/0x2e arch/riscv/kernel/stacktrace.c:118
[<ffffffe002a6ca98>] __dump_stack lib/dump_stack.c:79 [inline]
[<ffffffe002a6ca98>] dump_stack+0x148/0x1d8 lib/dump_stack.c:120
[<ffffffe0003bd560>] __kasan_report mm/kasan/report.c:403 [inline]
[<ffffffe0003bd560>] kasan_report+0x146/0x18c mm/kasan/report.c:416
[<ffffffe0003bddc8>] check_region_inline mm/kasan/generic.c:174 [inline]
[<ffffffe0003bddc8>] __asan_load8+0x4a/0x80 mm/kasan/generic.c:253
[<ffffffe000006fe8>] test_bit include/asm-generic/bitops/non-atomic.h:106 [inline]
[<ffffffe000006fe8>] cpumask_test_cpu include/linux/cpumask.h:373 [inline]
[<ffffffe000006fe8>] trace_sys_enter include/trace/events/syscalls.h:18 [inline]
[<ffffffe000006fe8>] do_syscall_trace_enter+0x24c/0x5ae arch/riscv/kernel/ptrace.c:255
[<ffffffe000005664>] handle_syscall_trace_enter+0x6/0x1e
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
SMP: stopping secondary CPUs
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96B0400AD4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhIDKhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:37:23 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44567 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhIDKhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:37:20 -0400
Received: by mail-io1-f72.google.com with SMTP id d15-20020a0566022befb02905b2e9040807so1251773ioy.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 03:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7NNx7gIj5TeGbj1VLxo80F+YlIqMfeRu8CH+i2zoe3o=;
        b=YpcPRHExqfrn3Re2OTRtCk+bYizV8bJ+SadkeWgN6JbNT6tidviIRks5W+A3ptF2Wj
         MxTeyRCnQ6p4yUiOYwppeTHLxTCz5pBvMS7CvenztSCJqQvkunCW9CRlnx4ynXzDbuG/
         XqeFpOQV8eG/fL1ggbm8yxa3n/uPg9/+r1H8UTPDvlmJEr++GtAqJan3oD0Y9Y/0ZicF
         vLCLrxiyJnBIg3ukZac7Prl7ECL76+n5Gr6fJ7r0Rh2aEqzVk6lzFIgyRQHXlA4tv9yF
         MhL5pqhdW7bWUNARnYnAZn89IJJjvsFX8rcXSwZ4OWzx/WtC/8i/o55F/YUAm1aUMDYn
         Z7jQ==
X-Gm-Message-State: AOAM533zU9DgJrkJubSDMkFV1N4WtTjSs3WX3+lyFQZsS+m9SwBhOTkN
        62p1gvTSWu0rK8+WkST89om0hpCUzsTCGNJ6f3wzgDf8MMSa
X-Google-Smtp-Source: ABdhPJx18cUggfgE9h6mJCtKYu+31TMBGhDgjfBfFsyicoywJKpTD0qpEmMoypsPy7eo2izMzwKlVjjwf233NShkX98vomBmGAxy
MIME-Version: 1.0
X-Received: by 2002:a92:3f01:: with SMTP id m1mr2227137ila.105.1630751779370;
 Sat, 04 Sep 2021 03:36:19 -0700 (PDT)
Date:   Sat, 04 Sep 2021 03:36:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086bfbc05cb28fc72@google.com>
Subject: [syzbot] INFO: task can't die in asm_sysvec_apic_timer_interrupt (2)
From:   syzbot <syzbot+ac4f41effb32ce6491c0@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        krisman@collabora.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    93717cde744f Add linux-next specific files for 20210830
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ef5ba9300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c643ef5289990dd1
dashboard link: https://syzkaller.appspot.com/bug?extid=ac4f41effb32ce6491c0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17bde2f5300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d11625300000

Bisection is inconclusive: the first bad commit could be any of:

0ee50b47532a namei: change filename_parentat() calling conventions
584d3226d665 namei: make do_mkdirat() take struct filename

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129f0125300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ac4f41effb32ce6491c0@syzkaller.appspotmail.com

INFO: task syz-executor702:6954 can't die for more than 143 seconds.
task:syz-executor702 state:R  running task     stack:24344 pid: 6954 ppid:  6540 flags:0x00004006
Call Trace:
 context_switch kernel/sched/core.c:4955 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6302
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0000:0xffffc900034bf728
RSP: 34bf748:0000000000000000 EFLAGS: 00000046 ORIG_RAX: ffffffff89400c02
==================================================================
BUG: KASAN: stack-out-of-bounds in __show_regs.cold+0x2b/0x481 arch/x86/kernel/process_64.c:81
Read of size 8 at addr ffffc900034bf6c0 by task khungtaskd/27

CPU: 1 PID: 27 Comm: khungtaskd Not tainted 5.14.0-next-20210830-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xf/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 __show_regs.cold+0x2b/0x481 arch/x86/kernel/process_64.c:81
 show_trace_log_lvl+0x25b/0x2ba arch/x86/kernel/dumpstack.c:298
 sched_show_task kernel/sched/core.c:8560 [inline]
 sched_show_task+0x433/0x5b0 kernel/sched/core.c:8534
 check_killed_task kernel/hung_task.c:184 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:242 [inline]
 watchdog.cold+0x74/0x1de kernel/hung_task.c:339
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


Memory state around the buggy address:
 ffffc900034bf580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900034bf600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc900034bf680: 00 00 00 f1 f1 f1 f1 00 00 f3 f3 00 00 00 00 00
                                           ^
 ffffc900034bf700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900034bf780: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 f2
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

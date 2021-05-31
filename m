Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AD23955DC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhEaHRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:17:17 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:42632 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhEaHRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:17:03 -0400
Received: by mail-il1-f197.google.com with SMTP id d17-20020a9236110000b02901cf25fcfdcdso7538445ila.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ms29K8906GcjzX9ZfLJGDgE5MeJLmEss4drSpezZ7Xg=;
        b=ayahK6aKl1Y/U+nl+fj99U24Th6MYI8J0m07eh2pg48gRh/zODNm5gDG+YaM0LQI/9
         KV7Rp5SusJ6PcXIY4/NCJQUthDmr6LIPlEqknwoIE7N7Y0liMUcgW+G+H8aQEYpiN9Ns
         tjY3qcZzL945zIux9K5pPb+1xy/DoTT5yYl8ytcUIOgR7/l2uhsRZ/PD/NDJHNYw0OF/
         lzPFi6cf/l0IxnNBpkMpHfrbTZxmMg9rze2tsCdBEsaNDC9wQF/jLqfU5h79i79wgFLU
         SPgrO+dybX2TLO0W5DNXG5pfrlx9WTVZziApo20BE262YheSYTHUNRnDewatbDdtt6sZ
         eayw==
X-Gm-Message-State: AOAM5319yhHfWmDcLUVbEvI9xhbCws+ds1V/9wQ74l9JlU0iU5XthyWY
        ZQij+EbNVPf3ECzDKB8XAo88sF8AIh8zr6XE7tUdoR7Cp7DN
X-Google-Smtp-Source: ABdhPJyoWLxd2nEyJQmr0Rf/2rxxjepU0VZsxb1cY+UCwQC9IglJC442LECgnxrAJexRViYjvKR8uQ0iHFwoalNDjBXAUXHN/9cb
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:590:: with SMTP id c16mr11049874ils.215.1622445323723;
 Mon, 31 May 2021 00:15:23 -0700 (PDT)
Date:   Mon, 31 May 2021 00:15:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030293b05c39afd6f@google.com>
Subject: [syzbot] KASAN: stack-out-of-bounds Read in profile_pc
From:   syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>
To:     ak@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        inglorion@google.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ac3a1c1 Merge tag 'mtd/fixes-for-5.13-rc4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1246d43dd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9f3fc7daa178986
dashboard link: https://syzkaller.appspot.com/bug?extid=84fe685c02cd112a2ac3
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in profile_pc+0xa4/0xe0 arch/x86/kernel/time.c:42
Read of size 8 at addr ffffc90001c0f7a0 by task systemd-udevd/12323

CPU: 1 PID: 12323 Comm: systemd-udevd Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x202/0x31e lib/dump_stack.c:120
 print_address_description+0x5f/0x3b0 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report+0x15c/0x200 mm/kasan/report.c:436
 profile_pc+0xa4/0xe0 arch/x86/kernel/time.c:42
 profile_tick+0xcd/0x120 kernel/profile.c:408
 tick_sched_handle kernel/time/tick-sched.c:227 [inline]
 tick_sched_timer+0x287/0x420 kernel/time/tick-sched.c:1373
 __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
 __hrtimer_run_queues+0x4cb/0xa60 kernel/time/hrtimer.c:1601
 hrtimer_interrupt+0x3b3/0x1040 kernel/time/hrtimer.c:1663
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0xf9/0x270 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8c/0xb0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xbc/0x120 kernel/locking/spinlock.c:191
Code: f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 5a 57 04 f8 f6 44 24 21 02 75 4e 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 0f 3f 94 f7 65 8b 05 50 54 3f 76 85 c0 74 3f 48 c7 04 24 0e 36
RSP: 0018:ffffc90001c0f7a0 EFLAGS: 00000206
RAX: 1ffff92000381ef8 RBX: ffff88802e529540 RCX: ffffffff90e84703
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffc90001c0f830 R08: ffffffff81855cb0 R09: ffffed1005ca52a9
R10: ffffed1005ca52a9 R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff92000381ef4 R14: ffffc90001c0f7c0 R15: 0000000000000a02
 spin_unlock_irqrestore include/linux/spinlock.h:409 [inline]
 __wake_up_common_lock kernel/sched/wait.c:140 [inline]
 __wake_up_sync_key+0x134/0x1f0 kernel/sched/wait.c:205
 sock_def_readable+0x141/0x210 net/core/sock.c:2910
 unix_dgram_sendmsg+0x1a6e/0x2aa0 net/unix/af_unix.c:1800
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg net/socket.c:674 [inline]
 sock_write_iter+0x398/0x520 net/socket.c:1001
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write fs/read_write.c:518 [inline]
 vfs_write+0xa39/0xc90 fs/read_write.c:605
 ksys_write+0x171/0x2a0 fs/read_write.c:658
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8354df21b0
Code: 2e 0f 1f 84 00 00 00 00 00 90 48 8b 05 19 7e 20 00 c3 0f 1f 84 00 00 00 00 00 83 3d 19 c2 20 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff ff 48 89 04 24
RSP: 002b:00007fff1f53e558 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055f37f7b13c0 RCX: 00007f8354df21b0
RDX: 0000000000000000 RSI: 00007fff1f53e610 RDI: 0000000000000008
RBP: 00007fff1f53e6d0 R08: 000055f37f7a0a04 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000246 R12: 00007fff1f53e620
R13: 000055f37f78c880 R14: 0000000000000003 R15: 000000000000000e


addr ffffc90001c0f7a0 is located in stack of task systemd-udevd/12323 at offset 0 in frame:
 _raw_spin_unlock_irqrestore+0x0/0x120 kernel/locking/spinlock.c:184

this frame has 1 object:
 [32, 40) 'flags.i.i.i.i'

Memory state around the buggy address:
 ffffc90001c0f680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90001c0f700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90001c0f780: 00 00 00 00 f1 f1 f1 f1 00 f3 f3 f3 00 00 00 00
                               ^
 ffffc90001c0f800: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
 ffffc90001c0f880: 00 00 00 00 00 f3 f3 f3 f3 f3 f3 f3 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

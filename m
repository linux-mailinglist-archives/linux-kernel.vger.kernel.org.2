Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137F9399C38
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFCIEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:04:12 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:44742 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhFCIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:04:11 -0400
Received: by mail-il1-f200.google.com with SMTP id h6-20020a92c0860000b02901e0cde08c7fso3561570ile.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 01:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=A2xCjM9zw3BoyRpLyyOu6YxuC9UXqbQYs5IWirkFgts=;
        b=CEuB4mdO1oQdhCddqJyUcWp3scyl04qkfI2lgwKGAj8egxRHuLAhqQ7Aa9ujlpujrz
         b4dqyCU8jr8s+b7PC8JHJd2PDgyLSFSdC6GReGriVyQzr69xTsNPu+eq011FBAqc29ZV
         FosmLuEIhU53knyUcuPc6qxcRdBIvZLZgrgVANv8yrRhWebC6ZvaVbfBdsqpaSklDj12
         Kmka71/mMQk1CFV/gEwlWvUz4HeSh2deyoGzhFI16f156lZOWQx4eW3XCgxjZaGhrRXg
         NBhm3GbwTDTVEMDFon63s+bRVTZFh4BCD47L4wztYXptNTE3SmUzo+Ji7gaB8mvTCylc
         u7zg==
X-Gm-Message-State: AOAM530xXeyRZgkoLgkfh3gWI7GFOlo/DS50W8lG27lW9dSx4b5LJz1D
        DHBhYWV5NE+f15JWC69HXrk9SO9JTEQHGkmIl+oG2hFsUv7C
X-Google-Smtp-Source: ABdhPJzIZv4eIgpza57l6WszkbQE/7A4q2V43YjWjffz1KBcLLZZz45Y/j9w4D9qWWqZPxWDBE59MLTDQfpAvmRdEHDE29PL7viM
MIME-Version: 1.0
X-Received: by 2002:a5e:de08:: with SMTP id e8mr3758068iok.25.1622707346829;
 Thu, 03 Jun 2021 01:02:26 -0700 (PDT)
Date:   Thu, 03 Jun 2021 01:02:26 -0700
In-Reply-To: <00000000000030293b05c39afd6f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb7af205c3d7fe69@google.com>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in profile_pc
From:   syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>
To:     ak@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        inglorion@google.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    324c92e5 Merge tag 'efi-urgent-2021-06-02' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1653122fd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ad5040c83f09b8e4
dashboard link: https://syzkaller.appspot.com/bug?extid=84fe685c02cd112a2ac3
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171e0683d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1723cc47d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in profile_pc+0xa4/0xe0 arch/x86/kernel/time.c:42
Read of size 8 at addr ffffc9000163f620 by task syz-executor815/8426

CPU: 1 PID: 8426 Comm: syz-executor815 Not tainted 5.13.0-rc4-syzkaller #0
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
Code: f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 ea e7 03 f8 f6 44 24 21 02 75 4e 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 1f b3 93 f7 65 8b 05 50 c4 3e 76 85 c0 74 3f 48 c7 04 24 0e 36
RSP: 0018:ffffc9000163f620 EFLAGS: 00000206
RAX: 1ffff920002c7ec8 RBX: ffffffff9117f258 RCX: ffffffff90e85703
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffc9000163f6b8 R08: ffffffff818560c0 R09: fffffbfff222fe4c
R10: fffffbfff222fe4c R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff920002c7ec4 R14: ffffc9000163f640 R15: 0000000000000a02
 __debug_check_no_obj_freed lib/debugobjects.c:997 [inline]
 debug_check_no_obj_freed+0x5a2/0x650 lib/debugobjects.c:1018
 free_pages_prepare mm/page_alloc.c:1303 [inline]
 __free_pages_ok+0x2f5/0x1180 mm/page_alloc.c:1572
 destroy_compound_page include/linux/mm.h:939 [inline]
 __put_compound_page mm/swap.c:111 [inline]
 release_pages+0x600/0x1b80 mm/swap.c:948
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu+0x780/0x910 mm/mmu_gather.c:249
 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:340
 exit_mmap+0x2c6/0x5f0 mm/mmap.c:3210
 __mmput+0x111/0x370 kernel/fork.c:1096
 exit_mm+0x67e/0x7d0 kernel/exit.c:502
 do_exit+0x6b9/0x23d0 kernel/exit.c:813
 do_group_exit+0x168/0x2d0 kernel/exit.c:923
 __do_sys_exit_group+0x13/0x20 kernel/exit.c:934
 __se_sys_exit_group+0x10/0x10 kernel/exit.c:932
 __x64_sys_exit_group+0x37/0x40 kernel/exit.c:932
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446bc9
Code: Unable to access opcode bytes at RIP 0x446b9f.
RSP: 002b:00007ffdae409208 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00000000004b8390 RCX: 0000000000446bc9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc4 R09: 0000000000000004
R10: 00000000004004a0 R11: 0000000000000246 R12: 00000000004b8390
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001


addr ffffc9000163f620 is located in stack of task syz-executor815/8426 at offset 0 in frame:
 _raw_spin_unlock_irqrestore+0x0/0x120 kernel/locking/spinlock.c:184

this frame has 1 object:
 [32, 40) 'flags.i.i.i.i'

Memory state around the buggy address:
 ffffc9000163f500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000163f580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000163f600: 00 00 00 00 f1 f1 f1 f1 00 f3 f3 f3 00 00 00 00
                               ^
 ffffc9000163f680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000163f700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


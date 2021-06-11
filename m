Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C22F3A42FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhFKN1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:27:32 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54934 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhFKN13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:27:29 -0400
Received: by mail-io1-f70.google.com with SMTP id s14-20020a5eaa0e0000b02904abce57cb24so16351114ioe.21
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=47SoH8M+YLMo/Ghpuy/ef9V3BQcZxcuzA8y+HvH2tJ4=;
        b=fjRO3cbtlKdPRxfCUJsep+8ihDy1mDd6UeBAemkrpu3S1gmuxxf2PwxO7sIIV61FQV
         bn0SHlshPrkLyfpoDJS3sHpm2mMuNXirZFgLJ3TKqMTvcm4pUjPfRj27jIBi5DzdzJ3J
         Geb9ZBBZ0C2NdTnw3XNxbMPmiXC1BpzucSim0GOft2CshBaewtmfuEpe8l3gH4Y9amBR
         pwkC6sMymrRUsTrlC5+/D5dDGXOjpbHIEXPg20kb2ivHA4O6nPH58wDYTc0jtJPsV+m/
         0E2iLnOWrjvJ4Ip/dDoDaIX3SYBNOkOzZ6bRSSCM+/JDvnSzfhBUqENMa9mgOru4dOR+
         Txfw==
X-Gm-Message-State: AOAM533DY8gLkswsh9LfgEs/QgbvvzEjRrRgFGGECVXmaZivbTBbIYug
        GKKb7AG9S7h6V1ka1CP/KQ+dS7DHWcB+43Aon0Is7wYoIguz
X-Google-Smtp-Source: ABdhPJzBlfxYFkcXKgYUJHV4EDwncScSiFETqBOHfumS4Lez3JLkS31IpmmknD92AmlGPi0GTktCwpsUEFKWNpQEoDWScm17/zWs
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16d1:: with SMTP id g17mr3924202jat.125.1623417931377;
 Fri, 11 Jun 2021 06:25:31 -0700 (PDT)
Date:   Fri, 11 Jun 2021 06:25:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f2e7705c47d713e@google.com>
Subject: [syzbot] general protection fault in free_swap_cache (2)
From:   syzbot <syzbot+f86560273c0c1c455aa7@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    614124be Linux 5.13-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1451414fd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30f476588412c065
dashboard link: https://syzkaller.appspot.com/bug?extid=f86560273c0c1c455aa7
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f86560273c0c1c455aa7@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 2367 Comm: syz-executor.3 Not tainted 5.13.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:compound_head include/linux/page-flags.h:184 [inline]
RIP: 0010:PageSwapCache include/linux/page-flags.h:399 [inline]
RIP: 0010:free_swap_cache+0x28/0x300 mm/swap_state.c:296
Code: c3 90 41 57 41 56 41 55 41 54 49 89 fc 55 4d 8d 6c 24 08 53 e8 c9 a0 c2 ff 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 85 02 00 00 4d 8b 74 24 08 31 ff 4c 89 e5 4c 89
RSP: 0018:ffffc9000cc7f6a8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88800015b088 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff81b23bb7 RDI: 0000000000000000
RBP: 000000000000000f R08: 00000000000001fe R09: 0000000000000000
R10: ffffffff81b27162 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000008 R14: dffffc0000000000 R15: ffffc9000cc7fa58
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000009efef1c CR3: 000000002868a000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 free_pages_and_swap_cache+0x58/0x90 mm/swap_state.c:324
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu+0xe9/0x6b0 mm/mmu_gather.c:249
 zap_pte_range mm/memory.c:1336 [inline]
 zap_pmd_range mm/memory.c:1374 [inline]
 zap_pud_range mm/memory.c:1403 [inline]
 zap_p4d_range mm/memory.c:1424 [inline]
 unmap_page_range+0x1a7f/0x2650 mm/memory.c:1445
 unmap_single_vma+0x198/0x300 mm/memory.c:1490
 unmap_vmas+0x16d/0x2f0 mm/memory.c:1522
 exit_mmap+0x2a8/0x590 mm/mmap.c:3208
 __mmput+0x122/0x470 kernel/fork.c:1096
 mmput+0x58/0x60 kernel/fork.c:1117
 exit_mm kernel/exit.c:502 [inline]
 do_exit+0xb0a/0x2a60 kernel/exit.c:813
 do_group_exit+0x125/0x310 kernel/exit.c:923
 get_signal+0x47f/0x2150 kernel/signal.c:2835
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:789
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x171/0x280 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x74/0xe0 arch/x86/entry/common.c:146
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:168
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f25549
Code: Unable to access opcode bytes at RIP 0xf7f2551f.
RSP: 002b:00000000f551f68c EFLAGS: 00000246 ORIG_RAX: 00000000000000f0
RAX: 0000000000000001 RBX: 000000000819afcc RCX: 0000000000000081
RDX: 00000000000f4240 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000080525a9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 1cbdfedd037865be ]---
RIP: 0010:compound_head include/linux/page-flags.h:184 [inline]
RIP: 0010:PageSwapCache include/linux/page-flags.h:399 [inline]
RIP: 0010:free_swap_cache+0x28/0x300 mm/swap_state.c:296
Code: c3 90 41 57 41 56 41 55 41 54 49 89 fc 55 4d 8d 6c 24 08 53 e8 c9 a0 c2 ff 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 85 02 00 00 4d 8b 74 24 08 31 ff 4c 89 e5 4c 89
RSP: 0018:ffffc9000cc7f6a8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88800015b088 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff81b23bb7 RDI: 0000000000000000
RBP: 000000000000000f R08: 00000000000001fe R09: 0000000000000000
R10: ffffffff81b27162 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000008 R14: dffffc0000000000 R15: ffffc9000cc7fa58
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000009efef1c CR3: 000000002868a000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

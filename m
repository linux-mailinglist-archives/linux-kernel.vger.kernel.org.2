Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609DF3BF4D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 06:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhGHEj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 00:39:59 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55019 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhGHEj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 00:39:58 -0400
Received: by mail-io1-f69.google.com with SMTP id m14-20020a5d898e0000b02904f7957d92b5so3171946iol.21
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 21:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=40l21TFuHqhJl0mM7zsS8/Vnk6ZKMOnaYU7/bH8VqkU=;
        b=ZpSnzGdJpzuGGTo7WNFySsHoRn5oTttTTuBkeP+XrUwedmtanWnmNVMYcY/2VeS1fg
         QpM7Gr2yVJwQXu3jIG6tBpATG3UwlBsy1rrF2Cpf/mg5XA4rop4O43LI18VYmhZofiRP
         hbdNN2F4dYSAwq64m19gDU+YVQvFbN5xm0zidUhSK9542GKWl+t0/WSB6qwdUZpU/xco
         KSEqLAdyJcuLE3Ct3SNAJolihJODvrE4mtFRuuU4NjdQKmQhHt7eJcIrerQv1uEipaWR
         A9hs4aiyRLvBIOucMesnQzg3ipVljTOV/iSfJi8HwHtK1rxo+YppGHjhgwfiEkRZEeMN
         bBQA==
X-Gm-Message-State: AOAM533foU3hJbVDonfRBkEYdnrTSQepnJpF/knshGw61h+jcbG26eEX
        DeytPhaK16b0dDQNZ2QcGdnOUc7QmsacTfo7DP/fCI3Ksqwv
X-Google-Smtp-Source: ABdhPJwbeNdDJaibVFfoqsd6LMSSJBeov+U4QbW9IjY+ESUaQyhqcY8c3Wzyhnst3V0G3j306oxA7ETyLX+KTIRqosmNQy/rauJG
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1544:: with SMTP id h4mr2437448iow.76.1625719037271;
 Wed, 07 Jul 2021 21:37:17 -0700 (PDT)
Date:   Wed, 07 Jul 2021 21:37:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8a3e905c69535e3@google.com>
Subject: [syzbot] kernel BUG in __tlb_remove_page_size
From:   syzbot <syzbot+2f816ba9b71ca9a8e6b0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, npiggin@gmail.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1216c149d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
dashboard link: https://syzkaller.appspot.com/bug?extid=2f816ba9b71ca9a8e6b0
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151ee572300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f816ba9b71ca9a8e6b0@syzkaller.appspotmail.com

 release_pages+0x856/0x20a0 mm/swap.c:972
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu mm/mmu_gather.c:249 [inline]
 tlb_finish_mmu+0x165/0x8c0 mm/mmu_gather.c:340
 exit_mmap+0x1ea/0x620 mm/mmap.c:3204
 __mmput+0x122/0x470 kernel/fork.c:1101
 mmput+0x58/0x60 kernel/fork.c:1122
 exit_mm kernel/exit.c:501 [inline]
 do_exit+0xae2/0x2a50 kernel/exit.c:812
 do_group_exit+0x125/0x310 kernel/exit.c:922
 __do_sys_exit_group kernel/exit.c:933 [inline]
 __se_sys_exit_group kernel/exit.c:931 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
------------[ cut here ]------------
kernel BUG at mm/mmu_gather.c:87!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 10208 Comm: syz-executor.4 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__tlb_remove_page_size+0x1f1/0x420 mm/mmu_gather.c:87
Code: d2 0f 85 ef 01 00 00 8b 6d 0c e9 34 ff ff ff e8 65 0d c8 ff 0f 0b e8 5e 0d c8 ff 48 c7 c6 60 93 96 89 4c 89 f7 e8 9f ce fa ff <0f> 0b e8 48 0d c8 ff 4c 8d 6b 24 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc90002757748 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90002757a60 RCX: 0000000000000000
RDX: ffff888032eeb880 RSI: ffffffff81ad7ce1 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000029 R09: 00000000ffffffff
R10: ffffffff88e1c1e9 R11: 00000000ffffffff R12: 0000000000000000
R13: 0000000000000001 R14: ffffea0000d09e00 R15: ffffc90002757a88
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000000ab8a404 CR3: 000000003792f000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __tlb_remove_page include/asm-generic/tlb.h:440 [inline]
 zap_pte_range mm/memory.c:1272 [inline]
 zap_pmd_range mm/memory.c:1384 [inline]
 zap_pud_range mm/memory.c:1413 [inline]
 zap_p4d_range mm/memory.c:1434 [inline]
 unmap_page_range+0xf22/0x2890 mm/memory.c:1455
 unmap_single_vma+0x198/0x300 mm/memory.c:1500
 unmap_vmas+0x16d/0x2f0 mm/memory.c:1532
 exit_mmap+0x1d0/0x620 mm/mmap.c:3202
 __mmput+0x122/0x470 kernel/fork.c:1101
 mmput+0x58/0x60 kernel/fork.c:1122
 exit_mm kernel/exit.c:501 [inline]
 do_exit+0xae2/0x2a50 kernel/exit.c:812
 do_group_exit+0x125/0x310 kernel/exit.c:922
 get_signal+0x47f/0x2150 kernel/signal.c:2796
 arch_do_signal_or_restart+0x2a9/0x1eb0 arch/x86/kernel/signal.c:789
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff1549
Code: Unable to access opcode bytes at RIP 0xf7ff151f.
RSP: 002b:00000000f77eb68c EFLAGS: 00000246 ORIG_RAX: 00000000000000f0
RAX: 0000000000000001 RBX: 000000000819afcc RCX: 0000000000000081
RDX: 00000000000f4240 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000080525a9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 67c535245c014435 ]---
RIP: 0010:__tlb_remove_page_size+0x1f1/0x420 mm/mmu_gather.c:87
Code: d2 0f 85 ef 01 00 00 8b 6d 0c e9 34 ff ff ff e8 65 0d c8 ff 0f 0b e8 5e 0d c8 ff 48 c7 c6 60 93 96 89 4c 89 f7 e8 9f ce fa ff <0f> 0b e8 48 0d c8 ff 4c 8d 6b 24 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc90002757748 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90002757a60 RCX: 0000000000000000
RDX: ffff888032eeb880 RSI: ffffffff81ad7ce1 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000029 R09: 00000000ffffffff
R10: ffffffff88e1c1e9 R11: 00000000ffffffff R12: 0000000000000000
R13: 0000000000000001 R14: ffffea0000d09e00 R15: ffffc90002757a88
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000000ab8a404 CR3: 000000003792f000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

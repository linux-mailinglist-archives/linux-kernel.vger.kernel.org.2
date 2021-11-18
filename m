Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA96455DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhKROX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:23:27 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:51101 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhKROX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:23:26 -0500
Received: by mail-il1-f200.google.com with SMTP id d10-20020a92360a000000b002756b12323bso4097849ila.17
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 06:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=z/DzrfesZMNqVRgfzsy+n7n7C2p0bhPR2vbMBVnOazQ=;
        b=m/YJznRbmDrNJFcIHL3blRR8/uA61Kqy5PE9zlXijqTjE21hHMy1UXf0V1qw1jXm2i
         kHKA5Zy+w245B1jkorBvdYO2MZPpWrokbMua1FST6j4j3XLg3wUCIycYBjNH+GX1V1VG
         TZUHTQxUPpmQh5SUTlfHhQ2xnzBUjQfB0oDY6EXFhzdgQUCDm9bn03HQNcMWcisAcQxk
         ZukVMyROl34xBFDyGVNLEnWApM9wQ9+A2vGHnoPaQ29KKTAVGJ8gIAmjN0Ern69OXqVS
         5TGXf1wtJ7DuHAjZKArnOqtfLtQwiuGIMtSVJ9gtB0ATVUD9jBC90p1szjSOmBFimCgk
         rKHg==
X-Gm-Message-State: AOAM532PosZ0qSqAxNz9l0FUcvCPCRCR3hWkWDpIxGFGrG3cn6cdc7qW
        V54FvmEJSgOYMu/C8fXF3AMqtOAfsBfqrpykwTfH/tbxp12d
X-Google-Smtp-Source: ABdhPJywu7TSs4tjbweXuYkztpX+8zVmrqg6b3dRdQyjopacGVSODIs/g7mj4q7Xx859qWAJmtfUgNII7n2IthgZWzeLhvQilL8W
MIME-Version: 1.0
X-Received: by 2002:a02:8663:: with SMTP id e90mr20365886jai.14.1637245226351;
 Thu, 18 Nov 2021 06:20:26 -0800 (PST)
Date:   Thu, 18 Nov 2021 06:20:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020805d05d110dc77@google.com>
Subject: [syzbot] KCSAN: data-race in flush_tlb_batched_pending / try_to_unmap_one
From:   syzbot <syzbot+aa5bebed695edaccf0df@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    42eb8fdac2fc Merge tag 'gfs2-v5.16-rc2-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13160026b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a70237460d215073
dashboard link: https://syzkaller.appspot.com/bug?extid=aa5bebed695edaccf0df
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa5bebed695edaccf0df@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in flush_tlb_batched_pending / try_to_unmap_one

write to 0xffff8881072cfbbc of 1 bytes by task 17406 on cpu 1:
 flush_tlb_batched_pending+0x5f/0x80 mm/rmap.c:691
 madvise_free_pte_range+0xee/0x7d0 mm/madvise.c:594
 walk_pmd_range mm/pagewalk.c:128 [inline]
 walk_pud_range mm/pagewalk.c:205 [inline]
 walk_p4d_range mm/pagewalk.c:240 [inline]
 walk_pgd_range mm/pagewalk.c:277 [inline]
 __walk_page_range+0x981/0x1160 mm/pagewalk.c:379
 walk_page_range+0x131/0x300 mm/pagewalk.c:475
 madvise_free_single_vma mm/madvise.c:734 [inline]
 madvise_dontneed_free mm/madvise.c:822 [inline]
 madvise_vma mm/madvise.c:996 [inline]
 do_madvise+0xe4a/0x1140 mm/madvise.c:1202
 __do_sys_madvise mm/madvise.c:1228 [inline]
 __se_sys_madvise mm/madvise.c:1226 [inline]
 __x64_sys_madvise+0x5d/0x70 mm/madvise.c:1226
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

write to 0xffff8881072cfbbc of 1 bytes by task 71 on cpu 0:
 set_tlb_ubc_flush_pending mm/rmap.c:636 [inline]
 try_to_unmap_one+0x60e/0x1220 mm/rmap.c:1515
 rmap_walk_anon+0x2fb/0x470 mm/rmap.c:2301
 try_to_unmap+0xec/0x110
 shrink_page_list+0xe91/0x2620 mm/vmscan.c:1719
 shrink_inactive_list+0x3fb/0x730 mm/vmscan.c:2394
 shrink_list mm/vmscan.c:2621 [inline]
 shrink_lruvec+0x3c9/0x710 mm/vmscan.c:2940
 shrink_node_memcgs+0x23e/0x410 mm/vmscan.c:3129
 shrink_node+0x8f6/0x1190 mm/vmscan.c:3252
 kswapd_shrink_node mm/vmscan.c:4022 [inline]
 balance_pgdat+0x702/0xd30 mm/vmscan.c:4213
 kswapd+0x200/0x340 mm/vmscan.c:4473
 kthread+0x2c7/0x2e0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

value changed: 0x01 -> 0x00

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 71 Comm: kswapd0 Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

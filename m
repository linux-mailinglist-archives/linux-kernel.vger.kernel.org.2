Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4266B42FF71
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 02:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbhJPAh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 20:37:27 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36586 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbhJPAh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 20:37:26 -0400
Received: by mail-io1-f70.google.com with SMTP id x21-20020a0566022c5500b005ddd625f399so5806119iov.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 17:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3JDst4DDEPTiwe2TIQk+0rab3FK3KwIKCIi2+7N7p5s=;
        b=Knhwz76NA4LOsYHzH4tzB6lxs4V/3AWyKKgc8Z9890OC2l3/c1Qc1ktvH+zHEXuzG3
         6fmtKoLI8Ccg+ZgffKYCltNtjWgbSj41tYYRTGlRCuwjWKyjXt96tPweIb8830biUheF
         esjbUHeQavcY75kzL4+HQT/4ZeoPvTR20mBVWRpv+rH/2xDdVmi7I3Pemu+vkBn/AqK2
         g9OLq2jEGQbmKIwMQXA1HPnYzDn9kwjmRStoUWhfH3EESJw4f+UWtIhV2UqMpTB3/pBF
         azZQh5Uj5QuPuq2fDtRTWy8ED7OaM6O4M5z5eXV8gZC7kETwerEg7Xi07dycnhJquJfq
         Gl7A==
X-Gm-Message-State: AOAM53142XIY/k9LemELpRggP+Me4p3x3iTFFNv+UjVpb7Brjl0TxMrV
        +P9nYq3Uc8SxDo8ieMNcGvg0oY0Kz5H+1VsbVexQYQJrNPbB
X-Google-Smtp-Source: ABdhPJzDrqpHQjiE3013OSINJRKFcds4gqows+jvI5C41vfEuP42xkXbtiGpKxdTk6SVp5wHE7hVu0FdHhpDeiY0/3dOSCE35jIf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca9:: with SMTP id x9mr6001246ill.60.1634344519180;
 Fri, 15 Oct 2021 17:35:19 -0700 (PDT)
Date:   Fri, 15 Oct 2021 17:35:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081a7bc05ce6d7c7a@google.com>
Subject: [syzbot] KASAN: use-after-free Read in __isofs_iget
From:   syzbot <syzbot+6fc7fb214625d82af7d1@syzkaller.appspotmail.com>
To:     bingjingc@synology.com, cccheng@synology.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, pali@kernel.org,
        robbieko@synology.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d3134eb5de85 Add linux-next specific files for 20211011
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f5fd98b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9662326d2be383b
dashboard link: https://syzkaller.appspot.com/bug?extid=6fc7fb214625d82af7d1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ca2e47300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17869bd4b00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10808570b00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12808570b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14808570b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6fc7fb214625d82af7d1@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 224
==================================================================
BUG: KASAN: use-after-free in isofs_read_inode fs/isofs/inode.c:1350 [inline]
BUG: KASAN: use-after-free in __isofs_iget fs/isofs/inode.c:1550 [inline]
BUG: KASAN: use-after-free in __isofs_iget+0x1c84/0x2100 fs/isofs/inode.c:1525
Read of size 1 at addr ffff88806ece6015 by task syz-executor936/6592

CPU: 0 PID: 6592 Comm: syz-executor936 Not tainted 5.15.0-rc4-next-20211011-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x320 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 isofs_read_inode fs/isofs/inode.c:1350 [inline]
 __isofs_iget fs/isofs/inode.c:1550 [inline]
 __isofs_iget+0x1c84/0x2100 fs/isofs/inode.c:1525
 isofs_iget fs/isofs/isofs.h:133 [inline]
 isofs_export_iget fs/isofs/export.c:29 [inline]
 isofs_export_iget fs/isofs/export.c:20 [inline]
 isofs_fh_to_dentry fs/isofs/export.c:170 [inline]
 isofs_fh_to_dentry+0x117/0x1f0 fs/isofs/export.c:162
 exportfs_decode_fh_raw+0x127/0x7a0 fs/exportfs/expfs.c:436
 exportfs_decode_fh+0x38/0x90 fs/exportfs/expfs.c:575
 do_handle_to_path fs/fhandle.c:152 [inline]
 handle_to_path fs/fhandle.c:207 [inline]
 do_handle_open+0x2b6/0x8b0 fs/fhandle.c:223
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fa002798fb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffffcd5a438 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 0000000000010939 RCX: 00007fa002798fb9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffffcd5a460
R10: 00007ffffcd5a300 R11: 0000000000000246 R12: 00007ffffcd5a45c
R13: 00007ffffcd5a490 R14: 00007ffffcd5a470 R15: 000000000000000d
 </TASK>

The buggy address belongs to the page:
page:ffffea0001bb3980 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6ece6
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001beb708 ffffea0001f38e48 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), pid 6450, ts 55488123071, free_ts 55808040837
 prep_new_page mm/page_alloc.c:2416 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4147
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5382
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2191
 __get_free_pages+0x8/0x40 mm/page_alloc.c:5431
 _pgd_alloc arch/x86/mm/pgtable.c:414 [inline]
 pgd_alloc+0x81/0x360 arch/x86/mm/pgtable.c:430
 mm_alloc_pgd kernel/fork.c:639 [inline]
 mm_init+0x60a/0xab0 kernel/fork.c:1125
 mm_alloc+0x99/0xc0 kernel/fork.c:1153
 bprm_mm_init fs/exec.c:368 [inline]
 alloc_bprm+0x1c3/0x8f0 fs/exec.c:1523
 do_execveat_common+0x232/0x780 fs/exec.c:1889
 do_execve fs/exec.c:1990 [inline]
 __do_sys_execve fs/exec.c:2066 [inline]
 __se_sys_execve fs/exec.c:2061 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:2061
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1336 [inline]
 free_pcp_prepare+0x373/0x870 mm/page_alloc.c:1387
 free_unref_page_prepare mm/page_alloc.c:3307 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3386
 mm_free_pgd kernel/fork.c:647 [inline]
 __mmdrop+0xcb/0x3f0 kernel/fork.c:749
 mmdrop include/linux/sched/mm.h:49 [inline]
 __mmput+0x3f1/0x4b0 kernel/fork.c:1174
 mmput+0x56/0x60 kernel/fork.c:1185
 exit_mm kernel/exit.c:507 [inline]
 do_exit+0xb29/0x2b40 kernel/exit.c:819
 do_group_exit+0x125/0x310 kernel/exit.c:929
 __do_sys_exit_group kernel/exit.c:940 [inline]
 __se_sys_exit_group kernel/exit.c:938 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:938
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88806ece5f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88806ece5f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88806ece6000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                         ^
 ffff88806ece6080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88806ece6100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

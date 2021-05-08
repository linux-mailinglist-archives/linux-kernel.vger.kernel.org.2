Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC6377169
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 13:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhEHLZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 07:25:25 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:49086 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhEHLZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 07:25:24 -0400
Received: by mail-il1-f197.google.com with SMTP id h4-20020a926c040000b0290192f4fa4c3bso9381127ilc.15
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 04:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=akSdRLe9fHHgflYpvbh+1JoTvkfwLMfNLnmulc008+g=;
        b=qMYNehvm+bL3+TzCOH8gqfqd91JO1EsOIp1u21jq8Mk5NDm7JjOF87Gr/XSSvePPG7
         nyC8nueNOm0lXa1W/M/A8rvqLUgwwo1S2XjQFs3ag6hiB8aVGcf+hddIQ8LxPE1LRG9m
         D31uygOdaRQLgZZdCKDMeNwUc6ElCssHPdgoBgCZoCXLAZBh3cjHEGpvAg9XW+Q1RmIe
         KyaRjHyuA+HtIbwSK8ZXjylKsUak1uxzSnnSfm3PWatCqUeLKGJC7k0rswmaGUpH7qiw
         27YPWzn1gYSgSKmaF5/n6OkSUoYVOXMrxeobrbZLYQW67Dyun/vc8GdpCd9gVKHJxIay
         WTSA==
X-Gm-Message-State: AOAM530Y9YBGmv7yA5O5IEWA7cxnritkvH3R8C/CsYsRQv3OAGLWsU4C
        ZCKuUOiBdeM0d8VGkV9uMixPyfgEsMqADe2fZLE3sB94CSCc
X-Google-Smtp-Source: ABdhPJwcc9JLeJrzBzkgmAp8vfAtvWKck3VUhodVUyi0JxHDe+y++eJ2pb8cK2Vbhhq1+LNZwCCdfEi1IbIxMwJ+88mGc2r5nnOM
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr13369216ils.93.1620473062750;
 Sat, 08 May 2021 04:24:22 -0700 (PDT)
Date:   Sat, 08 May 2021 04:24:22 -0700
In-Reply-To: <000000000000bc4fd705a6e090e2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045ff9505c1cfc9ae@google.com>
Subject: Re: [syzbot] kernel BUG at include/linux/swapops.h:LINE!
From:   syzbot <syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com>
To:     Markus.Elfring@web.de, akpm@linux-foundation.org, axboe@kernel.dk,
        david@redhat.com, hannes@cmpxchg.org, hdanton@sina.com,
        jennifer@dakotaviewrealty.com, kirill.shutemov@linux.intel.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mike.kravetz@oracle.com, rcampbell@nvidia.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    869a85b9 Add linux-next specific files for 20210507
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15b48a63d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b72885037018d06d
dashboard link: https://syzkaller.appspot.com/bug?extid=c48f34012b06c4ac67dd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10479fd5d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1565e995d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at include/linux/swapops.h:197!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8460 Comm: syz-executor246 Not tainted 5.12.0-next-20210507-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:migration_entry_to_page include/linux/swapops.h:197 [inline]
RIP: 0010:migration_entry_to_page include/linux/swapops.h:190 [inline]
RIP: 0010:zap_huge_pmd+0xe5b/0x1110 mm/huge_memory.c:1697
Code: 2b 3f b8 ff 48 8b 5c 24 10 48 83 eb 01 e9 a8 f6 ff ff e8 18 3f b8 ff 48 8b 5c 24 10 48 83 eb 01 e9 66 f7 ff ff e8 05 3f b8 ff <0f> 0b e8 fe 3e b8 ff 31 f6 31 ff 49 bc 00 f0 ff ff ff ff 0f 00 e8
RSP: 0018:ffffc90001a2f730 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888024bc5580 RSI: ffffffff81bc972b RDI: 0000000000000003
RBP: ffffc90001a2fa48 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81bc8ec8 R11: 0000000000000000 R12: ffff88802c9a5800
R13: ffffea0000e58080 R14: ffff8880303bfea0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c8168 CR3: 0000000016b36000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 zap_pmd_range mm/memory.c:1361 [inline]
 zap_pud_range mm/memory.c:1403 [inline]
 zap_p4d_range mm/memory.c:1424 [inline]
 unmap_page_range+0x1aa4/0x2650 mm/memory.c:1445
 unmap_single_vma+0x198/0x300 mm/memory.c:1490
 unmap_vmas+0x16d/0x2f0 mm/memory.c:1522
 exit_mmap+0x2a8/0x590 mm/mmap.c:3207
 __mmput+0x122/0x470 kernel/fork.c:1096
 mmput+0x58/0x60 kernel/fork.c:1117
 exit_mm kernel/exit.c:502 [inline]
 do_exit+0xb0a/0x2a60 kernel/exit.c:813
 do_group_exit+0x125/0x310 kernel/exit.c:923
 get_signal+0x47f/0x2150 kernel/signal.c:2856
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:789
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x171/0x280 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 do_syscall_64+0x47/0xb0 arch/x86/entry/common.c:57
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4458f9
Code: Unable to access opcode bytes at RIP 0x4458cf.
RSP: 002b:00007f45f24e4318 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000004ca408 RCX: 00000000004458f9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000004ca408
RBP: 00000000004ca400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000001000000020
R13: 00007ffeb676771f R14: 00007f45f24e4400 R15: 0000000000022000
Modules linked in:
---[ end trace 8c9f5c48deec1bb7 ]---
RIP: 0010:migration_entry_to_page include/linux/swapops.h:197 [inline]
RIP: 0010:migration_entry_to_page include/linux/swapops.h:190 [inline]
RIP: 0010:zap_huge_pmd+0xe5b/0x1110 mm/huge_memory.c:1697
Code: 2b 3f b8 ff 48 8b 5c 24 10 48 83 eb 01 e9 a8 f6 ff ff e8 18 3f b8 ff 48 8b 5c 24 10 48 83 eb 01 e9 66 f7 ff ff e8 05 3f b8 ff <0f> 0b e8 fe 3e b8 ff 31 f6 31 ff 49 bc 00 f0 ff ff ff ff 0f 00 e8
RSP: 0018:ffffc90001a2f730 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888024bc5580 RSI: ffffffff81bc972b RDI: 0000000000000003
RBP: ffffc90001a2fa48 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81bc8ec8 R11: 0000000000000000 R12: ffff88802c9a5800
R13: ffffea0000e58080 R14: ffff8880303bfea0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c8168 CR3: 000000000bc8e000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D69C3EC23E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 13:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbhHNLIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 07:08:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47780 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbhHNLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 07:07:52 -0400
Received: by mail-io1-f71.google.com with SMTP id p7-20020a6b63070000b02904f58bb90366so6672387iog.14
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 04:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jg6Z03SJ05/CjgMCaJhiwvhxwv4eMAQtr466IAVxO1w=;
        b=lOdxJj787B/1fehTcyV3zrje0EYNxTrUV7VqedTvq2G2TD95/pxGmldlg4UIvXmcRa
         gm6KzL/5LhH0aXz0T0O7mneSs7gDqMDtyL/F9l1hfCmyY1CkVF/YYYiVCPuHAgdO/G71
         CoKwwD5iZhs1GQWYRr4lM07vMdIt7JwaftiPrSn67kkcOSm3daqlADo2CcdSwLUS1N/t
         89IT6qfQUGlgjnu97GXvPAC0HWg+YRHzp9S6F0fMYKkN+vadruZ3wvy5y5KWgGUF8v0L
         /TDOQ+G00OHlWX6c+x4vqG0g1CZcmdjz90SidvrUFnZy2ulYa+y/DIVPVfe0SVp7pSPe
         MnOQ==
X-Gm-Message-State: AOAM531Es2gkWg6ijVbveRLcBxFSoI/46jpAPRM6bY6C/E+KVFKA5RcB
        YJmaNeqNSK3v/50GpV0j/osuCZBeH2GCztWjjTDbA3j1Gxyg
X-Google-Smtp-Source: ABdhPJwjioquqoHNADhdxLi1RG7P24OTrYmx7drCuSdqgzNJXAlxKwfSjGOO8w95IjsKHMTE8cfmFSF8FUYUguRnUp9F2TCQEpc7
MIME-Version: 1.0
X-Received: by 2002:a02:cd2c:: with SMTP id h12mr3429459jaq.84.1628939243726;
 Sat, 14 Aug 2021 04:07:23 -0700 (PDT)
Date:   Sat, 14 Aug 2021 04:07:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbad4305c982f836@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in alloc_huge_page
From:   syzbot <syzbot+57876cfc2dca0c6b2e6a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mike.kravetz@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92d00774360d Add linux-next specific files for 20210810
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12e2b4d9300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6933fa6f9a86ca9
dashboard link: https://syzkaller.appspot.com/bug?extid=57876cfc2dca0c6b2e6a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f81581300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11419dfa300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57876cfc2dca0c6b2e6a@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffffffffffffc
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD b68f067 P4D b68f067 PUD b691067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6601 Comm: syz-executor361 Not tainted 5.14.0-rc5-next-20210810-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__list_add include/linux/list.h:71 [inline]
RIP: 0010:list_add include/linux/list.h:86 [inline]
RIP: 0010:alloc_huge_page+0xdcb/0x11b0 mm/hugetlb.c:2821
Code: 00 0f 85 6b 03 00 00 48 89 ce 48 89 4a 08 48 b8 00 00 00 00 00 fc ff df 48 c1 ee 03 80 3c 06 00 0f 85 2b 03 00 00 49 8d 7e 10 <49> 89 56 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80
RSP: 0018:ffffc90002b8fb78 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: fffffffffffffffc
RDX: ffffea0001fb0008 RSI: 1fffffffffffffff RDI: 0000000000000004
RBP: ffffc90002b8fd50 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff81b6fda1 R11: 0000000000000000 R12: ffffffff90246a70
R13: 0000000000000001 R14: fffffffffffffff4 R15: ffffffff90246b48
FS:  00000000014e5300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffffc CR3: 000000006eadf000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 hugetlbfs_fallocate+0x6f3/0x12e0 fs/hugetlbfs/inode.c:727
 vfs_fallocate+0x48d/0xd80 fs/open.c:311
 ksys_fallocate fs/open.c:334 [inline]
 __do_sys_fallocate fs/open.c:342 [inline]
 __se_sys_fallocate fs/open.c:340 [inline]
 __x64_sys_fallocate+0xcf/0x140 fs/open.c:340
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43fca9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb30e0858 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 000000000043fca9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000003fe R11: 0000000000000246 R12: 000000000001105c
R13: 00007ffeb30e087c R14: 00007ffeb30e0890 R15: 00007ffeb30e0880
Modules linked in:
CR2: fffffffffffffffc
---[ end trace ca76f32b4018d821 ]---
RIP: 0010:__list_add include/linux/list.h:71 [inline]
RIP: 0010:list_add include/linux/list.h:86 [inline]
RIP: 0010:alloc_huge_page+0xdcb/0x11b0 mm/hugetlb.c:2821
Code: 00 0f 85 6b 03 00 00 48 89 ce 48 89 4a 08 48 b8 00 00 00 00 00 fc ff df 48 c1 ee 03 80 3c 06 00 0f 85 2b 03 00 00 49 8d 7e 10 <49> 89 56 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80
RSP: 0018:ffffc90002b8fb78 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: fffffffffffffffc
RDX: ffffea0001fb0008 RSI: 1fffffffffffffff RDI: 0000000000000004
RBP: ffffc90002b8fd50 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff81b6fda1 R11: 0000000000000000 R12: ffffffff90246a70
R13: 0000000000000001 R14: fffffffffffffff4 R15: ffffffff90246b48
FS:  00000000014e5300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffffc CR3: 000000006eadf000 CR4: 00000000001506f0
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

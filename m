Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D34371E57
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhECRVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:21:15 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:44896 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhECRVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:21:14 -0400
Received: by mail-io1-f69.google.com with SMTP id z25-20020a05660200d9b02903de90ff885fso3797520ioe.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 10:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fqjpEgXxU48dBvBc0k28t1xNCH6d9Lq1rJ6mmXcKRTs=;
        b=lq2/y5PMjOSrBjaW6vsDlr3xItUSizTClAciaF550WJO9C/p+UOqcb7e10VUPXd/ZF
         L5YUz3MZjBEI0eSxxOMJWrO8OKWIx3zLk/DN04CDtCz0aCAeJhbH/Gnug4B947GrUTKS
         pC84cqLjeDu9rIGfG4qE4+r/dQWsHOsF1epgvyXoVeWG51f2m8J7nn0dNDpI3LBiLjfM
         +okK0tGLN0Gsn9L81HDwnIhJyyAwppgriG6koKOgrX4rgjZCIklOtpCWF/GEHpYCGcMY
         oQ8gvd4ksMy6Uw0BGQXESK2ehPHAeH6zwn8E34+ryYKa6dO/II7hsdDOH+v+5bsYqoMH
         19+g==
X-Gm-Message-State: AOAM5310v5zn62zat/ZDSF7/UuB88hEHdGV85CYah5tq/nRANq/TehW0
        5hw0vABwGHeGh+F4Kj8f4DPDKUfhkDggPT5kJhCeOY/mRo4s
X-Google-Smtp-Source: ABdhPJxVH1MQc+kNDPr4qttOGaQJ7ecbGFZTQM7tJdeqxl959fjnLv/JbPjBvYSN39TskaEeoBb/Q4EIcflGOewSBkw/py5pGzFm
MIME-Version: 1.0
X-Received: by 2002:a6b:3c11:: with SMTP id k17mr14975043iob.115.1620062420672;
 Mon, 03 May 2021 10:20:20 -0700 (PDT)
Date:   Mon, 03 May 2021 10:20:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001923f505c1702dd3@google.com>
Subject: [syzbot] divide error in squashfs_readpage
From:   syzbot <syzbot+e8f781243ce16ac2f962@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1336f3f5d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
dashboard link: https://syzkaller.appspot.com/bug?extid=e8f781243ce16ac2f962
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c7221ed00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bc5cc3d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8f781243ce16ac2f962@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8
divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8394 Comm: syz-executor613 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:fill_meta_index fs/squashfs/file.c:243 [inline]
RIP: 0010:read_blocklist fs/squashfs/file.c:332 [inline]
RIP: 0010:squashfs_readpage+0xa0d/0x2210 fs/squashfs/file.c:469
Code: 3c 24 31 d2 48 63 8c 24 b4 00 00 00 49 8b 47 c8 48 89 cf 48 c1 e1 0b c1 e7 0b 89 7c 24 4c 31 ff 48 89 44 24 60 48 63 44 24 70 <48> f7 f1 49 89 c6 89 c6 48 89 44 24 58 89 44 24 1c 89 44 24 48 e8
RSP: 0018:ffffc9000188f3e8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000099 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8221fc4d RDI: 0000000000000000
RBP: 000000000000000c R08: ffffffffffffffff R09: 000000000000000c
R10: ffffffff8221fc3e R11: 000000000000003f R12: 00000000000000de
R13: ffff888033290088 R14: 0000000000000000 R15: ffff888033290038
FS:  00000000024ae300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffe4921df8 CR3: 0000000014fc9000 CR4: 0000000000350ee0
Call Trace:
 read_pages+0x5c5/0x8d0 mm/readahead.c:145
 page_cache_ra_unbounded+0x61f/0x920 mm/readahead.c:238
 do_page_cache_ra mm/readahead.c:267 [inline]
 ondemand_readahead+0x65c/0x1190 mm/readahead.c:550
 page_cache_sync_ra+0x1cb/0x200 mm/readahead.c:578
 page_cache_sync_readahead include/linux/pagemap.h:864 [inline]
 filemap_get_pages+0x29f/0x1920 mm/filemap.c:2442
 filemap_read+0x2ca/0xe40 mm/filemap.c:2525
 generic_file_read_iter+0x397/0x4f0 mm/filemap.c:2676
 __kernel_read+0x58d/0xa90 fs/read_write.c:454
 kernel_read+0x52/0x70 fs/read_write.c:472
 prepare_binprm fs/exec.c:1650 [inline]
 search_binary_handler fs/exec.c:1704 [inline]
 exec_binprm fs/exec.c:1761 [inline]
 bprm_execve fs/exec.c:1830 [inline]
 bprm_execve+0x740/0x19a0 fs/exec.c:1792
 do_execveat_common+0x626/0x7c0 fs/exec.c:1919
 do_execveat fs/exec.c:1998 [inline]
 __do_sys_execveat fs/exec.c:2074 [inline]
 __se_sys_execveat fs/exec.c:2066 [inline]
 __x64_sys_execveat+0xed/0x130 fs/exec.c:2066
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x443c09
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd2359618 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 0000000000443c09
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000005
RBP: 00000000004034a0 R08: 0000000000000000 R09: 00000000004004a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000403530
R13: 0000000000000000 R14: 00000000004b1018 R15: 00000000004004a0
Modules linked in:
---[ end trace eb837301c73b908d ]---
RIP: 0010:fill_meta_index fs/squashfs/file.c:243 [inline]
RIP: 0010:read_blocklist fs/squashfs/file.c:332 [inline]
RIP: 0010:squashfs_readpage+0xa0d/0x2210 fs/squashfs/file.c:469
Code: 3c 24 31 d2 48 63 8c 24 b4 00 00 00 49 8b 47 c8 48 89 cf 48 c1 e1 0b c1 e7 0b 89 7c 24 4c 31 ff 48 89 44 24 60 48 63 44 24 70 <48> f7 f1 49 89 c6 89 c6 48 89 44 24 58 89 44 24 1c 89 44 24 48 e8
RSP: 0018:ffffc9000188f3e8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000099 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8221fc4d RDI: 0000000000000000
RBP: 000000000000000c R08: ffffffffffffffff R09: 000000000000000c
R10: ffffffff8221fc3e R11: 000000000000003f R12: 00000000000000de
R13: ffff888033290088 R14: 0000000000000000 R15: ffff888033290038
FS:  00000000024ae300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2f175e5030 CR3: 0000000014fc9000 CR4: 0000000000350ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

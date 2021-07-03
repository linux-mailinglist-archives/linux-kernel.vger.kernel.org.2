Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD643BA945
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 17:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhGCPnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 11:43:50 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:56262 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhGCPnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 11:43:49 -0400
Received: by mail-il1-f197.google.com with SMTP id a15-20020a927f0f0000b02901ac2bdd733dso7816088ild.22
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jul 2021 08:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3Z+Kj9SdMBIQZbde3uiQ8uklH5LSV9rygtlZF17JwcQ=;
        b=KZnxDgzKiHQ3HwnCmuMG7xHe1+UvNnztnyqxNyCTMPEJaxEibKI1DMu3CqiSvGtI2q
         VfvpHc7RXF4g5Qeaky0jZ6IULiaUF4yGAyP5ZdyeQQxlujQ6H9EI0/7GbrlfNIXh/gLM
         324ma2btKljbwFd6iGnunkD+PeugBiiHatSltvWySdDzhaNK7iG6960cjVYvFTQiKoWa
         3vd4un+iesKqCg7Q3Newtm1KZbNRXZkquHg7UQOQeulaBg4FAA9r0F/zznz99iWjOs8b
         1j+rUxGFvYd1kFGYcLh63GofPc89yKoPSR1A28s3XKtcrSYi3u+i/yP+xu1DV07ADKfX
         NbBg==
X-Gm-Message-State: AOAM533W2XyjDRPQdxvYGlx2hkPqHwgOZkHDRae+P7Qg5Q7N8+aaB82z
        hYoJrAj6i8ugUwBoc88VGIyVB6qrs9wp7A0LUGFyDd40kwdb
X-Google-Smtp-Source: ABdhPJyr8SWpra/WRTEhwVMNsFsdmL2ZrzlATgZjYKjGFhBG96Iy09VU3vUynrav+CZf0Kt5M4oty+27Saa/FU6mgE5Ifrw4nK7+
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2144:: with SMTP id d4mr3975093ilv.136.1625326875355;
 Sat, 03 Jul 2021 08:41:15 -0700 (PDT)
Date:   Sat, 03 Jul 2021 08:41:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cafda05c639e751@google.com>
Subject: [syzbot] general protection fault in try_grab_compound_head
From:   syzbot <syzbot+a3fcd59df1b372066f5a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16758ac4300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
dashboard link: https://syzkaller.appspot.com/bug?extid=a3fcd59df1b372066f5a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a856c4300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1582c9d8300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3fcd59df1b372066f5a@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 8484 Comm: syz-executor116 Tainted: G        W         5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:page_zonenum include/linux/mm.h:1121 [inline]
RIP: 0010:is_zone_movable_page include/linux/mm.h:1140 [inline]
RIP: 0010:is_pinnable_page include/linux/mm.h:1556 [inline]
RIP: 0010:try_grab_compound_head mm/gup.c:126 [inline]
RIP: 0010:try_grab_compound_head+0x686/0x8f0 mm/gup.c:113
Code: e9 16 fe ff ff e8 0a fe cc ff 0f 0b 45 31 e4 e9 07 fe ff ff e8 fb fd cc ff 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 44 02 00 00 48 8b 2b bf 03 00 00 00 49 bc 00 00
RSP: 0018:ffffc900017df7e8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81a88c35 RDI: 0000000000000003
RBP: 0000000000010000 R08: 0000000000000000 R09: 0000000000000003
R10: ffffffff81a8862b R11: 000000000000003f R12: 0000000000040000
R13: ffff88803ac03ff8 R14: 0000000000000000 R15: dffffc0000000000
FS:  00000000005a5300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000084 CR3: 0000000021f85000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 follow_hugetlb_page+0x7bf/0x12c0 mm/hugetlb.c:5248
 __get_user_pages+0x5d8/0x1490 mm/gup.c:1137
 __get_user_pages_locked mm/gup.c:1352 [inline]
 __gup_longterm_locked+0x216/0xfa0 mm/gup.c:1745
 pin_user_pages+0x84/0xc0 mm/gup.c:2900
 io_sqe_buffer_register+0x24e/0x1350 fs/io_uring.c:8381
 io_sqe_buffers_register+0x29c/0x620 fs/io_uring.c:8508
 __io_uring_register fs/io_uring.c:10129 [inline]
 __do_sys_io_uring_register+0x1049/0x2880 fs/io_uring.c:10254
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43ef49
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffea3542188 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000043ef49
RDX: 00000000200001c0 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000402f30 R08: 0000000010000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000402fc0
R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488
Modules linked in:
---[ end trace e3fc885187db8a03 ]---
RIP: 0010:page_zonenum include/linux/mm.h:1121 [inline]
RIP: 0010:is_zone_movable_page include/linux/mm.h:1140 [inline]
RIP: 0010:is_pinnable_page include/linux/mm.h:1556 [inline]
RIP: 0010:try_grab_compound_head mm/gup.c:126 [inline]
RIP: 0010:try_grab_compound_head+0x686/0x8f0 mm/gup.c:113
Code: e9 16 fe ff ff e8 0a fe cc ff 0f 0b 45 31 e4 e9 07 fe ff ff e8 fb fd cc ff 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 44 02 00 00 48 8b 2b bf 03 00 00 00 49 bc 00 00
RSP: 0018:ffffc900017df7e8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81a88c35 RDI: 0000000000000003
RBP: 0000000000010000 R08: 0000000000000000 R09: 0000000000000003
R10: ffffffff81a8862b R11: 000000000000003f R12: 0000000000040000
R13: ffff88803ac03ff8 R14: 0000000000000000 R15: dffffc0000000000
FS:  00000000005a5300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000084 CR3: 0000000021f85000 CR4: 00000000001506f0
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

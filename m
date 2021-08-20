Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E963E3F31B6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhHTQs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 12:48:59 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42923 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhHTQsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:48:55 -0400
Received: by mail-il1-f199.google.com with SMTP id z14-20020a92d18e0000b029022418b34bc9so5736162ilz.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 09:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=53tNogvSRqGJfOiOdqD6lM2tBtj1RvkYDkpUz8ReIzw=;
        b=PPoXEGq7VOyhSFRFOT+sul1RWHiBiiXilPlNK5knPbyMTB3FtD8VJxnMwt0aUaRC0S
         g91jhBEPK1Qk1OfqhhaLPUJY+bSnUkHt0TlAwCfzzLEWDhpSo6+40lnXbqAGhEnAkxhU
         0Hbo+hWX0oal9KUPvP6wJyfTGxuCTK4pL1SsyyvU7+bdes2r8COXChods7ruRMFB5Tbg
         t380WQeMvE1l6ysRoSSkFb3jjH9y0y58qwqmTzvR7we4tSVivumpPcb/JdMXCwRg4Brs
         CRDr70hIYXDN5qi20d6egbLUOjYAZbhy/6K+oJH1Ne5d/hTcd95l4/J95EwYmyH+Mnwt
         A8SA==
X-Gm-Message-State: AOAM532rsN/LC1NqkSle+YbbWjJijPTQywOHWsoHeZ+EdBwUatYU/mKd
        Kn8pihUJR5XPfILu6h1bbEIlKFx6+LcP3ZTlh9VBm/s0WBWh
X-Google-Smtp-Source: ABdhPJx9bjWJRdADnmgbnpo0NKVWqI0fN6krvG3kTXRH5vNZYMYWMFd3vxa+EcrAxRMYx4n5EyA8/YNqkwvgxSm75kpQOoO0zN8b
MIME-Version: 1.0
X-Received: by 2002:a5d:8941:: with SMTP id b1mr16721739iot.45.1629478097800;
 Fri, 20 Aug 2021 09:48:17 -0700 (PDT)
Date:   Fri, 20 Aug 2021 09:48:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030563005ca006ffd@google.com>
Subject: [syzbot] WARNING in split_huge_page_to_list
From:   syzbot <syzbot+0c65e03871b364e714a3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f87d64319e6f Merge tag 'net-5.14-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1205bd55300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3205625db2f96ac9
dashboard link: https://syzkaller.appspot.com/bug?extid=0c65e03871b364e714a3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c65e03871b364e714a3@syzkaller.appspotmail.com

 __do_munmap+0x627/0x11c0 mm/mmap.c:2911
 do_munmap mm/mmap.c:2922 [inline]
 munmap_vma_range mm/mmap.c:604 [inline]
 mmap_region+0x85a/0x1760 mm/mmap.c:1753
 do_mmap+0x86e/0x1180 mm/mmap.c:1584
 vm_mmap_pgoff+0x1b7/0x290 mm/util.c:519
 ksys_mmap_pgoff+0x4a8/0x620 mm/mmap.c:1635
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2144 at mm/huge_memory.c:2327 unmap_page mm/huge_memory.c:2327 [inline]
WARNING: CPU: 0 PID: 2144 at mm/huge_memory.c:2327 split_huge_page_to_list+0x25eb/0x3e60 mm/huge_memory.c:2700
Modules linked in:
CPU: 0 PID: 2144 Comm: kswapd1 Not tainted 5.14.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:unmap_page mm/huge_memory.c:2327 [inline]
RIP: 0010:split_huge_page_to_list+0x25eb/0x3e60 mm/huge_memory.c:2700
Code: 89 de e8 28 e1 b6 ff 84 db 0f 85 54 e0 ff ff e8 6b d9 b6 ff 48 c7 c6 e0 d8 97 89 48 89 ef e8 9c 72 e9 ff c6 05 05 dd 99 0b 01 <0f> 0b e9 32 e0 ff ff bb 02 00 00 00 e9 64 ef ff ff e8 3f d9 b6 ff
RSP: 0018:ffffc900084f76d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801c44c000 RSI: ffffffff81be0514 RDI: 0000000000000003
RBP: ffffea00021c0000 R08: 0000000000000029 R09: 00000000ffffffff
R10: ffffffff88ea7679 R11: 00000000ffffffff R12: ffff88814018d2d8
R13: ffffea00021c0008 R14: ffffea00021c0000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f14895d5000 CR3: 0000000017350000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 split_huge_page include/linux/huge_mm.h:192 [inline]
 deferred_split_scan+0x5fa/0xbd0 mm/huge_memory.c:2860
 do_shrink_slab+0x42d/0xbd0 mm/vmscan.c:709
 shrink_slab+0x17c/0x6e0 mm/vmscan.c:869
 shrink_node_memcgs mm/vmscan.c:2868 [inline]
 shrink_node+0x8d1/0x1df0 mm/vmscan.c:2983
 kswapd_shrink_node mm/vmscan.c:3726 [inline]
 balance_pgdat+0x7ce/0x13b0 mm/vmscan.c:3917
 kswapd+0x5b6/0xdb0 mm/vmscan.c:4176
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

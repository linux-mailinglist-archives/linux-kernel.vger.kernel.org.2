Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0367A3E5C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbhHJNrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:47:52 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:37765 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241864AbhHJNrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:47:51 -0400
Received: by mail-il1-f197.google.com with SMTP id a2-20020a9266020000b0290222005f354cso7520921ilc.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 06:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Zw4D3Im4sGhoulQeX35uu1L8d+IQkJsucdWy6ITLtnA=;
        b=gqPy/a8rD8y3FHj+StEH1DTRndP6PVEVkCH0cp+Y9QFnjIdzPMNC+aOONcnY2AvVX3
         OU114qiH92Pw5V4jqlcW7KvWRNGxY+YFsSDBxKW5DcY/F9oo6btQfchqd66dW2St+sQs
         PZiLx4bs7eF1peYTY0drOfZuFC5xbTmOwZxcHJktWTHTh53YR/0ycueoyIQbe52mEAxX
         PJ2jHKqnO4npKa48dGAOIfVOXfU596CwwdIUo9eCPDLiavRSgaySxh1hTqnRhev2cWQt
         ikVGopwVxsS9PE++sN3KN3/17sBrKkEF574csydESa1ibPZdq01Kvmtjiiws7VvjyX5/
         YSuA==
X-Gm-Message-State: AOAM531IC4+8G6bImcqTBeUJaTHFUohsX9RdHVNH3I5PmxjBpXYokoQ/
        yfSBeshd9rebVjcVp8X/7Ergk7/Nwv2zAOEDw+6URK8L1fAW
X-Google-Smtp-Source: ABdhPJz0QGVh61e4edujPsYzUazD2eigv6GFaVwU6Fm8bciFF4+RzQ26PCyPdL9yQe481iNV3s3YYLhyxv1nhVBmdXsAgrdX/wkU
MIME-Version: 1.0
X-Received: by 2002:a92:b312:: with SMTP id p18mr510717ilh.233.1628603249210;
 Tue, 10 Aug 2021 06:47:29 -0700 (PDT)
Date:   Tue, 10 Aug 2021 06:47:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000263db905c934be32@google.com>
Subject: [syzbot] general protection fault in udmabuf_create
From:   syzbot <syzbot+e9cd3122a37c5d6c51e8@syzkaller.appspotmail.com>
To:     christian.koenig@amd.com, dongwon.kim@intel.com,
        dri-devel@lists.freedesktop.org, kraxel@redhat.com,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, sumit.semwal@linaro.org,
        syzkaller-bugs@googlegroups.com, vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7999516e20bd Add linux-next specific files for 20210806
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10f15f8e300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f518e910b029c31
dashboard link: https://syzkaller.appspot.com/bug?extid=e9cd3122a37c5d6c51e8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1181099a300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b6fce9300000

The issue was bisected to:

commit 16c243e99d335e1ef3059871897119affc98b493
Author: Vivek Kasireddy <vivek.kasireddy@intel.com>
Date:   Wed Jun 9 18:29:15 2021 +0000

    udmabuf: Add support for mapping hugepages (v4)

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f73dc9300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11f73dc9300000
console output: https://syzkaller.appspot.com/x/log.txt?x=16f73dc9300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9cd3122a37c5d6c51e8@syzkaller.appspotmail.com
Fixes: 16c243e99d33 ("udmabuf: Add support for mapping hugepages (v4)")

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 6603 Comm: syz-executor127 Not tainted 5.14.0-rc4-next-20210806-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:_compound_head include/linux/page-flags.h:187 [inline]
RIP: 0010:get_page include/linux/mm.h:1203 [inline]
RIP: 0010:udmabuf_create+0x664/0x16f0 drivers/dma-buf/udmabuf.c:236
Code: 03 48 89 84 24 90 00 00 00 e9 38 01 00 00 e8 23 7a f7 fc 4d 89 f4 49 c1 e4 06 4c 03 24 24 49 8d 7c 24 08 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 0f 85 d3 0d 00 00 4d 8b 6c 24 08 31 ff 4c 89 eb 83
RSP: 0018:ffffc90002d7fc70 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888023f69c80 RSI: ffffffff847e4f3d RDI: 0000000000000008
RBP: 0000000000000000 R08: fffffffffffff000 R09: 0000000000000000
R10: ffffffff847e50f5 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000935300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000020c CR3: 0000000018d16000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 udmabuf_ioctl_create drivers/dma-buf/udmabuf.c:305 [inline]
 udmabuf_ioctl+0x152/0x2c0 drivers/dma-buf/udmabuf.c:336
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43eed9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff10c6b558 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043eed9
RDX: 0000000020000180 RSI: 0000000040187542 RDI: 0000000000000003
RBP: 0000000000402ec0 R08: 0000000000400488 R09: 0000000000400488
R10: 0000000000400488 R11: 0000000000000246 R12: 0000000000402f50
R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488
Modules linked in:
---[ end trace e38355abd6102561 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:187 [inline]
RIP: 0010:get_page include/linux/mm.h:1203 [inline]
RIP: 0010:udmabuf_create+0x664/0x16f0 drivers/dma-buf/udmabuf.c:236
Code: 03 48 89 84 24 90 00 00 00 e9 38 01 00 00 e8 23 7a f7 fc 4d 89 f4 49 c1 e4 06 4c 03 24 24 49 8d 7c 24 08 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 0f 85 d3 0d 00 00 4d 8b 6c 24 08 31 ff 4c 89 eb 83
RSP: 0018:ffffc90002d7fc70 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888023f69c80 RSI: ffffffff847e4f3d RDI: 0000000000000008
RBP: 0000000000000000 R08: fffffffffffff000 R09: 0000000000000000
R10: ffffffff847e50f5 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000935300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff86ca0778 CR3: 0000000018d16000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

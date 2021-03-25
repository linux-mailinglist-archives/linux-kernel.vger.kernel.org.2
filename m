Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19601348C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCYJK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:10:56 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:53122 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhCYJKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:10:19 -0400
Received: by mail-io1-f69.google.com with SMTP id v5so3229925ioq.19
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gtEyF9gyo74WALZnume6M2OCrV7EyWoD5V6eC8Sn638=;
        b=t8JQvQRQdNDJorIxYEL8q9Yodyma26ABrRXWXWCepktyJjVoqX8BzsTXS+GWGk0atZ
         oWU/ZZsmngDXm3/a+v7DFamCtvdrX+Jja3iy2u1pzcBD/iKSQCf7X6O//X3oo3b0TfN4
         MYxWeWbcfYpuTRri5H6HxzhhgzdMOeixkRGzIMsYk3/pkqovrLurKAnXvYsWVPVtODGf
         +xy55A94sTqbZCtNp0g7mq1uzXD+/eF1OhLd0TPwsH2ose602Fc9pv03mMk5e9syZLqq
         eqvNLcCT8ikrpFtIh6ozMaye1HEIiq+5FMFrF9XUnoYo8tOcrhS3hkikBQrxVpCtGfLD
         cAbw==
X-Gm-Message-State: AOAM533uzBVAYfUJJPRVkynsMHIatpqX9URR/1EU5tRGC40zPbZ06Acm
        dJqEQ4INVvpsC0fatJUGDh0B1dEd95sFoIWlz/cIP+lctgMg
X-Google-Smtp-Source: ABdhPJyjmY8VWn2i4p2YiY5Skcb6zPy6H54VKwNmTXDVSKBuLtjrJTlGKB9Jy+67op1pOjRGctX1tnMAiLITeA15mjsJqmR/ZyUf
MIME-Version: 1.0
X-Received: by 2002:a6b:f00a:: with SMTP id w10mr5773216ioc.2.1616663418824;
 Thu, 25 Mar 2021 02:10:18 -0700 (PDT)
Date:   Thu, 25 Mar 2021 02:10:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ccf0e005be58c811@google.com>
Subject: [syzbot] WARNING in get_page_from_freelist
From:   syzbot <syzbot+ae79dc7907428bdb3fc9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a5406a7f riscv: Correct SPARSEMEM configuration
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=154738bed00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8436efa4b70702e6
dashboard link: https://syzkaller.appspot.com/bug?extid=ae79dc7907428bdb3fc9
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae79dc7907428bdb3fc9@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3271 at mm/page_alloc.c:3488 rmqueue mm/page_alloc.c:3488 [inline]
WARNING: CPU: 0 PID: 3271 at mm/page_alloc.c:3488 get_page_from_freelist+0x286/0x1782 mm/page_alloc.c:3943
Modules linked in:
CPU: 0 PID: 3271 Comm: syz-executor.1 Not tainted 5.12.0-rc2-syzkaller-00474-ga5406a7ff56e #0
Hardware name: riscv-virtio,qemu (DT)
epc : rmqueue mm/page_alloc.c:3488 [inline]
epc : get_page_from_freelist+0x286/0x1782 mm/page_alloc.c:3943
 ra : get_page_from_freelist+0x11a8/0x1782 mm/page_alloc.c:3943
epc : ffffffe00036abee ra : ffffffe00036bb10 sp : ffffffe01fd57480
 gp : ffffffe004588910 tp : ffffffe01fa95f00 t0 : ffffffc403acde00
 t1 : 0000000000000001 t2 : 0000003fffad1d06 s0 : ffffffe01fd57670
 s1 : 0000000000000000 a0 : ffffffe01fd57688 a1 : 0000000000000003
 a2 : 1ffffffc03faaed1 a3 : ffffffe00036bb10 a4 : 0000000000000003
 a5 : 0000000000000001 a6 : 0000000000000008 a7 : 781560e8875b1000
 s2 : ffffffe07fdf5d00 s3 : 0000000000000001 s4 : ffffffe07fdf5758
 s5 : 0000000000047df2 s6 : 0000000000000000 s7 : ffffffe07fdf5740
 s8 : ffffffe07fdf5740 s9 : ffffffe01fd57670 s10: 0000000000000001
 s11: ffffffe07fdf5740 t3 : 781560e8875b1000 t4 : ffffffc40133fbf0
 t5 : ffffffc40133fbf1 t6 : ffffffe01fd57af5
status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
Call Trace:
[<ffffffe00036abee>] rmqueue mm/page_alloc.c:3488 [inline]
[<ffffffe00036abee>] get_page_from_freelist+0x286/0x1782 mm/page_alloc.c:3943
[<ffffffe00036d996>] __alloc_pages_nodemask+0x19a/0x480 mm/page_alloc.c:4996
[<ffffffe00039fd8e>] alloc_pages_current+0x114/0x234 mm/mempolicy.c:2277
[<ffffffe0003b092e>] alloc_pages include/linux/gfp.h:561 [inline]
[<ffffffe0003b092e>] alloc_slab_page mm/slub.c:1638 [inline]
[<ffffffe0003b092e>] allocate_slab+0x282/0x406 mm/slub.c:1778
[<ffffffe0003b4638>] new_slab mm/slub.c:1841 [inline]
[<ffffffe0003b4638>] new_slab_objects mm/slub.c:2587 [inline]
[<ffffffe0003b4638>] ___slab_alloc+0x2fc/0x4d8 mm/slub.c:2750
[<ffffffe0003b4b72>] __slab_alloc.constprop.0+0xa4/0xce mm/slub.c:2790
[<ffffffe0003b627e>] slab_alloc_node mm/slub.c:2871 [inline]
[<ffffffe0003b627e>] slab_alloc mm/slub.c:2915 [inline]
[<ffffffe0003b627e>] kmem_cache_alloc_trace+0x29a/0x2bc mm/slub.c:2932
[<ffffffe00079bb14>] kmalloc include/linux/slab.h:554 [inline]
[<ffffffe00079bb14>] tomoyo_print_header security/tomoyo/audit.c:156 [inline]
[<ffffffe00079bb14>] tomoyo_init_log+0xb4/0x1402 security/tomoyo/audit.c:255
[<ffffffe0007a4648>] tomoyo_supervisor+0x1b0/0xaaa security/tomoyo/common.c:2097
[<ffffffe0007ae608>] tomoyo_audit_path_number_log security/tomoyo/file.c:235 [inline]
[<ffffffe0007ae608>] tomoyo_path_number_perm+0x2ae/0x33c security/tomoyo/file.c:734
[<ffffffe0007b630a>] tomoyo_file_ioctl+0x28/0x34 security/tomoyo/tomoyo.c:329
[<ffffffe000790950>] security_file_ioctl+0x48/0x90 security/security.c:1495
[<ffffffe00041f2a8>] __do_sys_ioctl fs/ioctl.c:747 [inline]
[<ffffffe00041f2a8>] sys_ioctl+0x76/0xd56 fs/ioctl.c:739
[<ffffffe000005572>] ret_from_syscall+0x0/0x2


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

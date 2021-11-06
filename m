Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12D3446CEE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 08:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhKFHvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 03:51:07 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:34654 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhKFHvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 03:51:04 -0400
Received: by mail-il1-f197.google.com with SMTP id d3-20020a056e02050300b0027578c6d9aaso205235ils.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 00:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oP5cRQOPI+/xIs7PBFAffDqIDfQtcdvc+FI5GhoActE=;
        b=1gQSUqhMk0HdbhgvNa2QFmDNsUC+Un3vUy6I+0dt+3LdfzC/yVqro4I/XQTPR03F3Y
         DTP7zPAF3WClqEMHnnTR53df5xeKLIwbXahCus9UfEW8CfYlu3bUIBhGKFRo0lEKfkVk
         FSExioYhqzcWIk9XhGWjJbxcb0cUb2NrRtTu7kQTkFb/ACDSsWZpcVaxN51MScAAP/Mx
         qkhiDTxwj5FSIsUuQLakeCmFKId1dy3e0PuviJhJegeY/Lc0zPHqt/YcQ7jFWk+WJw7+
         7bMIGjXHjNh+ejtD4syBw7pviRBa/zRC2sSV/ptJw7tKkTIM9931Q6zAHbGUepTKjvLZ
         TX1w==
X-Gm-Message-State: AOAM531E+X9mJKPZVuDMlEZ51WEC+Q3XEXaLVMdeyVhd3MENuo4ZRNeA
        ZJvuqnost9RY1J7i/AROyQ2gBcRBnmQgY5Bje7kOsyR5qZV8
X-Google-Smtp-Source: ABdhPJylrY9XsExJLCxymLRH9d2h1+9A8blaWbJTnOik+nkPLR8JFW4dx/wIIi+2YhXhcZBV2EAQwERzv/I8RPfkLM3VptF3n7Cg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219a:: with SMTP id j26mr36682087ila.287.1636184903236;
 Sat, 06 Nov 2021 00:48:23 -0700 (PDT)
Date:   Sat, 06 Nov 2021 00:48:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1c1fa05d019fb10@google.com>
Subject: [syzbot] kernel BUG in trans_pgd_create_copy
From:   syzbot <syzbot+a0d68c9c9123000ed5ab@syzkaller.appspotmail.com>
To:     catalin.marinas@arm.com, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d4439a1189f9 Merge tag 'hsi-for-5.16' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b5f782b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8eccc5e89b1d525c
dashboard link: https://syzkaller.appspot.com/bug?extid=a0d68c9c9123000ed5ab
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a0d68c9c9123000ed5ab@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/arm64/include/asm/pgalloc.h:79!
Internal error: Oops - BUG: 0 [#1] SMP
Modules linked in:
CPU: 0 PID: 12093 Comm: syz-executor.1 Not tainted 5.15.0-syzkaller-10158-gd4439a1189f9 #0
Hardware name: linux,dummy-virt (DT)
pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : pmd_populate_kernel arch/arm64/include/asm/pgalloc.h:79 [inline]
pc : copy_pte arch/arm64/mm/trans_pgd.c:70 [inline]
pc : copy_pmd arch/arm64/mm/trans_pgd.c:105 [inline]
pc : copy_pud arch/arm64/mm/trans_pgd.c:141 [inline]
pc : copy_p4d arch/arm64/mm/trans_pgd.c:167 [inline]
pc : copy_page_tables arch/arm64/mm/trans_pgd.c:186 [inline]
pc : trans_pgd_create_copy+0x5bc/0x7f0 arch/arm64/mm/trans_pgd.c:213
lr : trans_alloc arch/arm64/mm/trans_pgd.c:30 [inline]
lr : copy_pte arch/arm64/mm/trans_pgd.c:67 [inline]
lr : copy_pmd arch/arm64/mm/trans_pgd.c:105 [inline]
lr : copy_pud arch/arm64/mm/trans_pgd.c:141 [inline]
lr : copy_p4d arch/arm64/mm/trans_pgd.c:167 [inline]
lr : copy_page_tables arch/arm64/mm/trans_pgd.c:186 [inline]
lr : trans_pgd_create_copy+0x480/0x7f0 arch/arm64/mm/trans_pgd.c:213
sp : ffff80001b977a60
x29: ffff80001b977a60 x28: 1fffe0000ffff000 x27: ffff800010059c90
x26: ffff00003fffffff x25: ffff000032476000 x24: dfff800000000000
x23: ffff000000200000 x22: ffff80001b977c30 x21: ffff000040000000
x20: ffff00007fff8000 x19: ffff000000000000 x18: fffffbffeff9c3c8
x17: 0000000000000000 x16: 0000000000000000 x15: d503201fd503201f
x14: 1ffff0000372ee30 x13: 0000000000000000 x12: ffff60000648f000
x11: 1fffe0000648efff x10: ffff60000648efff x9 : 0000000000000000
x8 : ffff000032478000 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000004
x2 : fffffc0000000000 x1 : ffff800015f1e560 x0 : ffff000032477000
Call trace:
 set_p4d arch/arm64/include/asm/pgtable.h:695 [inline]
 __p4d_populate arch/arm64/include/asm/pgalloc.h:46 [inline]
 p4d_populate arch/arm64/include/asm/pgalloc.h:54 [inline]
 copy_pud arch/arm64/mm/trans_pgd.c:129 [inline]
 copy_p4d arch/arm64/mm/trans_pgd.c:167 [inline]
 copy_page_tables arch/arm64/mm/trans_pgd.c:186 [inline]
 trans_pgd_create_copy+0x5bc/0x7f0 arch/arm64/mm/trans_pgd.c:213
 machine_kexec_post_load+0x178/0x6d0 arch/arm64/kernel/machine_kexec.c:146
 do_kexec_load+0x194/0x520 kernel/kexec.c:155
 __do_compat_sys_kexec_load kernel/kexec.c:292 [inline]
 __se_compat_sys_kexec_load kernel/kexec.c:257 [inline]
 __arm64_compat_sys_kexec_load+0x36c/0x47c kernel/kexec.c:257
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x6c/0x260 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0xc4/0x254 arch/arm64/kernel/syscall.c:142
 do_el0_svc_compat+0x40/0x80 arch/arm64/kernel/syscall.c:187
 el0_svc_compat+0x64/0x280 arch/arm64/kernel/entry-common.c:736
 el0t_32_sync_handler+0x90/0x140 arch/arm64/kernel/entry-common.c:746
 el0t_32_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:577
Code: 17fffee0 aa1503e0 97ffdd37 17ffff17 (d4210000) 
---[ end trace a6c0112af29130b0 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5833A33865C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhCLHHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:07:30 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:49643 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhCLHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:07:17 -0500
Received: by mail-io1-f69.google.com with SMTP id d4so17110675ioc.16
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 23:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XSBNYQtXAGGHqnQSJMwpMHjh//Ek2Z5zsatXDPCWRFw=;
        b=nrsGLlU9ir4CFUdtqSObsQUmk3IB5w/1akyJWOa2QRpu7y67mny88ZKsJABnQUhLpi
         bbvRsVXQDwxHNHLZiCMdxNI4CV35ZhRy5ODDROovCS2V8UWMIjUlHPNSPVaEjI1QNXjn
         tiHXRSFZZYmwH7Fq86b1fnxF9UnuFsMjhnwi4jkKpXhf0KXcBOuzxSbdLzdjNuTJTn/J
         JTWajUkrsxFAgGh0OYip3XxQvKt/6b/OZzpU68rDEwnsxn20PVwkb+EfY7nxPz45DWE9
         oGlMuWmLGIQFPYG9E3XN+RjFtcuLOwEWt7wbNiPSdp5Opj0V4qH+ubSO1FyniuoE/gDR
         wZiw==
X-Gm-Message-State: AOAM532E1OiWtFhOU85C5G06e/pYTLqev5HSWv0b/GZt2DYrIkUAqvPt
        b8k4NlodVVINr1veo8i+lD0zwSyefk0lDDsihEEk6v1zPbU3
X-Google-Smtp-Source: ABdhPJzCRY+65B/yzxcHQM1nwJAS+UXW5zp7vBkuVS9gidqsTmeK4kFhpDsmwkp0fx/5yJOcntUHDbGKsU5QiIQIboxftN/s30Eo
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2156:: with SMTP id y22mr9348968ioy.10.1615532836778;
 Thu, 11 Mar 2021 23:07:16 -0800 (PST)
Date:   Thu, 11 Mar 2021 23:07:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbf8ee05bd518c23@google.com>
Subject: [syzbot] WARNING in huge_pmd_set_accessed
From:   syzbot <syzbot+edb1179c837e79cc2fc3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    05a59d79 Merge git://git.kernel.org:/pub/scm/linux/kernel/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b8820ad00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=750735fdbc630971
dashboard link: https://syzkaller.appspot.com/bug?extid=edb1179c837e79cc2fc3

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+edb1179c837e79cc2fc3@syzkaller.appspotmail.com

------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 8400 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 1 PID: 8400 Comm: syz-fuzzer Not tainted 5.12.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
Code: be ff cc cc cc cc cc cc cc cc cc cc cc 80 3d 11 d1 ad 04 00 74 01 c3 48 c7 c7 20 79 6b 89 c6 05 00 d1 ad 04 01 e8 75 5b be ff <0f> 0b c3 48 39 77 10 0f 84 97 00 00 00 66 f7 47 22 f0 ff 74 4b 48
RSP: 0000:ffffc90001737ac8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88801992a840 RCX: 0000000000000000
RDX: ffff8880223d0200 RSI: ffffffff815b4435 RDI: fffff520002e6f4b
RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815ad19e R11: 0000000000000000 R12: 0000000000000003
R13: ffffed1003325508 R14: 0000000000000001 R15: ffff8880b9d36000
FS:  000000c00002e890(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Call Trace:
 pv_wait arch/x86/include/asm/paravirt.h:564 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x8b8/0xb40 kernel/locking/qspinlock.c:508
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:554 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:85 [inline]
 do_raw_spin_lock+0x200/0x2b0 kernel/locking/spinlock_debug.c:113
 spin_lock include/linux/spinlock.h:354 [inline]
 pmd_lock include/linux/mm.h:2264 [inline]
 huge_pmd_set_accessed+0x103/0x320 mm/huge_memory.c:1265
 handle_mm_fault+0x1bc/0x7e0 mm/memory.c:4549
 handle_page_fault arch/x86/mm/fault.c:1475 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1531
RIP: 0033:0x59072c
Code: 48 8d 05 97 25 3e 00 48 89 44 24 08 e8 6d 54 ea ff 90 e8 07 a1 ed ff eb a5 cc cc cc cc cc 8b 44 24 10 48 8b 4c 24 08 89 41 24 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 48 8b
RSP: 002b:000000c0002e97b0 EFLAGS: 00010286
RAX: 0000000000004ef5 RBX: 0000000000004ef5 RCX: 0000000000d85fe0
RBP: 000000c0002e9890 R08: 0000000000004ef4 R09: 000000000059c5a0
R13: 00aaaaaaaaaaaaaa R14: 000000000093f064 R15: 0000000000000038


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EFD3E10C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbhHEJGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:06:35 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:57077 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbhHEJGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:06:33 -0400
Received: by mail-io1-f71.google.com with SMTP id k24-20020a6bef180000b02904a03acf5d82so3227887ioh.23
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 02:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=okfVz5rOJTn8JyZwzkVWRF2WK3bOiCNnYJnpD0UJgYE=;
        b=hByXppz2FNQ5lQQNsXlFQoW3y2eUjQnolYazwHavcMoK84bTE84Br/61D8/c76PPtX
         rPyD6O2O5jUNyEBxeneK7eGqsWmpgZT4wOv2mMQTh71uNKL8VNWVA7gMtqQhOl0FvSyf
         kflIvIT3r+IeLVmXQJAI37sjgfCUjdmudomGZkObwBL2ai6uDXdg8RBQMaM6wH0wO+Up
         89Sf9c7lcvIiMr9EAgXWvZglUq6+wt+WpR+0ln7Sr1xenJea+6DnvL5AVXplvtyADmSh
         H8ysUlPPH2+rb0I0C8VZpgu7jLlTCkV3My29mOjvuVbCGsZxvnuCZYt/NcRek+UwYMN3
         SfCA==
X-Gm-Message-State: AOAM53303wtUs/dY2vFl9oT3UBO3o+oYIHWAD3u+2ruB4e07Gnujndon
        kSUA6pRdtqNHxA5TPbr/LwAPkevH2gE9DpZzW6woLqaSZd/W
X-Google-Smtp-Source: ABdhPJz/xYy7f5gCCeVtPwASuDtysG8/j7H1Kina+RTC9hnmCocEAZ5KAXnGqhkXnJm5yBlDbpBD4Mop/1wxyDJCRzAOvJUHllXv
MIME-Version: 1.0
X-Received: by 2002:a6b:ea18:: with SMTP id m24mr411616ioc.76.1628154379209;
 Thu, 05 Aug 2021 02:06:19 -0700 (PDT)
Date:   Thu, 05 Aug 2021 02:06:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069924b05c8cc3b84@google.com>
Subject: [syzbot] WARNING in trc_read_check_handler
From:   syzbot <syzbot+fe9d8c955bd1d0f02dc1@syzkaller.appspotmail.com>
To:     jgross@suse.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        namit@vmware.com, paulmck@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8d4b477da1a8 Add linux-next specific files for 20210730
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12774fda300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4adf4987f875c210
dashboard link: https://syzkaller.appspot.com/bug?extid=fe9d8c955bd1d0f02dc1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10acec72300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12aeb472300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe9d8c955bd1d0f02dc1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 14 at kernel/rcu/tasks.h:901 trc_read_check_handler+0x248/0x2e0 kernel/rcu/tasks.h:920
Modules linked in:
CPU: 0 PID: 14 Comm: rcu_preempt Not tainted 5.14.0-rc3-next-20210730-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:trc_read_check_handler+0x248/0x2e0 kernel/rcu/tasks.h:901
Code: 48 c1 ea 03 0f b6 04 02 4c 89 e2 83 e2 07 38 d0 7f 0c 84 c0 74 08 4c 89 e7 e8 b4 6f 5a 00 c6 83 19 04 00 00 01 e9 5a fe ff ff <0f> 0b 31 c9 ba 01 00 00 00 be 03 00 00 00 48 c7 c7 e0 dd 97 8b e8
RSP: 0018:ffffc90000007f78 EFLAGS: 00010047
RAX: 0000000000000001 RBX: ffff888011ac9c80 RCX: ffffffff8160ce50
RDX: fffffbfff2045b5c RSI: 0000000000000004 RDI: ffffffff9022dae0
RBP: ffff888011ac9c80 R08: 0000000000000001 R09: 0000000000000003
R10: fffffbfff2045b5c R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8880b9d32a08
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff7ce84138 CR3: 0000000070a24000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 flush_smp_call_function_queue+0x34b/0x640 kernel/smp.c:663
 __sysvec_call_function_single+0x95/0x3d0 arch/x86/kernel/smp.c:248
 sysvec_call_function_single+0x8e/0xc0 arch/x86/kernel/smp.c:243
 </IRQ>
 asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:646
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:199
Code: 0f 1f 44 00 00 55 48 8b 74 24 08 48 89 fd 48 83 c7 18 e8 6e ca 2a f8 48 89 ef e8 16 40 2b f8 e8 71 7b 4b f8 fb bf 01 00 00 00 <e8> 86 18 1f f8 65 8b 05 6f 8e d1 76 85 c0 74 02 5d c3 e8 eb e3 cf
RSP: 0018:ffffc90000d37d58 EFLAGS: 00000202
RAX: 000000000005a55b RBX: ffff8880b9c32800 RCX: 1ffffffff1ada649
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffffff8b987640 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817bdce8 R11: 1ffff1101738651e R12: 0000000000000040
R13: ffffffff8b987a40 R14: dffffc0000000000 R15: ffffffff8d6d91ec
 rcu_gp_cleanup+0x86c/0xb30 kernel/rcu/tree.c:2092
 rcu_gp_kthread+0x1ef/0x320 kernel/rcu/tree.c:2132
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

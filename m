Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF9452DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhKPJ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:26:39 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:41744 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhKPJ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:26:17 -0500
Received: by mail-il1-f199.google.com with SMTP id j6-20020a056e02154600b0026dea698bbcso12331650ilu.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Nfz2M0Q3zQ12k3GA1LijwZf4IHwi8qmXUJEvVfbqItY=;
        b=lUEe1+1TJtBuwpdnsuprrbqBwpkl/l7p8200zvkdqfHtQv3RNKbzmQ7xpHwZlBResz
         IdcGC0GGndSLoiLpfMbhf9dZq/+zqQYT2DrC1YLfsu2FDzG371ZxuSOb6OUCR5k0QAg2
         JCybfQQQ+Lj3jBz4/ZZJ6Q/pF/CPhNC6BYw9fmFswuDxD5XG/tnV4pATvdHDHbeLf9nX
         O3KYhDpo04qQ4qaloRsfQ1niQK7NAHGW+5uxV6DYxOvcIpzZND6/xHvTGXhwL8SunBEV
         x7gGFV3t/olcl5QYnl51WnqPvOJxzcfkkhBwlLWiZReLDk0C+FQdBi3H5qA5n9zkIzI9
         MlKA==
X-Gm-Message-State: AOAM531aIl8lx7+XZrTvdE9sqJvREs7e0Mvs6OVtKlFvtN44h+TGkrcV
        9PHQWOUOWWWtCy1pBW9I5fGFCrt/dA5MVXnq8Lz6F24n7O6u
X-Google-Smtp-Source: ABdhPJyX21NoADgo7DKkhmSXR6kL0D75fpq2o7lh8090PXir9DsY5wOoaxES0ipI56LLvPN8pAlNvYH1LKXBqVJhQWkRIEU5ZNim
MIME-Version: 1.0
X-Received: by 2002:a5e:da09:: with SMTP id x9mr3923214ioj.171.1637054600429;
 Tue, 16 Nov 2021 01:23:20 -0800 (PST)
Date:   Tue, 16 Nov 2021 01:23:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000efc56905d0e47998@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in
 drm_fb_helper_damage_work (3)
From:   syzbot <syzbot+38cf2d663fcac29c9e0b@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5833291ab6de Merge tag 'pci-v5.16-fixes-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d04e6eb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7259f0deb293aa
dashboard link: https://syzkaller.appspot.com/bug?extid=38cf2d663fcac29c9e0b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38cf2d663fcac29c9e0b@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffc900048f1000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 10c00067 P4D 10c00067 PUD 10dbe067 PMD 45f19067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 4467 Comm: kworker/3:6 Not tainted 5.15.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: events drm_fb_helper_damage_work
RIP: 0010:rep_movs arch/x86/lib/iomem.c:12 [inline]
RIP: 0010:memcpy_toio+0x83/0xe0 arch/x86/lib/iomem.c:57
Code: 83 fd 49 89 dd 31 ff 41 83 e5 02 4c 89 ee e8 f4 22 83 fd 4d 85 ed 75 2e e8 5a 20 83 fd 48 89 e9 48 89 df 4c 89 e6 48 c1 e9 02 <f3> a5 40 f6 c5 02 74 02 66 a5 40 f6 c5 01 74 01 a4 5b 5d 41 5c 41
RSP: 0018:ffffc90006d9fbc8 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffffc900066fd000 RCX: 0000000000000400
RDX: ffff88801b369d00 RSI: ffffc900048f1000 RDI: ffffc90006700000
RBP: 0000000000004000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff83f4a60c R11: 0000000000000000 R12: ffffc900048ee000
R13: 0000000000000000 R14: ffffc900048ee000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900048f1000 CR3: 0000000071bde000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dma_buf_map_memcpy_to include/linux/dma-buf-map.h:245 [inline]
 drm_fb_helper_damage_blit_real drivers/gpu/drm/drm_fb_helper.c:388 [inline]
 drm_fb_helper_damage_blit drivers/gpu/drm/drm_fb_helper.c:419 [inline]
 drm_fb_helper_damage_work+0x733/0xac0 drivers/gpu/drm/drm_fb_helper.c:450
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Modules linked in:
CR2: ffffc900048f1000
---[ end trace 3c61e5e2b34760bf ]---
RIP: 0010:rep_movs arch/x86/lib/iomem.c:12 [inline]
RIP: 0010:memcpy_toio+0x83/0xe0 arch/x86/lib/iomem.c:57
Code: 83 fd 49 89 dd 31 ff 41 83 e5 02 4c 89 ee e8 f4 22 83 fd 4d 85 ed 75 2e e8 5a 20 83 fd 48 89 e9 48 89 df 4c 89 e6 48 c1 e9 02 <f3> a5 40 f6 c5 02 74 02 66 a5 40 f6 c5 01 74 01 a4 5b 5d 41 5c 41
RSP: 0018:ffffc90006d9fbc8 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffffc900066fd000 RCX: 0000000000000400
RDX: ffff88801b369d00 RSI: ffffc900048f1000 RDI: ffffc90006700000
RBP: 0000000000004000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff83f4a60c R11: 0000000000000000 R12: ffffc900048ee000
R13: 0000000000000000 R14: ffffc900048ee000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900048f1000 CR3: 0000000071bde000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	83 fd 49             	cmp    $0x49,%ebp
   3:	89 dd                	mov    %ebx,%ebp
   5:	31 ff                	xor    %edi,%edi
   7:	41 83 e5 02          	and    $0x2,%r13d
   b:	4c 89 ee             	mov    %r13,%rsi
   e:	e8 f4 22 83 fd       	callq  0xfd832307
  13:	4d 85 ed             	test   %r13,%r13
  16:	75 2e                	jne    0x46
  18:	e8 5a 20 83 fd       	callq  0xfd832077
  1d:	48 89 e9             	mov    %rbp,%rcx
  20:	48 89 df             	mov    %rbx,%rdi
  23:	4c 89 e6             	mov    %r12,%rsi
  26:	48 c1 e9 02          	shr    $0x2,%rcx
* 2a:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi) <-- trapping instruction
  2c:	40 f6 c5 02          	test   $0x2,%bpl
  30:	74 02                	je     0x34
  32:	66 a5                	movsw  %ds:(%rsi),%es:(%rdi)
  34:	40 f6 c5 01          	test   $0x1,%bpl
  38:	74 01                	je     0x3b
  3a:	a4                   	movsb  %ds:(%rsi),%es:(%rdi)
  3b:	5b                   	pop    %rbx
  3c:	5d                   	pop    %rbp
  3d:	41 5c                	pop    %r12
  3f:	41                   	rex.B


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

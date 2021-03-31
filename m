Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431F734AD08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhCZRBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:01:25 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:56043 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhCZRBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:01:10 -0400
Received: by mail-io1-f70.google.com with SMTP id e15so6678950ioe.22
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ek8xQFiHkPpKYZJF6UVHo7xZprWCoprwUieS9pAdC30=;
        b=YLUNTyO1U3bTB7I+xLpNXB5asVNfRmokjWThjPGpKkhrBm4NXEMmqeEvDHBAETtuoF
         gI+Gd5z83wOoVTjFN06UUFiVJuEviGGZNGhLo1zNa6hMk1Hwn4pikTgJCYkI21Tlwilx
         9M/ps6GfJRp+XAKsClPN9yKPEvlueXtfCZQ9PFOuHZ8HESF+dctLC+XpWe22gIdVG3Dv
         p3Zma2i05J091kqS1iIxrgGPTDO1GM+tHZ1IWAE9RTWOHIoODvEy5GCjS1/zGxalP2zc
         jnwQ9ICLYKEKZnWmDcC+pMcGT4TiTW6nLq6fpDDRYX3RkbYXZa6vfc3F3HJ8MZoZswQY
         8g2w==
X-Gm-Message-State: AOAM530YuEGYvUsbPamwekGJDHLeQUMWEfHmNOV2MdgjSevRdZJqVEET
        VgZn5RrM1rzYGw3pwLSz0TBlGdc3gg+8M+Z77qJCoaGzjUNK
X-Google-Smtp-Source: ABdhPJz2oHmtdU4TwtcdUDIu8ZiVlgzcEuBdBPcIpGSElqPWyukMVjNhVMr1su7zUZdqkCK6Ss5dD91euYUvnSWUq0uWm5u4Thzq
MIME-Version: 1.0
X-Received: by 2002:a92:b002:: with SMTP id x2mr11287921ilh.248.1616778069814;
 Fri, 26 Mar 2021 10:01:09 -0700 (PDT)
Date:   Fri, 26 Mar 2021 10:01:09 -0700
In-Reply-To: <CACVXFVMf9n8bHP8ZTx74bBqoKRFHbPPLSBkvmdaV50xXwNKC1A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088336505be737abc@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
From:   syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tom.leiming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in kvm_wait

------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 10753 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 1 PID: 10753 Comm: syz-executor.4 Not tainted 5.12.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
Code: be ff cc cc cc cc cc cc cc cc cc cc cc 80 3d a1 e7 2b 04 00 74 01 c3 48 c7 c7 20 92 6b 89 c6 05 90 e7 2b 04 01 e8 79 cf be ff <0f> 0b c3 48 39 77 10 0f 84 97 00 00 00 66 f7 47 22 f0 ff 74 4b 48
RSP: 0018:ffffc90008f0f9c0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888021f02040 RCX: 0000000000000000
RDX: ffff888017d4d4c0 RSI: ffffffff815c3875 RDI: fffff520011e1f2a
RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815bc60e R11: 0000000000000000 R12: 0000000000000003
R13: ffffed10043e0408 R14: 0000000000000001 R15: ffff8880b9f35f40
FS:  00000000022dd400(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004e4a64 CR3: 0000000016964000 CR4: 0000000000350ee0
Call Trace:
 kvm_wait arch/x86/kernel/kvm.c:860 [inline]
 kvm_wait+0xc9/0xe0 arch/x86/kernel/kvm.c:837
 pv_wait arch/x86/include/asm/paravirt.h:564 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x8b8/0xb40 kernel/locking/qspinlock.c:508
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:554 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:85 [inline]
 do_raw_spin_lock+0x200/0x2b0 kernel/locking/spinlock_debug.c:113
 spin_lock include/linux/spinlock.h:354 [inline]
 ext4_lock_group fs/ext4/ext4.h:3383 [inline]
 __ext4_new_inode+0x384f/0x5570 fs/ext4/ialloc.c:1188
 ext4_symlink+0x489/0xd50 fs/ext4/namei.c:3347
 vfs_symlink fs/namei.c:4176 [inline]
 vfs_symlink+0x10f/0x270 fs/namei.c:4161
 do_symlinkat+0x27a/0x300 fs/namei.c:4206
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x465d67
Code: 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 58 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda32c3708 EFLAGS: 00000202 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000465d67
RDX: 00007ffda32c37f3 RSI: 00000000004bfab2 RDI: 00007ffda32c37e0
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffda32c35a0
R10: 00007ffda32c3457 R11: 0000000000000202 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 00007ffda32c37e0


Tested on:

commit:         c47a2e74 block: not create too many partitions
git tree:       https://github.com/ming1/linux.git v5.12-block-test
console output: https://syzkaller.appspot.com/x/log.txt?x=11d037e6d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5da36c3359b30d1
dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139
compiler:       


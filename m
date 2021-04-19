Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342C9364094
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbhDSLbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhDSLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:31:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D18C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:30:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618831837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c8U6Sx7xm1qw/VGbM/nwEf5LhdEK+YWexsDvoahYBBg=;
        b=s0vfoJMRYaxdyrKmvG4c10M3D6xL2W7XYLysG2uxnDfQOaPdIV1Kfn/YY7/PO6uomtRgtD
        mpLo/VnUR0U0DQw4Z4VdYjaL8qsfaZhxaLo3hKKulk+c5yZ6jGlcG/vZt7WydYNVa5Kanv
        dR98FbsW5iLMtS3mi6Yeplw1YFx/elFvxOZzj69H1umsB+DHEnJjIIh+WZJxzx/ul9n5ly
        MPVuFkI7y8ffybjCYiAFPVDnLpSQLUe1zdyYBiW4sSd0+QxYIvClbdfIHMj0pxAjZIK7+Z
        v4lLyV5/n9BhMbrNwKH9isE95IvXpIvV+WfL8m5pE/+EZYT8gqCdBz4ptm+qsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618831837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c8U6Sx7xm1qw/VGbM/nwEf5LhdEK+YWexsDvoahYBBg=;
        b=XT2nkZ49EW8gpYWLzG8eHp3kjsvrfct4h3GU4tZpq5NLVPgNdPoqv9MVqNueurtaZWDRcA
        ems3VtUG7ZSqmlBA==
To:     syzbot <syzbot+9362b31a2e0cad8b749d@syzkaller.appspotmail.com>
Cc:     peterz@infraded.org, bp@alien8.de, dwmw@amazon.co.uk,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: [syzbot] WARNING in kthread_is_per_cpu
In-Reply-To: <000000000000a61f7705c050e601@google.com>
References: <000000000000a61f7705c050e601@google.com>
Date:   Mon, 19 Apr 2021 13:30:37 +0200
Message-ID: <87r1j6qzoi.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19 2021 at 03:36, syzbot wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1216f02e Add linux-next specific files for 20210415
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1032ba29d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3491b04113499f81
> dashboard link: https://syzkaller.appspot.com/bug?extid=9362b31a2e0cad8b749d
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9362b31a2e0cad8b749d@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 23550 at kernel/kthread.c:83 to_kthread kernel/kthread.c:83 [inline]
> WARNING: CPU: 1 PID: 23550 at kernel/kthread.c:83 kthread_is_per_cpu+0xc4/0xf0 kernel/kthread.c:519
> Modules linked in:
> CPU: 1 PID: 23550 Comm: syz-executor.3 Not tainted 5.12.0-rc7-next-20210415-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:to_kthread kernel/kthread.c:83 [inline]
> RIP: 0010:kthread_is_per_cpu+0xc4/0xf0 kernel/kthread.c:519
> Code: 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 2e 4c 8b 23 41 83 e4 01 e8 89 d3 27 00 44 89 e0 5b 5d 41 5c c3 e8 7c d3 27 00 <0f> 0b eb 88 e8 33 90 6c 00 e9 68 ff ff ff e8 39 90 6c 00 eb 9a 48
> RSP: 0018:ffffc90000dc0c08 EFLAGS: 00010046
> RAX: 0000000000000000 RBX: ffff88802533d580 RCX: 0000000000000100
> RDX: ffff8880549bb900 RSI: ffffffff814ca4c4 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffff88802533d580
> R10: ffffffff814ca44c R11: 00000000018a3b90 R12: 0000000000000001
> R13: ffffc90000dc0d90 R14: 0000000000000001 R15: ffff88802533d580
> FS:  00007f4be57d3700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2cd24000 CR3: 0000000024626000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  can_migrate_task+0x124/0x1630 kernel/sched/fair.c:7610

So this is:

if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))

The warning in to_kthread() is:

    WARN_ON(!(k->flags & PF_KTHREAD));

IOW, the p>flags lost PF_KTHREAD within at max. 50 instructions.

Magic, cosmic rays or memory corruption / stray pointer in some other
place?

Thanks,

        tglx

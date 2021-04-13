Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028DB35D9BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbhDMIMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbhDMIMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:12:40 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B96C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 01:12:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c6so12069229qtc.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d12Y9lIvm9byUn0SmfXOlS4sJonP+P/fuF6Juefsf6E=;
        b=dx59nD8YvzUjRAKMmEe8ZjDN6wLp/6yBkKTw03FUf7tcIeXd3nXwEWgjF9i+PW2LTJ
         Njt3BpleKBhacmw70gkuWOl/yOl8qFhdQJ5jl8B0aiVTJt0GLNkqLX37kBR5yaWc2IdK
         IQwiKLr9//ZaVQvzFNZMuOScdp9sBFAc0z7v6co2tPH1CR0mO3ktZ9vbPfsouUZstbZO
         HM8dAlKPhlNOYVkG5O5eMrOpPK417AL6h9oqXaGQjiwdYa6dHfPbvFA3vQqRtdCXe/PI
         NRWCfoDAqvNwVwupMHE9Z3XZ/lgDhqx659VqmsdUr0C8qlx+vxPtnyfX89uYW07FP6nD
         Pdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d12Y9lIvm9byUn0SmfXOlS4sJonP+P/fuF6Juefsf6E=;
        b=j5Fb/lUOipJ0QXsBmUgM23R8S3nRyhrTI/HOHMnQ2lOgTWbKD/QpEGzfhJy/20iBIt
         gpGJFYdcR1jcmo4dS40DSd/+O1rIT4VMwAphRBaDGUyK8Unb3GVkbPJva7PKNHYqu+me
         Y5E2JQ8OmRgNQLGXEZkwyRunl6nOlaYgxvSNAdN2kETTsZXVqKnPhgIEtCaad5AUrBiC
         5D8HWyBC8+Om9Q/DMvrJIRc/AE4q/Kx8BQdHOxBCShn/SxNJ1ayz/r1+36P3VK/rM8K3
         VJ3paGphdV7rA3twr7wguSiYXXPNqfjFxYOvHY8N/7mcRLB+4D+Rdass8bNScIl8u2g9
         hTJg==
X-Gm-Message-State: AOAM533pFiPkpa4cOnBEx4j/4wfqFtRk1/Vf+nDR6N6xHMJyfSOK7y6c
        xuvbeD5q2wv9n23KKVBDmvOTD1Q0XLwSDBZPfYpRsTL6x1om7w==
X-Google-Smtp-Source: ABdhPJzsnUzLNTX+i5G5H/gHEPyYzJhNPKRvbEFWIG2MZ4p0lw0eyprjt/BHtYOoRI3BTl4TsaLYGoJHy+HbbSSW4JU=
X-Received: by 2002:a05:622a:c3:: with SMTP id p3mr28974716qtw.43.1618301536606;
 Tue, 13 Apr 2021 01:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000075c58405bfd6228c@google.com>
In-Reply-To: <00000000000075c58405bfd6228c@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Apr 2021 10:12:05 +0200
Message-ID: <CACT4Y+bTjQz=RBXVNrVMQ9xPz5CzGNBE854fsb0ukS-2_wdi3Q@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in gadget_setup
To:     syzbot <syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 10:08 AM syzbot
<syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0f4498ce Merge tag 'for-5.12/dm-fixes-2' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=124adbf6d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
> dashboard link: https://syzkaller.appspot.com/bug?extid=eb4674092e6cc8d9e0bd
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com

I suspect that the raw gadget_unbind() can be called while the timer
is still active. gadget_unbind() sets gadget data to NULL.
But I am not sure which unbind call this is:
usb_gadget_remove_driver() or right in udc_bind_to_driver() due to a
start error.

Also looking at the code, gadget_bind() resets data to NULL on this error path:
https://elixir.bootlin.com/linux/v5.12-rc7/source/drivers/usb/gadget/legacy/raw_gadget.c#L283
but not on this error path:
https://elixir.bootlin.com/linux/v5.12-rc7/source/drivers/usb/gadget/legacy/raw_gadget.c#L306
Should the second one also reset data to NULL?


> general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> CPU: 1 PID: 5016 Comm: systemd-udevd Not tainted 5.12.0-rc4-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> RIP: 0010:__lock_acquire+0xcfe/0x54c0 kernel/locking/lockdep.c:4770
> Code: 09 0e 41 bf 01 00 00 00 0f 86 8c 00 00 00 89 05 48 69 09 0e e9 81 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 5b 31 00 00 49 81 3e c0 13 38 8f 0f 84 d0 f3 ff
> RSP: 0000:ffffc90000ce77d8 EFLAGS: 00010002
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000004 RSI: 1ffff9200019cf0c RDI: 0000000000000020
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000006 R12: ffff88801295b880
> R13: 0000000000000000 R14: 0000000000000020 R15: 0000000000000000
> FS:  00007fcd745f98c0(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffe279f7d87 CR3: 000000001c7d4000 CR4: 0000000000150ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  lock_acquire kernel/locking/lockdep.c:5510 [inline]
>  lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
>  gadget_setup+0x4e/0x510 drivers/usb/gadget/legacy/raw_gadget.c:327
>  dummy_timer+0x1615/0x32a0 drivers/usb/gadget/udc/dummy_hcd.c:1903
>  call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1431
>  expire_timers kernel/time/timer.c:1476 [inline]
>  __run_timers.part.0+0x67c/0xa50 kernel/time/timer.c:1745
>  __run_timers kernel/time/timer.c:1726 [inline]
>  run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1758
>  __do_softirq+0x29b/0x9f6 kernel/softirq.c:345
>  invoke_softirq kernel/softirq.c:221 [inline]
>  __irq_exit_rcu kernel/softirq.c:422 [inline]
>  irq_exit_rcu+0x134/0x200 kernel/softirq.c:434
>  sysvec_apic_timer_interrupt+0x45/0xc0 arch/x86/kernel/apic/apic.c:1100
>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:632
> RIP: 0033:0x560cfc4a02ed
> Code: 4c 39 c1 48 89 42 18 4c 89 52 08 4c 89 5a 10 48 89 1a 0f 87 7b ff ff ff 48 89 f8 48 f7 d0 48 01 c8 48 83 e0 f8 48 8d 7c 07 08 <48> 8d 0d 34 d9 02 00 48 63 04 b1 48 01 c8 ff e0 0f 1f 00 48 8d 0d
> RSP: 002b:00007ffe279f9dd0 EFLAGS: 00000246
> RAX: 0000000000000000 RBX: 0000560cfcd88e40 RCX: 0000560cfcd72af0
> RDX: 00007ffe279f9de0 RSI: 0000000000000007 RDI: 0000560cfcd72af0
> RBP: 00007ffe279f9e70 R08: 0000000000000000 R09: 0000000000000020
> R10: 0000560cfcd72af7 R11: 0000560cfcd73530 R12: 0000560cfcd72af0
> R13: 0000000000000000 R14: 0000560cfcd72b10 R15: 0000000000000001
> Modules linked in:
> ---[ end trace ab0f6632fdd289cf ]---
> RIP: 0010:__lock_acquire+0xcfe/0x54c0 kernel/locking/lockdep.c:4770
> Code: 09 0e 41 bf 01 00 00 00 0f 86 8c 00 00 00 89 05 48 69 09 0e e9 81 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 5b 31 00 00 49 81 3e c0 13 38 8f 0f 84 d0 f3 ff
> RSP: 0000:ffffc90000ce77d8 EFLAGS: 00010002
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000004 RSI: 1ffff9200019cf0c RDI: 0000000000000020
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000006 R12: ffff88801295b880
> R13: 0000000000000000 R14: 0000000000000020 R15: 0000000000000000
> FS:  00007fcd745f98c0(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffe279f7d87 CR3: 000000001c7d4000 CR4: 0000000000150ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000075c58405bfd6228c%40google.com.

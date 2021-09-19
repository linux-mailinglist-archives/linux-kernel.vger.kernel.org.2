Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8CC410B9A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 14:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhISM4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhISM4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 08:56:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8317AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 05:55:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632056123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+OLK43v2moJaSmMHQZXfBdQNFh+lvMLEft1206Pu7Vw=;
        b=G6dmn4q6Kdle+J90FlW2oZ8k9j1FlZtT0qJpYY+0ugIHdz1xGP5dM4jesMBMz2ojKeOpvB
        F00KsDio1txfNen7JzNPc7QFax59wWkD6QqaQpHx+9Xa2Rxs3DWbwVB6uHWc0zfU6hAAYY
        RDs5v9e8jBcosR/KKU2lsIVEqSYrzSo7LZ+Pqw9YioRzORJjdOIOEwmwILoFERQ58iq9Dj
        JMWX0x8C+S7rTcsVtyabuDHrXGL0bF+mcz/cdvL0xvEkggBiTwC9KsHbSjqa79U4koRbi8
        BnO9NWHrjHxTqaunx6Gd415x0N+joH0kyYpYj+QSkzJLMpPKofY7xrZElwwK2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632056123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+OLK43v2moJaSmMHQZXfBdQNFh+lvMLEft1206Pu7Vw=;
        b=NgjdzzGoz48EsMmQGlQtCIVq4nEXPwV9UxjfV9+2sF0gWeAXWa1VTlqp75UZIaci9hIAQE
        g8q2T8ow4tG/IOAw==
To:     syzbot <syzbot+4546a69bfcab9a42f280@syzkaller.appspotmail.com>,
        bp@alien8.de, dwmw@amazon.co.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, x86@kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [syzbot] WARNING in insert_work
In-Reply-To: <000000000000343aaf05cc027f83@google.com>
References: <000000000000343aaf05cc027f83@google.com>
Date:   Sun, 19 Sep 2021 14:55:22 +0200
Message-ID: <87o88o7mit.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2021 at 23:06, syzbot wrote:
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/workqueue.c:633 set_work_data kernel/workqueue.c:633 [inline]

That is this warning in set_work_data():

     WARN_ON_ONCE(!work_pending(work));

> WARNING: CPU: 0 PID: 0 at kernel/workqueue.c:633 set_work_pwq kernel/workqueue.c:640 [inline]
> WARNING: CPU: 0 PID: 0 at kernel/workqueue.c:633 insert_work+0x2a7/0x370 kernel/workqueue.c:1356
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.14.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:set_work_data kernel/workqueue.c:633 [inline]
> RIP: 0010:set_work_pwq kernel/workqueue.c:640 [inline]
> RIP: 0010:insert_work+0x2a7/0x370 kernel/workqueue.c:1356
> Code: b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cc 00 00 00 48 8b 7b 40 e8 30 93 05 00 eb 83 e8 09 86 2a 00 <0f> 0b e9 dc fd ff ff 48 89 ef e8 ca d0 71 00 e9 56 ff ff ff 4c 89
> RSP: 0018:ffffc90000007c70 EFLAGS: 00010046
> RAX: 0000000000000000 RBX: ffff888088ac54b0 RCX: 0000000000000100
> RDX: ffffffff8b6bc680 RSI: ffffffff814b8737 RDI: 0000000000000003
> RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff814b8511 R11: 0000000000000000 R12: ffff888010c69858
> R13: ffff888147c49800 R14: ffff888010c69800 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4db76b6ab4 CR3: 000000000b68e000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> Call Trace:
>  <IRQ>
>  __queue_work+0x5ca/0xee0 kernel/workqueue.c:1519
>  call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421

So this is a delayed work. The timer fires and wants to queue the work,
but the work is not pending. No idea how that can happen.

Unfortunately there is no hint which work item this could be. The
warning does not tell which work function is associated to that
work. That might be a useful hint (or not if it's some generic and
widely used work function).

Thanks,

        tglx


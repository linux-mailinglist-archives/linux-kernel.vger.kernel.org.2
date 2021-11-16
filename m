Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898BC452D39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhKPI5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhKPI4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:56:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A891C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:53:57 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so84495368edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bVzQtZqrN1ftwfaMCzYpoNRv7CblXww8PyoP3BzBAFg=;
        b=kJa9o5peIWuLMkl51euYgr0s7OCeoKzKpMmfcqTgKUENQykvhK7cH7PRkcaxV4OWQv
         cbhQIDL4+PgsVghfz/KD85gc6FMViu0/SBVybZK20pyutBkkpfRBson8ZuMTOh/AuX7Z
         FMuEPdWFi8TUJiJLUNPTDShyQpDWZVLDK1SgWwP0XSQHtjhiIWci/6wqQh6Krgc/PaAV
         gqKD7sHQcGB4Zukp8sq0q4SMZX7S//AwmoPkj30A/yzMf4BuLJIupC2Rt9N5s2cvW9yB
         ztZd08IL+3Zt4jkvc0aRsAEbWe2WB0A421lws9TnNmmH1P9iE++Vq/+7eNuHuFSZH0PH
         yglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVzQtZqrN1ftwfaMCzYpoNRv7CblXww8PyoP3BzBAFg=;
        b=we5tri5hYHamcqhRJpQQ+gq12feqbKyHLL0mqsnWJiDvGhiRoa8u6z0C83CPRwbn+D
         0NetOqw2Gn7RBjHqsN3zSpB8ZOJvkV8lsvPPvF8QNAWD62sE1cn2tO+cu4Pc+tA362sG
         GZSMo2zWbYJFnYaRYqZBqHOy3+rbLsYpPzK2jDlYA1GYsIIKQjMtpP7KLoC+6r1OYrWG
         ivW0IUuDMWl4xrY+CVg8/6R3KUzUjIXs2Mtb1lqDToFT4ydYZS43TOvtwvI+yz7oUY1B
         eSvvcL4SETGzP9FyisJmQ72lMpru3OLuYiOftmeRmCe5QZoKdUSuE7ng/IXw0HMlN+Lj
         CqoQ==
X-Gm-Message-State: AOAM532ASeU9brAYOWMTsLTlru2X5Zo32XpTylJPxeMAbdhhYcT9O0ZT
        zZIc9CJDVD5ghTkqRYaTYqjUnvhZTxc=
X-Google-Smtp-Source: ABdhPJymeV4uBCkaBJc6mTWlLlaKalvXjp7KcAEv/n9DvMQyAZAKChDdPFINLc32jRGzWHF0m1m2+Q==
X-Received: by 2002:a17:907:96a4:: with SMTP id hd36mr7662499ejc.407.1637052835876;
        Tue, 16 Nov 2021 00:53:55 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id d14sm8061474edu.57.2021.11.16.00.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 00:53:55 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     elver@google.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
Date:   Tue, 16 Nov 2021 09:53:53 +0100
Message-ID: <5631140.hc6UrLtR2d@localhost.localdomain>
In-Reply-To: <000000000000be6cff05d0e3709b@google.com>
References: <000000000000be6cff05d0e3709b@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart14753752.cerE3pXiLi"
Content-Transfer-Encoding: 7Bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart14753752.cerE3pXiLi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Tuesday, November 16, 2021 9:09:11 AM CET syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering 
an issue:
> BUG: sleeping function called from invalid context in __might_resched
> 
> BUG: sleeping function called from invalid context at kernel/printk/
printk.c:2522
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 8755, name: syz-
executor.2
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 3 locks held by syz-executor.2/8755:
>  #0: ffff888070c9a098
>  (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/
tty/tty_ldisc.c:252
>  #1: ffff888070c9a468
>  (&tty->flow.lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:
374 [inline]
>  (&tty->flow.lock){....}-{2:2}, at: n_tty_ioctl_helper+0xb6/0x2d0 drivers/
tty/tty_ioctl.c:877
>  #2: ffff888070c9a098 (&tty->ldisc_sem){++++}-{0:0}, at: 
tty_ldisc_ref+0x1d/0x80 drivers/tty/tty_ldisc.c:273
> irq event stamp: 916
> hardirqs last  enabled at (915): [<ffffffff81beabd5>] 
kasan_quarantine_put+0xf5/0x210 mm/kasan/quarantine.c:220
> hardirqs last disabled at (916): [<ffffffff8950a731>] __raw_spin_lock_irq 
include/linux/spinlock_api_smp.h:117 [inline]
> hardirqs last disabled at (916): [<ffffffff8950a731>] 
_raw_spin_lock_irq+0x41/0x50 kernel/locking/spinlock.c:170
> softirqs last  enabled at (0): [<ffffffff8144cf0c>] copy_process+0x1e8c/
0x75a0 kernel/fork.c:2136
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 1 PID: 8755 Comm: syz-executor.2 Not tainted 5.16.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS 
Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9542
>  console_lock+0x17/0x80 kernel/printk/printk.c:2522
>  con_flush_chars drivers/tty/vt/vt.c:3365 [inline]
>  con_flush_chars+0x35/0x90 drivers/tty/vt/vt.c:3357
>  con_write+0x2c/0x40 drivers/tty/vt/vt.c:3296

The reproducer is still triggering an issue, but this time it looks like it 
is triggered by a different path of execution.

The same invalid "in_interrupt()" test is also in con_flush_chars().

Let's try to remove it too...

My first idea would be to replace "if (in_interrupt())" with the same 
"preempt_count() || irqs_disabled()" I used in do_con_write(). However I 
noticed that both do_con_write() and con_flush_chars() are only called from 
inside con_write() (which, aside from calling those functions, does nothing 
else).

So why not remove the if (in_interrupt()) from both them and use if 
(preempt_count() || irqs_disabled()) just once in con_write()?

I think this should be the right solution, but I prefer to go one step at a 
time.

Therefore, I'll (1) use the same (redundant, if it was used in con_write()) 
test also in con_flush_chars(), (2) wait for Syzbot to confirm that it fixes 
the bug, and (3) wait for maintainers review and suggestions about whether or 
not moving those tests one level upper.

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

---
Fabio M. De Francesco

--nextPart14753752.cerE3pXiLi
Content-Disposition: attachment; filename="vt.c.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="vt.c.diff"

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7359c3e80d63..46511d1ac6ee 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 	struct vt_notifier_param param;
 	bool rescan;
 
-	if (in_interrupt())
+	if (preempt_count() || irqs_disabled())
 		return count;
 
 	console_lock();
@@ -3358,7 +3358,7 @@ static void con_flush_chars(struct tty_struct *tty)
 {
 	struct vc_data *vc;
 
-	if (in_interrupt())	/* from flush_to_ldisc */
+	if (preempt_count() || irqs_disabled())	/* from flush_to_ldisc */
 		return;
 
 	/* if we race with con_close(), vt may be null */

--nextPart14753752.cerE3pXiLi--




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0FC3687EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbhDVUaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:30:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41016 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbhDVUaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:30:14 -0400
Message-Id: <20210422194705.125957049@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619123377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=shlvjKCBd71NCvlvINFb/PhBTsCYwLOokXpCAI2ZxMs=;
        b=FA708uGJ6kx6y8evECzdZw/8AqWgIT4udyi1e6c325QhTqnsRSrlCFz0Up/2F8EcySN4v4
        LWFswvcop0/1H3xHZ0XdVE5BopPXu3+o7CSInscZ7Y3xWMKb8lIra4MD/Wu3qkXuKc9LxS
        qbnLf0A8YKQgDoZJjn1rFKg1b12J9owGd9COwJ1BI+iSXRg+QI2MnV/DB/xOJDCw8o4XwM
        Jzx0peqlGGra2YaXE1EtLBHc+/mMb1ZFGWLfcSpQIhRVB6+BcvY9IoOcnDWkGZbiA74B+V
        n41A2RqBvjWiD55LK22XIcLe6A3soLt5GwKlzxDhmovonH3sz6gKC7YLFohI0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619123377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=shlvjKCBd71NCvlvINFb/PhBTsCYwLOokXpCAI2ZxMs=;
        b=50hpCusVKJPbu5Ez0SJuS44cxbX+iziql+Hd1uBnOLqC5LcGKGSTEIlCza2g2WPnEPAt+T
        P7vFH1KvyUa8LHDg==
Date:   Thu, 22 Apr 2021 21:44:20 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Lukasz Majewski <lukma@denx.de>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [patch 3/6] futex: Get rid of the val2 conditional dance
References: <20210422194417.866740847@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in checking which FUTEX operand treats the utime pointer
as 'val2' argument because that argument to do_futex() is only used by
exactly these operands.

So just handing it in unconditionally is not making any difference, but
removes a lot of pointless gunk.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3765,7 +3765,6 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
 {
 	struct timespec64 ts;
 	ktime_t t, *tp = NULL;
-	u32 val2 = 0;
 	int cmd = op & FUTEX_CMD_MASK;
 
 	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
@@ -3785,15 +3784,8 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
 			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
 		tp = &t;
 	}
-	/*
-	 * requeue parameter in 'utime' if cmd == FUTEX_*_REQUEUE_*.
-	 * number of waiters to wake in 'utime' if cmd == FUTEX_WAKE_OP.
-	 */
-	if (cmd == FUTEX_REQUEUE || cmd == FUTEX_CMP_REQUEUE ||
-	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
-		val2 = (u32) (unsigned long) utime;
 
-	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
+	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 
 #ifdef CONFIG_COMPAT
@@ -3961,7 +3953,6 @@ SYSCALL_DEFINE6(futex_time32, u32 __user
 {
 	struct timespec64 ts;
 	ktime_t t, *tp = NULL;
-	int val2 = 0;
 	int cmd = op & FUTEX_CMD_MASK;
 
 	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
@@ -3979,11 +3970,8 @@ SYSCALL_DEFINE6(futex_time32, u32 __user
 			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
 		tp = &t;
 	}
-	if (cmd == FUTEX_REQUEUE || cmd == FUTEX_CMP_REQUEUE ||
-	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
-		val2 = (int) (unsigned long) utime;
 
-	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
+	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 #endif /* CONFIG_COMPAT_32BIT_TIME */
 


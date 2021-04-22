Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BD83687EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbhDVUaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:30:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41016 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239216AbhDVUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:30:15 -0400
Message-Id: <20210422194705.338657741@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619123380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5+Nf1hNa8uJgYIBeiJzmvWEoEyrCLxbp2wWmMTt1B5E=;
        b=kkm9ZaR6/SglwS9pc47PYBaPxO96kTlv+XcH+dAxY4vmWsUv3IM1xr+wBKfOAiqmO8VWmi
        Rv50In9QyvMh5KOZWtE4bqeGKZcqJWeXKCZ8qNEDqIUWpMoFCmVW5gZUOhU9/0qHb9WG2b
        HpzhN9G4D5gKG4kIh7EB0KOQe4DNdYmka/e6VgFHb1IPwCzORF3NhID+ZTw3hQ1Ao1Xr6/
        1CCpCtRcPxFMbPqDMM2RDYr3HkWZXqN+h7q0ypT8Z18YLjzngHpeCmZCLBH7vsWDdFiroH
        OcceFznxEx7wFMX1Wsxv1FG3F0yrJinUce9LNrRRmIM1A+UWwnW2ToPX/LWhCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619123380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5+Nf1hNa8uJgYIBeiJzmvWEoEyrCLxbp2wWmMTt1B5E=;
        b=SgbsvqcSMq39dMe/uqpkdxZCkUs92FS0NSL3v4/GpDph7sLFpnsSsq6K8Ckl+MrhkTU1pu
        hCrpoaR+/J7cBaAA==
Date:   Thu, 22 Apr 2021 21:44:22 +0200
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
        Kurt Kanzenbach <kurt@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Andrei Vagin <avagin@gmail.com>
Subject: [patch 5/6] futex: Prepare futex_lock_pi() for runtime clock selection
References: <20210422194417.866740847@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

futex_lock_pi() is the only futex operation which cannot select the clock
for timeouts (CLOCK_MONOTONIC/CLOCK_REALTIME). That's inconsistent and
there is no particular reason why this cannot be supported.

This was overlooked when CLOCK_REALTIME_FLAG was introduced and
unfortunately not reported when the inconsistency was discovered in glibc.

Prepare the function and enforce the CLOCK_REALTIME_FLAG on FUTEX_LOCK_PI
so that a new FUTEX_LOCK_PI2 can implement it correctly.

Reported-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2786,7 +2786,7 @@ static int futex_lock_pi(u32 __user *uad
 	if (refill_pi_state_cache())
 		return -ENOMEM;
 
-	to = futex_setup_timer(time, &timeout, FLAGS_CLOCKRT, 0);
+	to = futex_setup_timer(time, &timeout, flags, 0);
 
 retry:
 	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
@@ -3711,7 +3711,7 @@ long do_futex(u32 __user *uaddr, int op,
 
 	if (op & FUTEX_CLOCK_REALTIME) {
 		flags |= FLAGS_CLOCKRT;
-		if (cmd != FUTEX_WAIT_BITSET &&	cmd != FUTEX_WAIT_REQUEUE_PI)
+		if (cmd != FUTEX_WAIT_BITSET && cmd != FUTEX_WAIT_REQUEUE_PI)
 			return -ENOSYS;
 	}
 
@@ -3743,6 +3743,7 @@ long do_futex(u32 __user *uaddr, int op,
 	case FUTEX_WAKE_OP:
 		return futex_wake_op(uaddr, flags, uaddr2, val, val2, val3);
 	case FUTEX_LOCK_PI:
+		flags |= FLAGS_CLOCKRT;
 		return futex_lock_pi(uaddr, flags, timeout, 0);
 	case FUTEX_UNLOCK_PI:
 		return futex_unlock_pi(uaddr, flags);


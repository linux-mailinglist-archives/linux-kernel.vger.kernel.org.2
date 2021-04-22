Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A868B3687ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbhDVUaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbhDVUaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:30:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B694C061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:29:42 -0700 (PDT)
Message-Id: <20210422194705.440773992@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619123381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kByiViUrq7Upj2zpSrHGQwYQx0PYKxQru1GlSrbjYpY=;
        b=n6TuLdt/3IaLaC65BTRFHDabhwR9LjHHDY/R5N9BaA16H+YJRZT4wQHAdyKYdEAnhI4sEs
        maJPoed45F4l7fNpH6tEwvA6aHabWIZUalPpY0lw8a4aac5vVjtz1v+gyxgeGqanPQwNT2
        zLX5J+SdBsKXD0A3z5LsWBXjwaXKPcNq01cLi/mSC/r5vv5xFCEbZEZgliiFXzSbfASvxO
        J/deDrC0AZFqvoNwCgmgFJcRf5x9kAgBF/HbsxFyFs+mN9nln5tbaLnijJnqI4oPxRC5wb
        Ppo8zmVtCTa+VVXfKgeVb698Knzx1/2c99szvp710Abw+Rv901K8hc6NTm/kzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619123381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kByiViUrq7Upj2zpSrHGQwYQx0PYKxQru1GlSrbjYpY=;
        b=4dxMaTzhLW9kv1WbgngGC5gCS4IM/UZBndWOpbA20G8gRVMpomIDEsGIwR+6CcoW2DGFwe
        Jr2sgiPaTSCToBBw==
Date:   Thu, 22 Apr 2021 21:44:23 +0200
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
Subject: [patch 6/6] futex: Provide FUTEX_LOCK_PI2 to support clock selection
References: <20210422194417.866740847@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FUTEX_LOCK_PI futex operand uses a CLOCK_REALTIME based absolute
timeout since it was implemented, but it does not require that the
FUTEX_CLOCK_REALTIME flag is set, because that was introduced later.

In theory as none of the user space implementations can set the
FUTEX_CLOCK_REALTIME flag on this operand, it would be possible to
creatively abuse it and make the meaning invers, i.e. select CLOCK_REALTIME
when not set and CLOCK_MONOTONIC when set. But that's a nasty hackery.

Another option would be to have a new FUTEX_CLOCK_MONOTONIC flag only for
FUTEX_LOCK_PI, but that's also awkward because it does not allow libraries
to handle the timeout clock selection consistently.

So provide a new FUTEX_LOCK_PI2 operand which implements the timeout
semantics which the other operands use and leave FUTEX_LOCK_PI alone.

Reported-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/uapi/linux/futex.h |    1 +
 kernel/futex.c             |    6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -21,6 +21,7 @@
 #define FUTEX_WAKE_BITSET	10
 #define FUTEX_WAIT_REQUEUE_PI	11
 #define FUTEX_CMP_REQUEUE_PI	12
+#define FUTEX_LOCK_PI2		13
 
 #define FUTEX_PRIVATE_FLAG	128
 #define FUTEX_CLOCK_REALTIME	256
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3711,7 +3711,8 @@ long do_futex(u32 __user *uaddr, int op,
 
 	if (op & FUTEX_CLOCK_REALTIME) {
 		flags |= FLAGS_CLOCKRT;
-		if (cmd != FUTEX_WAIT_BITSET && cmd != FUTEX_WAIT_REQUEUE_PI)
+		if (cmd != FUTEX_WAIT_BITSET && cmd != FUTEX_WAIT_REQUEUE_PI &&
+		    cmd != FUTEX_LOCK_PI2)
 			return -ENOSYS;
 	}
 
@@ -3744,6 +3745,8 @@ long do_futex(u32 __user *uaddr, int op,
 		return futex_wake_op(uaddr, flags, uaddr2, val, val2, val3);
 	case FUTEX_LOCK_PI:
 		flags |= FLAGS_CLOCKRT;
+		fallthrough;
+	case FUTEX_LOCK_PI2:
 		return futex_lock_pi(uaddr, flags, timeout, 0);
 	case FUTEX_UNLOCK_PI:
 		return futex_unlock_pi(uaddr, flags);
@@ -3764,6 +3767,7 @@ static inline bool futex_cmd_has_timeout
 	switch (cmd) {
 	case FUTEX_WAIT:
 	case FUTEX_LOCK_PI:
+	case FUTEX_LOCK_PI2:
 	case FUTEX_WAIT_BITSET:
 	case FUTEX_WAIT_REQUEUE_PI:
 		return true;


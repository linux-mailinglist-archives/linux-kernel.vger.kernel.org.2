Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECB03687EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbhDVUaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239239AbhDVUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:30:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6D2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:29:40 -0700 (PDT)
Message-Id: <20210422194705.244476369@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619123378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1KyXbAgHyLOPweAOIVefP+lbdiDSQGpwGEeAQArZ+UM=;
        b=XeQsnOJg/4dL3n5oQUbrpY+lBde/aY+HuFei7nZyj6GmVupsXTAE4CZzqExcQeYceztu4o
        wrKfhkbnHgIG2am+w1M5q7LAr3Ilb6tU17lj/3zw7NYppb3ms62fVfkwIgeSCK9z42gjn4
        E4F2S4t8n9vi2bqOm5lG9Xq3psHs1N+ybFz8EXfPCfehn397JB5GU8fpEp5ZUuAyqEy22g
        M7M8SZOamG8nLuy1NHd39rXsKbHIGiHEbC42E5GNpI8NBgPcLxA6FYITf+d+EoCnOcJdKY
        BijtFR8pQNDMBxW2XZH+kbqkbVlD2PWWJfhMrQy8JmPdq9fpVv8eTzOxfeXrTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619123378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1KyXbAgHyLOPweAOIVefP+lbdiDSQGpwGEeAQArZ+UM=;
        b=n7KbdUt+ty57AarIUrzUuOS96cXdJj7W4doJvqKvfANZfZoaIf3DtfnA6rUUahVx9CaI+X
        QHdd5lKkJFTHCaCw==
Date:   Thu, 22 Apr 2021 21:44:21 +0200
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
Subject: [patch 4/6] futex: Make syscall entry points less convoluted
References: <20210422194417.866740847@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The futex and the compat syscall entry points do pretty much the same
except for the timespec data types and the corresponding copy from
user function.

Split out the rest into inline functions and share the functionality.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |   63 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 26 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3758,30 +3758,48 @@ long do_futex(u32 __user *uaddr, int op,
 	return -ENOSYS;
 }
 
+static __always_inline bool futex_cmd_has_timeout(u32 cmd)
+{
+	switch (cmd) {
+	case FUTEX_WAIT:
+	case FUTEX_LOCK_PI:
+	case FUTEX_WAIT_BITSET:
+	case FUTEX_WAIT_REQUEUE_PI:
+		return true;
+	}
+	return false;
+}
+
+static __always_inline int
+futex_init_timeout(u32 cmd, u32 op, struct timespec64 *ts, ktime_t *t)
+{
+	if (!timespec64_valid(ts))
+		return -EINVAL;
+
+	*t = timespec64_to_ktime(*ts);
+	if (cmd == FUTEX_WAIT)
+		*t = ktime_add_safe(ktime_get(), *t);
+	else if (cmd != FUTEX_LOCK_PI && !(op & FUTEX_CLOCK_REALTIME))
+		*t = timens_ktime_to_host(CLOCK_MONOTONIC, *t);
+	return 0;
+}
 
 SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 		const struct __kernel_timespec __user *, utime,
 		u32 __user *, uaddr2, u32, val3)
 {
-	struct timespec64 ts;
+	int ret, cmd = op & FUTEX_CMD_MASK;
 	ktime_t t, *tp = NULL;
-	int cmd = op & FUTEX_CMD_MASK;
+	struct timespec64 ts;
 
-	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
-		      cmd == FUTEX_WAIT_BITSET ||
-		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
+	if (utime && futex_cmd_has_timeout(cmd)) {
 		if (unlikely(should_fail_futex(!(op & FUTEX_PRIVATE_FLAG))))
 			return -EFAULT;
 		if (get_timespec64(&ts, utime))
 			return -EFAULT;
-		if (!timespec64_valid(&ts))
-			return -EINVAL;
-
-		t = timespec64_to_ktime(ts);
-		if (cmd == FUTEX_WAIT)
-			t = ktime_add_safe(ktime_get(), t);
-		else if (cmd != FUTEX_LOCK_PI && !(op & FUTEX_CLOCK_REALTIME))
-			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
+		ret = futex_init_timeout(cmd, op, &ts, &t);
+		if (ret)
+			return ret;
 		tp = &t;
 	}
 
@@ -3951,23 +3969,16 @@ SYSCALL_DEFINE6(futex_time32, u32 __user
 		const struct old_timespec32 __user *, utime, u32 __user *, uaddr2,
 		u32, val3)
 {
-	struct timespec64 ts;
+	int ret, cmd = op & FUTEX_CMD_MASK;
 	ktime_t t, *tp = NULL;
-	int cmd = op & FUTEX_CMD_MASK;
+	struct timespec64 ts;
 
-	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
-		      cmd == FUTEX_WAIT_BITSET ||
-		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
+	if (utime && futex_cmd_has_timeout(cmd)) {
 		if (get_old_timespec32(&ts, utime))
 			return -EFAULT;
-		if (!timespec64_valid(&ts))
-			return -EINVAL;
-
-		t = timespec64_to_ktime(ts);
-		if (cmd == FUTEX_WAIT)
-			t = ktime_add_safe(ktime_get(), t);
-		else if (cmd != FUTEX_LOCK_PI && !(op & FUTEX_CLOCK_REALTIME))
-			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
+		ret = futex_init_timeout(cmd, op, &ts, &t);
+		if (ret)
+			return ret;
 		tp = &t;
 	}
 


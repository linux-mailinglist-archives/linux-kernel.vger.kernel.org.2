Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B051C4163AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbhIWQ4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbhIWQ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:56:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131F5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:54:39 -0700 (PDT)
Message-ID: <20210923165357.991262778@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632416077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+x3a3U01x3/KHPZpen6Xkh6ecYX3g15V47u3+lMxhwA=;
        b=IkeD9qWNmlYUz+h+lDXvEiAQyPtcpSHhogG/uVAPGZfrgkksv4+jRVbwNJMwQ3QpCaKDRN
        YAMOAilSabPyoOG5BBCGkMjOz9AK8QwNHIgMl2FA5t298nZEKjR7L5s7N1O44a91VaNyi9
        +Gj1JC8BOQt0YNixvBSn4ziQC1pwca8w34qS0/ufUkkna/MoJezstp1Apzmhk1WZ0cT+cA
        HKkXItpEsyiP7/9u52B64cBXIez0UsiOkb0HIdkzCgsUrrTjQBYhfqFNflivDEafXI5nmy
        XPn+QsiOGrMMWEQgnKv+hApPHzjWxg0hubpK3Fb8rKbLBzze8viWM6NHE5PQGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632416077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+x3a3U01x3/KHPZpen6Xkh6ecYX3g15V47u3+lMxhwA=;
        b=GhqbrKi/PZTVw9bN6wwSHdHkvw3n9NVaZ/1lxdJ3oPwCAykreEZbmR6sPrcQgSih4RYtJs
        YPl24nlmYHNw47Dg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: [patch 2/8] sched: Make cond_resched_*lock() variants consistent vs.
 might_sleep()
References: <20210923164145.466686140@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:54:37 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3427445afd26 ("sched: Exclude cond_resched() from nested sleep
test") removed the task state check of __might_sleep() for
cond_resched_lock() because cond_resched_lock() is not a voluntary
scheduling point which blocks. It's a preemption point which requires the
lock holder to release the spin lock.

The same rationale applies to cond_resched_rwlock_read/write(), but those
were not touched.

Make it consistent and use the non-state checking __might_resched() there
as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2054,14 +2054,14 @@ extern int __cond_resched_rwlock_write(r
 	__cond_resched_lock(lock);					\
 })
 
-#define cond_resched_rwlock_read(lock) ({			\
-	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
-	__cond_resched_rwlock_read(lock);			\
+#define cond_resched_rwlock_read(lock) ({				\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
+	__cond_resched_rwlock_read(lock);				\
 })
 
-#define cond_resched_rwlock_write(lock) ({			\
-	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
-	__cond_resched_rwlock_write(lock);			\
+#define cond_resched_rwlock_write(lock) ({				\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
+	__cond_resched_rwlock_write(lock);				\
 })
 
 static inline void cond_resched_rcu(void)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEB3347D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhCXQRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbhCXQQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:16:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346B7C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:16:53 -0700 (PDT)
Date:   Wed, 24 Mar 2021 17:16:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616602610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TDc6obC9xxGB9aleYAOscRGaYtdO6g42dF2WqEr7Bb4=;
        b=aaTm+KYvi4nbkGUi+UW4/9Ws15lXkt+qbnNZUBYW44t+F+DBYgRNINmSmHda/en8XLQBh3
        vKMxZuaBPIvsLYeBz9k6zWVjmrB+5e72OLpb+IrkLbe0FItzndUxKZkrRuZEdkH8LCPK+H
        6M3kzo+OwRFYDK2tpC0Ue+Co6ih5+M8mw+QgsWesBhnU50xraMj5O9MyOtsambmXR15PED
        WPng98Ygq3jP2sabeY94HxKOi/KxXrio+DiOk4lu3ASmMFBqiIaE5HdTZ8rFrcpYvGatEW
        2SogUzKWa4uHXKRq/iPoXwg4Y2FsBr5kx3wxhyz14fzo7zIm2NIbGYgzV8eDgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616602610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TDc6obC9xxGB9aleYAOscRGaYtdO6g42dF2WqEr7Bb4=;
        b=o3tSY0gUSx3rxvWOi15hR6djayRJ2X1MXS3y3ME517NBobLdiT7r2zGFVLLD9gwg9NwaEZ
        Tay+ePqDYjLLw0DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] locking/rtmutex: Use correct define for debug
Message-ID: <20210324161649.7x25oyj44lelhgls@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no such thing like CONFIG_RT_MUTEX_DEBUG. The debugging code
for rtmutex is hidding behind CONFIG_DEBUG_RT_MUTEXES.

Use CONFIG_DEBUG_RT_MUTEXES for debugging.

Fixes: 3ac7d0ecf0e18 ("locking/rtmutex: Restrict the trylock WARN_ON() to debug")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index d584e32dae50a..56f1278150637 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1504,7 +1504,7 @@ int __sched rt_mutex_trylock(struct rt_mutex *lock)
 {
 	int ret;
 
-	if (IS_ENABLED(CONFIG_RT_MUTEX_DEBUG) && WARN_ON_ONCE(!in_task()))
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
 		return 0;
 
 	ret = rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock);
-- 
2.31.0


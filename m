Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6993ECB60
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhHOVdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhHOV36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DA4C0612AC
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:29:17 -0700 (PDT)
Message-ID: <20210815211305.581789253@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=J/Q5mp4iSoyn+xkjqqAPGiS328rpsMJOy9V5VRPg834=;
        b=HApkNWeRIDwTzPvXsNNppoYDJluJUnq8+3MaPY21LOPicGQt3xL6yjbiXqGXDIA0QDF2q+
        2GUIbZmzehc4rEVhXFhDFAiz5uwSSdTdAxnKqgpaxxUGakHwdS1bBAmTrWQUOGXthTSih8
        FSHZHdEXjbwTOgzcdSIZQMn1QZmW4EQTNqSS6MTQyMy1yvU/2sjz0S3kP7LRnTobPpWI0i
        3qHAILr5MHWFJe1zNicBRvGB5gsxvBpCXVZ4x4le9/BLzzHwkV1mUW98V69ydwbmRQLVyd
        q+ujuVKgGrlDU8sGEvWBT5gBHEjryciKXwzLFvBs3Hs749wc+xV20KRb7Zmn6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=J/Q5mp4iSoyn+xkjqqAPGiS328rpsMJOy9V5VRPg834=;
        b=Crub0IykubcSHjkk9ma0AJultDpIhzDOQQgl3dMsRtbl+ftiHpg+4uOVFIBtCRj0y6to61
        vUGXob5CT875r2DQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V5 64/72] futex: Reorder sanity checks in futex_requeue()
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:29:15 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point in allocating memory when the input parameters are bogus. Validate
all parameters before proceeding.

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
---
 kernel/futex.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1934,13 +1934,6 @@ static int futex_requeue(u32 __user *uad
 			return -EINVAL;
 
 		/*
-		 * requeue_pi requires a pi_state, try to allocate it now
-		 * without any locks in case it fails.
-		 */
-		if (refill_pi_state_cache())
-			return -ENOMEM;
-
-		/*
 		 * futex_requeue() allows the caller to define the number
 		 * of waiters to wake up via the @nr_wake argument. With
 		 * REQUEUE_PI waking up more than one waiter is creating
@@ -1963,6 +1956,13 @@ static int futex_requeue(u32 __user *uad
 		 */
 		if (nr_wake != 1)
 			return -EINVAL;
+
+		/*
+		 * requeue_pi requires a pi_state, try to allocate it now
+		 * without any locks in case it fails.
+		 */
+		if (refill_pi_state_cache())
+			return -ENOMEM;
 	}
 
 retry:


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A36B3F735B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbhHYKeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239869AbhHYKeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:34:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9EFC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:33:16 -0700 (PDT)
Message-ID: <20210825102454.042280541@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629887594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GVvis4akLVMW3ZSD/zhjeKWIwvsjbbWmIjnbB2XgVv4=;
        b=SP87J8EGHC2uCWYGee7rjz/ghkHXS6NURbEBkIvclf31vWZByq0u8e5f0hhYmsn+aRsyw6
        KHwjYio/ZxICKduARq9jdXiXezzbEQMVtzdGOjaUCXrbCx2AGyxf7Qtrq+Dv2jR76rj2+C
        D1Ze9uRluqkJT22Q1MZGYnYdFJCAxim9x1axwUFDmg7tUOLcdiCdIQyaRkoVP4uIGOjofQ
        3RZwtrIO9zyj1VGN73dOkIn2GsWVXxDfrEj4pe8tMrwhaD6XV0Ra9Z0adBZZ9ph7zrGoih
        x9OMdBoR8Oil6+Km7XAHPLWhuqLZkCrPXQGub5S8FVYlc+/YtVyq30fl75W9OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629887594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GVvis4akLVMW3ZSD/zhjeKWIwvsjbbWmIjnbB2XgVv4=;
        b=JQ+6BsTNFZEu41Nd1UOzLoGjyzAaPLECGWasn6ZloBnHESyvPeKqU2ex/+mJ0mSEg4KS9N
        WAl/KZm3FB8vW4DA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 2/2] locking/rtmutex: Dequeue waiter on ww_mutex deadlock
References: <20210825101857.420032248@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 25 Aug 2021 12:33:14 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt_mutex based ww_mutex variant queues the new waiter first in the
lock's rbtree before evaluating the ww_mutex specific conditions which
might decide that the waiter should back out. This check and conditional
exit happens before the waiter is enqueued into the PI chain.

The failure handling at the call site assumes that the waiter, if it is the
top most waiter on the lock, is queued in the PI chain and then proceeds to
adjust the unmodified PI chain, which results in RB tree corruption.

Dequeue the waiter from the lock waiter list in the ww_mutex error exit
path to prevent this.

Fixes: add461325ec5 ("locking/rtmutex: Extend the rtmutex core to support ww_mutex")
Reported-by: Sebastian Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1082,8 +1082,13 @@ static int __sched task_blocks_on_rt_mut
 		/* Check whether the waiter should back out immediately */
 		rtm = container_of(lock, struct rt_mutex, rtmutex);
 		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx);
-		if (res)
+		if (res) {
+			raw_spin_lock(&task->pi_lock);
+			rt_mutex_dequeue(lock, waiter);
+			task->pi_blocked_on = NULL;
+			raw_spin_unlock(&task->pi_lock);
 			return res;
+		}
 	}
 
 	if (!owner)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C08034AC2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhCZQCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:02:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhCZQBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:01:38 -0400
Message-Id: <20210326153943.754254046@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616774497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=erVQNMrM1P/5eIpWf0Wv6X7PSPbYJedxbQMK3vysrrw=;
        b=Eoi8aeP/pbkUdacxepueLzfoumZJ0Stob7QlX11CAFESOyTqYfXfEjNOyZEVAXfE9rt9jN
        VCCuQwSbx4RyAT6MluYoAFwL9clTtP5QvdsfT+S0K0Jao3Ug58RUa3EnUIjBYZvJe1l23Z
        t5VvTQXSINDsnHL2HM1xSgWskZ4rRx5tHZUxBBk3F9mJ5JJM+1zgtvtKiHjKU9V9X8na31
        Otih0uWBUfQVbugISrwVSP6DqPyuMPlfFOtC8/NyQgh7Rb3ze9m1FM2R2hFFqGKya+ZRrg
        /Eggqy3uhKIj9DmfF7qeOLTnTfHPguqNshQrG7Q/RBdHYwBqUA6XG9Tp9SwH/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616774497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=erVQNMrM1P/5eIpWf0Wv6X7PSPbYJedxbQMK3vysrrw=;
        b=FvUiji7LckFbB8WvtOeI5HGv6RBkboc+lRyyCdzgfuIANOJ/IFD9f2IA8EMgL3w8S0wcQU
        L80GAjZg5SKAU9Ag==
Date:   Fri, 26 Mar 2021 16:29:36 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 07/15] locking/rtmutex: Inline chainwalk depth check
References: <20210326152929.709289883@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point for this wrapper at all.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -343,14 +343,9 @@ static void rt_mutex_adjust_prio(struct
 static bool rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
 					  enum rtmutex_chainwalk chwalk)
 {
-	/*
-	 * This is just a wrapper function for the following call,
-	 * because debug_rt_mutex_detect_deadlock() smells like a magic
-	 * debug feature and I wanted to keep the cond function in the
-	 * main source file along with the comments instead of having
-	 * two of the same in the headers.
-	 */
-	return debug_rt_mutex_detect_deadlock(waiter, chwalk);
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEX))
+		return waiter != NULL;
+	return chwalk == RT_MUTEX_FULL_CHAINWALK;
 }
 
 /*


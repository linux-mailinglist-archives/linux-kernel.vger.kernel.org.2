Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884833E90E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhHKM0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:26:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50274 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238292AbhHKMYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:24:02 -0400
Message-ID: <20210811121417.417875300@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dIDJMNRwhT3cmHlH64KgwOQfGpxXmECFG6+jpah8Ozg=;
        b=KVFJ/Va1+AIlKEtlY/rDiRlin47pGxUE5ekWRZMy/9anGTWcMiyDwSaUyBb0hFGwX0W7bM
        cso4NX9nSBZtbpDwVUq158w8ZWH+ab+Eurhb/RF2xT7mYxvWhnGJk1zheZa+KLt1O0jaRb
        sx9ZUdjJ5TwjE6XrZ0DNuriOtY7zR3oRFmJTV/jFQzEGae63k1zcqwR/QWHraDnmWFNF+a
        IwySzo0HYZRAd8yZwjijfrLk4D6J6As6a+W8pm3BDCIGXxxhvWp3aOB7FGATIBWcFY6zFa
        LN+S5q1FIRWd5biYlJqnwLrTPNaNAxyNNbLQsR7TfGC2oOCuNk4Kiq0QP+bTVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dIDJMNRwhT3cmHlH64KgwOQfGpxXmECFG6+jpah8Ozg=;
        b=NwELPFklSH4w12SEMJ1CIYj2qNM6VkzJFGcP8INb9T+FUV/a32ZW7NeF2bNZ9zyURxCrHg
        OjGbVcUfAcYWxCBw==
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
Subject: [patch V4 55/68] futex: Validate waiter correctly in
 futex_proxy_trylock_atomic()
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:38 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The loop in futex_requeue() has a sanity check for the waiter which is
missing in futex_proxy_trylock_atomic(). In theory the key2 check is
sufficient, but futexes are cursed so add it for completeness and paranoia
sake.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |    7 +++++++
 1 file changed, 7 insertions(+)
---
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1879,6 +1879,13 @@ futex_proxy_trylock_atomic(u32 __user *p
 	if (!top_waiter)
 		return 0;
 
+	/*
+	 * Ensure that this is a waiter sitting in futex_wait_requeue_pi()
+	 * and waiting on the 'waitqueue' futex which is always !PI.
+	 */
+	if (!top_waiter->rt_waiter || top_waiter->pi_state)
+		ret = -EINVAL;
+
 	/* Ensure we requeue to the expected futex. */
 	if (!match_futex(top_waiter->requeue_pi_key, key2))
 		return -EINVAL;


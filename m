Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BC43E1887
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhHEPqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:46:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43854 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbhHEPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:43 -0400
Message-ID: <20210805153955.941393026@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dIDJMNRwhT3cmHlH64KgwOQfGpxXmECFG6+jpah8Ozg=;
        b=ZAlSu7+1AG8NlHN/sn7GiiU23uZxe/AvzBaehXkyExcJs9umeRkf4jkszEIr0irhNNedSF
        N+HBMGHGT69ZeY3HRKhxffMNrXqcwGyDplj8PGJ5KkouEeCqy3YXDGLxXPEf5N+PDnF4Xo
        PnP44JXay0/SsvIcD9GXnZBJrTyQzP83J4Fq3hHPJEyqfpM2p71kwYdCfwMvZeNvf3+dZs
        cu0RAlV/EHd+kwB2akwev1oi+fI1GKWNWSwzOkLxI0xyCII+tSJcjDcQknTKVfTCo9Il4+
        8tibW+DH0kTizodNQGEspRQ7YckIRFRwN/m2zVgdg5ZU65Oj4pxrbAkDTpJipA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dIDJMNRwhT3cmHlH64KgwOQfGpxXmECFG6+jpah8Ozg=;
        b=h4Owvr4GjI5FEV52uH0Y74XwBo7Op1oQU4k5T2L5kdGFPj4H/YsWNpk63EkpTz+9rsSUor
        AGI8z4DR6AEf3YDA==
Date:   Thu, 05 Aug 2021 17:13:54 +0200
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
Subject: [patch V3 54/64] futex: Validate waiter correctly in
 futex_proxy_trylock_atomic()
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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


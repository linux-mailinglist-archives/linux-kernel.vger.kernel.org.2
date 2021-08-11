Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D714A3E90E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbhHKM0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:26:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50310 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbhHKMYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:24:11 -0400
Message-ID: <20210811121417.833987783@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=J/Q5mp4iSoyn+xkjqqAPGiS328rpsMJOy9V5VRPg834=;
        b=YbWq8M8e6mURNf9kBScYSoCHRusuPBlCL+ZIQWxJQ2AGaf7Z/ZaowRxohcEvYwFUxsct8D
        pau6xDXdZl12sCyr5m1MrgTMFsT51wTANT9mtHn2QfN2NXTbHrFCDkKDMMK5Q/JLik5ajN
        0x9ejy0UqelZUYxc8L2/e5I0kU6vS0+VNcHJUdQPFVqskiT3nQDTsN0B3Jfxsx2o63Ay+D
        utlpVah3q35L6ASEFGgf6D3+eoMBUerk0tc77d5sSj9NsnIKdjCQUpH0/H6qBvbUcfo2vA
        H2SaFREnwkgOJAf75zlKE5txuHHmX/uG3VfyGaDqiiYmAV86ysnlmcZCBOwd4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=J/Q5mp4iSoyn+xkjqqAPGiS328rpsMJOy9V5VRPg834=;
        b=o6gzxAqGgdoXFqKffxQQ+CT7thVxVwa6zPwlJjdfvIAeISjqTF9Q4AW4Gz8LeT4CJTBlTG
        tQxJqNSecnQP7SAg==
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
Subject: [patch V4 62/68] futex: Reorder sanity checks in futex_requeue()
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:47 +0200 (CEST)
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


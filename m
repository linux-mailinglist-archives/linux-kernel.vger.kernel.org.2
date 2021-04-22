Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D833680AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhDVMkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbhDVMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:38:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0815C06138F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YLpTeBkr9QHTanWJ3WqNByjPgXazLIzEzgYU9DG5kO8=; b=dJVSmkdc+cXLjH/6haR6cOf5lq
        2YQ/5Lh7CjtAWh9OZ8IKfky0aY7gncXtXRHEbHNOcmoHANHWwam4G6AdUBksIbFBAFo92OABp3XTy
        OXpjR2cAhDDrq/P/eKAnrxGJZo+DxNG7gU5H8j78nt1dBfHvs8OkMz3ZLoVSVVMj/K7IQitgCF0cK
        gQf1QmH6CZJmCgn6qNrYZur2ushe8snppi9gllYo/qpsOGlTTqqR/Pdb10hLUmpbxMGHCMVyZ5WEg
        3HxJ38hLM+JUqKWu79u0qMJJYYnu4z5reyplIkVL32W1fhQ9AEzqrN9YbDPvssfe25getPKuw1eYN
        plFEMWlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYZ2-00GiYw-Mp; Thu, 22 Apr 2021 12:38:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C87C30030E;
        Thu, 22 Apr 2021 14:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3FAD32C679688; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.377455632@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH 07/19] sched: Allow sched_core_put() from atomic context
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stuff the meat of sched_core_put() into a work such that we can use
sched_core_put() from atomic context.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -102,7 +102,7 @@ DEFINE_STATIC_KEY_FALSE(__sched_core_ena
  */
 
 static DEFINE_MUTEX(sched_core_mutex);
-static int sched_core_count;
+static atomic_t sched_core_count;
 static struct cpumask sched_core_mask;
 
 static void __sched_core_flip(bool enabled)
@@ -165,18 +165,39 @@ static void __sched_core_disable(void)
 
 void sched_core_get(void)
 {
+	if (atomic_inc_not_zero(&sched_core_count))
+		return;
+
 	mutex_lock(&sched_core_mutex);
-	if (!sched_core_count++)
+	if (!atomic_read(&sched_core_count))
 		__sched_core_enable();
+
+	smp_mb__before_atomic();
+	atomic_inc(&sched_core_count);
 	mutex_unlock(&sched_core_mutex);
 }
 
-void sched_core_put(void)
+static void __sched_core_put(struct work_struct *work)
 {
-	mutex_lock(&sched_core_mutex);
-	if (!--sched_core_count)
+	if (atomic_dec_and_mutex_lock(&sched_core_count, &sched_core_mutex)) {
 		__sched_core_disable();
-	mutex_unlock(&sched_core_mutex);
+		mutex_unlock(&sched_core_mutex);
+	}
+}
+
+void sched_core_put(void)
+{
+	static DECLARE_WORK(_work, __sched_core_put);
+
+	/*
+	 * "There can be only one"
+	 *
+	 * Either this is the last one, or we don't actually need to do any
+	 * 'work'. If it is the last *again*, we rely on
+	 * WORK_STRUCT_PENDING_BIT.
+	 */
+	if (!atomic_add_unless(&sched_core_count, -1, 1))
+		schedule_work(&_work);
 }
 
 #endif /* CONFIG_SCHED_CORE */



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9E35190A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhDARtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbhDARj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:39:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920F8C08EC3A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=bSkpn8YwppbBu1+bjtC3/BWjfwf24YsnpFTDiWEk1II=; b=OEGV5xNTo9hq/P6PuJ0zc6SxmL
        Tg5HDP0xwfrAHv40muhsz08J0eXlfwM8LahcMmtITqCMbP/o09hyi2sFk7DIk0DoWPZmaesNLB0wt
        hEV8giTa0sOpUeW4K/bQXDMW2FRi8spKngaPkBrCaYfbIU4mtlLket6QEfCvMgIVZScCKXgopjJeK
        tt7Ok7o8FKZ3iCmSn8tK/RJRfDSi7uW7SEGCBdqTaCWMcfMdc2+TGlRAZ2NHMktrXxAWkbnRpZvXp
        Ds29s8AW+sbqKXD+7RGzH+ihFZxUCOQAFOkho8K6/din0yGwZyMTthlOFMXnGwNt1EcF3cCWk3kQu
        SsFei4fQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRxag-009isd-Py; Thu, 01 Apr 2021 13:44:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26356307005;
        Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C4BEF20CBFFF6; Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Message-ID: <20210401133917.111845286@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 01 Apr 2021 15:10:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        tglx@linutronix.de
Subject: [PATCH 1/9] sched: Allow sched_core_put() from atomic context
References: <20210401131012.395311786@infradead.org>
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
@@ -223,7 +223,7 @@ static struct task_struct *sched_core_ne
  */
 
 static DEFINE_MUTEX(sched_core_mutex);
-static int sched_core_count;
+static atomic_t sched_core_count;
 static struct cpumask sched_core_mask;
 
 static void __sched_core_flip(bool enabled)
@@ -286,18 +286,39 @@ static void __sched_core_disable(void)
 
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
+	 * "There can only be one"
+	 *
+	 * Either this is the last one, or we don't actually need to do any
+	 * 'work'. If it is the last *again*, we rely on
+	 * WORK_STRUCT_PENDING_BIT.
+	 */
+	if (!atomic_add_unless(&sched_core_count, -1, 1))
+		schedule_work(&_work);
 }
 
 #else /* !CONFIG_SCHED_CORE */



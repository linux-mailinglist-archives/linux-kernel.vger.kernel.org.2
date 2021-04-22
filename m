Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B159368095
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhDVMhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbhDVMhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:37:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F301BC06138D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=gEk+g2UL2lnDKtrMFI+Rnh3Mlniub12leOr0EemlOgg=; b=qOl2GgYS3kPewvHKt5CxYBqFgv
        65U7ubyUfrfL71dGoehK6ypXQ0M3VbncK+WHyfZEve5auI3s0EgM2d6HWln4YbvVHUBr6Hkpftsbw
        81q1mLw/2UFpF3vkVdqwh50vEAXBv5hTrAU9xPbXNhCSuvZgoLueaJMvaMuVAQR0dMmQB8jt0Q7ey
        WWAnPbKWldY5lYrpZfJBNm2usOh2EZFSeboGdyaGgHEX39foACT8udqefHArkebUHT4M7QIm/P3Xg
        zXF/kRfltd9srhdQOQbybYJr2WqzeDCsXxLituYrs2nsjnjrx/NLcPx0kO/d/0KT9pGasyZTap19u
        SpCjDdXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYYF-000I90-AQ; Thu, 22 Apr 2021 12:35:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6EE1D3002CA;
        Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 28B022122BE8C; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.015639083@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH 01/19] sched/fair: Add a few assertions
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6246,6 +6246,11 @@ static int select_idle_sibling(struct ta
 		task_util = uclamp_task_util(p);
 	}
 
+	/*
+	 * per-cpu select_idle_mask usage
+	 */
+	lockdep_assert_irqs_disabled();
+
 	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
 	    asym_fits_capacity(task_util, target))
 		return target;
@@ -6711,8 +6716,6 @@ static int find_energy_efficient_cpu(str
  * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
  *
  * Returns the target CPU number.
- *
- * preempt must be disabled.
  */
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
@@ -6725,6 +6728,10 @@ select_task_rq_fair(struct task_struct *
 	/* SD_flags and WF_flags share the first nibble */
 	int sd_flag = wake_flags & 0xF;
 
+	/*
+	 * required for stable ->cpus_allowed
+	 */
+	lockdep_assert_held(&p->pi_lock);
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 



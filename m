Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABFE38CA78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhEUP6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbhEUP57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:57:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E356BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:56:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t21so11223180plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zztYf9XfUtWeHWTD7m+lPtPVQ8eesduNWWwZRn0fOIk=;
        b=YpnlMvhTixMEKNQmLIrp0kUAvB7zDOf2Cr03hYy+nVVvDKLhltgpyoQOXO95OMfWAf
         mM/CQ+CSNkIuCpKyFtInMlflMHnnubXQi1C0dqdp0/ps9ZVNIOvtnlOF7pcMWxM2AJGh
         PGWkRdCwuhwv2FG4A3kDJJUboRy6J/o0+yVGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zztYf9XfUtWeHWTD7m+lPtPVQ8eesduNWWwZRn0fOIk=;
        b=nUCkHKwYQdLZlmkizBPWWnfoapz8Zr5JQ3jx0/v6SYQ3Y0SDdpYQ3AZRnoEAO4yCKE
         TPo+dW/GZ8VVdO+DgvgZL67xCUQCZdidHjbkRj77BwtqQwmS4JCqi1eKLZAD3Ksxh78g
         p9upyWOCtkMkOL6VuE7QuSSo/bUFIRIikJgGqJgsLVWWCplIIAyZPVGf7+EnjHOsrzRM
         gKbtMZPdSlJXUfa7Dq09ZaNZCnhwQi+yqg8bp5E/Vknz4Mcbt19IfzC2/4VV5m6QBBAL
         mFJmK7hADCfU1cK4A3joGJq/6OP52HcDiHYp7a2dKdXkKQW4owN0yPJiRrRTmT+XdF8m
         SBPg==
X-Gm-Message-State: AOAM531oLIqGUMtwLtr1zew83kI29sl91H45bm40r5N3YWBiD4pNHF4w
        kdRo7IGVuURzWc3fjyvWlDRRNQ==
X-Google-Smtp-Source: ABdhPJzKNratLuKlzZwSfhaXM+6qpl4oSpPYq9X5BJeYu2n6luBLNPfoZyCGCn1RRas0m2ACANyCAA==
X-Received: by 2002:a17:90a:514e:: with SMTP id k14mr11463634pjm.72.1621612593494;
        Fri, 21 May 2021 08:56:33 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:245d:3890:fa95:996e])
        by smtp.gmail.com with ESMTPSA id k15sm4767123pfi.0.2021.05.21.08.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:56:32 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 1/2] rcu/tree: handle VM stoppage in stall detection
Date:   Sat, 22 May 2021 00:56:23 +0900
Message-Id: <20210521155624.174524-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soft watchdog timer function checks if a virtual machine
was suspended and hence what looks like a lockup in fact
is a false positive.

This is what kvm_check_and_clear_guest_paused() does: it
tests guest PVCLOCK_GUEST_STOPPED (which is set by the host)
and if it's set then we need to touch all watchdogs and bail
out.

Watchdog timer function runs from IRQ, so PVCLOCK_GUEST_STOPPED
check works fine.

There is, however, one more watchdog that runs from IRQ, so
watchdog timer fn races with it, and that watchdog is not aware
of PVCLOCK_GUEST_STOPPED - RCU stall detector.

apic_timer_interrupt()
 smp_apic_timer_interrupt()
  hrtimer_interrupt()
   __hrtimer_run_queues()
    tick_sched_timer()
     tick_sched_handle()
      update_process_times()
       rcu_sched_clock_irq()

This triggers RCU stalls on our devices during VM resume.

If tick_sched_handle()->rcu_sched_clock_irq() runs on a VCPU
before watchdog_timer_fn()->kvm_check_and_clear_guest_paused()
then there is nothing on this VCPU that touches watchdogs and
RCU reads stale gp stall timestamp and new jiffies value, which
makes it think that RCU has stalled.

Make RCU stall watchdog aware of PVCLOCK_GUEST_STOPPED and
don't report RCU stalls when we resume the VM.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---

v2: fixed powerpc build breakage

 kernel/rcu/tree_stall.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d574e3bbd929..bc689911a81d 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -7,6 +7,8 @@
  * Author: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <linux/kvm_para.h>
+
 //////////////////////////////////////////////////////////////////////////////
 //
 // Controlling CPU stall warnings, including delay calculation.
@@ -698,6 +700,14 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
 	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
+		/*
+		 * If a virtual machine is stopped by the host it can look to
+		 * the watchdog like an RCU stall. Check to see if the host
+		 * stopped the vm.
+		 */
+		if (kvm_check_and_clear_guest_paused())
+			return;
+
 		/* We haven't checked in, so go dump stack. */
 		print_cpu_stall(gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
@@ -707,6 +717,14 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
 		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
+		/*
+		 * If a virtual machine is stopped by the host it can look to
+		 * the watchdog like an RCU stall. Check to see if the host
+		 * stopped the vm.
+		 */
+		if (kvm_check_and_clear_guest_paused())
+			return;
+
 		/* They had a few time units to dump stack, so complain. */
 		print_other_cpu_stall(gs2, gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
-- 
2.31.1.818.g46aad6cb9e-goog


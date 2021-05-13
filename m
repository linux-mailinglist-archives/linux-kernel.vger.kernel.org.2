Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1B37F3F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhEMIVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhEMIVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:21:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0633CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U3AtK357XhQlF95ANJynYFxOAFG/7/0spRwmZLPK/sk=; b=Fg92kioqpMDqSIMchG0+GGR1wY
        bM9mIR1c0wLY7gmewlqRLSrwW7DkBd5YT9oPfofKB58sYv+Plp3vcaUloFMg4DWbyvEAxoCRNAwuN
        bfF2r051/LjmOLAihpHzkgLnLS6PmcJBmNneOn/OPWnANPY4BLM+piF96WAybj5zlzRLbyIznBAn3
        KgyLLyqtWxV8YibzLzeRvkPqJm0Xr3o4ITtQjmZgoihN9ydf9BN2SBuDWHKluaTzxlg9shRi/bwTv
        lrjI+iUPiFJIlCHg+hPyBnAPAjhdKSLqVMwVBGRb3uQtJD81ofVaSE5C3UNWIDczGrWVRCoJiUh80
        IHopR7eA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lh6Z1-009GSP-ET; Thu, 13 May 2021 08:19:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C65130001C;
        Thu, 13 May 2021 10:19:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A15692C2FC6F9; Thu, 13 May 2021 10:19:21 +0200 (CEST)
Date:   Thu, 13 May 2021 10:19:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, Paul McKenney <paulmck@kernel.org>
Subject: Re: [entry]  47b8ff194c:  will-it-scale.per_process_ops -3.0%
 regression
Message-ID: <YJzhCX/CqrMQDB+y@hirez.programming.kicks-ass.net>
References: <20210428071653.GC13086@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428071653.GC13086@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 03:16:53PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -3.0% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: 47b8ff194c1fd73d58dc339b597d466fe48c8958 ("entry: Explicitly flush pending rcuog wakeup before last rescheduling point")

So the RCU bits are in rcu_user_enter(), which is called from
__context_tracking_enter() aka user_enter(), which is under
context_tracking_enabled().

But the new code in entry is not; we now unconditionally call
rcu_nocb_flush_deferred_wakeup(). Did that want to be under
context_tracking_enabled() as well?

Frederic, Paul?

---

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 9455476c5ba2..f4df001410fc 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -114,7 +114,12 @@ static inline void rcu_user_exit(void) { }
 void rcu_init_nohz(void);
 int rcu_nocb_cpu_offload(int cpu);
 int rcu_nocb_cpu_deoffload(int cpu);
-void rcu_nocb_flush_deferred_wakeup(void);
+void __rcu_nocb_flush_deferred_wakeup(void);
+static inline void rcu_nocb_flush_deferred_wakeup(void)
+{
+	if (context_tracking_enabled())
+		__rcu_nocb_flush_deferred_wakeup();
+}
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 static inline void rcu_init_nohz(void) { }
 static inline int rcu_nocb_cpu_offload(int cpu) { return -EINVAL; }
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ad0156b86937..3cdbbf7fba01 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2378,7 +2378,7 @@ static bool do_nocb_deferred_wakeup(struct rcu_data *rdp)
 	return false;
 }
 
-void rcu_nocb_flush_deferred_wakeup(void)
+void __rcu_nocb_flush_deferred_wakeup(void)
 {
 	do_nocb_deferred_wakeup(this_cpu_ptr(&rcu_data));
 }


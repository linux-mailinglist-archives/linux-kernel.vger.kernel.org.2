Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B333E3F9EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhH0Sfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 14:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhH0Sfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:35:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3A7060F6C;
        Fri, 27 Aug 2021 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630089295;
        bh=QfNxQf7D3r2igmpkWhorAtoddkMjfE4vmt4ob92VG6I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AqtEVRlqlQwipDmKo8YghAQIJ8pN1f3ATiLe9Uzw8To6FVzzc8JFj0AzfNK1sqVOZ
         CNJTRWceuzb6b1UdHHGJlLy8L7MsIdaZPb3JsinJExmbe8+uw+XcjG/XwRWlUZ6dZW
         DJjhMWQDivNxRQ7rLaKENx5NYKV/DQRfTzAWVDbPyaKUBX/d/rdZ44of0JSwtEIHvc
         zPioakU8TFekSrTFKFYpToW7HS4mGqhEdHEblOIN09/1YX7slLwjBYVGfnEIXE+zbk
         hqJkOxiHS1UbegG121oK0/Vp+yTDvD27jIsWbsgI7oHpvLtgeSUKhkVd6+HXmQw3fP
         tW9gzv+2478Iw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ADA975C059E; Fri, 27 Aug 2021 11:34:55 -0700 (PDT)
Date:   Fri, 27 Aug 2021 11:34:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        andrii@kernel.org
Subject: Re: [PATCH] rcu: Avoid unneeded function call in rcu_read_unlock()
Message-ID: <20210827183455.GP4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210827022122.15816-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827022122.15816-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 10:21:22PM -0400, Waiman Long wrote:
> Since commit aa40c138cc8f3 ("rcu: Report QS for outermost
> PREEMPT=n rcu_read_unlock() for strict GPs"). A real function call
> rcu_read_unlock_strict() is added to the inlined rcu_read_unlock().
> The rcu_read_unlock_strict() call is only needed if the performance
> sagging CONFIG_RCU_STRICT_GRACE_PERIOD option is set. This config
> option isn't set for most production kernels while the function call
> overhead remains.
> 
> To provide a slight performance improvement, the
> CONFIG_RCU_STRICT_GRACE_PERIOD config check is moved from
> rcu_read_unlock_strict() to __rcu_read_unlock() so that the function
> call can be compiled out in most cases.
> 
> Besides, the GPL exported rcu_read_unlock_strict() also impact the
> the compilation of non-GPL kernel modules as rcu_read_unlock() is a
> frequently used kernel API.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Nice, and good eyes!!!

I have queued this for v5.16, that is, not the upcoming merge window
but the one after that.

I did my usual wordsmithing, so please check the following in case I
messed something up.  I intentionally omitted the EXPORT_SYMBOL_GPL()
discussion because:

1.	Kernels built with CONFIG_PREEMPT=y have the same issue
	with the __rcu_read_lock() and __rcu_read_unlock() functions.

2.	Many other RCU functions are EXPORT_SYMBOL_GPL() and have
	been for almost two decades.

But if someone does use RCU readers within CONFIG_PREEMPT=n kernels from
a binary module, I will happily refer them to you for any RCU issues
that they encounter.  ;-)

I am also CCing the BPF guys in case my interpretation of the code in
the BPF verifier is incorrect.

							Thanx, Paul

------------------------------------------------------------------------

commit 4a9f53b997b809c0256838e31c604aeeded2345a
Author: Waiman Long <longman@redhat.com>
Date:   Thu Aug 26 22:21:22 2021 -0400

    rcu: Avoid unneeded function call in rcu_read_unlock()
    
    Since commit aa40c138cc8f3 ("rcu: Report QS for outermost PREEMPT=n
    rcu_read_unlock() for strict GPs") the function rcu_read_unlock_strict()
    is invoked by the inlined rcu_read_unlock() function.  However,
    rcu_read_unlock_strict() is an empty function in production kernels,
    which are built with CONFIG_RCU_STRICT_GRACE_PERIOD=n.
    
    There is a mention of rcu_read_unlock_strict() in the BPF verifier,
    but this is in a deny-list, meaning that BPF does not care whether
    rcu_read_unlock_strict() is ever called.
    
    This commit therefore provides a slight performance improvement
    by hoisting the check of CONFIG_RCU_STRICT_GRACE_PERIOD from
    rcu_read_unlock_strict() into rcu_read_unlock(), thus avoiding the
    pointless call to an empty function.
    
    Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
    Cc: Andrii Nakryiko <andrii@kernel.org>
    Signed-off-by: Waiman Long <longman@redhat.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 434d12fe2d4f..5e0beb5c5659 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -71,7 +71,8 @@ static inline void __rcu_read_lock(void)
 static inline void __rcu_read_unlock(void)
 {
 	preempt_enable();
-	rcu_read_unlock_strict();
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		rcu_read_unlock_strict();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7a4876a3a882..0b55c647ab80 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -814,8 +814,7 @@ void rcu_read_unlock_strict(void)
 {
 	struct rcu_data *rdp;
 
-	if (!IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
-	   irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
 		return;
 	rdp = this_cpu_ptr(&rcu_data);
 	rcu_report_qs_rdp(rdp);

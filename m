Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1A338067B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhENJtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhENJtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:49:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57723C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DT6QaNJpkkcD2IyqqcKUlsxcPI0O3ZT4y/+lE15xu+A=; b=BjQvTKpXuKfuy5wXhHWv6vlQSd
        mMfa5gbJB50BC+AJjKMPThBi4KnnYTG3YP+tWq1dtd33Jy/8z2X34LedQ0cSqvfslbxn9AewjXEjJ
        iyBOPCUoEq2CM0hxs7OkCwlFGRDV7fJGLPR/jejqaYqsQ8KKEMCLsxYDtZNhXqNqnNrAxEjjLlmlO
        XhtybRmX8Pha7hdnrQ1F6dxmjBadf02MeMR/nqE5b0+PXfUwnsMBIbTVM3MSeWkNQmC1ZApLgi4Ng
        tM5JDvdYmHPa12i/FLiLHonfsNfO+VeihCEi3wASEn2QUkTsAEp6tisRp3gffakIdV2avIYdCMh2H
        ZtsIYxew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhUQ9-007gK9-0h; Fri, 14 May 2021 09:47:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C12FA30022A;
        Fri, 14 May 2021 11:47:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BBAD20829FB9; Fri, 14 May 2021 11:47:45 +0200 (CEST)
Date:   Fri, 14 May 2021 11:47:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 5/6] sched/fair: Consider SMT in ASYM_PACKING load
 balance
Message-ID: <YJ5HQR943rSFsLxw@hirez.programming.kicks-ass.net>
References: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
 <20210513154909.6385-6-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513154909.6385-6-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 08:49:08AM -0700, Ricardo Neri wrote:
>  include/linux/sched/topology.h |   1 +
>  kernel/sched/fair.c            | 101 +++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 8f0f778b7c91..43bdb8b1e1df 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -57,6 +57,7 @@ static inline int cpu_numa_flags(void)
>  #endif
>  
>  extern int arch_asym_cpu_priority(int cpu);
> +extern bool arch_asym_check_smt_siblings(void);
>  
>  struct sched_domain_attr {
>  	int relax_domain_level;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c8b66a5d593e..3d6cc027e6e6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -106,6 +106,15 @@ int __weak arch_asym_cpu_priority(int cpu)
>  	return -cpu;
>  }
>  
> +/*
> + * For asym packing, first check the state of SMT siblings before deciding to
> + * pull tasks.
> + */
> +bool __weak arch_asym_check_smt_siblings(void)
> +{
> +	return false;
> +}
> +
>  /*
>   * The margin used when comparing utilization with CPU capacity.
>   *

> @@ -8458,6 +8550,9 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
>  	if (group == sds->local)
>  		return false;
>  
> +	if (arch_asym_check_smt_siblings())
> +		return asym_can_pull_tasks(env->dst_cpu, sds, sgs, group);
> +
>  	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
>  }

So I'm thinking that this is a property of having ASYM_PACKING at a core
level, rather than some arch special. Wouldn't something like this be
more appropriate?

---
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -57,7 +57,6 @@ static inline int cpu_numa_flags(void)
 #endif
 
 extern int arch_asym_cpu_priority(int cpu);
-extern bool arch_asym_check_smt_siblings(void);
 
 struct sched_domain_attr {
 	int relax_domain_level;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -107,15 +107,6 @@ int __weak arch_asym_cpu_priority(int cp
 }
 
 /*
- * For asym packing, first check the state of SMT siblings before deciding to
- * pull tasks.
- */
-bool __weak arch_asym_check_smt_siblings(void)
-{
-	return false;
-}
-
-/*
  * The margin used when comparing utilization with CPU capacity.
  *
  * (default: ~20%)
@@ -8550,7 +8541,8 @@ sched_asym(struct lb_env *env, struct sd
 	if (group == sds->local)
 		return false;
 
-	if (arch_asym_check_smt_siblings())
+	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
+	    (group->flags & SD_SHARE_CPUCAPACITY))
 		return asym_can_pull_tasks(env->dst_cpu, sds, sgs, group);
 
 	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);

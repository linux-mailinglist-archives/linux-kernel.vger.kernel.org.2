Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E783358A0D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhDHQrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhDHQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:47:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A026AC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 09:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r3GNHaQcGzrzJ0AcJjhjBhTwrIPdz5ehsPGm72g73u4=; b=uQe/C2U7b5GKuCQW1Sywx4DPZ9
        y1NAWYalkoOBWWVvz1GbgJQryh8uxOqZdmAsbxWg++2nRWBSUc4V1R+dSeCIOYTinnICLH2wiPLkL
        FQ9uMQ/FfweTqg5BqSTlKh8Q2/Qd9bAa6mpvd7HxcOBV7uqqnbfiPMXAA2oWgGI02RLRKKNEKbYbc
        +nQn1LJkDUoBmZpAspLsWNjk5Efrv2yKndZLMjPzkBrNJjLGhC6roAOJCVVFRr4prrPZNBnvVnOrd
        UoI84k/gofVjOfTV4PJ+uqemZuXeW71OjsNppFia3G741ZRs3QHrAW6I9WQDo7rDZr3fUI6v76RDU
        PBhpvUoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXna-00GXc5-Rv; Thu, 08 Apr 2021 16:46:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1E01300103;
        Thu,  8 Apr 2021 18:46:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DDEE2BD0DAEF; Thu,  8 Apr 2021 16:22:35 +0200 (CEST)
Date:   Thu, 8 Apr 2021 16:22:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ricardo.neri-calderon@linux.intel.com
Subject: Re: [PATCH V5 08/25] perf/x86: Hybrid PMU support for hardware cache
 event
Message-ID: <YG8RqwmmE8YBe5uS@hirez.programming.kicks-ass.net>
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
 <1617635467-181510-9-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617635467-181510-9-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 08:10:50AM -0700, kan.liang@linux.intel.com wrote:
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 0bd9554..d71ca69 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -356,6 +356,7 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
>  {
>  	struct perf_event_attr *attr = &event->attr;
>  	unsigned int cache_type, cache_op, cache_result;
> +	struct x86_hybrid_pmu *pmu = is_hybrid() ? hybrid_pmu(event->pmu) : NULL;
>  	u64 config, val;
>  
>  	config = attr->config;
> @@ -375,7 +376,10 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
>  		return -EINVAL;
>  	cache_result = array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RESULT_MAX);
>  
> -	val = hw_cache_event_ids[cache_type][cache_op][cache_result];
> +	if (pmu)
> +		val = pmu->hw_cache_event_ids[cache_type][cache_op][cache_result];
> +	else
> +		val = hw_cache_event_ids[cache_type][cache_op][cache_result];
>  
>  	if (val == 0)
>  		return -ENOENT;
> @@ -384,7 +388,10 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
>  		return -EINVAL;
>  
>  	hwc->config |= val;
> -	attr->config1 = hw_cache_extra_regs[cache_type][cache_op][cache_result];
> +	if (pmu)
> +		attr->config1 = pmu->hw_cache_extra_regs[cache_type][cache_op][cache_result];
> +	else
> +		attr->config1 = hw_cache_extra_regs[cache_type][cache_op][cache_result];
>  	return x86_pmu_extra_regs(val, event);
>  }

So I'm still bugged by this, and you have the same pattern for
unconstrained, plus that other issue you couldn't use hybrid() for.

How's something like this on top?

---
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -356,7 +356,6 @@ set_ext_hw_attr(struct hw_perf_event *hw
 {
 	struct perf_event_attr *attr = &event->attr;
 	unsigned int cache_type, cache_op, cache_result;
-	struct x86_hybrid_pmu *pmu = is_hybrid() ? hybrid_pmu(event->pmu) : NULL;
 	u64 config, val;
 
 	config = attr->config;
@@ -376,11 +375,7 @@ set_ext_hw_attr(struct hw_perf_event *hw
 		return -EINVAL;
 	cache_result = array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RESULT_MAX);
 
-	if (pmu)
-		val = pmu->hw_cache_event_ids[cache_type][cache_op][cache_result];
-	else
-		val = hw_cache_event_ids[cache_type][cache_op][cache_result];
-
+	val = hybrid_var(event->pmu, hw_cache_event_ids)[cache_type][cache_op][cache_result];
 	if (val == 0)
 		return -ENOENT;
 
@@ -388,10 +383,8 @@ set_ext_hw_attr(struct hw_perf_event *hw
 		return -EINVAL;
 
 	hwc->config |= val;
-	if (pmu)
-		attr->config1 = pmu->hw_cache_extra_regs[cache_type][cache_op][cache_result];
-	else
-		attr->config1 = hw_cache_extra_regs[cache_type][cache_op][cache_result];
+	attr->config1 = hybrid_var(event->pmu, hw_cache_extra_regs)[cache_type][cache_op][cache_result];
+
 	return x86_pmu_extra_regs(val, event);
 }
 
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -660,14 +660,24 @@ static __always_inline struct x86_hybrid
 #define is_hybrid()			(!!x86_pmu.num_hybrid_pmus)
 
 #define hybrid(_pmu, _field)				\
-({							\
-	typeof(x86_pmu._field) __F = x86_pmu._field;	\
+(*({							\
+	typeof(&x86_pmu._field) __Fp = &x86_pmu._field;	\
 							\
 	if (is_hybrid() && (_pmu))			\
-		__F = hybrid_pmu(_pmu)->_field;		\
+		__Fp = &hybrid_pmu(_pmu)->_field;	\
 							\
-	__F;						\
-})
+	__Fp;						\
+}))
+
+#define hybrid_var(_pmu, _var)				\
+(*({							\
+	typeof(&_var) __Fp = &_var;			\
+							\
+	if (is_hybrid() && (_pmu))			\
+		__Fp = &hybrid_pmu(_pmu)->_var;		\
+							\
+	__Fp;						\
+}))
 
 /*
  * struct x86_pmu - generic x86 pmu
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3147,10 +3147,7 @@ x86_get_event_constraints(struct cpu_hw_
 		}
 	}
 
-	if (!is_hybrid() || !cpuc->pmu)
-		return &unconstrained;
-
-	return &hybrid_pmu(cpuc->pmu)->unconstrained;
+	return &hybrid_var(cpuc->pmu, unconstrained);
 }
 
 static struct event_constraint *
@@ -3656,10 +3653,7 @@ static inline bool is_mem_loads_aux_even
 
 static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
 {
-	union perf_capabilities *intel_cap;
-
-	intel_cap = is_hybrid() ? &hybrid_pmu(event->pmu)->intel_cap :
-				  &x86_pmu.intel_cap;
+	union perf_capabilities *intel_cap = &hybrid(event->pmu, intel_cap);
 
 	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
 }

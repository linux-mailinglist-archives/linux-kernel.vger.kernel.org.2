Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0B0358B8B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhDHRk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:40:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:6857 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231566AbhDHRk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:40:57 -0400
IronPort-SDR: ZZDAyA0Uh0e4nDU3C1n3v64ye4y4W3YIF06tB3fQHktOxK4NIWPBZPmTsLAvOEaeohVanS4H15
 rgMvfq3Fljsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="193637922"
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="193637922"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 10:40:44 -0700
IronPort-SDR: 81E9GSAgEvkmavuU6Aw6RU+0/+kij4PrrrjbmqmdpL9y3c0livHeQyoVh1uwvi8n7ECx5mhfuD
 v2eo48zQbtNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="598860598"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2021 10:40:44 -0700
Received: from [10.209.60.104] (kliang2-MOBL.ccr.corp.intel.com [10.209.60.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 498AB580812;
        Thu,  8 Apr 2021 10:40:43 -0700 (PDT)
Subject: Re: [PATCH V5 04/25] perf/x86/intel: Hybrid PMU support for perf
 capabilities
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ricardo.neri-calderon@linux.intel.com
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
 <1617635467-181510-5-git-send-email-kan.liang@linux.intel.com>
 <YG82scZuZAsxj2js@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <42ca6320-dca8-ae58-a764-037a46936d78@linux.intel.com>
Date:   Thu, 8 Apr 2021 13:40:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YG82scZuZAsxj2js@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/2021 1:00 PM, Peter Zijlstra wrote:
> On Mon, Apr 05, 2021 at 08:10:46AM -0700, kan.liang@linux.intel.com wrote:
>> +#define is_hybrid()			(!!x86_pmu.num_hybrid_pmus)
> 
> Given this is sprinkled all over the place, can you make this a
> static_key_false + static_branch_unlikely() such that the hybrid case is
> out-of-line?
> 

Sure, I will add a new static_key_false "perf_is_hybrid" to indicate a 
hybrid system as below (not test yet).

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f8d1222..bd6412e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -54,6 +54,7 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {

  DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
  DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
+DEFINE_STATIC_KEY_FALSE(perf_is_hybrid);

  /*
   * This here uses DEFINE_STATIC_CALL_NULL() to get a static_call defined
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2b553d9..7cef3cd 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6119,6 +6119,7 @@ __init int intel_pmu_init(void)
  					     GFP_KERNEL);
  		if (!x86_pmu.hybrid_pmu)
  			return -ENOMEM;
+		static_branch_enable(&perf_is_hybrid);
  		x86_pmu.num_hybrid_pmus = X86_HYBRID_NUM_PMUS;

  		x86_pmu.late_ack = true;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index bfbecde..d6383d1 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -663,8 +663,8 @@ static __always_inline struct x86_hybrid_pmu 
*hybrid_pmu(struct pmu *pmu)
  	return container_of(pmu, struct x86_hybrid_pmu, pmu);
  }

-/* The number of hybrid PMUs implies whether it's a hybrid system */
-#define is_hybrid()			(!!x86_pmu.num_hybrid_pmus)
+extern struct static_key_false perf_is_hybrid;
+#define is_hybrid()		static_branch_unlikely(&perf_is_hybrid)

  #define hybrid(_pmu, _field)				\
  ({							\

Thanks,
Kan

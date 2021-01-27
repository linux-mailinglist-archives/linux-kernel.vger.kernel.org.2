Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1DE30656D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhA0Uwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:52:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:33435 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233256AbhA0Uwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:52:32 -0500
IronPort-SDR: oLUGfG9SZiwj8xFmpibHEVlxlYwuVrxzyP589/HuX1T+F/lOTktgg35kxpzGpNdmvwyXMiHY58
 UIN8b+sfxJPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="244209621"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="244209621"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 12:50:42 -0800
IronPort-SDR: VwPVX0QlXB2IkieBL8wAnPRe68QsA+JXgUeL/7Huw3K/aZN6g3cW+ZCpW8v/0uMx/otP5UjtSl
 YqOEoKNfrRow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="353940111"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2021 12:50:41 -0800
Received: from [10.251.8.120] (kliang2-MOBL.ccr.corp.intel.com [10.251.8.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8571858079D;
        Wed, 27 Jan 2021 12:50:39 -0800 (PST)
Subject: Re: [PATCH V2 3/5] perf/x86/intel: Filter unsupported Topdown metrics
 event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com
References: <1611761925-159055-1-git-send-email-kan.liang@linux.intel.com>
 <1611761925-159055-4-git-send-email-kan.liang@linux.intel.com>
 <YBG7ZJUBQsUmoXlY@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <16cc31ac-eb41-e7cc-5582-e21400bfd15f@linux.intel.com>
Date:   Wed, 27 Jan 2021 15:50:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBG7ZJUBQsUmoXlY@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/2021 2:13 PM, Peter Zijlstra wrote:
> On Wed, Jan 27, 2021 at 07:38:43AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Current perf doesn't check the index of a Topdown metrics event before
>> updating the event. A perf tool user may get a value from an unsupported
>> Topdown metrics event.
>>
>> For example, the L2 topdown event, cpu/event=0x00,umask=0x84/, is not
>> supported on Ice Lake. A perf tool user may mistakenly use the
>> unsupported events via RAW format. In this case, the scheduler follows
>> the unknown event handling and assigns a GP counter to the event. The
>> icl_get_topdown_value() returns the value of the slots to the event.
>> The perf tool user will get the value for the unsupported
>> Topdown metrics event.
>>
>> Add a check in the __icl_update_topdown_event() and avoid updating
>> unsupported events.
> 
> I was struggling trying to understand how we end up here. Because
> userspace can add whatever crap it wants, and why is only this thing a
> problem..
> 
> But the actual problem is the next patch changing INTEL_TD_METRIC_NUM,
> which then means is_metric_idx() will change, and that means that for
> ICL we'll accept these raw events as metric events on creation and then
> at runtime we get into trouble.
> 
> This isn't spelled out.
> 
> I do think this is entirely the wrong fix for that though. You're now
> adding cycles to the relative hot path, instead of fixing the problem at
> event creation, which is the slow path.
> 
> Why can't we either refuse the event on ICL or otherwise wreck it on
> construction to avoid getting into trouble here?
> 

To reject the unsupported topdown events, I think perf needs to know the 
number of the supported topdown events. Maybe we can add a variable 
num_topdown_events in x86_pmu as below. Is it OK?

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3d6fdcf..c7f2602 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1061,6 +1061,18 @@ int x86_schedule_events(struct cpu_hw_events 
*cpuc, int n, int *assign)
  	return unsched ? -EINVAL : 0;
  }

+#define INTEL_TD_METRIC_AVAILABLE_MAX	(INTEL_TD_METRIC_RETIRING + \
+					 ((x86_pmu.num_topdown_events - 1) << 8))
+
+inline bool is_metric_event(struct perf_event *event)
+{
+	u64 config = event->attr.config;
+
+	return ((config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
+		((config & INTEL_ARCH_EVENT_MASK) >= INTEL_TD_METRIC_RETIRING)  &&
+		((config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_AVAILABLE_MAX);
+}
+
  static int add_nr_metric_event(struct cpu_hw_events *cpuc,
  			       struct perf_event *event)
  {
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cd4d542..eab1eba 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5769,6 +5769,7 @@ __init int intel_pmu_init(void)
  		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
  		x86_pmu.lbr_pt_coexist = true;
  		intel_pmu_pebs_data_source_skl(pmem);
+		x86_pmu.num_topdown_events = 4;
  		x86_pmu.update_topdown_event = icl_update_topdown_event;
  		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
  		pr_cont("Icelake events, ");
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 15977d0..8b05893 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -87,14 +87,7 @@ static inline bool is_topdown_count(struct perf_event 
*event)
  	return event->hw.flags & PERF_X86_EVENT_TOPDOWN;
  }

-static inline bool is_metric_event(struct perf_event *event)
-{
-	u64 config = event->attr.config;
-
-	return ((config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
-		((config & INTEL_ARCH_EVENT_MASK) >= INTEL_TD_METRIC_RETIRING)  &&
-		((config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_MAX);
-}
+inline bool is_metric_event(struct perf_event *event);

  static inline bool is_slots_event(struct perf_event *event)
  {
@@ -782,6 +775,7 @@ struct x86_pmu {
  	/*
  	 * Intel perf metrics
  	 */
+	int		num_topdown_events;
  	u64		(*update_topdown_event)(struct perf_event *event);
  	int		(*set_topdown_event_period)(struct perf_event *event);


Thanks,
Kan

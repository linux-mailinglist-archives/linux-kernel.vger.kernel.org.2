Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBCA32DA76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhCDTfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:35:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:14203 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231827AbhCDTfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:35:06 -0500
IronPort-SDR: tnMbW7JWeGCkTOv3+kJUsslwGkD1R22z7JgLuin9PuUzb9alhaTdbu3NAjzK9Z11+WRHc2nAln
 7jrXxaFulYzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="186842212"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="186842212"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 11:33:20 -0800
IronPort-SDR: JviQkSzYEuA6/b+ZnYdrqMsQXla0p5WcLi7AplNp1NtmclUWiHTNgCzm8dYK8yY3WkMPGXSzBO
 Z8gvROMo81uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="597026979"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 04 Mar 2021 11:33:20 -0800
Received: from [10.252.141.30] (kliang2-MOBL.ccr.corp.intel.com [10.252.141.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 388105808B1;
        Thu,  4 Mar 2021 11:33:19 -0800 (PST)
Subject: Re: [perf] perf_fuzzer causes unchecked MSR access error
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <61a56699-aab4-ef6-ed8d-a22b6bf532d@maine.edu>
 <7170d3b-c17f-1ded-52aa-cc6d9ae999f4@maine.edu>
 <YCVE8q4MlbcU4fnV@hirez.programming.kicks-ass.net>
 <32888c33-c286-c600-66cb-8b1b03beeb8b@linux.intel.com>
 <6c1f8e-f81-a781-e594-368e7adef0c0@maine.edu>
 <CABPqkBRp17EMqgoO3LTC-hTkpbv2njFO-Kkf-RifrSksdGfEaA@mail.gmail.com>
 <9df5f72d-a959-fe46-400a-7dca6c596478@linux.intel.com>
 <a8cebd2-a0fe-2ade-30d6-d592b3423db@maine.edu>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <473aff30-5e4f-394f-1c75-9bae66e37bbc@linux.intel.com>
Date:   Thu, 4 Mar 2021 14:33:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a8cebd2-a0fe-2ade-30d6-d592b3423db@maine.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/2021 3:22 PM, Vince Weaver wrote:
> On Wed, 3 Mar 2021, Liang, Kan wrote:
> 
>> We never use bit 58. It should be a new issue.

Actually, KVM uses it. They create a fake event called VLBR_EVENT, which 
uses bit 58. It's introduced from the commit 097e4311cda9 ("perf/x86: 
Add constraint to create guest LBR event without hw counter").

Since it's a fake event, it doesn't support PEBS. Perf should reject it 
if it sets the precise_ip.

The below patch should fix the MSR access error.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5bac48d..1ea3c67 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3659,6 +3659,10 @@ static int intel_pmu_hw_config(struct perf_event 
*event)
  		return ret;

  	if (event->attr.precise_ip) {
+
+		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == 
INTEL_FIXED_VLBR_EVENT)
+			return -EINVAL;
+
  		if (!(event->attr.freq || (event->attr.wakeup_events && 
!event->attr.watermark))) {
  			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
  			if (!(event->attr.sample_type &

Thanks,
Kan

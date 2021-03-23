Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99247346DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 00:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhCWXDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 19:03:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:26405 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234105AbhCWXDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 19:03:31 -0400
IronPort-SDR: 97rmymRX9jw+cp2MNo7Wf6MflvEOr3bB3vzzy2CP1BuEvuqjDc4yVR10iOf1cusxPwvRozOPZY
 URzML2fI9cHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="189984885"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="189984885"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 16:03:26 -0700
IronPort-SDR: D9pZYc2MMI9MMsFQ+ppeLCHg1sHzZlCf7E7xwS1xFabAeuEx2xp3p4jJFPsYIKIPJQLdGn6fHY
 ezlsevDoTM/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="376223373"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2021 16:03:26 -0700
Received: from [10.251.24.54] (kliang2-MOBL.ccr.corp.intel.com [10.251.24.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6B80758069F;
        Tue, 23 Mar 2021 16:03:25 -0700 (PDT)
Subject: Re: [PATCH v4 RESEND 3/5] perf/x86/lbr: Move cpuc->lbr_xsave
 allocation out of sleeping region
To:     Peter Zijlstra <peterz@infradead.org>,
        Like Xu <like.xu@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210322060635.821531-1-like.xu@linux.intel.com>
 <20210322060635.821531-4-like.xu@linux.intel.com>
 <20210323214140.GE4746@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b9532af0-4539-960d-dd7a-78c8731ba2f6@linux.intel.com>
Date:   Tue, 23 Mar 2021 19:03:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323214140.GE4746@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/2021 5:41 PM, Peter Zijlstra wrote:
> On Mon, Mar 22, 2021 at 02:06:33PM +0800, Like Xu wrote:
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 18df17129695..a4ce669cc78d 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -373,7 +373,7 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
>>   	return x86_pmu_extra_regs(val, event);
>>   }
>>   
>> -int x86_reserve_hardware(void)
>> +int x86_reserve_hardware(struct perf_event *event)
>>   {
>>   	int err = 0;
>>   
>> @@ -382,8 +382,10 @@ int x86_reserve_hardware(void)
>>   		if (atomic_read(&pmc_refcount) == 0) {
>>   			if (!reserve_pmc_hardware())
>>   				err = -EBUSY;
>> -			else
>> +			else {
>>   				reserve_ds_buffers();
>> +				reserve_lbr_buffers(event);
>> +			}
>>   		}
>>   		if (!err)
>>   			atomic_inc(&pmc_refcount);
> 
> This makes absolutely no sense what so ever. This is only executed for
> the first event that gets here.
> 

The LBR xsave buffer is a per-CPU buffer, not a per-event buffer. I 
think we only need to allocate the buffer once when initializing the 
first event.

Thanks,
Kan

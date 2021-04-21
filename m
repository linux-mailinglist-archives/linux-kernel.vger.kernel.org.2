Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DEA366743
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhDUItO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:49:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:22710 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232140AbhDUItN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:49:13 -0400
IronPort-SDR: OKRyT04GN3A8vSTpdoHCTHkRfVTawfR5C9apMewOsNtS0rIDLzFidupauy55IQrhhxr11ViCEC
 4ERu3a+tyWtQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="193542248"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="193542248"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 01:48:40 -0700
IronPort-SDR: 3+2uj8P/4vfssUQJyAj8EaXG2WVKt9KTA9rmr5r+g3XFXu/gmfT/uHWC2kqKso/MNMAYUhlA8Y
 IAuPa04WE9UA==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="420907869"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.238.4.93]) ([10.238.4.93])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 01:48:37 -0700
Subject: Re: [PATCH RESEND 2/2] perf/x86/lbr: Move cpuc->lbr_xsave allocation
 out of sleeping region
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210421021825.37872-1-like.xu@linux.intel.com>
 <20210421021825.37872-2-like.xu@linux.intel.com>
 <YH/kikWFlfD260qy@hirez.programming.kicks-ass.net>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <13fd7ac4-46fd-3fa7-0e80-3f46cfc8edac@linux.intel.com>
Date:   Wed, 21 Apr 2021 16:48:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YH/kikWFlfD260qy@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2021/4/21 16:38, Peter Zijlstra wrote:
> On Wed, Apr 21, 2021 at 10:18:25AM +0800, Like Xu wrote:
>> -int x86_reserve_hardware(void)
>> +int x86_reserve_hardware(struct perf_event *event)
>>   {
>>   	int err = 0;
>>   
>> @@ -398,8 +398,10 @@ int x86_reserve_hardware(void)
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
>> @@ -650,7 +652,7 @@ static int __x86_pmu_event_init(struct perf_event *event)
>>   	if (!x86_pmu_initialized())
>>   		return -ENODEV;
>>   
>> -	err = x86_reserve_hardware();
>> +	err = x86_reserve_hardware(event);
>>   	if (err)
>>   		return err;
>>   
> 
> This is still complete garbage..

Hhh,thanks for your comment!

So do we have a better idea to alloc cpuc->lbr_xsave
to avoid this kind of call trace ?

> 


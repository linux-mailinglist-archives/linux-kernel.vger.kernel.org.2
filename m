Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1080836D038
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 03:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbhD1BTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 21:19:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:10880 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238777AbhD1BTB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 21:19:01 -0400
IronPort-SDR: yvuMvrqADGRahLtZPV+NfrWMc60bblz1lwzTA6yGInNjtU/zrkLhXgkg540YfMZZPG0u42i74E
 r2SUEK40qeBQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="196738192"
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="196738192"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 18:18:16 -0700
IronPort-SDR: evNNsgoWgKHRV1vurxB0aWNFdz8z8IoTQdsLT/YH21EfYpBXSMIa6VneA0Eq9AfdQfPjyur9o9
 NTnaewGxtyNA==
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="430056557"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 18:18:14 -0700
Subject: Re: [PATCH v6 01/26] tools headers uapi: Update tools's copy of
 linux/perf_event.h
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
 <20210427070139.25256-2-yao.jin@linux.intel.com>
 <YIhk2XkvUcoIPbgc@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <e6bc62d5-50e8-15cf-915f-de15b3d7b860@linux.intel.com>
Date:   Wed, 28 Apr 2021 09:18:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIhk2XkvUcoIPbgc@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 4/28/2021 3:24 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Apr 27, 2021 at 03:01:14PM +0800, Jin Yao escreveu:
>> To get the changes in:
>>
>> Liang Kan's patch
>> [PATCH V6 21/25] perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
>>
>> Kan's patch is upstreamed yet but perf/core branch doesn't have it
>> at this moment. But next perf tool patches need this interface for
>> hybrid support.
>>
>> This patch can be removed after Kan's patch is merged in perf/core
>> branch.
> 
> Nope, it is already in tip/perf/core as:
> 
>    55bcf6ef314ae8ba ("perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE")
> 

Oh, the perf/core mentioned here just means the "perf/core" from acme/linux.git. Sorry, I didn't say 
this clearly. I guess it will be merged to acme/linux.git at some window.

> And your patch, the one below, shouldn't include the kernel file, i.e. include/uapi/linux/perf_event.h
> as tooling only uses the one in tools/include/uapi/linux/perf_event.h.
> 

Yes, my fault. I only need to update the tools/include/uapi/linux/perf_event.h. You have helped me 
to update the commit 7ad6382ef375 ("tools headers uapi: Update tools's copy of linux/perf_event.h") 
in tmp.perf/core. Thanks so much!

> Leave the perf tool build warning there, as soon as both acme/perf/core
> and tip/perf/core hit torvalds/master, all gets solved.
> 
> So I'm removing it here in addition to updating the commit log message.
> 

Thanks again!

> Ah good news, the test builds passed in all my test build containers.
>

Great! :)

> I'll refresh tmp.perf/core once I update these messages, etc. So that we
> can continue from there in case you need to respin a v7.
> 

I've seen the patches have been applied in tmp.perf/core now, thanks! If we need v7, we can continue 
from tmp.perf/core.

Thanks
Jin Yao

> Thanks,
> 
> - Arnaldo.
> 
> 
>   
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>> v6:
>>   - No update.
>>
>> v5:
>>   - Update the commit message to mention that Kan's patch is
>>     upstreamed but not merged to perf/core branch.
>>
>> v4:
>>   - Updated by Kan's latest patch,
>>     '[PATCH V6 21/25] perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE'
>>
>>   include/uapi/linux/perf_event.h       | 15 +++++++++++++++
>>   tools/include/uapi/linux/perf_event.h | 15 +++++++++++++++
>>   2 files changed, 30 insertions(+)
>>
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index ad15e40d7f5d..14332f4cf816 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -37,6 +37,21 @@ enum perf_type_id {
>>   	PERF_TYPE_MAX,				/* non-ABI */
>>   };
>>   
>> +/*
>> + * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
>> + * PERF_TYPE_HARDWARE:			0xEEEEEEEE000000AA
>> + *					AA: hardware event ID
>> + *					EEEEEEEE: PMU type ID
>> + * PERF_TYPE_HW_CACHE:			0xEEEEEEEE00DDCCBB
>> + *					BB: hardware cache ID
>> + *					CC: hardware cache op ID
>> + *					DD: hardware cache op result ID
>> + *					EEEEEEEE: PMU type ID
>> + * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
>> + */
>> +#define PERF_PMU_TYPE_SHIFT		32
>> +#define PERF_HW_EVENT_MASK		0xffffffff
>> +
>>   /*
>>    * Generalized performance event event_id types, used by the
>>    * attr.event_id parameter of the sys_perf_event_open()
>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>> index ad15e40d7f5d..14332f4cf816 100644
>> --- a/tools/include/uapi/linux/perf_event.h
>> +++ b/tools/include/uapi/linux/perf_event.h
>> @@ -37,6 +37,21 @@ enum perf_type_id {
>>   	PERF_TYPE_MAX,				/* non-ABI */
>>   };
>>   
>> +/*
>> + * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
>> + * PERF_TYPE_HARDWARE:			0xEEEEEEEE000000AA
>> + *					AA: hardware event ID
>> + *					EEEEEEEE: PMU type ID
>> + * PERF_TYPE_HW_CACHE:			0xEEEEEEEE00DDCCBB
>> + *					BB: hardware cache ID
>> + *					CC: hardware cache op ID
>> + *					DD: hardware cache op result ID
>> + *					EEEEEEEE: PMU type ID
>> + * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
>> + */
>> +#define PERF_PMU_TYPE_SHIFT		32
>> +#define PERF_HW_EVENT_MASK		0xffffffff
>> +
>>   /*
>>    * Generalized performance event event_id types, used by the
>>    * attr.event_id parameter of the sys_perf_event_open()
>> -- 
>> 2.17.1
>>
> 

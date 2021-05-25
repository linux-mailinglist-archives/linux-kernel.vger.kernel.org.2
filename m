Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD9238FAB6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhEYGQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:16:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:50529 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhEYGQM (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:16:12 -0400
IronPort-SDR: M6Tk4/WKSmnTQo4LoJk7NFSGd7/PPo8LTiKSuW4c3Fo5JeH8FcsoQZV9qWEY+dI8+d2iZAia/Z
 +RGOVk0Ysazw==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="202133065"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="202133065"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 23:14:43 -0700
IronPort-SDR: Jb2Rfz8dz7Lrc03U3/Nkc2hc6nnOgdfDIibgbuY6HLKv6nHmSHFLFv+E2ojbgBXPrOSMu010m2
 +xetwpdAlmtw==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="442400634"
Received: from unknown (HELO [10.239.159.33]) ([10.239.159.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 23:14:40 -0700
Subject: Re: [PATCH v1 3/5] perf tools: Check if mem_events is supported for
 hybrid
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210520070040.710-1-yao.jin@linux.intel.com>
 <20210520070040.710-4-yao.jin@linux.intel.com> <YKvgHfNdi7U/sEVg@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <406a0ae9-4742-448c-e4f2-6f7c5b74ace9@linux.intel.com>
Date:   Tue, 25 May 2021 14:14:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKvgHfNdi7U/sEVg@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/25/2021 1:19 AM, Jiri Olsa wrote:
> On Thu, May 20, 2021 at 03:00:38PM +0800, Jin Yao wrote:
>> Check if the mem_events ('mem-loads' and 'mem-stores') exist
>> in the sysfs path.
>>
>> For Alderlake, the hybrid cpu pmu are "cpu_core" and "cpu_atom".
>> Check the existing of following paths:
>> /sys/devices/cpu_atom/events/mem-loads
>> /sys/devices/cpu_atom/events/mem-stores
>> /sys/devices/cpu_core/events/mem-loads
>> /sys/devices/cpu_core/events/mem-stores
>>
>> If the patch exists, the mem_event is supported.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/mem-events.c | 43 +++++++++++++++++++++++++++++-------
>>   1 file changed, 35 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
>> index c736eaded06c..e8f6e745eaf0 100644
>> --- a/tools/perf/util/mem-events.c
>> +++ b/tools/perf/util/mem-events.c
>> @@ -12,14 +12,16 @@
>>   #include "mem-events.h"
>>   #include "debug.h"
>>   #include "symbol.h"
>> +#include "pmu.h"
>> +#include "pmu-hybrid.h"
>>   
>>   unsigned int perf_mem_events__loads_ldlat = 30;
>>   
>>   #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>>   
>>   static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
>> -	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
>> -	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
>> +	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads"),
>> +	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores"),
>>   	E(NULL,			NULL,				NULL),
> 
> so this was generic place, now it's x86 specific, I wonder we should
> move it under arch/x86 to avoid confusion
> 

Yes, I will move x86 specific perf_mem_events[] to arch/x86/util/mem-events.c.

>>   };
>>   #undef E
>> @@ -100,6 +102,18 @@ int perf_mem_events__parse(const char *str)
>>   	return -1;
>>   }
>>   
>> +static bool perf_mem_events__supported(const char *mnt, char *sysfs_name)
>> +{
>> +	char path[PATH_MAX];
>> +	struct stat st;
>> +
>> +	scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
>> +	if (!stat(path, &st))
>> +		return true;
>> +
>> +	return false;
> 
> could be just 'return !stat(path, &st);' right?
> 

Right :)

>> +}
>> +
>>   int perf_mem_events__init(void)
>>   {
>>   	const char *mnt = sysfs__mount();
>> @@ -110,9 +124,10 @@ int perf_mem_events__init(void)
>>   		return -ENOENT;
>>   
>>   	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
>> -		char path[PATH_MAX];
>>   		struct perf_mem_event *e = perf_mem_events__ptr(j);
>> -		struct stat st;
>> +		struct perf_pmu *pmu;
>> +		char sysfs_name[100];
>> +		int unsupported = 0;
>>   
>>   		/*
>>   		 * If the event entry isn't valid, skip initialization
>> @@ -121,11 +136,23 @@ int perf_mem_events__init(void)
>>   		if (!e->tag)
>>   			continue;
>>   
>> -		scnprintf(path, PATH_MAX, "%s/devices/%s",
>> -			  mnt, e->sysfs_name);
>> +		if (!perf_pmu__has_hybrid()) {
>> +			scnprintf(sysfs_name, sizeof(sysfs_name),
>> +				  e->sysfs_name, "cpu");
>> +			e->supported = perf_mem_events__supported(mnt, sysfs_name);
>> +		} else {
>> +			perf_pmu__for_each_hybrid_pmu(pmu) {
>> +				scnprintf(sysfs_name, sizeof(sysfs_name),
>> +					  e->sysfs_name, pmu->name);
>> +				if (!perf_mem_events__supported(mnt, sysfs_name))
>> +					unsupported++;
>> +			}
>> +
>> +			e->supported = (unsupported == 0) ? true : false;
> 
> could you just do in the above loop:
> 			e->supported |= perf_mem_events__supported(mnt, sysfs_name);
> 

That's OK, thanks!

Thanks
Jin Yao

> jirka
> 
>> +		}
>>   
>> -		if (!stat(path, &st))
>> -			e->supported = found = true;
>> +		if (e->supported)
>> +			found = true;
>>   	}
>>   
>>   	return found ? 0 : -ENOENT;
>> -- 
>> 2.17.1
>>
> 

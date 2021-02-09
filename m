Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE4F314491
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBIAH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:07:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:7333 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhBIAHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:07:23 -0500
IronPort-SDR: MMavFpwTpzov+IThVaqb5bgVwEAYmgFNwAIDcF7KBOdIEF4tEv2FHj+Wt5obDPf6tf4EkAQ/er
 +pEq1FsoQbDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181947478"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="181947478"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 16:05:37 -0800
IronPort-SDR: Ws7yiCUCyLVZpOK7AE4z+08xRXUG7jwTpPtLtzv/cwqn3dFcS6+XLOWN5X0YM2QpGu3rj8zDaq
 U3twhIn85SCA==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="395793230"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 16:05:34 -0800
Subject: Re: [PATCH 28/49] perf pmu: Save detected hybrid pmus to a global pmu
 list
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        "Jin, Yao" <yao.jin@intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <1612797946-18784-29-git-send-email-kan.liang@linux.intel.com>
 <20210208185521.GJ920417@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <36f679f5-30b9-cb2a-0373-2c9e05645750@linux.intel.com>
Date:   Tue, 9 Feb 2021 08:05:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210208185521.GJ920417@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 2/9/2021 2:55 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 08, 2021 at 07:25:25AM -0800, kan.liang@linux.intel.com escreveu:
>> From: Jin Yao <yao.jin@linux.intel.com>
>>
>> We identify the cpu_core pmu and cpu_atom pmu by explicitly
>> checking following files:
>>
>> For cpu_core, check:
>> "/sys/bus/event_source/devices/cpu_core/cpus"
>>
>> For cpu_atom, check:
>> "/sys/bus/event_source/devices/cpu_atom/cpus"
>>
>> If the 'cpus' file exists, the pmu exists.
>>
>> But in order not to hardcode the "cpu_core" and "cpu_atom",
>> and make the code generic, if the path
>> "/sys/bus/event_source/devices/cpu_xxx/cpus" exists, the hybrid
>> pmu exists. All the detected hybrid pmus are linked to a
>> global list 'perf_pmu__hybrid_pmus' and then next we just need
>> to iterate the list by using perf_pmu__for_each_hybrid_pmus.
>>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/pmu.c | 21 +++++++++++++++++++++
>>   tools/perf/util/pmu.h |  7 +++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 0c25457..e97b121 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -27,6 +27,7 @@
>>   #include "fncache.h"
>>   
>>   struct perf_pmu perf_pmu__fake;
>> +LIST_HEAD(perf_pmu__hybrid_pmus);
>>   
>>   struct perf_pmu_format {
>>   	char *name;
>> @@ -633,11 +634,27 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
>>   	return NULL;
>>   }
>>   
>> +static bool pmu_is_hybrid(const char *name)
>> +{
>> +	char path[PATH_MAX];
>> +	const char *sysfs;
>> +
>> +	if (strncmp(name, "cpu_", 4))
>> +		return false;
>> +
>> +	sysfs = sysfs__mountpoint();
> 
> Its extremely unlikely that sysfs isn't mounted, but if so, this will
> NULL deref, so please do as other sysfs__mountpoint() uses in
> tools/perf/util/pmu.c and check if sysfs is NULL, returning false, i.e.
> file isn't available.
> 

Yes, I need to check the return value of sysfs__mountpoint(), something like.

sysfs = sysfs__mountpoint();
if (!sysfs)
	return false;

>> +	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, name);
>> +	return file_available(path);
>> +}
>> +
>>   static bool pmu_is_uncore(const char *name)
>>   {
>>   	char path[PATH_MAX];
>>   	const char *sysfs;
>>   
>> +	if (pmu_is_hybrid(name))
>> +		return false;
>> +
>>   	sysfs = sysfs__mountpoint();
>>   	snprintf(path, PATH_MAX, CPUS_TEMPLATE_UNCORE, sysfs, name);
>>   	return file_available(path);
>> @@ -951,6 +968,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
>>   	pmu->is_uncore = pmu_is_uncore(name);
>>   	if (pmu->is_uncore)
>>   		pmu->id = pmu_id(name);
>> +	pmu->is_hybrid = pmu_is_hybrid(name);
>>   	pmu->max_precise = pmu_max_precise(name);
>>   	pmu_add_cpu_aliases(&aliases, pmu);
>>   	pmu_add_sys_aliases(&aliases, pmu);
>> @@ -962,6 +980,9 @@ static struct perf_pmu *pmu_lookup(const char *name)
>>   	list_splice(&aliases, &pmu->aliases);
>>   	list_add_tail(&pmu->list, &pmus);
>>   
>> +	if (pmu->is_hybrid)
>> +		list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
>> +
>>   	pmu->default_config = perf_pmu__get_default_config(pmu);
>>   
>>   	return pmu;
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index 0e724d5..99bdb5d 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -5,6 +5,7 @@
>>   #include <linux/bitmap.h>
>>   #include <linux/compiler.h>
>>   #include <linux/perf_event.h>
>> +#include <linux/list.h>
>>   #include <stdbool.h>
>>   #include "parse-events.h"
>>   #include "pmu-events/pmu-events.h"
>> @@ -34,6 +35,7 @@ struct perf_pmu {
>>   	__u32 type;
>>   	bool selectable;
>>   	bool is_uncore;
>> +	bool is_hybrid;
>>   	bool auxtrace;
>>   	int max_precise;
>>   	struct perf_event_attr *default_config;
>> @@ -42,9 +44,11 @@ struct perf_pmu {
>>   	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
>>   	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
>>   	struct list_head list;    /* ELEM */
>> +	struct list_head hybrid_list;
>>   };
>>   
>>   extern struct perf_pmu perf_pmu__fake;
>> +extern struct list_head perf_pmu__hybrid_pmus;
>>   
>>   struct perf_pmu_info {
>>   	const char *unit;
>> @@ -124,4 +128,7 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
>>   
>>   int perf_pmu__caps_parse(struct perf_pmu *pmu);
>>   
>> +#define perf_pmu__for_each_hybrid_pmus(pmu)	\
> 
> singular, i.e.
> 
> #define perf_pmu__for_each_hybrid_pmu(pmu)	\
>

Got it. Will use perf_pmu__for_each_hybrid_pmu in next version.

Thanks
Jin Yao

>> +	list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
>> +
>>   #endif /* __PMU_H */
>> -- 
>> 2.7.4
>>
> 

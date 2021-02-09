Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0A3144D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhBIAZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:25:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:30442 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhBIAZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:25:27 -0500
IronPort-SDR: 7XWReuBkiGISEvmJwoY5JKXTZ/oyY2aN9I6MYdiW/eeJ6lnQilko5CY8qSHyIvXd/d54QYiV+4
 TIN73rG0bcAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="245874219"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="245874219"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 16:23:39 -0800
IronPort-SDR: rwyc3HDjhY14gysAHSmrFebWbwllIP5ZHw2Fyn93dqoZhVaaXQm0DhK//2/Fo2fFE2Hn59JS3y
 w8sW/GI1E6vA==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="395798837"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 16:23:35 -0800
Subject: Re: [PATCH 35/49] perf parse-events: Create two hybrid hardware
 events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        "Jin, Yao" <yao.jin@intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <1612797946-18784-36-git-send-email-kan.liang@linux.intel.com>
 <20210208185905.GL920417@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <12c2095f-52c5-ceb7-405c-ccc1484a2a49@linux.intel.com>
Date:   Tue, 9 Feb 2021 08:23:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210208185905.GL920417@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 2/9/2021 2:59 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 08, 2021 at 07:25:32AM -0800, kan.liang@linux.intel.com escreveu:
>> From: Jin Yao <yao.jin@linux.intel.com>
>>
>> For hardware events, they have pre-defined configs. The kernel
>> needs to know where the event comes from (e.g. from cpu_core pmu
>> or from cpu_atom pmu). But the perf type 'PERF_TYPE_HARDWARE'
>> can't carry pmu information.
>>
>> So the kernel introduces a new type 'PERF_TYPE_HARDWARE_PMU'.
>> The new attr.config layout for PERF_TYPE_HARDWARE_PMU is:
>>
>> 0xDD000000AA
>> AA: original hardware event ID
>> DD: PMU type ID
>>
>> PMU type ID is retrieved from sysfs. For example,
>>
>> cat /sys/devices/cpu_atom/type
>> 10
>>
>> cat /sys/devices/cpu_core/type
>> 4
>>
>> When enabling a hybrid hardware event without specified pmu, such as,
>> 'perf stat -e cycles -a', two events are created automatically. One
>> is for atom, the other is for core.
> 
> please move the command output two chars to the right, otherwise lines
> with --- may confuse some scripts.
> 

oh, very sorry about that. I will be careful in next version.

Thanks
Jin Yao

>> root@otcpl-adl-s-2:~# ./perf stat -e cycles -vv -a -- sleep 1
>> Control descriptor is not initialized
>> ------------------------------------------------------------
>> perf_event_attr:
>>    type                             6
>>    size                             120
>>    config                           0x400000000
>>    sample_type                      IDENTIFIER
>>    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>    disabled                         1
>>    inherit                          1
>>    exclude_guest                    1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
>> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 4
>> sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 5
>> sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 7
>> sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 8
>> sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 9
>> sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 10
>> sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 11
>> sys_perf_event_open: pid -1  cpu 8  group_fd -1  flags 0x8 = 12
>> sys_perf_event_open: pid -1  cpu 9  group_fd -1  flags 0x8 = 13
>> sys_perf_event_open: pid -1  cpu 10  group_fd -1  flags 0x8 = 14
>> sys_perf_event_open: pid -1  cpu 11  group_fd -1  flags 0x8 = 15
>> sys_perf_event_open: pid -1  cpu 12  group_fd -1  flags 0x8 = 16
>> sys_perf_event_open: pid -1  cpu 13  group_fd -1  flags 0x8 = 17
>> sys_perf_event_open: pid -1  cpu 14  group_fd -1  flags 0x8 = 18
>> sys_perf_event_open: pid -1  cpu 15  group_fd -1  flags 0x8 = 19
>> ------------------------------------------------------------
>> perf_event_attr:
>>    type                             6
>>    size                             120
>>    config                           0xa00000000
>>    sample_type                      IDENTIFIER
>>    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>    disabled                         1
>>    inherit                          1
>>    exclude_guest                    1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8 = 20
>> sys_perf_event_open: pid -1  cpu 17  group_fd -1  flags 0x8 = 21
>> sys_perf_event_open: pid -1  cpu 18  group_fd -1  flags 0x8 = 22
>> sys_perf_event_open: pid -1  cpu 19  group_fd -1  flags 0x8 = 23
>> sys_perf_event_open: pid -1  cpu 20  group_fd -1  flags 0x8 = 24
>> sys_perf_event_open: pid -1  cpu 21  group_fd -1  flags 0x8 = 25
>> sys_perf_event_open: pid -1  cpu 22  group_fd -1  flags 0x8 = 26
>> sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 27
>> cycles: 0: 1254337 1001292571 1001292571
>> cycles: 1: 2595141 1001279813 1001279813
>> cycles: 2: 134853 1001276406 1001276406
>> cycles: 3: 81119 1001271089 1001271089
>> cycles: 4: 251353 1001264678 1001264678
>> cycles: 5: 415593 1001259163 1001259163
>> cycles: 6: 129643 1001265312 1001265312
>> cycles: 7: 80289 1001258979 1001258979
>> cycles: 8: 169983 1001251207 1001251207
>> cycles: 9: 81981 1001245487 1001245487
>> cycles: 10: 4116221 1001245537 1001245537
>> cycles: 11: 85531 1001253097 1001253097
>> cycles: 12: 3969132 1001254270 1001254270
>> cycles: 13: 96006 1001254691 1001254691
>> cycles: 14: 385004 1001244971 1001244971
>> cycles: 15: 394446 1001251437 1001251437
>> cycles: 0: 427330 1001253457 1001253457
>> cycles: 1: 444043 1001255914 1001255914
>> cycles: 2: 97285 1001253555 1001253555
>> cycles: 3: 92071 1001260556 1001260556
>> cycles: 4: 86292 1001249896 1001249896
>> cycles: 5: 236851 1001238979 1001238979
>> cycles: 6: 100081 1001239792 1001239792
>> cycles: 7: 72836 1001243276 1001243276
>> cycles: 14240632 16020168708 16020168708
>> cycles: 1556789 8009995425 8009995425
>>
>>   Performance counter stats for 'system wide':
>>
>>          14,240,632      cycles
>>           1,556,789      cycles
>>
>>         1.002261231 seconds time elapsed
>>
>> type 6 is PERF_TYPE_HARDWARE_PMU.
>> 0x4 in 0x400000000 indicates the cpu_core pmu.
>> 0xa in 0xa00000000 indicates the cpu_atom pmu.
>>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/parse-events.c | 73 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index 81a6fce..1e767dc 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -446,6 +446,24 @@ static int config_attr(struct perf_event_attr *attr,
>>   		       struct parse_events_error *err,
>>   		       config_term_func_t config_term);
>>   
>> +static void config_hybrid_attr(struct perf_event_attr *attr,
>> +			       int type, int pmu_type)
>> +{
>> +	/*
>> +	 * attr.config layout:
>> +	 * PERF_TYPE_HARDWARE_PMU:     0xDD000000AA
>> +	 *                             AA: hardware event ID
>> +	 *                             DD: PMU type ID
>> +	 * PERF_TYPE_HW_CACHE_PMU:     0xDD00CCBBAA
>> +	 *                             AA: hardware cache ID
>> +	 *                             BB: hardware cache op ID
>> +	 *                             CC: hardware cache op result ID
>> +	 *                             DD: PMU type ID
>> +	 */
>> +	attr->type = type;
>> +	attr->config = attr->config | ((__u64)pmu_type << PERF_PMU_TYPE_SHIFT);
>> +}
>> +
>>   int parse_events_add_cache(struct list_head *list, int *idx,
>>   			   char *type, char *op_result1, char *op_result2,
>>   			   struct parse_events_error *err,
>> @@ -1409,6 +1427,47 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
>>   					    err, head_config);
>>   }
>>   
>> +static int create_hybrid_hw_event(struct parse_events_state *parse_state,
>> +				  struct list_head *list,
>> +				  struct perf_event_attr *attr,
>> +				  struct perf_pmu *pmu)
>> +{
>> +	struct evsel *evsel;
>> +	__u32 type = attr->type;
>> +	__u64 config = attr->config;
>> +
>> +	config_hybrid_attr(attr, PERF_TYPE_HARDWARE_PMU, pmu->type);
>> +	evsel = __add_event(list, &parse_state->idx, attr, true, NULL,
>> +			    pmu, NULL, false, NULL);
>> +	if (evsel)
>> +		evsel->pmu_name = strdup(pmu->name);
>> +	else
>> +		return -ENOMEM;
>> +
>> +	attr->type = type;
>> +	attr->config = config;
>> +	return 0;
>> +}
>> +
>> +static int add_hybrid_numeric(struct parse_events_state *parse_state,
>> +			      struct list_head *list,
>> +			      struct perf_event_attr *attr,
>> +			      bool *hybrid)
>> +{
>> +	struct perf_pmu *pmu;
>> +	int ret;
>> +
>> +	*hybrid = false;
>> +	perf_pmu__for_each_hybrid_pmus(pmu) {
>> +		*hybrid = true;
>> +		ret = create_hybrid_hw_event(parse_state, list, attr, pmu);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   int parse_events_add_numeric(struct parse_events_state *parse_state,
>>   			     struct list_head *list,
>>   			     u32 type, u64 config,
>> @@ -1416,6 +1475,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>>   {
>>   	struct perf_event_attr attr;
>>   	LIST_HEAD(config_terms);
>> +	bool hybrid;
>> +	int ret;
>>   
>>   	memset(&attr, 0, sizeof(attr));
>>   	attr.type = type;
>> @@ -1430,6 +1491,18 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>>   			return -ENOMEM;
>>   	}
>>   
>> +	/*
>> +	 * Skip the software dummy event.
>> +	 */
>> +	if (type != PERF_TYPE_SOFTWARE) {
>> +		if (!perf_pmu__hybrid_exist())
>> +			perf_pmu__scan(NULL);
>> +
>> +		ret = add_hybrid_numeric(parse_state, list, &attr, &hybrid);
>> +		if (hybrid)
>> +			return ret;
>> +	}
>> +
>>   	return add_event(list, &parse_state->idx, &attr,
>>   			 get_config_name(head_config), &config_terms);
>>   }
>> -- 
>> 2.7.4
>>
> 

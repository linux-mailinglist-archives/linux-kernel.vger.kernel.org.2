Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8EF32E0C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 05:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhCEE2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 23:28:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:37710 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhCEE2p (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:28:45 -0500
IronPort-SDR: BhJi6Vc5smxOIKK5dz2ArFFLwOWdHrlL4G9JYLqCZ1NatUarcz3ZXM+z7Yzt3n9oZhdJptl9Fv
 aewRDiGUwJjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="174680655"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="174680655"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 20:28:44 -0800
IronPort-SDR: c9NYKyf0wLbpD/avZvaK1ydoQ4OThfq0tdXqI+WmR5b+NWnq1LgQVs9h8PgWW+12lNZ50lh30Y
 gEzUXMzW9Ehw==
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="408131350"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 20:28:40 -0800
Subject: Re: [PATCH] perf pmu: Validate raw event with sysfs exported format
 bits
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210303051736.26974-1-yao.jin@linux.intel.com>
 <YEFAb7Q7yhkw6g9s@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <3c88d257-f923-bc82-f860-ea1f6588d9ed@linux.intel.com>
Date:   Fri, 5 Mar 2021 12:28:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEFAb7Q7yhkw6g9s@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/5/2021 4:17 AM, Jiri Olsa wrote:
> On Wed, Mar 03, 2021 at 01:17:36PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> The set bits in 'bits' indicate the invalid bits used in config.
>> Finally use strbuf to report the invalid bits.
>>
>> Some architectures may not export supported bits through sysfs,
>> so if masks is 0, perf_pmu__config_valid just returns true.
>>
>> After:
>>
>> Single event:
>>
>>    # ./perf stat -e cpu/r031234/ -a -- sleep 1
>>    WARNING: event config '31234' not valid (bits 16 17 not supported by kernel)!
>>
>>     Performance counter stats for 'system wide':
>>
>>                     0      cpu/r031234/
>>
>>           1.001403757 seconds time elapsed
>>
>> Multiple events:
>>
>>    # ./perf stat -e cpu/rf01234/,cpu/r031234/ -a -- sleep 1
>>    WARNING: event config 'f01234' not valid (bits 20 22 not supported by kernel)!
>>    WARNING: event config '31234' not valid (bits 16 17 not supported by kernel)!
> 
> right, seems useful
> 

Thanks :)

>>
>>     Performance counter stats for 'system wide':
>>
>>                     0      cpu/rf01234/
>>                     0      cpu/r031234/
>>
>> The warning is reported for invalid bits.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/parse-events.c | 11 ++++++++++
>>   tools/perf/util/pmu.c          | 38 ++++++++++++++++++++++++++++++++++
>>   tools/perf/util/pmu.h          |  4 ++++
>>   3 files changed, 53 insertions(+)
>>
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index 42c84adeb2fb..1820b2c0a241 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -356,6 +356,17 @@ __add_event(struct list_head *list, int *idx,
>>   	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
>>   			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
>>   
> 
> if we want it just for raw/numeric, we could add it earlier on,
> like to parse_events_add_numeric call
> 
> but perhaps it might be helpful to check any pmu event,
> could perhaps reveal some broken format
> 

Yes, I think so. So directly checking the attr->config here may cover more cases.

>> +	if (pmu && attr->type == PERF_TYPE_RAW) {
>> +		struct strbuf buf = STRBUF_INIT;
>> +
>> +		if (!perf_pmu__config_valid(pmu, attr->config, &buf)) {
>> +			pr_warning("WARNING: event config '%llx' not valid ("
>> +				   "bits%s not supported by kernel)!\n",
>> +				   attr->config, buf.buf);
>> +		}
>> +		strbuf_release(&buf);
>> +	}
>> +
>>   	if (init_attr)
>>   		event_attr_init(attr);
>>   
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 44ef28302fc7..5e361adb2698 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -1812,3 +1812,41 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>>   
>>   	return nr_caps;
>>   }
>> +
>> +bool perf_pmu__config_valid(struct perf_pmu *pmu, __u64 config,
>> +			    struct strbuf *buf)
>> +{
>> +	struct perf_pmu_format *format;
>> +	__u64 masks = 0, bits;
>> +	int i;
>> +
>> +	list_for_each_entry(format, &pmu->format, list)	{
>> +		/*
>> +		 * Skip extra configs such as config1/config2.
>> +		 */
>> +		if (format->value > 0)
>> +			continue;
>> +
>> +		for_each_set_bit(i, format->bits, PERF_PMU_FORMAT_BITS)
>> +			masks |= 1ULL << i;
>> +	}
>> +
>> +	/*
>> +	 * Kernel doesn't export any valid format bits.
>> +	 */
>> +	if (masks == 0)
>> +		return true;
>> +
>> +	bits = config & ~masks;
>> +	if (bits == 0)
>> +		return true;
> 
> so in here you now that there's something wrong, so why
> bother with the outside strbuf, when we can easily just
> do all the printing in here?
> 

For this patch, yes, I don't need to return the strbuf to caller then print outside.

Andi now comments to print the original event as well, so I need to choose #1 pass the event name to 
perf_pmu__config_valid or #2 return the strbuf to caller.

>> +
>> +	for (i = 0; i < PERF_PMU_FORMAT_BITS; i++) {
>> +		if (bits & 0x1)
>> +			strbuf_addf(buf, " %d", i);
>> +
>> +		bits >>= 1;
> 
> could you use the for_each_set_bit in here?
> 

Yes, maybe I can use the code such as :

for_each_set_bit(i, (unsigned long *) &bits, sizeof(bits) * 8)
	strbuf_addf(buf, " %d", i);

Thanks
Jin Yao

> thanks,
> jirka
> 

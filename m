Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B75330EC1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCHM6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:58:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:14592 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhCHM54 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:57:56 -0500
IronPort-SDR: qB7c5mIyGQRxaXJHNw7QOAvu1n4fRS3a/kdturSHHnDnS7n+VSReOjgGaLKcq0zfu9hxUUbyMU
 D3ALZIMkEl2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="207786806"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="207786806"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 04:57:56 -0800
IronPort-SDR: KLfwtnP4cQslc8+bjJygTR3OoeonRsGy+kYS6FRmKvSBDKNIjH69/5/I6rHSoWmB46Amay2mLn
 //8H7F5uuEhQ==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="409289301"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.249.172.44]) ([10.249.172.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 04:57:51 -0800
Subject: Re: [PATCH v3] perf pmu: Validate raw event with sysfs exported
 format bits
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210308031506.23019-1-yao.jin@linux.intel.com>
 <YEX91MTGMU41zeuF@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <c06cdd0d-fee2-ab6d-1d22-49a6590996ea@linux.intel.com>
Date:   Mon, 8 Mar 2021 20:57:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEX91MTGMU41zeuF@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/8/2021 6:35 PM, Jiri Olsa wrote:
> On Mon, Mar 08, 2021 at 11:15:06AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 44ef28302fc7..03ab1e6d0418 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -1812,3 +1812,39 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>>   
>>   	return nr_caps;
>>   }
>> +
>> +void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>> +				   char *name)
>> +{
>> +	struct perf_pmu_format *format;
>> +	__u64 masks = 0, bits;
>> +	char buf[100];
>> +	unsigned int i;
>> +
>> +	list_for_each_entry(format, &pmu->format, list)	{
>> +		/*
>> +		 * Skip extra configs such as config1/config2.
>> +		 */
>> +		if (format->value > 0)
>> +			continue;
> 
> sorry I did not notice before, but could you please use more direct
> approach like:
> 
> 		if (format->value == PERF_PMU_FORMAT_VALUE_CONFIG) {
> 			break;
> 		}
> 
> this will be more obvious, also no need for the comment.. I spent some
> time looking what's the value for ;-)
> 
> thanks,
> jirka
> 

Oh, yes, using PERF_PMU_FORMAT_VALUE_CONFIG is much more obvious. Sorry about that!

While it can't break the loop, because we need to iterate over the whole list to get the total valid 
bits. So like:

if (format->value != PERF_PMU_FORMAT_VALUE_CONFIG)
	continue;

Is it right?

I will post v4 tomorrow.

Thanks
Jin Yao

>> +
>> +		for_each_set_bit(i, format->bits, PERF_PMU_FORMAT_BITS)
>> +			masks |= 1ULL << i;
>> +	}
>> +
>> +	/*
>> +	 * Kernel doesn't export any valid format bits.
>> +	 */
>> +	if (masks == 0)
>> +		return;
>> +
>> +	bits = config & ~masks;
>> +	if (bits == 0)
>> +		return;
>> +
>> +	bitmap_scnprintf((unsigned long *)&bits, sizeof(bits) * 8, buf, sizeof(buf));
>> +
>> +	pr_warning("WARNING: event '%s' not valid (bits %s of config "
>> +		   "'%llx' not supported by kernel)!\n",
>> +		   name ?: "N/A", buf, config);
>> +}
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index 8164388478c6..160b0f561771 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -123,4 +123,7 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
>>   
>>   int perf_pmu__caps_parse(struct perf_pmu *pmu);
>>   
>> +void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>> +				   char *name);
>> +
>>   #endif /* __PMU_H */
>> -- 
>> 2.17.1
>>
> 

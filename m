Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC87331D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 04:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhCIDAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 22:00:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:27909 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230492AbhCIDAK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 22:00:10 -0500
IronPort-SDR: IxUR+JC2wFTjdjCFYA+co/7274qMKJEe1yZlSj3jVUVsJTzAAI1t0MxZbvPa8NGnehtM7tVlgZ
 +6HRRzk+6HfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175257362"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="175257362"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 19:00:09 -0800
IronPort-SDR: bz9DyvP7moEZSv9RyKdF6OSUNwClMq9rqTZp8ayaUO5o9h5ZRgowmZy/Y8CWdbnsb+QJ/1Zbaf
 b7hi+ND2rXEw==
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="403056145"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 19:00:05 -0800
Subject: Re: [PATCH v3] perf pmu: Validate raw event with sysfs exported
 format bits
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210308031506.23019-1-yao.jin@linux.intel.com>
 <YEX91MTGMU41zeuF@krava>
 <c06cdd0d-fee2-ab6d-1d22-49a6590996ea@linux.intel.com>
 <YEYjQOYI7utqnCq6@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <b84f76b1-1300-ef04-9845-ff206dec9f10@linux.intel.com>
Date:   Tue, 9 Mar 2021 11:00:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEYjQOYI7utqnCq6@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/8/2021 9:14 PM, Jiri Olsa wrote:
> On Mon, Mar 08, 2021 at 08:57:49PM +0800, Jin, Yao wrote:
>> Hi Jiri,
>>
>> On 3/8/2021 6:35 PM, Jiri Olsa wrote:
>>> On Mon, Mar 08, 2021 at 11:15:06AM +0800, Jin Yao wrote:
>>>
>>> SNIP
>>>
>>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>>> index 44ef28302fc7..03ab1e6d0418 100644
>>>> --- a/tools/perf/util/pmu.c
>>>> +++ b/tools/perf/util/pmu.c
>>>> @@ -1812,3 +1812,39 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>>>>    	return nr_caps;
>>>>    }
>>>> +
>>>> +void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>>>> +				   char *name)
>>>> +{
>>>> +	struct perf_pmu_format *format;
>>>> +	__u64 masks = 0, bits;
>>>> +	char buf[100];
>>>> +	unsigned int i;
>>>> +
>>>> +	list_for_each_entry(format, &pmu->format, list)	{
>>>> +		/*
>>>> +		 * Skip extra configs such as config1/config2.
>>>> +		 */
>>>> +		if (format->value > 0)
>>>> +			continue;
>>>
>>> sorry I did not notice before, but could you please use more direct
>>> approach like:
>>>
>>> 		if (format->value == PERF_PMU_FORMAT_VALUE_CONFIG) {
>>> 			break;
>>> 		}
>>>
>>> this will be more obvious, also no need for the comment.. I spent some
>>> time looking what's the value for ;-)
>>>
>>> thanks,
>>> jirka
>>>
>>
>> Oh, yes, using PERF_PMU_FORMAT_VALUE_CONFIG is much more obvious. Sorry about that!
>>
>> While it can't break the loop, because we need to iterate over the whole
>> list to get the total valid bits. So like:
>>
>> if (format->value != PERF_PMU_FORMAT_VALUE_CONFIG)
>> 	continue;
>>
>> Is it right?
> 
> sure, what I meant was to process only PERF_PMU_FORMAT_VALUE_CONFIG
> and then call break, because there's no need to iterate further
> 
> jirka
> 

Sorry, maybe I still misunderstood what you suggested.

My understanding is we still need to iterate the whole formats list even we find a 
PERF_PMU_FORMAT_VALUE_CONFIG.

root@kbl-ppc:/sys/devices/cpu/format# ls
any  cmask  edge  event  frontend  in_tx  in_tx_cp  inv  ldlat  offcore_rsp  pc  umask
root@kbl-ppc:/sys/devices/cpu/format# cat any
config:21
root@kbl-ppc:/sys/devices/cpu/format# cat cmask
config:24-31
root@kbl-ppc:/sys/devices/cpu/format# cat edge
config:18
root@kbl-ppc:/sys/devices/cpu/format# cat edge
config:18
root@kbl-ppc:/sys/devices/cpu/format# cat event
config:0-7
root@kbl-ppc:/sys/devices/cpu/format# cat frontend
config1:0-23
root@kbl-ppc:/sys/devices/cpu/format# cat in_tx_cp
config:33
root@kbl-ppc:/sys/devices/cpu/format# cat inv
config:23
root@kbl-ppc:/sys/devices/cpu/format# cat ldlat
config1:0-15
root@kbl-ppc:/sys/devices/cpu/format# cat offcore_rsp
config1:0-63
root@kbl-ppc:/sys/devices/cpu/format# cat pc
config:19
root@kbl-ppc:/sys/devices/cpu/format# cat umask
config:8-15

If we break the loop when we get the first PERF_PMU_FORMAT_VALUE_CONFIG, we will only get the format 
'any', right?

Thanks
Jin Yao

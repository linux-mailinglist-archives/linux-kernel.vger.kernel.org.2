Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C4235B862
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 04:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhDLCBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 22:01:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:11707 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235543AbhDLCBx (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 22:01:53 -0400
IronPort-SDR: 9yroIMTLsRBYzKEhkx4nkWTu3DjzE5Y2LjMioZu+zsK/Cn/6pSfDF2naGPVPmDCmVjkLKXldVf
 QoBHhecjmVsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="214551143"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="214551143"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 19:01:35 -0700
IronPort-SDR: gQy0LhDHM+J5x278/CsruSjKQmU3l9RVn25wXZ4Vs9GurjDZGI3NQWaFizUdbjNlccMj0JM/gU
 mDti7+eQy+bw==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="451229238"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 19:01:33 -0700
Subject: Re: [PATCH v3 11/27] perf pmu: Support 'cycles' and 'branches' inside
 hybrid PMU
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-12-yao.jin@linux.intel.com> <YHBbJEKjE3DuPvZZ@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <a9a2f035-5b5a-be3c-af75-5fffee650a24@linux.intel.com>
Date:   Mon, 12 Apr 2021 10:01:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHBbJEKjE3DuPvZZ@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/9/2021 9:48 PM, Jiri Olsa wrote:
> On Mon, Mar 29, 2021 at 03:00:30PM +0800, Jin Yao wrote:
>> On hybrid platform, user may want to enable the hardware event
>> only on one PMU. So following syntax is supported:
>>
>> cpu_core/<hardware event>/
>> cpu_atom/<hardware event>/
>>
>>    # perf stat -e cpu_core/cpu-cycles/ -a -- sleep 1
>>
>>     Performance counter stats for 'system wide':
>>
>>             6,049,336      cpu_core/cpu-cycles/
>>
>>           1.003577042 seconds time elapsed
>>
>> It enables the event 'cpu-cycles' only on cpu_core pmu.
>>
>> But for 'cycles' and 'branches', the syntax doesn't work.
> 
> because the alias is not there.. but there's:
>    cpu/cpu-cycles/
>    cpu/branch-instructions/
> 
> doing the same thing..  what's wrong with that?
> 
> I have a feeling we discussed this in the previous
> version.. did I give up? ;-)
> 

Yes, we discussed this in previous threads. :)

Now I'm fine to keep the original behavior. Because the syntax 'cpu/cycles/' and 'cpu/branches/' are 
not supported by current perf.

> SNIP
> 
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index beff29981101..72e5ae5e868e 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -916,6 +916,35 @@ static int pmu_max_precise(const char *name)
>>   	return max_precise;
>>   }
>>   
>> +static void perf_pmu__add_hybrid_aliases(struct list_head *head)
>> +{
>> +	static struct pmu_event pme_hybrid_fixup[] = {
>> +		{
>> +			.name = "cycles",
>> +			.event = "event=0x3c",
>> +		},
>> +		{
>> +			.name = "branches",
>> +			.event = "event=0xc4",
>> +		},
>> +		{
>> +			.name = 0,
>> +			.event = 0,
>> +		},
> 
> if you really need to access these 2 events with special name,
> why not add it through the json.. let's not have yet another
> place that defines aliases ... also this should be model specific
> no?
> 

Yes, defining in json is a good idea if we really need to support 'cpu/cycles/' and 'cpu/branches/'.

Anyway, I will drop this patch in next version.

Thanks
Jin Yao

> jirka
> 

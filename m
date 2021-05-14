Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F46380526
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhENI06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:26:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:42279 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230459AbhENI05 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:26:57 -0400
IronPort-SDR: SUy9smRe4vVeWNJ1TlG+GsgYoWBRBlqrZQ0V65FPRwZfFBFo33+VvoKuUiLfvs99yNkA/NVHd3
 oFFtTohEDeMw==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="197052394"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="197052394"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 01:25:46 -0700
IronPort-SDR: BuypO+HpOVZSCiQzdscVOG6/zC0fKoeruGxQGmUA4rRpHKn+sJAuUkhOA7UIYs9o8UutQpXa6T
 KNUo164GEaJw==
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="626813096"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.82]) ([10.238.4.82])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 01:25:44 -0700
Subject: Re: [PATCH v3 2/2] perf header: Support HYBRID_CPU_PMU_CAPS feature
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210511053003.27015-1-yao.jin@linux.intel.com>
 <20210511053003.27015-3-yao.jin@linux.intel.com> <YJ4x0usa1ljPT5DV@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <4381cb3b-a0de-e8e9-baf9-c6e202c5abef@linux.intel.com>
Date:   Fri, 14 May 2021 16:25:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJ4x0usa1ljPT5DV@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/14/2021 4:16 PM, Jiri Olsa wrote:
> On Tue, May 11, 2021 at 01:30:03PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
>> index fbee9e580ee4..e6ff8c898ada 100644
>> --- a/tools/perf/Documentation/perf.data-file-format.txt
>> +++ b/tools/perf/Documentation/perf.data-file-format.txt
>> @@ -419,6 +419,22 @@ Example:
>>     cpu_core cpu list : 0-15
>>     cpu_atom cpu list : 16-23
>>   
>> +	HEADER_HYBRID_CPU_PMU_CAPS = 31,
>> +
>> +	A list of hybrid CPU PMU capabilities.
>> +
>> +struct {
>> +	u32 nr_pmu;
>> +	struct {
>> +		u32 nr_cpu_pmu_caps;
>> +		{
>> +			char	name[];
>> +			char	value[];
>> +		} [nr_cpu_pmu_caps];
>> +		char pmu_name[];
>> +	} [nr_pmu];
>> +};
> 
> when I saw it's similar to the previous one I thought we could have
> one big hybrid feature.. but that would be probably more complex and
> we might not be able to reuse the code as much as you did
> 

Yes. Actually I had the same idea before but as you said the code would be more complex.

> 
>>   free_value:
>> @@ -3142,6 +3208,64 @@ static int process_cpu_pmu_caps(struct feat_fd *ff,
>>   	return -1;
>>   }
>>   
>> +static int process_cpu_pmu_caps(struct feat_fd *ff,
>> +				void *data __maybe_unused)
>> +{
>> +	int ret;
>> +
>> +	ret = process_per_cpu_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
>> +				       &ff->ph->env.cpu_pmu_caps,
>> +				       &ff->ph->env.max_branches);
>> +	return ret;
> 
> why the 'ret' var? could be just:
> 
>     return process_per_cpu_pmu_caps(...
> 

OK, I will fix it in v4.

>> +}
>> +
>> +static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>> +				       void *data __maybe_unused)
>> +{
>> +	struct hybrid_cpc_node *nodes;
>> +	u32 nr_pmu, i;
>> +	int ret;
>> +
>> +	if (do_read_u32(ff, &nr_pmu))
>> +		return -1;
>> +
>> +	if (!nr_pmu) {
>> +		pr_debug("hybrid cpu pmu capabilities not available\n");
>> +		return 0;
>> +	}
>> +
>> +	nodes = zalloc(sizeof(*nodes) * nr_pmu);
>> +	if (!nodes)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < nr_pmu; i++) {
>> +		struct hybrid_cpc_node *n = &nodes[i];
>> +
>> +		ret = process_per_cpu_pmu_caps(ff, &n->nr_cpu_pmu_caps,
>> +					       &n->cpu_pmu_caps,
>> +					       &n->max_branches);
>> +		if (ret)
>> +			goto err;
>> +
>> +		n->pmu_name = do_read_string(ff);
>> +		if (!n->pmu_name)
> 
> should you set 'ret = -1' in here?
> 

Yes, I should add 'ret = -1' before 'n->pmu_name = do_read_string(ff);'.

> other than this both patches look good to me
> 

Thanks, I will prepare v4 soon.

Thanks
Jin Yao

> thanks,
> jirka
> 
>> +			goto err;
>> +	}
>> +
>> +	ff->ph->env.nr_hybrid_cpc_nodes = nr_pmu;
>> +	ff->ph->env.hybrid_cpc_nodes = nodes;
>> +	return 0;
>> +
>> +err:
>> +	for (i = 0; i < nr_pmu; i++) {
>> +		free(nodes[i].cpu_pmu_caps);
> 
> SNIP
> 

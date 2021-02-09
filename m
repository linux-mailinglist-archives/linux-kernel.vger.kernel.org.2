Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B197314521
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhBIAzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:55:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:10595 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhBIAzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:55:33 -0500
IronPort-SDR: cnWveyiLb5HRmoOUbEYN7y2xX96vjMnPjHkrpxTYvU4JYuXKrbvzX4z5dddfTmHQD8rxnAmDPy
 9kcPP21VqpDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181951965"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="181951965"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 16:53:46 -0800
IronPort-SDR: f4GPOf/tGk4NGtNDq8iV+ngdivpxa0jYrS6gBGdZIjoF5cMPFg2Wgoq18Kb4FF5Le5/g+R7FOR
 s8VlqY5qYwjg==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="395823852"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 16:53:42 -0800
Subject: Re: [PATCH 46/49] perf stat: Filter out unmatched aggregation for
 hybrid event
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        "Jin, Yao" <yao.jin@intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <1612797946-18784-47-git-send-email-kan.liang@linux.intel.com>
 <20210208191645.GQ920417@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <6f91b752-6e00-b595-62d4-e19b2e724eb3@linux.intel.com>
Date:   Tue, 9 Feb 2021 08:53:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210208191645.GQ920417@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 2/9/2021 3:16 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 08, 2021 at 07:25:43AM -0800, kan.liang@linux.intel.com escreveu:
>> From: Jin Yao <yao.jin@linux.intel.com>
>>
>> perf-stat has supported some aggregation modes, such as --per-core,
>> --per-socket and etc. While for hybrid event, it may only available
>> on part of cpus. So for --per-core, we need to filter out the
>> unavailable cores, for --per-socket, filter out the unavailable
>> sockets, and so on.
>>
>> Before:
>>
>> root@otcpl-adl-s-2:~# ./perf stat --per-core -e cpu_core/cycles/ -a -- sleep 1
>>
>>   Performance counter stats for 'system wide':
>>
>> S0-D0-C0           2            311,114      cycles [cpu_core]
> 
> Why not use the pmu style event name, i.e.:
> 
> S0-D0-C0           2            311,114        cpu_core/cycles/
> 
> ?
> 

For "cycles [cpu_core]" style, it's very easy. We just need to set 'stat_config.no_merge = true', 
and no more coding work.

Please let me think about a easy way for pmu style event name.

Thanks
Jin Yao

>> S0-D0-C4           2             59,784      cycles [cpu_core]
>> S0-D0-C8           2            121,287      cycles [cpu_core]
>> S0-D0-C12          2          2,690,245      cycles [cpu_core]
>> S0-D0-C16          2          2,060,545      cycles [cpu_core]
>> S0-D0-C20          2          3,632,251      cycles [cpu_core]
>> S0-D0-C24          2            775,736      cycles [cpu_core]
>> S0-D0-C28          2            742,020      cycles [cpu_core]
>> S0-D0-C32          0      <not counted>      cycles [cpu_core]
>> S0-D0-C33          0      <not counted>      cycles [cpu_core]
>> S0-D0-C34          0      <not counted>      cycles [cpu_core]
>> S0-D0-C35          0      <not counted>      cycles [cpu_core]
>> S0-D0-C36          0      <not counted>      cycles [cpu_core]
>> S0-D0-C37          0      <not counted>      cycles [cpu_core]
>> S0-D0-C38          0      <not counted>      cycles [cpu_core]
>> S0-D0-C39          0      <not counted>      cycles [cpu_core]
>>
>>         1.001779842 seconds time elapsed
>>
>> After:
>>
>> root@otcpl-adl-s-2:~# ./perf stat --per-core -e cpu_core/cycles/ -a -- sleep 1
>>
>>   Performance counter stats for 'system wide':
>>
>> S0-D0-C0           2          1,088,230      cycles [cpu_core]
>> S0-D0-C4           2             57,228      cycles [cpu_core]
>> S0-D0-C8           2             98,327      cycles [cpu_core]
>> S0-D0-C12          2          2,741,955      cycles [cpu_core]
>> S0-D0-C16          2          2,090,432      cycles [cpu_core]
>> S0-D0-C20          2          3,192,108      cycles [cpu_core]
>> S0-D0-C24          2          2,910,752      cycles [cpu_core]
>> S0-D0-C28          2            388,696      cycles [cpu_core]
>>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/stat-display.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>> index 21a3f80..fa11572 100644
>> --- a/tools/perf/util/stat-display.c
>> +++ b/tools/perf/util/stat-display.c
>> @@ -630,6 +630,20 @@ static void aggr_cb(struct perf_stat_config *config,
>>   	}
>>   }
>>   
>> +static bool aggr_id_hybrid_matched(struct perf_stat_config *config,
>> +				   struct evsel *counter, struct aggr_cpu_id id)
>> +{
>> +	struct aggr_cpu_id s;
>> +
>> +	for (int i = 0; i < evsel__nr_cpus(counter); i++) {
>> +		s = config->aggr_get_id(config, evsel__cpus(counter), i);
>> +		if (cpu_map__compare_aggr_cpu_id(s, id))
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   static void print_counter_aggrdata(struct perf_stat_config *config,
>>   				   struct evsel *counter, int s,
>>   				   char *prefix, bool metric_only,
>> @@ -643,6 +657,12 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>>   	double uval;
>>   
>>   	ad.id = id = config->aggr_map->map[s];
>> +
>> +	if (perf_pmu__hybrid_exist() &&
>> +	    !aggr_id_hybrid_matched(config, counter, id)) {
>> +		return;
>> +	}
>> +
>>   	ad.val = ad.ena = ad.run = 0;
>>   	ad.nr = 0;
>>   	if (!collect_data(config, counter, aggr_cb, &ad))
>> -- 
>> 2.7.4
>>
> 

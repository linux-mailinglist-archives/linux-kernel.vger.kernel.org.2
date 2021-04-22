Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011D73677C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 05:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhDVDLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 23:11:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:58213 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhDVDLf (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 23:11:35 -0400
IronPort-SDR: RlwyIpjHr6BCMWbLdKIROEAtYAPKDHpo4SNC6PH8266P1Pqnz4Ye3k8+kAiSoCZ/SucdxWHLHG
 Haa0bV/401bg==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="281147150"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="281147150"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:11:00 -0700
IronPort-SDR: fRAdjy9WupuSVeddIAiQlV3uBpgAyfTf6uuDaiv9baQJ/lPxOshpALS1Hb9+XZPGSDjQsQMMyE
 ICd0G4UUlnsA==
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="427755221"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:10:57 -0700
Subject: Re: [PATCH v4 15/25] perf stat: Filter out unmatched aggregation for
 hybrid event
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-16-yao.jin@linux.intel.com> <YIBvJLAvL0rWGhhP@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1da39794-bdc3-2a9d-4038-9e95e2c02660@linux.intel.com>
Date:   Thu, 22 Apr 2021 11:10:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIBvJLAvL0rWGhhP@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/22/2021 2:29 AM, Jiri Olsa wrote:
> On Fri, Apr 16, 2021 at 10:05:07PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>> index 5255d78b1c30..15eafd249e46 100644
>> --- a/tools/perf/util/stat-display.c
>> +++ b/tools/perf/util/stat-display.c
>> @@ -643,6 +643,20 @@ static void aggr_cb(struct perf_stat_config *config,
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
>> @@ -656,6 +670,12 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>>   	double uval;
>>   
>>   	ad.id = id = config->aggr_map->map[s];
>> +
>> +	if (perf_pmu__has_hybrid() &&
>> +	    !aggr_id_hybrid_matched(config, counter, id)) {
>> +		return;
>> +	}
>> +
>>   	ad.val = ad.ena = ad.run = 0;
>>   	ad.nr = 0;
>>   	if (!collect_data(config, counter, aggr_cb, &ad))
> 
> there's same check in aggr_cb, so it seems like we could just make check in here:
> 
> 	if (perf_pmu__has_hybrid() && ad.ena == 0)
> 		return;
> 
> without another extra loop
> 
> jirka
> 

I guess you recommended the patch like this:

  static void print_counter_aggrdata(struct perf_stat_config *config,
                                    struct evsel *counter, int s,
                                    char *prefix, bool metric_only,
@@ -670,17 +656,14 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
         double uval;

         ad.id = id = config->aggr_map->map[s];
         ad.val = ad.ena = ad.run = 0;
         ad.nr = 0;
         if (!collect_data(config, counter, aggr_cb, &ad))
                 return;

+       if (perf_pmu__has_hybrid() && ad.ena == 0)
+               return;
+
         nr = ad.nr;
         ena = ad.ena;
         run = ad.run;

Yes, it works. The test log is,

# perf stat --per-core -e cpu_core/cycles/ -a -- sleep 1

  Performance counter stats for 'system wide':

S0-D0-C0           2          2,341,923      cpu_core/cycles/
S0-D0-C4           2          1,707,933      cpu_core/cycles/
S0-D0-C8           2            845,805      cpu_core/cycles/
S0-D0-C12          2          1,001,961      cpu_core/cycles/
S0-D0-C16          2            932,004      cpu_core/cycles/
S0-D0-C20          2          1,778,603      cpu_core/cycles/
S0-D0-C24          2            804,448      cpu_core/cycles/
S0-D0-C28          2            178,360      cpu_core/cycles/

        1.002264168 seconds time elapsed

Thanks
Jin Yao

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5762138FB54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhEYHCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:02:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:11196 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhEYHCI (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:02:08 -0400
IronPort-SDR: UN3qc1U4AbZ9ytSg6YeHSH0z2GRT6FrOqmS+RtNCdsvbVkhmiZKIV22NGGyu5fZ0uzIecGapOj
 1W7CBRysnEYg==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="199065814"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="199065814"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 00:00:33 -0700
IronPort-SDR: VL9kVIMXwZ6l6hoMe2ZBkif8ykao6qJrwWrz68zzbxah28T6psBHvd4Opb4/6HC7rY8kL+iXGv
 U8zDnp9q0k4Q==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="442415002"
Received: from unknown (HELO [10.239.159.33]) ([10.239.159.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 00:00:30 -0700
Subject: Re: [PATCH v1 4/5] perf mem: Support record for hybrid platform
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210520070040.710-1-yao.jin@linux.intel.com>
 <20210520070040.710-5-yao.jin@linux.intel.com> <YKvgFVVywalr+Owr@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <3d9e738d-b972-056b-d0bc-35ed1aaefbad@linux.intel.com>
Date:   Tue, 25 May 2021 15:00:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKvgFVVywalr+Owr@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/25/2021 1:19 AM, Jiri Olsa wrote:
> On Thu, May 20, 2021 at 03:00:39PM +0800, Jin Yao wrote:
>> Support 'perf mem record' for hybrid platform. On hybrid platform,
>> such as Alderlake, when executing 'perf mem record', it actually calls:
>>
>> record -e {cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}:P
>>         -e cpu_atom/mem-loads,ldlat=30/P
>>         -e cpu_core/mem-stores/P
>>         -e cpu_atom/mem-stores/P
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-mem.c     | 39 ++++++++++++----------
>>   tools/perf/util/mem-events.c | 65 ++++++++++++++++++++++++++++++++++++
>>   tools/perf/util/mem-events.h |  2 ++
>>   3 files changed, 89 insertions(+), 17 deletions(-)
>>
>> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
>> index 03795bf49d51..a50abcb45f0f 100644
>> --- a/tools/perf/builtin-mem.c
>> +++ b/tools/perf/builtin-mem.c
>> @@ -62,8 +62,9 @@ static const char * const *record_mem_usage = __usage;
>>   
>>   static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>>   {
>> -	int rec_argc, i = 0, j;
>> +	int rec_argc, i = 0, j,  tmp_nr = 0;
>>   	const char **rec_argv;
>> +	char **rec_tmp;
>>   	int ret;
>>   	bool all_user = false, all_kernel = false;
>>   	struct perf_mem_event *e;
>> @@ -87,11 +88,20 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>>   	argc = parse_options(argc, argv, options, record_mem_usage,
>>   			     PARSE_OPT_KEEP_UNKNOWN);
>>   
>> -	rec_argc = argc + 9; /* max number of arguments */
>> +	rec_argc = argc + 64; /* max number of arguments */
> 
> please add comment on how you got the number 64
> 

original max number of arguments is 9, *2 (=18) for hybrid pmus. 18 should be OK. I use 64 is to 
allocate a big enough value.

> 
>>   	rec_argv = calloc(rec_argc + 1, sizeof(char *));
>>   	if (!rec_argv)
>>   		return -1;
>>   
>> +	/*
>> +	 * Save the allocated event name strings.
>> +	 */
>> +	rec_tmp = calloc(rec_argc + 1, sizeof(char *));
>> +	if (!rec_tmp) {
>> +		free(rec_argv);
>> +		return -1;
>> +	}
> 
> why not do strdup on all of them and always call free instead?
> that would get rid of the rec_tmp and tmp_nr
> 

That is also one method. Let me try it.

>> +
>>   	rec_argv[i++] = "record";
>>   
>>   	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
>> @@ -128,21 +138,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>>   	if (mem->data_page_size)
>>   		rec_argv[i++] = "--data-page-size";
>>   
>> -	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
>> -		e = perf_mem_events__ptr(j);
>> -		if (!e->record)
>> -			continue;
>> -
>> -		if (!e->supported) {
>> -			pr_err("failed: event '%s' not supported\n",
>> -			       perf_mem_events__name(j, NULL));
>> -			free(rec_argv);
>> -			return -1;
>> -		}
>> -
>> -		rec_argv[i++] = "-e";
>> -		rec_argv[i++] = perf_mem_events__name(j, NULL);
>> -	}
>> +	ret = perf_mem_events__record_args(rec_argv, &i, rec_tmp, &tmp_nr);
>> +	if (ret)
>> +		goto out;
>>   
>>   	if (all_user)
>>   		rec_argv[i++] = "--all-user";
>> @@ -164,6 +162,13 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>>   	}
>>   
>>   	ret = cmd_record(i, rec_argv);
>> +out:
>> +	for (i = 0; i < tmp_nr; i++) {
>> +		if (rec_tmp[i])
>> +			free(rec_tmp[i]);
> 
> no need to check rec_tmp[i] != NULL, free will do that
>

Yes, no need checking for NULL here.

Thanks
Jin Yao

>> +	}
>> +
>> +	free(rec_tmp);
>>   	free(rec_argv);
>>   	return ret;
>>   }
>> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
>> index e8f6e745eaf0..909ee91b75f0 100644
>> --- a/tools/perf/util/mem-events.c
>> +++ b/tools/perf/util/mem-events.c
>> @@ -173,6 +173,71 @@ void perf_mem_events__list(void)
>>   	}
>>   }
>>   
>> +static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
>> +						    int idx)
>> +{
>> +	const char *mnt = sysfs__mount();
>> +	char sysfs_name[100];
>> +	struct perf_pmu *pmu;
>> +
>> +	perf_pmu__for_each_hybrid_pmu(pmu) {
>> +		scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name,
>> +			  pmu->name);
>> +		if (!perf_mem_events__supported(mnt, sysfs_name)) {
>> +			pr_err("failed: event '%s' not supported\n",
>> +			       perf_mem_events__name(idx, pmu->name));
>> +		}
>> +	}
>> +}
>> +
>> +int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>> +				 char **rec_tmp, int *tmp_nr)
>> +{
>> +	int i = *argv_nr, k = 0;
>> +	struct perf_mem_event *e;
>> +	struct perf_pmu *pmu;
>> +	char *s;
>> +
>> +	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
>> +		e = perf_mem_events__ptr(j);
>> +		if (!e->record)
>> +			continue;
>> +
>> +		if (!perf_pmu__has_hybrid()) {
>> +			if (!e->supported) {
>> +				pr_err("failed: event '%s' not supported\n",
>> +				       perf_mem_events__name(j, NULL));
>> +				return -1;
>> +			}
>> +
>> +			rec_argv[i++] = "-e";
>> +			rec_argv[i++] = perf_mem_events__name(j, NULL);
>> +		} else {
>> +			if (!e->supported) {
>> +				perf_mem_events__print_unsupport_hybrid(e, j);
>> +				return -1;
>> +			}
>> +
>> +			perf_pmu__for_each_hybrid_pmu(pmu) {
>> +				rec_argv[i++] = "-e";
>> +				s = perf_mem_events__name(j, pmu->name);
>> +				if (s) {
>> +					s = strdup(s);
>> +					if (!s)
>> +						return -1;
>> +
>> +					rec_argv[i++] = s;
>> +					rec_tmp[k++] = s;
>> +				}
>> +			}
>> +		}
>> +	}
>> +
>> +	*argv_nr = i;
>> +	*tmp_nr = k;
>> +	return 0;
>> +}
>> +
>>   static const char * const tlb_access[] = {
>>   	"N/A",
>>   	"HIT",
>> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
>> index a3fa19093fd2..916242f8020a 100644
>> --- a/tools/perf/util/mem-events.h
>> +++ b/tools/perf/util/mem-events.h
>> @@ -43,6 +43,8 @@ struct perf_mem_event *perf_mem_events__ptr(int i);
>>   bool is_mem_loads_aux_event(struct evsel *leader);
>>   
>>   void perf_mem_events__list(void);
>> +int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>> +				 char **rec_tmp, int *tmp_nr);
>>   
>>   int perf_mem__tlb_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
>>   int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
>> -- 
>> 2.17.1
>>
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC9239F7C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhFHN0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:26:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:18618 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232797AbhFHN0v (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:26:51 -0400
IronPort-SDR: g5VTSsJNrcV+OAxaIYPyDfERIArbKMosEeHZ4KyO82TzZUkG2O3hxmlPGI0VbUpOAPpMdo7P2X
 lCdOv2NL3uTg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="268695282"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="268695282"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 06:24:56 -0700
IronPort-SDR: IwY+72vvmPu9ocR7J1LjyQJ4c+PuoED+ZH6brkydGyXKC24w6UH8CQnz1KrGovjXD9eC0HUIZ+
 RUpMouN8Jqzg==
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="481947517"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.249.172.44]) ([10.249.172.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 06:24:52 -0700
Subject: Re: [PATCH] perf evsel: Adjust hybrid event and global event mixed
 group
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210601013827.1102-1-yao.jin@linux.intel.com>
 <YL9M+FUE5BHaD9w/@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1110d89c-b948-7e72-08cb-dbbf2cca2d65@linux.intel.com>
Date:   Tue, 8 Jun 2021 21:24:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YL9M+FUE5BHaD9w/@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 6/8/2021 6:56 PM, Jiri Olsa wrote:
> On Tue, Jun 01, 2021 at 09:38:27AM +0800, Jin Yao wrote:
>> A group mixed with hybrid event and global event is allowed. For example,
>> group leader is 'intel_pt//' and the group member is 'cpu_atom/cycles/'.
>>
>> e.g.
>> perf record --aux-sample -e '{intel_pt//,cpu_atom/cycles/}:u'
>>
>> The challenge is their available cpus are not fully matched. For example,
>> 'intel_pt//' is available on CPU0-CPU23, but 'cpu_atom/cycles/' is
>> available on CPU16-CPU23.
>>
>> When getting the group id for group member, we must be very careful.
>> Because the cpu for 'intel_pt//' is not equal to the cpu for
>> 'cpu_atom/cycles/'. Actually the cpu here is the index of evsel->core.cpus,
>> not the real CPU ID.
>>
>> e.g. cpu0 for 'intel_pt//' is CPU0, but cpu0 for 'cpu_atom/cycles/' is CPU16.
>>
>> Before:
>>
>>    # perf record --aux-sample -e '{intel_pt//,cpu_atom/cycles/}:u' -vv uname
>>    ...
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             10
>>      size                             128
>>      config                           0xe601
>>      { sample_period, sample_freq }   1
>>      sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      exclude_kernel                   1
>>      exclude_hv                       1
>>      enable_on_exec                   1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid 4084  cpu 0  group_fd -1  flags 0x8 = 5
>>    sys_perf_event_open: pid 4084  cpu 1  group_fd -1  flags 0x8 = 6
>>    sys_perf_event_open: pid 4084  cpu 2  group_fd -1  flags 0x8 = 7
>>    sys_perf_event_open: pid 4084  cpu 3  group_fd -1  flags 0x8 = 9
>>    sys_perf_event_open: pid 4084  cpu 4  group_fd -1  flags 0x8 = 10
>>    sys_perf_event_open: pid 4084  cpu 5  group_fd -1  flags 0x8 = 11
>>    sys_perf_event_open: pid 4084  cpu 6  group_fd -1  flags 0x8 = 12
>>    sys_perf_event_open: pid 4084  cpu 7  group_fd -1  flags 0x8 = 13
>>    sys_perf_event_open: pid 4084  cpu 8  group_fd -1  flags 0x8 = 14
>>    sys_perf_event_open: pid 4084  cpu 9  group_fd -1  flags 0x8 = 15
>>    sys_perf_event_open: pid 4084  cpu 10  group_fd -1  flags 0x8 = 16
>>    sys_perf_event_open: pid 4084  cpu 11  group_fd -1  flags 0x8 = 17
>>    sys_perf_event_open: pid 4084  cpu 12  group_fd -1  flags 0x8 = 18
>>    sys_perf_event_open: pid 4084  cpu 13  group_fd -1  flags 0x8 = 19
>>    sys_perf_event_open: pid 4084  cpu 14  group_fd -1  flags 0x8 = 20
>>    sys_perf_event_open: pid 4084  cpu 15  group_fd -1  flags 0x8 = 21
>>    sys_perf_event_open: pid 4084  cpu 16  group_fd -1  flags 0x8 = 22
>>    sys_perf_event_open: pid 4084  cpu 17  group_fd -1  flags 0x8 = 23
>>    sys_perf_event_open: pid 4084  cpu 18  group_fd -1  flags 0x8 = 24
>>    sys_perf_event_open: pid 4084  cpu 19  group_fd -1  flags 0x8 = 25
>>    sys_perf_event_open: pid 4084  cpu 20  group_fd -1  flags 0x8 = 26
>>    sys_perf_event_open: pid 4084  cpu 21  group_fd -1  flags 0x8 = 27
>>    sys_perf_event_open: pid 4084  cpu 22  group_fd -1  flags 0x8 = 28
>>    sys_perf_event_open: pid 4084  cpu 23  group_fd -1  flags 0x8 = 29
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      size                             128
>>      config                           0x800000000
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|PERIOD|IDENTIFIER|AUX
>>      read_format                      ID
>>      inherit                          1
>>      exclude_kernel                   1
>>      exclude_hv                       1
>>      freq                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>      aux_sample_size                  4096
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid 4084  cpu 16  group_fd 5  flags 0x8
>>    sys_perf_event_open failed, error -22
>>
>> The group_fd 5 is not correct. It should be 22 (the fd of
>> 'intel_pt' on CPU16).
>>
>> After:
>>
>>    # perf record --aux-sample -e '{intel_pt//,cpu_atom/cycles/}:u' -vv uname
>>    ...
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             10
>>      size                             128
>>      config                           0xe601
>>      { sample_period, sample_freq }   1
>>      sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      exclude_kernel                   1
>>      exclude_hv                       1
>>      enable_on_exec                   1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid 5162  cpu 0  group_fd -1  flags 0x8 = 5
>>    sys_perf_event_open: pid 5162  cpu 1  group_fd -1  flags 0x8 = 6
>>    sys_perf_event_open: pid 5162  cpu 2  group_fd -1  flags 0x8 = 7
>>    sys_perf_event_open: pid 5162  cpu 3  group_fd -1  flags 0x8 = 9
>>    sys_perf_event_open: pid 5162  cpu 4  group_fd -1  flags 0x8 = 10
>>    sys_perf_event_open: pid 5162  cpu 5  group_fd -1  flags 0x8 = 11
>>    sys_perf_event_open: pid 5162  cpu 6  group_fd -1  flags 0x8 = 12
>>    sys_perf_event_open: pid 5162  cpu 7  group_fd -1  flags 0x8 = 13
>>    sys_perf_event_open: pid 5162  cpu 8  group_fd -1  flags 0x8 = 14
>>    sys_perf_event_open: pid 5162  cpu 9  group_fd -1  flags 0x8 = 15
>>    sys_perf_event_open: pid 5162  cpu 10  group_fd -1  flags 0x8 = 16
>>    sys_perf_event_open: pid 5162  cpu 11  group_fd -1  flags 0x8 = 17
>>    sys_perf_event_open: pid 5162  cpu 12  group_fd -1  flags 0x8 = 18
>>    sys_perf_event_open: pid 5162  cpu 13  group_fd -1  flags 0x8 = 19
>>    sys_perf_event_open: pid 5162  cpu 14  group_fd -1  flags 0x8 = 20
>>    sys_perf_event_open: pid 5162  cpu 15  group_fd -1  flags 0x8 = 21
>>    sys_perf_event_open: pid 5162  cpu 16  group_fd -1  flags 0x8 = 22
>>    sys_perf_event_open: pid 5162  cpu 17  group_fd -1  flags 0x8 = 23
>>    sys_perf_event_open: pid 5162  cpu 18  group_fd -1  flags 0x8 = 24
>>    sys_perf_event_open: pid 5162  cpu 19  group_fd -1  flags 0x8 = 25
>>    sys_perf_event_open: pid 5162  cpu 20  group_fd -1  flags 0x8 = 26
>>    sys_perf_event_open: pid 5162  cpu 21  group_fd -1  flags 0x8 = 27
>>    sys_perf_event_open: pid 5162  cpu 22  group_fd -1  flags 0x8 = 28
>>    sys_perf_event_open: pid 5162  cpu 23  group_fd -1  flags 0x8 = 29
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      size                             128
>>      config                           0x800000000
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|PERIOD|IDENTIFIER|AUX
>>      read_format                      ID
>>      inherit                          1
>>      exclude_kernel                   1
>>      exclude_hv                       1
>>      freq                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>      aux_sample_size                  4096
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid 5162  cpu 16  group_fd 22  flags 0x8 = 30
>>    sys_perf_event_open: pid 5162  cpu 17  group_fd 23  flags 0x8 = 31
>>    sys_perf_event_open: pid 5162  cpu 18  group_fd 24  flags 0x8 = 32
>>    sys_perf_event_open: pid 5162  cpu 19  group_fd 25  flags 0x8 = 33
>>    sys_perf_event_open: pid 5162  cpu 20  group_fd 26  flags 0x8 = 34
>>    sys_perf_event_open: pid 5162  cpu 21  group_fd 27  flags 0x8 = 35
>>    sys_perf_event_open: pid 5162  cpu 22  group_fd 28  flags 0x8 = 36
>>    sys_perf_event_open: pid 5162  cpu 23  group_fd 29  flags 0x8 = 37
>>    ------------------------------------------------------------
>>    ...
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> ---
>>   tools/perf/util/evsel.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 4a3cd1b5bb33..a9cf615fe580 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1581,6 +1581,15 @@ int __evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread, bool scale)
>>   	return 0;
>>   }
>>   
>> +static int evsel_cpuid_match(struct evsel *evsel1, struct evsel *evsel2,
>> +			     int cpu)
>> +{
> 
> could this be better name:
> 
>     evsel__match_other_cpu(struct evsel *evsel, struct evsel *other, int cpu)
> 
> 

OK. I will use evsel__match_other_cpu in v2.

>> +	int cpuid;
>> +
>> +	cpuid = perf_cpu_map__cpu(evsel1->core.cpus, cpu);
>> +	return perf_cpu_map__idx(evsel2->core.cpus, cpuid);
>> +}
>> +
>>   static int get_group_fd(struct evsel *evsel, int cpu, int thread)
>>   {
>>   	struct evsel *leader = evsel->leader;
>> @@ -1595,6 +1604,26 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
>>   	 */
>>   	BUG_ON(!leader->core.fd);
>>   
>> +	/*
>> +	 * If leader is global event (e.g. 'intel_pt//'), but member is
>> +	 * hybrid event. Need to get the leader's fd from correct cpu.
>> +	 */
>> +	if (evsel__is_hybrid(evsel) &&
>> +	    !evsel__is_hybrid(leader)) {
>> +		cpu = evsel_cpuid_match(evsel, leader, cpu);
>> +		BUG_ON(cpu == -1);
>> +	}
>> +
>> +	/*
>> +	 * Leader is hybrid event but member is global event.
>> +	 */
>> +	if (!evsel__is_hybrid(evsel) &&
>> +	    evsel__is_hybrid(leader)) {
>> +		cpu = evsel_cpuid_match(evsel, leader, cpu);
>> +		if (cpu == -1)
>> +			return -1;
>> +	}
> 
> why do we call BUG_ON on the first one and return -1 on the other?
> they are equally bad no?
> 

For first one, evsel1 is hybrid event and evsel2 is global event. The evsel1 is only available on 
part of CPUs and evsel2 is avaialbe on total CPUs.

So 'perf_cpu_map__idx(evsel2->core.cpus, cpuid);' must return a valid cpu index otherwise there 
should be a bug here.

For second one, evsel1 is global event and evsel2 is hybrid event. The evsel2 is only available on 
part of CPUs. It's possible that cpuid is not in the range of evsel2->core.cpus. So it's not a bug.

> could you put that into separate function, like
> 
>    cpu = evsel__hybrid_group_fd(evsel,  cpu);
> 

Sure, that's OK.

Thanks
Jin Yao

> jirka
> 
> 
>> +
>>   	fd = FD(leader, cpu, thread);
>>   	BUG_ON(fd == -1);
>>   
>> -- 
>> 2.17.1
>>
> 

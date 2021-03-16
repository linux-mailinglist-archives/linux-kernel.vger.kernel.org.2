Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813B633CCA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhCPEjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:39:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:3431 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231621AbhCPEjo (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:39:44 -0400
IronPort-SDR: kRCwmYU9YSMUkJfFfw27AU/t4B4rzeHdvpy8pQx4kCY3ds+Kdmf7b+gRXaDba6tMQzMEM4v0je
 SyF/2V2N++RA==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="209123947"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="209123947"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 21:39:43 -0700
IronPort-SDR: QtYektpDzKtNVJgL7bAkY4L6NRNHLUL0jdCbUzIEbZFWFQQAvKyACdDXum5qUbnFVjHo0orosY
 VP5bC64tyuDA==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="449591599"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 21:39:41 -0700
Subject: Re: [PATCH v2 17/27] perf evsel: Adjust hybrid event and global event
 mixed group
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-18-yao.jin@linux.intel.com> <YE/oF4pOkyQmm0rI@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <709fd95a-d379-da99-3816-83797d3d5411@linux.intel.com>
Date:   Tue, 16 Mar 2021 12:39:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YE/oF4pOkyQmm0rI@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/16/2021 7:04 AM, Jiri Olsa wrote:
> On Thu, Mar 11, 2021 at 03:07:32PM +0800, Jin Yao wrote:
>> A group mixed with hybrid event and global event is allowed. For example,
>> group leader is 'cpu-clock' and the group member is 'cpu_atom/cycles/'.
>>
>> e.g.
>> perf stat -e '{cpu-clock,cpu_atom/cycles/}' -a
>>
>> The challenge is their available cpus are not fully matched.
>> For example, 'cpu-clock' is available on CPU0-CPU23, but 'cpu_core/cycles/'
>> is available on CPU16-CPU23.
>>
>> When getting the group id for group member, we must be very careful
>> because the cpu for 'cpu-clock' is not equal to the cpu for 'cpu_atom/cycles/'.
>> Actually the cpu here is the index of evsel->core.cpus, not the real CPU ID.
>> e.g. cpu0 for 'cpu-clock' is CPU0, but cpu0 for 'cpu_atom/cycles/' is CPU16.
>>
>> Another challenge is for group read. The events in group may be not
>> available on all cpus. For example the leader is a software event and
>> it's available on CPU0-CPU1, but the group member is a hybrid event and
>> it's only available on CPU1. For CPU0, we have only one event, but for CPU1
>> we have two events. So we need to change the read size according to
>> the real number of events on that cpu.
> 
> ugh, this is really bad.. do we really want to support it? ;-)
> I guess we need that for metrics..
> 

Yes, it's a bit of pain but the user case makes sense. Some metrics need the event group which 
consists of global event + hybrid event.

For example, CPU_Utilization = 'cpu_clk_unhalted.ref_tsc' / 'msr/tsc/'.

'msr/tsc/' is a global event. It's valid on all CPUs.

But 'cpu_clk_unhalted.ref' is hybrid event.
'cpu_core/cpu_clk_unhalted.ref/' is valid on core CPUs
'cpu_atom/cpu_clk_unhalted.ref/' is valid on atom CPUs.

So we have to support this usage. :)

> SNIP
> 
>>
>>     Performance counter stats for 'system wide':
>>
>>             24,059.14 msec cpu-clock                 #   23.994 CPUs utilized
>>         6,406,677,892      cpu_atom/cycles/          #  266.289 M/sec
>>
>>           1.002699058 seconds time elapsed
>>
>> For cpu_atom/cycles/, cpu16-cpu23 are set with valid group fd (cpu-clock's fd
>> on that cpu). For counting results, cpu-clock has 24 cpus aggregation and
>> cpu_atom/cycles/ has 8 cpus aggregation. That's expected.
>>
>> But if the event order is changed, e.g. '{cpu_atom/cycles/,cpu-clock}',
>> there leaves more works to do.
>>
>>    root@ssp-pwrt-002:~# ./perf stat -e '{cpu_atom/cycles/,cpu-clock}' -a -vvv -- sleep 1
> 
> what id you add the other hybrid pmu event? or just cycles?
>

Do you mean the config for cpu_atom/cycles/? Let's see the log.

root@ssp-pwrt-002:~# perf stat -e '{cpu_atom/cycles/,cpu-clock}' -a -vvv -- sleep 1
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
   type                             6
   size                             120
   config                           0xa00000000
   sample_type                      IDENTIFIER
   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
   disabled                         1
   inherit                          1
   exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8 = 3
sys_perf_event_open: pid -1  cpu 17  group_fd -1  flags 0x8 = 4
sys_perf_event_open: pid -1  cpu 18  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid -1  cpu 19  group_fd -1  flags 0x8 = 7
sys_perf_event_open: pid -1  cpu 20  group_fd -1  flags 0x8 = 8
sys_perf_event_open: pid -1  cpu 21  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid -1  cpu 22  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 11
------------------------------------------------------------
perf_event_attr:
   type                             1
   size                             120
   sample_type                      IDENTIFIER
   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
   inherit                          1
   exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 15
sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 16
sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 17
sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 18
sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 19
sys_perf_event_open: pid -1  cpu 8  group_fd -1  flags 0x8 = 20
sys_perf_event_open: pid -1  cpu 9  group_fd -1  flags 0x8 = 21
sys_perf_event_open: pid -1  cpu 10  group_fd -1  flags 0x8 = 22
sys_perf_event_open: pid -1  cpu 11  group_fd -1  flags 0x8 = 23
sys_perf_event_open: pid -1  cpu 12  group_fd -1  flags 0x8 = 24
sys_perf_event_open: pid -1  cpu 13  group_fd -1  flags 0x8 = 25
sys_perf_event_open: pid -1  cpu 14  group_fd -1  flags 0x8 = 26
sys_perf_event_open: pid -1  cpu 15  group_fd -1  flags 0x8 = 27
sys_perf_event_open: pid -1  cpu 16  group_fd 3  flags 0x8 = 28
sys_perf_event_open: pid -1  cpu 17  group_fd 4  flags 0x8 = 29
sys_perf_event_open: pid -1  cpu 18  group_fd 5  flags 0x8 = 30
sys_perf_event_open: pid -1  cpu 19  group_fd 7  flags 0x8 = 31
sys_perf_event_open: pid -1  cpu 20  group_fd 8  flags 0x8 = 32
sys_perf_event_open: pid -1  cpu 21  group_fd 9  flags 0x8 = 33
sys_perf_event_open: pid -1  cpu 22  group_fd 10  flags 0x8 = 34
sys_perf_event_open: pid -1  cpu 23  group_fd 11  flags 0x8 = 35
cycles: 0: 800791792 1002389889 1002389889
cycles: 1: 800788198 1002383611 1002383611
cycles: 2: 800783491 1002377507 1002377507
cycles: 3: 800777752 1002371035 1002371035
cycles: 4: 800771559 1002363669 1002363669
cycles: 5: 800766391 1002356944 1002356944
cycles: 6: 800761593 1002350144 1002350144
cycles: 7: 800756258 1002343203 1002343203
WARNING: for cpu-clock, some CPU counts not read
cpu-clock: 0: 0 0 0
cpu-clock: 1: 0 0 0
cpu-clock: 2: 0 0 0
cpu-clock: 3: 0 0 0
cpu-clock: 4: 0 0 0
cpu-clock: 5: 0 0 0
cpu-clock: 6: 0 0 0
cpu-clock: 7: 0 0 0
cpu-clock: 8: 0 0 0
cpu-clock: 9: 0 0 0
cpu-clock: 10: 0 0 0
cpu-clock: 11: 0 0 0
cpu-clock: 12: 0 0 0
cpu-clock: 13: 0 0 0
cpu-clock: 14: 0 0 0
cpu-clock: 15: 0 0 0
cpu-clock: 16: 1002390566 1002389889 1002389889
cpu-clock: 17: 1002383263 1002383611 1002383611
cpu-clock: 18: 1002377257 1002377507 1002377507
cpu-clock: 19: 1002370895 1002371035 1002371035
cpu-clock: 20: 1002363611 1002363669 1002363669
cpu-clock: 21: 1002356623 1002356944 1002356944
cpu-clock: 22: 1002349562 1002350144 1002350144
cpu-clock: 23: 1002343089 1002343203 1002343203
cycles: 6406197034 8018936002 8018936002
cpu-clock: 8018934866 8018936002 8018936002

  Performance counter stats for 'system wide':

      6,406,197,034      cpu_atom/cycles/          #  798.884 M/sec
           8,018.93 msec cpu-clock                 #    7.999 CPUs utilized

        1.002475994 seconds time elapsed

'0xa00000000' is the config for cpu_atom/cycles/ and we can see this event is only enabled on CPU16-23.

'cpu-clock' is a global event and it's enable don CPU0-23 (but only have valid group fd on CPU16-23).

> 
> SNIP
>    
>> +static int hybrid_read_size(struct evsel *leader, int cpu, int *nr_members)
>> +{
>> +	struct evsel *pos;
>> +	int nr = 1, back, new_size = 0, idx;
>> +
>> +	for_each_group_member(pos, leader) {
>> +		idx = evsel_cpuid_match(leader, pos, cpu);
>> +		if (idx != -1)
>> +			nr++;
>> +	}
>> +
>> +	if (nr != leader->core.nr_members) {
>> +		back = leader->core.nr_members;
>> +		leader->core.nr_members = nr;
>> +		new_size = perf_evsel__read_size(&leader->core);
>> +		leader->core.nr_members = back;
>> +	}
>> +
>> +	*nr_members = nr;
>> +	return new_size;
>> +}
>> +
>>   static int evsel__read_group(struct evsel *leader, int cpu, int thread)
>>   {
>>   	struct perf_stat_evsel *ps = leader->stats;
>>   	u64 read_format = leader->core.attr.read_format;
>>   	int size = perf_evsel__read_size(&leader->core);
>> +	int new_size, nr_members;
>>   	u64 *data = ps->group_data;
>>   
>>   	if (!(read_format & PERF_FORMAT_ID))
>>   		return -EINVAL;
> 
> I wonder if we do not find some reasonable generic way to process
> this, porhaps we should make some early check that this evlist has
> hybrid event and the move the implementation in some separated
> hybrid-XXX object, so we don't confuse the code
> 
> jirka
> 

Agree. The code looks a bit tricky and hard to understand for non-hybrid platform.

Maybe it's a good idea to move this code to hybrid-xxx files.

Thanks
Jin Yao

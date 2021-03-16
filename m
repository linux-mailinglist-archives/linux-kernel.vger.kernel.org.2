Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF8233CB01
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 02:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhCPBuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 21:50:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:39536 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhCPBts (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:49:48 -0400
IronPort-SDR: vT50fumd3o6UUbnj4O+T7OEuH0Tjk+lsrdltfqxQimTtIXwimUA1v+NdcRGu1p9aabaatd/iqV
 BD73l0L/bDpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="189275116"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="189275116"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 18:49:48 -0700
IronPort-SDR: yZq5FO0AA4wu7Xzi3lFsZr79bsK/E4KtNNIAXZGgse/KU08pHt2zTn6lUKMQSc5RHzAdCADe3p
 T3zA1Iym/q9w==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="449560248"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 18:49:44 -0700
Subject: Re: [PATCH v2 11/27] perf parse-events: Support hardware events
 inside PMU
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-12-yao.jin@linux.intel.com> <YEu9usdFl6VSnOQ7@krava>
 <c40d6187-9391-40de-aea8-7389bb369555@linux.intel.com>
 <YE+balbLkG5RL7Lu@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <fd88f214-f0a4-87bc-ef52-ee750ca13a8d@linux.intel.com>
Date:   Tue, 16 Mar 2021 09:49:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YE+balbLkG5RL7Lu@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/16/2021 1:37 AM, Jiri Olsa wrote:
> On Mon, Mar 15, 2021 at 10:28:12AM +0800, Jin, Yao wrote:
>> Hi Jiri,
>>
>> On 3/13/2021 3:15 AM, Jiri Olsa wrote:
>>> On Thu, Mar 11, 2021 at 03:07:26PM +0800, Jin Yao wrote:
>>>> On hybrid platform, some hardware events are only available
>>>> on a specific pmu. For example, 'L1-dcache-load-misses' is only
>>>> available on 'cpu_core' pmu. And even for the event which can be
>>>> available on both pmus, the user also may want to just enable
>>>> one event. So now following syntax is supported:
>>>>
>>>> cpu_core/<hardware event>/
>>>> cpu_core/<hardware cache event>/
>>>> cpu_core/<pmu event>/
>>>>
>>>> cpu_atom/<hardware event>/
>>>> cpu_atom/<hardware cache event>/
>>>> cpu_atom/<pmu event>/
>>>>
>>>> It limits the event to be enabled only on a specified pmu.
>>>>
>>>> The patch uses this idea, for example, if we use "cpu_core/LLC-loads/",
>>>> in parse_events_add_pmu(), term->config is "LLC-loads".
>>>
>>> hum, I don't understand how this doest not work even now,
>>> I assume both cpu_core and cpu_atom have sysfs device directory
>>> with events/ directory right?
>>>
>>
>> Yes, we have cpu_core and cpu_atom directories with events.
>>
>> root@ssp-pwrt-002:/sys/devices/cpu_atom/events# ls
>> branch-instructions  bus-cycles    cache-references  instructions
>> mem-stores  topdown-bad-spec topdown-fe-bound
>> branch-misses        cache-misses  cpu-cycles        mem-loads
>> ref-cycles  topdown-be-bound topdown-retiring
>>
>> root@ssp-pwrt-002:/sys/devices/cpu_core/events# ls
>> branch-instructions  cache-misses      instructions   mem-stores
>> topdown-bad-spec topdown-fe-bound   topdown-mem-bound
>> branch-misses        cache-references  mem-loads      ref-cycles
>> topdown-be-bound topdown-fetch-lat  topdown-retiring
>> bus-cycles           cpu-cycles        mem-loads-aux  slots
>> topdown-br-mispredict topdown-heavy-ops
>>
>>> and whatever is defined in events we allow in parsing syntax..
>>>
>>> why can't we treat them like 2 separated pmus?
>>>
>>
>> But if without this patch, it reports the error,
>>
>> root@ssp-pwrt-002:~# ./perf stat -e cpu_core/cycles/ -a -vv -- sleep 1
>> event syntax error: 'cpu_core/cycles/'
>>                                \___ unknown term 'cycles' for pmu 'cpu_core'
> 
> yep, because there's special care for 'cycles' unfortunately,
> but you should be able to run 'cpu_core/cpu-cycles/' right?
> 

Yes, cpu_core/cpu-cycles/ is OK.

# ./perf stat -e cpu_core/cpu-cycles/ -a -- sleep 1

  Performance counter stats for 'system wide':

     12,831,980,326      cpu_core/cpu-cycles/

        1.003132639 seconds time elapsed

>>
>> valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,name,period,percore
>>
>> Initial error:
>> event syntax error: 'cpu_core/cycles/'
>>                                \___ unknown term 'cycles' for pmu 'cpu_core'
>>
>> valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,name,period,percore
>> Run 'perf list' for a list of valid events
>>
>> The 'cycles' is treated as a unknown term, then it errors out.
> 
> yep, because it's not in events.. we could add special rule to
> treat cycles as cpu-cycles inside pmu definition ;-)
> 
> jirka
> 

But not only the cycles, the branches has error too.

# ./perf stat -e cpu_core/branches/ -a -- sleep 1
event syntax error: 'cpu_core/branches/'
                               \___ unknown term 'branches' for pmu 'cpu_core'

valid terms: 
event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,name,period,percore

Initial error:
event syntax error: 'cpu_core/branches/'
                               \___ unknown term 'branches' for pmu 'cpu_core'

Of course, branch-instructions runs OK.

# ./perf stat -e cpu_core/branch-instructions/ -a -- sleep 1

  Performance counter stats for 'system wide':

        136,655,302      cpu_core/branch-instructions/

        1.003171561 seconds time elapsed

So we need special rules for both cycles and branches.

The worse thing is, we also need to process the hardware cache events.

# ./perf stat -e cpu_core/LLC-loads/
event syntax error: 'cpu_core/LLC-loads/'
                               \___ unknown term 'LLC-loads' for pmu 'cpu_core'

valid terms: 
event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,name,period,percore

Initial error:
event syntax error: 'cpu_core/LLC-loads/'
                               \___ unknown term 'LLC-loads' for pmu 'cpu_core'

If we use special rules for establishing all event mapping, that looks too much. :(

Thanks
Jin Yao

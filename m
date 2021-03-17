Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A843B33F01C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhCQMS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:18:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:1072 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhCQMSA (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:18:00 -0400
IronPort-SDR: rUVGrSQZO6QXxYRv6aIkikaY+jIYBpQvB56JEb+SUKMBPzVgppOep4Lu6aqkzlwCQzY0YeV+PP
 DYOePFCExCLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="189494464"
X-IronPort-AV: E=Sophos;i="5.81,256,1610438400"; 
   d="scan'208";a="189494464"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 05:17:59 -0700
IronPort-SDR: rRmXTtjZ/vG9m7jUqesoFYr5iCAvDS0bRSv/mlWRj5pLHS1OXPWEEVh1/aqBwd/kFExD1aox8k
 Sqc0LvzGqtWw==
X-IronPort-AV: E=Sophos;i="5.81,256,1610438400"; 
   d="scan'208";a="412623637"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.255.28.23]) ([10.255.28.23])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 05:17:56 -0700
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
 <fd88f214-f0a4-87bc-ef52-ee750ca13a8d@linux.intel.com>
 <YFC615nTdUR/aLw5@krava>
 <65624432-2752-8381-d299-9b48ec508406@linux.intel.com>
 <YFHUo1I8cYf502qJ@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <b0ec8d05-acbc-3021-2e74-684d119de2db@linux.intel.com>
Date:   Wed, 17 Mar 2021 20:17:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFHUo1I8cYf502qJ@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/17/2021 6:06 PM, Jiri Olsa wrote:
> On Wed, Mar 17, 2021 at 10:12:03AM +0800, Jin, Yao wrote:
>>
>>
>> On 3/16/2021 10:04 PM, Jiri Olsa wrote:
>>> On Tue, Mar 16, 2021 at 09:49:42AM +0800, Jin, Yao wrote:
>>>
>>> SNIP
>>>
>>>>
>>>>    Performance counter stats for 'system wide':
>>>>
>>>>          136,655,302      cpu_core/branch-instructions/
>>>>
>>>>          1.003171561 seconds time elapsed
>>>>
>>>> So we need special rules for both cycles and branches.
>>>>
>>>> The worse thing is, we also need to process the hardware cache events.
>>>>
>>>> # ./perf stat -e cpu_core/LLC-loads/
>>>> event syntax error: 'cpu_core/LLC-loads/'
>>>>                                 \___ unknown term 'LLC-loads' for pmu 'cpu_core'
>>>>
>>>> valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,name,period,percore
>>>>
>>>> Initial error:
>>>> event syntax error: 'cpu_core/LLC-loads/'
>>>>                                 \___ unknown term 'LLC-loads' for pmu 'cpu_core'
>>>>
>>>> If we use special rules for establishing all event mapping, that looks too much. :(
>>>
>>> hmmm but wait, currently we do not support events like this:
>>>
>>>     'cpu/cycles/'
>>>     'cpu/branches/'
>>>
>>> the pmu style accepts only 'events' or 'format' terms within //
>>>
>>> we made hw events like 'cycles','instructions','branches' special
>>> to be used without the pmu
>>>
>>> so why do we need to support cpu_code/cycles/ ?
>>>
>>> jirka
>>>
>>
>> Actually we have to support pmu style event for hybrid platform.
>>
>> User may want to enable the events from specified pmus and also with flexible grouping.
>>
>> For example,
>>
>> perf stat -e '{cpu_core/cycles/,cpu_core/instructions/}' -e '{cpu_atom/cycles/,cpu_atom/instructions/}'
>>
>> This usage is common and reasonable. So I think we may need to support pmu style events.
> 
> sure, but we don't support 'cpu/cycles/' but we support 'cpu/cpu-cycles/'
> why do you insist on supporting cpu_core/cycles/ ?
> 
> jirka
> 

I'm OK to only support 'cpu_core/cpu-cycles/' or 'cpu_atom/cpu-cycles/'. But what would we do for 
cache event?

'perf stat -e LLC-loads' is OK, but 'perf stat -e cpu/LLC-loads/' is not supported currently.

For hybrid platform, user may only want to enable the LLC-loads on core CPUs or on atom CPUs. That's 
reasonable. While if we don't support the pmu style event, how to satisfy this requirement?

If we can support the pmu style event, we can also use the same way for cpu_core/cycles/. At least 
it's not a bad thing, right? :)

Thanks
Jin Yao

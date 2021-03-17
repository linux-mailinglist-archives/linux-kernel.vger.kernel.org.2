Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A706833E6A6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 03:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCQCM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 22:12:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:19962 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhCQCMJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:12:09 -0400
IronPort-SDR: FNHMWbF6SJnRpdVFw9M9T/Arqzfzn0Xtus/v8ViTCOPwxhzMn7dPduQ3hgMo6x4gXazRgLqwD4
 kO2YBXVtKVQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="176968872"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="176968872"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:12:08 -0700
IronPort-SDR: B500BWcGr6iYrrQ8P/wnTSKm9s42yb3CQ7X3ut40mmrit6OsP7QJNHb0VtVgZJC52OUBVrk9Kc
 u7QXwQXZP6bA==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="412461566"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:12:06 -0700
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
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <65624432-2752-8381-d299-9b48ec508406@linux.intel.com>
Date:   Wed, 17 Mar 2021 10:12:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFC615nTdUR/aLw5@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2021 10:04 PM, Jiri Olsa wrote:
> On Tue, Mar 16, 2021 at 09:49:42AM +0800, Jin, Yao wrote:
> 
> SNIP
> 
>>
>>   Performance counter stats for 'system wide':
>>
>>         136,655,302      cpu_core/branch-instructions/
>>
>>         1.003171561 seconds time elapsed
>>
>> So we need special rules for both cycles and branches.
>>
>> The worse thing is, we also need to process the hardware cache events.
>>
>> # ./perf stat -e cpu_core/LLC-loads/
>> event syntax error: 'cpu_core/LLC-loads/'
>>                                \___ unknown term 'LLC-loads' for pmu 'cpu_core'
>>
>> valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,name,period,percore
>>
>> Initial error:
>> event syntax error: 'cpu_core/LLC-loads/'
>>                                \___ unknown term 'LLC-loads' for pmu 'cpu_core'
>>
>> If we use special rules for establishing all event mapping, that looks too much. :(
> 
> hmmm but wait, currently we do not support events like this:
> 
>    'cpu/cycles/'
>    'cpu/branches/'
> 
> the pmu style accepts only 'events' or 'format' terms within //
> 
> we made hw events like 'cycles','instructions','branches' special
> to be used without the pmu
> 
> so why do we need to support cpu_code/cycles/ ?
> 
> jirka
> 

Actually we have to support pmu style event for hybrid platform.

User may want to enable the events from specified pmus and also with flexible grouping.

For example,

perf stat -e '{cpu_core/cycles/,cpu_core/instructions/}' -e '{cpu_atom/cycles/,cpu_atom/instructions/}'

This usage is common and reasonable. So I think we may need to support pmu style events.

Thanks
Jin Yao


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BDA340CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhCRSRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:17:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:45402 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232600AbhCRSQ7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:16:59 -0400
IronPort-SDR: f0GmlefuxGq3+v8fhtRSSqfdfAp9noD3HLMHV9z3SGPgCnFauWigTqrj23VFuBuaaQ4ph+WWFx
 ghI0VkHMOSeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="176876388"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="176876388"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 11:16:58 -0700
IronPort-SDR: TK395rKztxm8Y9y8RsM/s6MhdK1Xf3UwrFAcjc5QsZsvhB47VuiDZ5rm+PL2IkvRw4FMFZda1A
 bOUddm508oew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="441007463"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Mar 2021 11:16:58 -0700
Received: from [10.254.95.173] (kliang2-MOBL.ccr.corp.intel.com [10.254.95.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CF7595808B0;
        Thu, 18 Mar 2021 11:16:56 -0700 (PDT)
Subject: Re: [PATCH v2 11/27] perf parse-events: Support hardware events
 inside PMU
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <YEu9usdFl6VSnOQ7@krava>
 <c40d6187-9391-40de-aea8-7389bb369555@linux.intel.com>
 <YE+balbLkG5RL7Lu@krava>
 <fd88f214-f0a4-87bc-ef52-ee750ca13a8d@linux.intel.com>
 <YFC615nTdUR/aLw5@krava>
 <65624432-2752-8381-d299-9b48ec508406@linux.intel.com>
 <YFHUo1I8cYf502qJ@krava>
 <b0ec8d05-acbc-3021-2e74-684d119de2db@linux.intel.com>
 <YFIHVQPG3TEeiOpP@kernel.org> <YFNEpRILOTwh3svv@krava>
 <YFNT8YpR7bnCjmdf@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c1320d04-fcc1-562c-5429-4649a80d9bbb@linux.intel.com>
Date:   Thu, 18 Mar 2021 14:16:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFNT8YpR7bnCjmdf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2021 9:21 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 18, 2021 at 01:16:37PM +0100, Jiri Olsa escreveu:
>> On Wed, Mar 17, 2021 at 10:42:45AM -0300, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Mar 17, 2021 at 08:17:52PM +0800, Jin, Yao escreveu:
>>>> I'm OK to only support 'cpu_core/cpu-cycles/' or 'cpu_atom/cpu-cycles/'. But
>>>> what would we do for cache event?
> 
>>>> 'perf stat -e LLC-loads' is OK, but 'perf stat -e cpu/LLC-loads/' is not supported currently.
> 
>>>> For hybrid platform, user may only want to enable the LLC-loads on core CPUs
>>>> or on atom CPUs. That's reasonable. While if we don't support the pmu style
>>>> event, how to satisfy this requirement?
> 
>>>> If we can support the pmu style event, we can also use the same way for
>>>> cpu_core/cycles/. At least it's not a bad thing, right? :)
> 
>>> While we're discussing, do we really want to use the "core" and "atom"
>>> terms here? I thought cpu/cycles/ would be ok for the main (Big) CPU and
>>> that we should come up with some short name for the "litle" CPUs.
> 
>>> Won't we have the same situation with ARM where we want to know the
>>> number of cycles spent on a BIG core and also on a little one?
> 
>>> Perhaps 'cycles' should mean all cycles, and then we use 'big/cycles/' and
>>> 'little/cycles/'?
> 
>> do arm servers already export multiple pmus like this?
>> I did not notice
> 
> I haven't checked, but AFAIK this BIG/Little kind of arch started there,
> Mark?


Here is the cover letter of the ARM big.little patch set. ARM also 
exports multiple PMUs, e.g., armv7_cortex_a15 and armv7_cortex_a7.
https://lore.kernel.org/lkml/1431533549-27715-1-git-send-email-mark.rutland@arm.com/

We follow a similar way to handle the Intel hybrid PMUs. The naming rule 
is also similar, "cpu_" + CPU type.

We don't use the old name "cpu" for the main CPU type, because we want 
to make sure every software updated for the hybrid architecture. 
Otherwise, the old script with "cpu//" can still run on a hybrid 
architecture. Users cannot notice that the monitored scope is already 
implicitly changed. The results may be not what they want.

Thanks,
Kan

> 
> - Arnaldo
>   
>> it'd be definitely great to have some unite way for this,
>> so far we have the hybrid pmu detection and support in
>> hw events like cycles/instructions.. which should be easy
>> to follow on arm
>>
>> there's also support to have these events on specific pmu
>> pmu/cycles/ , which I still need to check on

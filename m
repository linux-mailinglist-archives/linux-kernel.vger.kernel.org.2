Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A003B7A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 23:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhF2Vu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 17:50:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:62191 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233660AbhF2Vu2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 17:50:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="195398110"
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="scan'208";a="195398110"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 14:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="scan'208";a="558083495"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2021 14:47:59 -0700
Received: from [10.212.193.2] (kliang2-MOBL.ccr.corp.intel.com [10.212.193.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 001E45807C8;
        Tue, 29 Jun 2021 14:47:57 -0700 (PDT)
Subject: Re: [PATCH v1] perf tools: Fix pattern matching for same substring
 used in different pmu type
To:     Jiri Olsa <jolsa@redhat.com>, "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210609045738.1051-1-yao.jin@linux.intel.com>
 <982714a5-8a5d-8f8a-4e30-bd9a497ffa40@linux.intel.com>
 <4787334d-cf28-5b25-8d11-c767c52288f1@linux.intel.com>
 <YNWr7zsEaNPCn4CR@krava>
 <14a70048-ddd0-3297-9ae9-6b76dd0f1000@linux.intel.com>
 <YNuNW/Afd/X25fNe@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <844625a7-5903-519e-9ef4-ca6684661aef@linux.intel.com>
Date:   Tue, 29 Jun 2021 17:47:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNuNW/Afd/X25fNe@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2021 5:15 PM, Jiri Olsa wrote:
> On Mon, Jun 28, 2021 at 09:52:42AM +0800, Jin, Yao wrote:
> 
> SNIP
> 
>>>>>> +    /*
>>>>>> +     * The pmu_name has substring tok. If the format of
>>>>>> +     * pmu_name is <tok> or <tok>_<digit>, return true.
>>>>>> +     */
>>>>>> +    p = pmu_name + strlen(tok);
>>>>>> +    if (*p == 0)
>>>>>> +        return true;
>>>>>> +
>>>>>> +    if (*p != '_')
>>>>>> +        return false;
>>>>>> +
>>>>>> +    ++p;
>>>>>> +    if (*p == 0 || !isdigit(*p))
>>>>>> +        return false;
>>>>>> +
>>>>>> +    return true;
>>>>>> +}
>>>
>>> hum, so we have pattern serch and then another function checking
>>> if that search was ok..
>>
>> Yes, that's what this patch does.
>>
>> I understand that's convenient, because
>>> it's on 2 different places
>>
>> Yes, on pmu_uncore_alias_match() and on parse-events.y.
>>
>> but could we have some generic solution,
>>> line one function/search that returns/search for valid pmu name?
>>>
>>
>> Sorry, I don't understand this idea well. Would you like to further explain?
>>
>> Or can you accept the regex approach?
> 
> I don't really have any suggestion, just would be great to have
> this encapsulated in one function.. 

Yes, I agree. One function is better.

We just changed the design for the uncore PMU on SPR. There will be two 
PMU names for each uncore unit, a real name and an alias. The perf tool 
should handle both names. So we have to compare both names here.
I think one generic function can facilitate the code rebase.

https://lore.kernel.org/lkml/1624990443-168533-7-git-send-email-kan.liang@linux.intel.com/

Thanks,
Kan


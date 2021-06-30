Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F60A3B7EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 10:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhF3ISC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 04:18:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:58159 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232954AbhF3ISB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:18:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="188688613"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="188688613"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 01:15:31 -0700
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="457127719"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 01:15:28 -0700
Subject: Re: [PATCH v1] perf tools: Fix pattern matching for same substring
 used in different pmu type
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
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
 <844625a7-5903-519e-9ef4-ca6684661aef@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <aa963629-f52f-d42b-de30-298f5755eb49@linux.intel.com>
Date:   Wed, 30 Jun 2021 16:15:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <844625a7-5903-519e-9ef4-ca6684661aef@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri, Hi Kan,

On 6/30/2021 5:47 AM, Liang, Kan wrote:
> 
> 
> On 6/29/2021 5:15 PM, Jiri Olsa wrote:
>> On Mon, Jun 28, 2021 at 09:52:42AM +0800, Jin, Yao wrote:
>>
>> SNIP
>>
>>>>>>> +    /*
>>>>>>> +     * The pmu_name has substring tok. If the format of
>>>>>>> +     * pmu_name is <tok> or <tok>_<digit>, return true.
>>>>>>> +     */
>>>>>>> +    p = pmu_name + strlen(tok);
>>>>>>> +    if (*p == 0)
>>>>>>> +        return true;
>>>>>>> +
>>>>>>> +    if (*p != '_')
>>>>>>> +        return false;
>>>>>>> +
>>>>>>> +    ++p;
>>>>>>> +    if (*p == 0 || !isdigit(*p))
>>>>>>> +        return false;
>>>>>>> +
>>>>>>> +    return true;
>>>>>>> +}
>>>>
>>>> hum, so we have pattern serch and then another function checking
>>>> if that search was ok..
>>>
>>> Yes, that's what this patch does.
>>>
>>> I understand that's convenient, because
>>>> it's on 2 different places
>>>
>>> Yes, on pmu_uncore_alias_match() and on parse-events.y.
>>>
>>> but could we have some generic solution,
>>>> line one function/search that returns/search for valid pmu name?
>>>>
>>>
>>> Sorry, I don't understand this idea well. Would you like to further explain?
>>>
>>> Or can you accept the regex approach?
>>
>> I don't really have any suggestion, just would be great to have
>> this encapsulated in one function.. 
> 
> Yes, I agree. One function is better.
> 
> We just changed the design for the uncore PMU on SPR. There will be two PMU names for each uncore 
> unit, a real name and an alias. The perf tool should handle both names. So we have to compare both 
> names here.
> I think one generic function can facilitate the code rebase.
> 
> https://lore.kernel.org/lkml/1624990443-168533-7-git-send-email-kan.liang@linux.intel.com/
> 
> Thanks,
> Kan
> 

Thanks for the comments!

I'm now preparing v2. In v2 version, I will provide a new function 'perf_pmu__pattern_match which 
wraps the matching and checking. Something like:

while ((pmu = perf_pmu__scan(pmu)) != NULL) {
	if (!perf_pmu__pattern_match(pmu, pattern, $1)) {
		...
	}
}

I will post v2 soon.

Thanks
Jin Yao

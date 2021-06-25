Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131FA3B4752
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 18:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFYQUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 12:20:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:3083 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFYQUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 12:20:51 -0400
IronPort-SDR: LJ3/kmBeNYtBxvNPJxipEv/uejtkR0GbmpWu4MQnUE4aeGnLt8Sd9246dLXi5+OwQ7NQL4j9lk
 T/hVDSF3LA3A==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="293334646"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="293334646"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 09:18:30 -0700
IronPort-SDR: RY9/tckYGDaQjbLmr+ko/K0n7McmAgYGkcNaqEQWqmyRiGuzx12JMhajkMA8K4ESy1KkFn6yrQ
 80c54OQ+D2Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="557742457"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2021 09:18:30 -0700
Received: from [10.212.190.24] (kliang2-MOBL.ccr.corp.intel.com [10.212.190.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7813B58060A;
        Fri, 25 Jun 2021 09:18:29 -0700 (PDT)
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>, Greg KH <greg@kroah.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
 <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
 <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
 <29d5f315-578f-103c-9523-ae890e29c7e7@linux.intel.com>
 <YNVneO6exCS4ETRt@kroah.com>
 <540d8a38-da12-56c8-8306-8d3d61ae1d6b@linux.intel.com>
 <YNXqXwq1+o09eHox@kroah.com>
 <e670abe2-67b9-a602-410a-0c4170796ec7@linux.intel.com>
 <c3ffcdd4-fabb-38fd-6ccd-3497389f94ec@linux.intel.com>
 <6f2941a4-4a32-ea09-bbc6-5a8e4836411b@linux.intel.com>
 <82fe02c8-2ac6-fc53-490c-382df3e07dc4@linux.intel.com>
Message-ID: <1edc6666-c4b3-ebf5-964a-e5ffc97d8563@linux.intel.com>
Date:   Fri, 25 Jun 2021 12:18:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <82fe02c8-2ac6-fc53-490c-382df3e07dc4@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/2021 11:57 AM, Liang, Kan wrote:
> 
> 
> On 6/25/2021 11:44 AM, Andi Kleen wrote:
>>
>>> We have an attribute "caps/pmu_name" for the core PMU. Maybe we 
>>> should add it for uncore PMU as well. For example,
>>>
>>> $ cat /sys/devices/uncore_type_0_0/caps/pmu_name
>>> cha_0
>>>
>>> Userspace tool can get clues about what type_0_0 is.
>>
>> It would break all the old tools, but I suppose it could work for 
>> updated tools.
>>
> 
> Right, users have to update their perf tool to use the new name, 
> uncore_cha_0.

I think the above example is misleading. Let me rephrase.
Here is what I'm planing to do in V2.

With the V2 platform-specific patch, uncore driver will only create a 
meaningful uncore name, e.g., uncore_cha_0.

An attribute "caps/pmu_name" is also created to indicate the previous 
name. For example,

$ cat /sys/devices/uncore_cha_0/caps/pmu_name
type_0_0

If any users use the old numeric name, they have to update either their 
script or a perf tool which supports "caps/pmu_name".

In the future, if the users already use a perf tool which supports 
"caps/pmu_name", nothing needs to be updated. The old numeric name 
should just work.

Thanks,
Kan

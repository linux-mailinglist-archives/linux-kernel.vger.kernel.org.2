Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1747C310C34
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhBENwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:52:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:15641 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231449AbhBENsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:48:14 -0500
IronPort-SDR: VhsCdSkz5nl2OhlnVTwR6p1AxrMnCskjHnyx/grJ5Y0W4CUjxZSu9EWENgqv90/fnfLB2oPTqU
 ZiwC52/bVjKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="266261858"
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="266261858"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 05:46:02 -0800
IronPort-SDR: DoTquzvhTq1CvAtbZbu34YKcrxqL0urd3JEIlGJA+/8eofvvXYPZly4DXny7ENvBwEsC49H7Bc
 P5Mw3hx2nZ1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="373396890"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 05 Feb 2021 05:46:01 -0800
Received: from [10.254.80.1] (kliang2-MOBL.ccr.corp.intel.com [10.254.80.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 703AB580689;
        Fri,  5 Feb 2021 05:46:00 -0800 (PST)
Subject: Re: [PATCH V3 1/5] perf/core: Add PERF_SAMPLE_WEIGHT_STRUCT
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Yao Jin <yao.jin@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>, maddy@linux.vnet.ibm.com
References: <1611873611-156687-1-git-send-email-kan.liang@linux.intel.com>
 <1611873611-156687-2-git-send-email-kan.liang@linux.intel.com>
 <b970c739-6783-34d6-8676-44632c7c9428@linux.intel.com>
 <CAM9d7chzwnmSeKydv0Fb_iopcuMZxRsx2mZ66uVwcu_RMw+Vyg@mail.gmail.com>
 <4723a1de-9caa-e192-7b0d-8aced00b8f50@linux.intel.com>
 <CAM9d7ciaCgebmGd98GrngY-he6LGwKeFKJeCqyTBnJ30-tSghQ@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8d8b7323-7e99-b8c6-fbc1-813ecff0e844@linux.intel.com>
Date:   Fri, 5 Feb 2021 08:45:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7ciaCgebmGd98GrngY-he6LGwKeFKJeCqyTBnJ30-tSghQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/2021 5:43 AM, Namhyung Kim wrote:
> On Fri, Feb 5, 2021 at 12:24 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>> On 2/4/2021 9:00 AM, Namhyung Kim wrote:
>>> Hi Kan,
>>>
>>> On Sat, Jan 30, 2021 at 2:25 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>> [SNIP]
>>>> diff --git a/include/uapi/linux/perf_event.h
>>>> b/include/uapi/linux/perf_event.h
>>>> index b15e344..c50718a 100644
>>>> --- a/include/uapi/linux/perf_event.h
>>>> +++ b/include/uapi/linux/perf_event.h
>>>> @@ -145,12 +145,14 @@ enum perf_event_sample_format {
>>>>           PERF_SAMPLE_CGROUP                      = 1U << 21,
>>>>           PERF_SAMPLE_DATA_PAGE_SIZE              = 1U << 22,
>>>>           PERF_SAMPLE_CODE_PAGE_SIZE              = 1U << 23,
>>>> +       PERF_SAMPLE_WEIGHT_STRUCT               = 1U << 24,
>>>>
>>>> -       PERF_SAMPLE_MAX = 1U << 24,             /* non-ABI */
>>>> +       PERF_SAMPLE_MAX = 1U << 25,             /* non-ABI */
>>>>
>>>>           __PERF_SAMPLE_CALLCHAIN_EARLY           = 1ULL << 63, /* non-ABI; internal use */
>>>>     };
>>>>
>>>> +#define PERF_SAMPLE_WEIGHT_TYPE        (PERF_SAMPLE_WEIGHT |
>>>> PERF_SAMPLE_WEIGHT_STRUCT)
>>>
>>> I'm not sure you want to expose it in the uapi header as it's not
>>> intended to be used IMHO.
>>>
>>
>> I'm not sure I understood, but it's indeed used in the tool patch set.
>>
>> https://lore.kernel.org/lkml/1612296553-21962-6-git-send-email-kan.liang@linux.intel.com/
> 
> Well, it's not a big deal.. but I just worried if some users might do
> 
>    event.attr.sample_type = PERF_SAMPLE_WEIGHT_TYPE;
> 

Yes, it's possible. For this case, Kernel returns -EINVAL.

Actually, even without the macro, users may still set PERF_SAMPLE_WEIGHT 
| PERF_SAMPLE_WEIGHT_STRUCT manually. We cannot control what a user 
sets. I don't think it's a problem as long as the kernel can handle it 
properly.

Thanks,
Kan

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B9535F62B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349596AbhDNO2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:28:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:61591 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349630AbhDNO2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:28:01 -0400
IronPort-SDR: bwLCcMe302Q5PEUFHp/X6qnB5KOopWuuz3hPhMlp36xzIAafM1zN5uJ4guH1mLTMgfSNqA+/eh
 MsOArosbjh+Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="191464138"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="191464138"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 07:27:31 -0700
IronPort-SDR: BjYR8f/isYE2cN+iBRYqXk9T8ZvtCGT0mXREoFxLqfpiogJN/dBNGNX3MPSYzb0Duxw89oRyVu
 guYiRKZsSjng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="383695416"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2021 07:27:31 -0700
Received: from [10.209.105.172] (kliang2-MOBL.ccr.corp.intel.com [10.209.105.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1D005580021;
        Wed, 14 Apr 2021 07:27:30 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>, luto@amacapital.net,
        Stephane Eranian <eranian@google.com>
References: <1618340250-29027-1-git-send-email-kan.liang@linux.intel.com>
 <1618340250-29027-2-git-send-email-kan.liang@linux.intel.com>
 <CAM9d7cijoqGDAHa8FSj8VcLWSLUugiRJe6ZC5eVq4MoTAGh_AA@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <599982b3-321a-9a75-2041-252fc73bbaa4@linux.intel.com>
Date:   Wed, 14 Apr 2021 10:27:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cijoqGDAHa8FSj8VcLWSLUugiRJe6ZC5eVq4MoTAGh_AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2021 9:51 AM, Namhyung Kim wrote:
> Hi Kan,
> 
> On Wed, Apr 14, 2021 at 4:04 AM <kan.liang@linux.intel.com> wrote:
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index dd9f3c2..0d4a1a3 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -1585,6 +1585,8 @@ static void x86_pmu_del(struct perf_event *event, int flags)
>>          if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
>>                  goto do_del;
>>
>> +       __set_bit(event->hw.idx, cpuc->dirty);
>> +
>>          /*
>>           * Not a TXN, therefore cleanup properly.
>>           */
>> @@ -2304,12 +2306,46 @@ static int x86_pmu_event_init(struct perf_event *event)
>>          return err;
>>   }
>>
>> +void x86_pmu_clear_dirty_counters(void)
>> +{
>> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +       int i;
>> +
>> +       if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
>> +               return;
> 
> Maybe you can check it after clearing assigned counters.
> 

It should be very likely that the cpuc->dirty is non-empty.
Move it after the clearing can skip the for_each_set_bit() and 
bitmap_zero().
OK. I will change it in V4.

Thanks,
Kan



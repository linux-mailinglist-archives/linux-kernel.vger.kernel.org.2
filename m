Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D4B3DD4D7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhHBLlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 07:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbhHBLlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 07:41:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31CDC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 04:41:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so5427440pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 04:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xTkDa/ACi/D65DC2OxA9X5m/GDgoFMDOoOCJhTIhmhU=;
        b=kywCCPnNcLBnwITG/LLTn48sY4+SvUzWjOsFveN2xbM3cIqBsHCovEzy62vQcPg3jd
         M3muojo9dcE01Ap9UVGCcBldRN3cyG8tmPuzFJZRJZCXK+au/WM/ERjXtjcSJMsZsL1c
         i6W/AkRO8BMBnJicGyxVBLEyBH31giGjMgQmPmdJ04GovuamtoSC9PElxkTyrN74VcDj
         cvJ0zCYNWYAa8Xn7KSbbHoDhs21gnTn2nTZ+w40zFKR4H0TvypuDD6GG7MPccOpSBzl9
         u27PcvKrl01g+taP4fMqN2TrejqHE6kfPYyqMa2/V9Hooc6FQCAHR8aCie2EJRFqbFI1
         I2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xTkDa/ACi/D65DC2OxA9X5m/GDgoFMDOoOCJhTIhmhU=;
        b=QAvDY7IwhIHbwLx6fkY3pzfpYdqAXgK6x4PmgLiM2EI/67WxKZ1G1EERhgDkmg8CVw
         NzLuQdK6mvKejvTRefsHCka3pymzyG0wl77kx5vB1RijssNfzp/aVB7c8HyQ0CIPOOYw
         6+O/23DtBpNW0sVDLVLRUDyk05yAAMOvPI7KPAoLFHWurTUP8yl1LbCvDiXtW+P+qAE8
         IEgk3OIj1es8WmiqxmrmLt9OSUa7X/z6I9hz4hQN8Mbqlv3G0n3WmFUkBeG39vPtn3fF
         J1gOrL9QM0JVJuIMTZv7gTDaw+baIJ7OfSPMg0fw2gnLpgO6gIv5sFL9JyjGjiDiryXv
         hEdg==
X-Gm-Message-State: AOAM532zBoqNeT1IKIvuu/cSzY7egFN9DQSmhOKLUsTFjFX5ziSlySv3
        OFQAbeq/oCoF7fmM2YbJpBc=
X-Google-Smtp-Source: ABdhPJxV9z4iZ/OeGvOL6LXX/jdsc1xQQsfmgcL0Q1Ewlmrai6QiKnuiX0z7kSBWqgT8yFYxDWlUXg==
X-Received: by 2002:a17:902:ac82:b029:12c:798a:6d26 with SMTP id h2-20020a170902ac82b029012c798a6d26mr13925543plr.54.1627904464314;
        Mon, 02 Aug 2021 04:41:04 -0700 (PDT)
Received: from Likes-MacBook-Pro.local ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id a12sm914411pfg.120.2021.08.02.04.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 04:41:03 -0700 (PDT)
Subject: Re: [perf] fuzzer triggers unchecked MSR access error: WRMSR to 0x318
To:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Liang, Kan" <kan.liang@intel.com>
References: <37881148-a43e-5fd4-817c-a875adc7a15f@maine.edu>
 <YQJxka3dxgdIdebG@hirez.programming.kicks-ass.net>
 <45bee582-0f89-5125-82e7-92caf8b741ea@linux.intel.com>
 <YQLJhAiYQKtvvhjJ@hirez.programming.kicks-ass.net>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
Message-ID: <e3fd66b0-778a-21c5-5f01-e91db0099cc3@gmail.com>
Date:   Mon, 2 Aug 2021 19:40:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQLJhAiYQKtvvhjJ@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/7/2021 11:30 pm, Peter Zijlstra wrote:
> On Thu, Jul 29, 2021 at 09:21:01AM -0400, Liang, Kan wrote:
>>
>>
>> On 7/29/2021 5:14 AM, Peter Zijlstra wrote:
>>> On Wed, Jul 28, 2021 at 12:49:43PM -0400, Vince Weaver wrote:
>>>> [32694.087403] unchecked MSR access error: WRMSR to 0x318 (tried to write 0x0000000000000000) at rIP: 0xffffffff8106f854 (native_write_msr+0x4/0x20)
>>>> [32694.101374] Call Trace:
>>>> [32694.103974]  perf_clear_dirty_counters+0x86/0x100
>>>
>>> Hmm.. if I read this right that's MSR_ARCH_PERFMON_FIXED_CTR0 + i, given
>>> that FIXED_CTR0 is 0x309 that gives i == 15, which is FIXED_BTS.
>>>
>>> I'm thinking something like this ought to cure things.
>>>
>>> ---
>>>    arch/x86/events/core.c | 12 +++++++-----
>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>>> index 1eb45139fcc6..04edf8017961 100644
>>> --- a/arch/x86/events/core.c
>>> +++ b/arch/x86/events/core.c
>>> @@ -2489,13 +2489,15 @@ void perf_clear_dirty_counters(void)
>>>    		return;
>>>    	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
>>> -		/* Metrics and fake events don't have corresponding HW counters. */
>>> -		if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
>>> -			continue;
>>> -		else if (i >= INTEL_PMC_IDX_FIXED)
>>> +		if (i >= INTEL_PMC_IDX_FIXED) {
>>> +			/* Metrics and fake events don't have corresponding HW counters. */
>>> +			if ((i - INTEL_PMC_IDX_FIXED) >= x86_pmu.num_counters_fixed)
>>
>> Yes, the fix is better. My previous implementation tries to pick up all the
>> special cases. It's very likely to miss some special cases like FIXED_BTS
>> and probably any new fake events added later if there are.
>> Thanks for the fix.
>>
>> The x86_pmu.num_counters_fixed should work well on HSW. But we have hybrid
>> machines now. I think we can use
>> hybrid(cpuc->pmu, num_counters_fixed) instead, which should be more
>> accurate.
> 
> Yes, good point. I guess I still need to adjust to the hybrid world.

I recently enabled guest BTS and encountered the same call trace.

For the proposal hybrid(cpuc->pmu, num_counters_fixed),
Tested-by: Like Xu <likexu@tencent.com>



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027C34267FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbhJHKgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 06:36:17 -0400
Received: from foss.arm.com ([217.140.110.172]:41512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhJHKgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:36:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D390EED1;
        Fri,  8 Oct 2021 03:34:20 -0700 (PDT)
Received: from [10.57.25.67] (unknown [10.57.25.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63FB13F70D;
        Fri,  8 Oct 2021 03:34:18 -0700 (PDT)
Subject: Re: [PATCH 1/4] perf vendor events: Syntax corrections in Neoverse N1
 json
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>
Cc:     John Garry <john.garry@huawei.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211004160008.21645-1-andrew.kilroy@arm.com>
 <b7a4a1b3-3d22-7a52-75b1-66c04b57a50c@huawei.com>
 <0743bf83-2e5d-8830-61bc-ed0731db108d@arm.com>
 <83767166-e379-a352-d920-ad8b6e923800@huawei.com>
 <b24041af-1c92-3855-9659-133e73a0c241@linux.intel.com>
 <CAP-5=fXuzH9Gh8=CP9E=vb7sDSL5TO-8_pPvfQz4p61jUQEPmQ@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <18ef658a-48d3-0038-f988-f39f9498d31e@arm.com>
Date:   Fri, 8 Oct 2021 11:34:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXuzH9Gh8=CP9E=vb7sDSL5TO-8_pPvfQz4p61jUQEPmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2021 03:59, Ian Rogers wrote:
> On Thu, Oct 7, 2021 at 5:03 PM Andi Kleen <ak@linux.intel.com> wrote:
>>
>>
>> On 10/6/2021 9:26 AM, John Garry wrote:
>>> On 06/10/2021 09:43, James Clark wrote:
>>>
>>> + Andi
>>>
>>>>
>>>>
>>>> On 05/10/2021 11:10, John Garry wrote:
>>>>> On 04/10/2021 17:00, Andrew Kilroy wrote:
>>>>>> There are some syntactical mistakes in the json files for the
>>>>>> Cortex A76
>>>>>> N1 (Neoverse N1).  This was obstructing parsing from an external tool.
>>>>>
>>>>> If the trailing comma is not allowed by standard, then maybe we
>>>>> should fix our parsing tool to not allow it also. However maybe
>>>>> there is a good reason why we allow it..
>>>>
>>>> It would be nice to do, because I have also made similar fixes
>>>> before. We looked at the STRICT option
>>>> in the parser (https://github.com/zserge/jsmn), but even then it
>>>> seems to allow trailing commas.
>>>>
>>>> Trailing commas are not allowed in the json standard, but there is a
>>>> split between parsers
>>>> where some allow it and others don't. Specifically the Python parser
>>>> doesn't allow it, and Python
>>>> can easily be involved in some workflow that parses these files.
>>>>
>>>> The only way forwards I can think of is either getting a change
>>>> accepted upstream to the parser
>>>> and then updating it in perf, switching to a different parser, or
>>>> doing some hack to add an extra
>>>> step in perf to look for commas. None of which sound ideal.
>>>>
>>>
>>> Looking at the license in jsmn.c, we seem to be ok to modify it (to
>>> error on non-standard trailing ',') - that parser has already
>>> apparently been modified in mainline.
>>>
>>> If we do that then I hope that there are not to many violations in out
>>> JSONs, including downstream.
>>
>>
>> Sure we can modify the file. I already did some minor changes when I
>> submitted it originally.
>>
>> -Andi
> 
> jsmn is a somewhat frustrating way to work on json code and working on
> a forked version of jsmn was frustrating in [1]. Could we assume
> python on build systems and rewrite jevents in python?

Seems reasonable to me, although maybe a big job. I suppose there could be
an empty generated pmu file for systems that don't have Python and only the
ones listed in pmu-events/arch/ would need it.

James
> 
> Thanks,
> Ian
> 
> [1] https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/
> 

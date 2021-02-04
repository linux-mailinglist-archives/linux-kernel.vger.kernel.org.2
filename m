Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F89E30F19F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhBDLJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:09:36 -0500
Received: from foss.arm.com ([217.140.110.172]:56172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235551AbhBDLJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:09:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3765FD6E;
        Thu,  4 Feb 2021 03:08:36 -0800 (PST)
Received: from [10.57.60.124] (unknown [10.57.60.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EE403F73B;
        Thu,  4 Feb 2021 03:08:31 -0800 (PST)
Subject: Re: [PATCH v2 7/7] Documentation: coresight: Add PID tracing
 description
To:     Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210202163842.134734-1-leo.yan@linaro.org>
 <20210202163842.134734-8-leo.yan@linaro.org>
 <CAJ9a7VgzNphx=OkxjrxHJsuFAYEbOgHuAm9ysdwHq20=GhbgTg@mail.gmail.com>
 <20210204040909.GH11059@leoy-ThinkPad-X240s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a6ee6d9e-a17f-0861-60b5-585abe99ce92@arm.com>
Date:   Thu, 4 Feb 2021 11:08:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204040909.GH11059@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 4:09 AM, Leo Yan wrote:
> Hi Mike,
> 
> On Wed, Feb 03, 2021 at 05:39:54PM +0000, Mike Leach wrote:
> 
> [...]
> 
>>> +2.2) Tracing PID
>>> +
>>> +When the kernel is running at EL2 with Virtualization Host Extensions (VHE),
>>> +perf records CONTEXTIDR_EL2 in the trace data and can be used as PID when
>>> +decoding; and if the kernel is running at EL1 with nVHE, CONTEXTIDR_EL1 is
>>> +traced for PID.
>>> +
>>
>> Would this introductory paragraph be better if is explained where the
>> kernel stores the PID for the different levels, then we logically move
>> on to how to trace this in perf.
>>
>> e.g:-
>>
>> "The lernel can be built to write the PID value into the PE ContextID registers.
>> For a kernel running at EL1, the PID is stored in CONTEXTIDR_EL1.
>> A PE may implement ARM Virtualisation Host Extensions (VHE), were the
>> kernel can run at EL2 as a virtualisation host.
>> In this case the PID value is stored in CONTEXTIDR_EL2.
>> perf provides PMU options which program the ETM to insert these values
>> into the trace data."
> 
> Will in next spin; thanks a lot for writing up!
> 
>>> +To support tracing PID for the kernel runs at different exception levels,
>>> +the PMU formats are defined as follow:
>>> +
>>> +  "contextid1": Available on both EL1 kernel and EL2 kernel.  When the
>>> +                kernel is running at EL1, "contextid1" enables the PID
>>> +                tracing; when the kernel is running at EL2, this enables
>>> +                tracing the PID of guest applications.
>>> +
>>> +  "contextid2": Only usable when the kernel is running at EL2.  When
>>> +                selected, enables PID tracing on EL2 kernel.
>>> +
>>> +  "contextid":  Will be an alias for the option that enables PID
>>> +                tracing.  I.e,
>>> +                contextid == contextid1, on EL1 kernel.
>>> +                contextid == contextid2, on EL2 kernel.
>>> +
>>> +The perf tool automatically sets corresponding bit for the "contextid" config,
>>> +therefore, the user doesn't have to bother which EL the kernel is running.
>>> +
>>> +  i.e, perf record -e cs_etm/contextid/u -- uname
>>> +    or perf record -e cs_etm//u -- uname
>>> +
>>> +will always do the "PID" tracing, independent of the kernel EL.
>>> +
>>
>> This is telling me that both cs_etm// and cs_etm/contextid/ have the
>> same effect - trace PID. Is this correct?
> 

Just to make this clear, this is not a side effect of the patch. The perf
tool driver automatically adds the "contextid" tracing and timestamp for
"system wide" and process bound events, as they traces get mixed into
the single sink. So these options are added implicitly by the perf tool
to make the decoding easier.

> Correct.
> 
>> If so, then contextid, contextid1 and contextid2 have no effect except
>> in specific EL2 circumstances.

These are required when perf tool may not automatically request them.
With this series the EL2 is on par with the EL1, where we get the PID
automatcially in the trace.

And as you rightly said, contextid1, contextid2 are for EL2 specific
usage.

Cheers
Suzuki

> 
> Yes, exactly.
> 
> Thanks,
> Leo
> 
>>> +When the kernel is running at EL2 with VHE, if user wants to trace both the
>>> +PIDs for both host and guest, the two configs "contextid1" and "contextid2"
>>> +can be set at the same time:
>>> +
>>> +  perf record -e cs_etm/contextid1,contextid2/u -- uname
>>> +
>>>
>>
>>
>> Regards
>>
>> Mike
>>
>>
>>>   Generating coverage files for Feedback Directed Optimization: AutoFDO
>>>   ---------------------------------------------------------------------
>>> --
>>> 2.25.1
>>>
>>
>>
>> --
>> Mike Leach
>> Principal Engineer, ARM Ltd.
>> Manchester Design Centre. UK


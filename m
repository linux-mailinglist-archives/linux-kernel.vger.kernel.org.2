Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A18141DD00
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244917AbhI3PKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:10:41 -0400
Received: from foss.arm.com ([217.140.110.172]:55586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244732AbhI3PKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:10:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E1C8101E;
        Thu, 30 Sep 2021 08:08:55 -0700 (PDT)
Received: from [10.57.21.81] (unknown [10.57.21.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5D833F70D;
        Thu, 30 Sep 2021 08:08:53 -0700 (PDT)
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     Leo Yan <leo.yan@linaro.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>, german.gomez@arm.com
References: <20210916001748.1525291-1-namhyung@kernel.org>
 <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <363c4107-fc6f-51d0-94d8-a3f579c8f5a2@arm.com>
Date:   Thu, 30 Sep 2021 16:08:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923142305.GA603008@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2021 15:23, Leo Yan wrote:
> Hi Namhyung,
> 
> On Thu, Sep 16, 2021 at 02:01:21PM -0700, Namhyung Kim wrote:
> 
> [...]
> 
>>> Before we had discussion for enabling PID/TID for SPE samples; in the patch
>>> set [1], patches 07, 08 set sample's pid/tid based on the Arm SPE context
>>> packets.  To enable hardware tracing context ID, you also needs to enable
>>> kernel config CONFIG_PID_IN_CONTEXTIDR.
>>
>> Thanks for sharing this.
>>
>> Yeah I also look at the context info but having a dependency on a kconfig
>> looks limiting its functionality.  Also the kconfig says it has some overhead
>> in the critical path (even if perf is not running, right?) - but not sure how
>> much it can add.
> 
> Yes, after enabled config PID_IN_CONTEXTIDR, the kernel will always
> write PID into the system register CONTEXTIDR during process context
> switching.  Please see the flow:
> 
>   __switch_to() (arch/arm64/kernel/process.c)
>     `-> contextidr_thread_switch(next)
> 
>> config PID_IN_CONTEXTIDR
>>     bool "Write the current PID to the CONTEXTIDR register"
>>     help
>>       Enabling this option causes the kernel to write the current PID to
>>       the CONTEXTIDR register, at the expense of some additional
>>       instructions during context switch. Say Y here only if you are
>>       planning to use hardware trace tools with this kernel.
>>
>>>
>>> At that time, there have a concern is the hardware context ID might
>>> introduce confusion for non-root namespace.
>>
>> Sounds like a problem.
>>
>>>
>>> We also considered to use PERF_RECORD_SWITCH_CPU_WIDE event for setting
>>> pid/tid, the Intel PT implementation uses two things to set sample's
>>> pid/tid: one is PERF_RECORD_SWITCH_CPU_WIDE event and another is to detect
>>> the branch instruction is the symbol "__switch_to".  Since the trace
>>> event PERF_RECORD_SWITCH_CPU_WIDE is coarse, so it only uses the new
>>> pid/tid after the branch instruction for "__switch_to".  Arm SPE is
>>> 'statistical', thus it cannot promise the trace data must contain the
>>> branch instruction for "__switch_to", please see details [2].
>>
>> I can see the need in the Intel PT as it needs to trace all (branch)
>> instructions, but is it really needed for ARM SPE too?
>> Maybe I am missing something, but it seems enough to have a
>> coarse-grained context switch for sampling events..
> 
> The issue is that the coarse-grained context switch if introduces any
> inaccuracy in the reported result.  If we can run some workloads and
> prove the coarse-grained context switch doesn't cause significant bias,
> it will be great and can give us the confidence for this approach.

It sounds like it's worth testing. Do you think the inaccuracy would only
apply to code in the kernel around the time of the switch? Or do you think
it could affect userspace as well? It seems to me that the switch event
would have a timestamp that would precede _all_ userspace code, but I'm not
100% sure on that. I suppose it's easy to test.

German Gomez actually starting looking into the switch events for SPE at the
same time, so I've CCd him and maybe he can do some testing of the patch.

Thanks
James

> 
> Even enabling PERF_RECORD_SWITCH_CPU_WIDE event, I think it's good to
> give priority for hardware PID tracing in Arm SPE trace data, if detects
> the hardware PID tracing is enabled, then we can rollback to use
> context packets from hardware trace data to set sample's PID.
> 
> How about you think for this?
> 
> Thanks,
> Leo
> 

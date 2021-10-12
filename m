Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54B642A2D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhJLLJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:09:52 -0400
Received: from foss.arm.com ([217.140.110.172]:35860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233324AbhJLLJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:09:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73BA41FB;
        Tue, 12 Oct 2021 04:07:49 -0700 (PDT)
Received: from [10.1.34.171] (e127744.cambridge.arm.com [10.1.34.171])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 315823F694;
        Tue, 12 Oct 2021 04:07:46 -0700 (PDT)
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     Leo Yan <leo.yan@linaro.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s>
 <363c4107-fc6f-51d0-94d8-a3f579c8f5a2@arm.com>
 <20211004062638.GB174271@leoy-ThinkPad-X240s>
 <f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com>
 <20211006093620.GA14400@leoy-ThinkPad-X240s>
 <CAM9d7cghXgUbAqUUJjyKAea+9=jxei7RDScgV5Fd_i9bXyXkKA@mail.gmail.com>
 <be937a2e-311b-2a8b-1094-39c203c6d9f3@arm.com>
 <CAM9d7cho2hN+NDWd9-P-AQAf3D8WfPgCpEDe7cD6hk5FoA_c8Q@mail.gmail.com>
 <87dad53f-a9a5-cd36-7348-ee10f4edd8fb@arm.com>
 <20211011142940.GB37383@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <8a1eafe3-d19e-40d6-f659-de0e9daa5877@arm.com>
Date:   Tue, 12 Oct 2021 12:07:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211011142940.GB37383@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Leo and Namhyung,

I want to make sure I'm on the same page as you regarding this topic.

On 11/10/2021 15:29, Leo Yan wrote:
> Hi German,
>
> On Mon, Oct 11, 2021 at 02:58:40PM +0100, German Gomez wrote:
>> Hi Namhyung,
>>
>> On 09/10/2021 01:12, Namhyung Kim wrote:
>>
>>> Hi German,
>>>
>>> On Fri, Oct 8, 2021 at 4:08 AM German Gomez <german.gomez@arm.com> wrote:
>>>
>>> [...]
>>>
>>> I think we should use context-switch even for kernel samples, but
>>> only if the context packets are not available.

Do you think we should use them also when tracing outside of the root
namespace? I'm no sure if we are considering the driver patch to disable
context packets in non-root ns from earlier.

>> [...]
>> Actually I took time to try to find some way to enable switch events
>> conditionally.  As Namhyung suggested, we can enable the switch events
>> in the perf tool (should do this in arm_spe_recording_options()), I am
>> just wandering if perf tool can enable switch event only when it runs
>> in the non-root namespace.  I looked the code util/namespaces.c but
>> still fail to find any approach to confirm the perf is running in
>> the root namespace...  anyway, this is not critical for this work.
>>
>> Welcome if anyone has idea for this.

Thanks, Leo. We'll let you know if we come up with something too.

>
>> @Leo, what are your thoughts on this? Perhaps adding a warning message
>> to tell the user to please enable context packets, otherwise the results
>> will have workload-dependant inaccuracies, could be a good enough
>> compromise?
> Yeah, this is exactly what I think.  It's good to give a warning so
> users have knowledge for the potential inaccuracies.
>
> Thanks,
> Leo

If we are not considering patching the driver at this stage, so we allow
hardware tracing on non-root namespaces. I think we could proceed like
this:

  - For userspace, always use context-switch events as they are
    accurate and consistent with namespaces.
  - For kernel tracing, if context packets are enabled, use them, but
    warn the user that the PIDs correspond to the root namespace.
  - Otherwise, use context-switch events and warn the user of the time
    inaccuracies.

Later, if the driver is patched to disable context packets outside the
root namespace, kernel tracing could fall back to using context-switch
events and warn the user with a single message about the time
inaccuracies.

If we are aligned, we could collect your feedback and share an updated
patch that considers the warnings.

Many thanks
Best regards

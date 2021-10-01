Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8696441EB22
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 12:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353653AbhJAKqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 06:46:13 -0400
Received: from foss.arm.com ([217.140.110.172]:40090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352862AbhJAKqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:46:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88B8D106F;
        Fri,  1 Oct 2021 03:44:25 -0700 (PDT)
Received: from [10.32.36.22] (e121896.Emea.Arm.com [10.32.36.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11F593F70D;
        Fri,  1 Oct 2021 03:44:22 -0700 (PDT)
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210916001748.1525291-1-namhyung@kernel.org>
 <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s>
 <CAM9d7cixyD6ZmXnBnoB8Zg-JN-tWYXUdqURHGn+2ZMD5x9evew@mail.gmail.com>
 <CABPqkBTW9dnfSz1KrtiGNzbOf7QfzB6ga+EQvK28J+3-SzBsgQ@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <8cc1574a-29a9-f550-0b09-a23ce69467d3@arm.com>
Date:   Fri, 1 Oct 2021 11:44:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABPqkBTW9dnfSz1KrtiGNzbOf7QfzB6ga+EQvK28J+3-SzBsgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/09/2021 19:47, Stephane Eranian wrote:
> On Thu, Sep 23, 2021 at 9:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hi Leo,
>>
>> On Thu, Sep 23, 2021 at 7:23 AM Leo Yan <leo.yan@linaro.org> wrote:
>>>
>>> Hi Namhyung,
>>>
>>> On Thu, Sep 16, 2021 at 02:01:21PM -0700, Namhyung Kim wrote:
>>>
>>> [...]
>>>
>>>>> Before we had discussion for enabling PID/TID for SPE samples; in the patch
>>>>> set [1], patches 07, 08 set sample's pid/tid based on the Arm SPE context
>>>>> packets.  To enable hardware tracing context ID, you also needs to enable
>>>>> kernel config CONFIG_PID_IN_CONTEXTIDR.
>>>>
>>>> Thanks for sharing this.
>>>>
>>>> Yeah I also look at the context info but having a dependency on a kconfig
>>>> looks limiting its functionality.  Also the kconfig says it has some overhead
>>>> in the critical path (even if perf is not running, right?) - but not sure how
>>>> much it can add.
>>>
>>> Yes, after enabled config PID_IN_CONTEXTIDR, the kernel will always
>>> write PID into the system register CONTEXTIDR during process context
>>> switching.  Please see the flow:
>>>
>>>   __switch_to() (arch/arm64/kernel/process.c)
>>>     `-> contextidr_thread_switch(next)
>>
>> Thanks for the info.  I assume it's a light-weight operation.
>>
>>
> I'd like to understand why it was believed that having SPE record to
> PID could be too expensive
> vs. what I am seeing with all the tracking of context switches and the
> volume of data this generates.
> 

I think the justification about it being expensive is that when PID_IN_CONTEXTIDR
is set, there is an extra few instructions to write that value on every context
switch, whether SPE is enabled or not. So it has a system wide impact.

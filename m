Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF9A423FCA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbhJFOIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:08:24 -0400
Received: from foss.arm.com ([217.140.110.172]:54164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238733AbhJFOIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:08:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 219F06D;
        Wed,  6 Oct 2021 07:06:28 -0700 (PDT)
Received: from [10.57.23.208] (unknown [10.57.23.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F5A03F66F;
        Wed,  6 Oct 2021 07:06:26 -0700 (PDT)
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     German Gomez <german.gomez@arm.com>, Leo Yan <leo.yan@linaro.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210916001748.1525291-1-namhyung@kernel.org>
 <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s>
 <363c4107-fc6f-51d0-94d8-a3f579c8f5a2@arm.com>
 <20211004062638.GB174271@leoy-ThinkPad-X240s>
 <f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <4ec2508a-d87a-ad91-87ec-dadef71bbc78@arm.com>
Date:   Wed, 6 Oct 2021 15:06:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2021 11:06, German Gomez wrote:
> Hi Leo,
> 
> On 04/10/2021 07:26, Leo Yan wrote:
>> Hi James,
>>
>> On Thu, Sep 30, 2021 at 04:08:52PM +0100, James Clark wrote:
>>> On 23/09/2021 15:23, Leo Yan wrote:
>>>> On Thu, Sep 16, 2021 at 02:01:21PM -0700, Namhyung Kim wrote:
>> [...]
>> I'd like to use the comparison method for the test:
>> We should enable PID tracing and capture in the perf.data, when decode
>> the trace data, we can based on context packet and based on the switch
>> events to generate out two results, so we can check how the difference
>> between these results.
> 
> Yesterday we did some testing and found that there seems to be an exact
> match between using context packets and switch events. However this only
> applies when tracing in userspace (by adding the 'u' suffix to the perf
> event). Otherwise we still see as much as 2% of events having the wrong
> PID around the time of the switch.
> 
> In order to measure this I applied Namhyung's patch and James's patch
> from [1]. 

I thought that this had been applied already so I need to follow this up.

James

[...]
> 
> [1] https://www.spinics.net/lists/linux-perf-users/msg12543.html
> 

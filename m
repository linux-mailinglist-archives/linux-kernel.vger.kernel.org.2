Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6653D7591
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhG0NGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:06:38 -0400
Received: from foss.arm.com ([217.140.110.172]:38622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232106AbhG0NGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:06:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E62CD1FB;
        Tue, 27 Jul 2021 06:06:36 -0700 (PDT)
Received: from [10.57.85.65] (unknown [10.57.85.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2A1E3F66F;
        Tue, 27 Jul 2021 06:06:34 -0700 (PDT)
Subject: Re: [PATCH v2 07/10] coresight: trbe: Do not truncate buffer on IRQ
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tamas.zsoldos@arm.com, Al Grant <al.grant@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        jinlmao@qti.qualcomm.com, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
 <20210723124611.3828908-8-suzuki.poulose@arm.com>
 <CAJ9a7Vi28GuPUx8jvGoYhqBRzWanwhiLJJuLnaZuPj46g3ex2w@mail.gmail.com>
 <064baefd-1213-1e54-20a0-b28f7565a810@arm.com>
 <CAJ9a7VgEfx=BREdo23EW60c8W-FXNPrkDjAbiXA-wOi-cm_D8A@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <278117cd-677d-c1be-b1e3-ea2a8825fcb1@arm.com>
Date:   Tue, 27 Jul 2021 14:06:33 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAJ9a7VgEfx=BREdo23EW60c8W-FXNPrkDjAbiXA-wOi-cm_D8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2021 11:46, Mike Leach wrote:
> HI Suzuki,
> 
> On Mon, 26 Jul 2021 at 17:01, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Hi Mike,
>>
>> On 26/07/2021 13:34, Mike Leach wrote:
>>> Hi Suzuki,
>>>
>>> On Fri, 23 Jul 2021 at 13:46, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>
>>>> The TRBE driver marks the AUX buffer as TRUNCATED when we get an IRQ
>>>> on FILL event. This has rather unwanted side-effect of the event
>>>> being disabled when there may be more space in the ring buffer.
>>>>
>>>> So, instead of TRUNCATE we need a different flag to indicate
>>>> that the trace may have lost a few bytes (i.e from the point of
>>>> generating the FILL event until the IRQ is consumed). Anyways, the
>>>> userspace must use the size from RECORD_AUX headers to restrict
>>>> the "trace" decoding.
>>>>
>>>> Using PARTIAL flag causes the perf tool to generate the
>>>> following warning:
>>>>
>>>>     Warning:
>>>>     AUX data had gaps in it XX times out of YY!
>>>>
>>>>     Are you running a KVM guest in the background?
>>>>
>>>> which is pointlessly scary for a user. The other remaining options
>>>> are :
>>>>     - COLLISION - Use by SPE to indicate samples collided
>>>>     - Add a new flag - Specifically for CoreSight, doesn't sound
>>>>       so good, if we can re-use something.
>>>>
>>>
>>> What is the user visible behaviour when using COLLISION?
>>
>> If you meant a Warning from the perf tool (similar to TRUNCATE or
>> PARTIAL), the answer is none. We could add one in the perf tool
>> if you think this is necessary.
>>
> 
> I do - the problem is that we have replaced a visible warning with a
> silent failure.
> 
> While we agree that the side effects of TRUNCATE mean it unfeasible as
> a solution here - at least the PARTIAL message does give some
> indication.
> The average perf user is going to rely on the output from the tool -
> if there is no warning they will assume all is good, but they have
> possible non-contiguous trace and no indication of such.
> 
> Since we are using a collision flag  in a particular context - i.e.
> coresight trace - we have the chance to provide an appropriate message
> for this context.
> 
>>> The TRUNCATE warning is at least accurate - even if the KVM thing is
>>> something of a red herring.
>>
> 
> Sorry - I meant PARTIAL here - but the comment stands otherwise.
> 
>>
>>> It is easier to explain a "scary" warning, than try to debug someones
>>> problems if perf is silent or misleading when using the COLLISION
>>> flag.
>>
>> The RECORD_AUX still has this flag. So, if someone really wanted to
>> know how many times the TRBE fired the IRQ and thus potentially lost a
>> few bytes of the trace, they could always look at this.
>>
> 
> They could - but how would they know that they needed to - what
> indicators would they have that the trace was not continuous?
> The point of the perf tool is that it presents an accurate picture to
> the user, based on the data collected. Most users aren't going to
> start digging into the intricacies of the perf data file formats and
> nor should they have to.
> 
>> Definitely this is not something similar to "TRUNCATED", which we
>> realized the hard way, nor the PARTIAL. But the perf tool could
>> report something similar. Please remember that the perf tool always
>> uses the "size" field from the RECORD_AUX to limit the trace decoding.
>>
>> So, I am not sure how this could create new problems.
>>
> 
> There is no issue with decode - but if a user is investigating a
> problem using trace, they need to be aware that some trace might be
> dropped.
> That way they can take mitigating action.

Agreed. This is something that can be done by the perf tool.

Kind regards
Suzuki

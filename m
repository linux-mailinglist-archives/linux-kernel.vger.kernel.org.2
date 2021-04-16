Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA04362041
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbhDPMvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:51:55 -0400
Received: from foss.arm.com ([217.140.110.172]:40762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235074AbhDPMvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:51:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAD8411B3;
        Fri, 16 Apr 2021 05:51:28 -0700 (PDT)
Received: from [10.57.57.112] (unknown [10.57.57.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99AA23F85F;
        Fri, 16 Apr 2021 05:51:26 -0700 (PDT)
Subject: Re: [PATCH v4 4/6] perf arm-spe: Assign kernel time to synthesized
 event
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <Al.Grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210412091006.468557-1-leo.yan@linaro.org>
 <20210412091006.468557-5-leo.yan@linaro.org>
 <9036368a-e824-3d63-da5b-54cf32a86aed@arm.com>
 <20210415152348.GF1011890@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <c9c060d1-0884-b67d-7689-6b45ad10baa9@arm.com>
Date:   Fri, 16 Apr 2021 15:51:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210415152348.GF1011890@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/04/2021 18:23, Leo Yan wrote:
> On Thu, Apr 15, 2021 at 05:46:31PM +0300, James Clark wrote:
>>
>>
>> On 12/04/2021 12:10, Leo Yan wrote:
>>> In current code, it assigns the arch timer counter to the synthesized
>>> samples Arm SPE trace, thus the samples don't contain the kernel time
>>> but only contain the raw counter value.
>>>
>>> To fix the issue, this patch converts the timer counter to kernel time
>>> and assigns it to sample timestamp.
>>>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>> ---
>>>  tools/perf/util/arm-spe.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>>> index 23714cf0380e..c13a89f06ab8 100644
>>> --- a/tools/perf/util/arm-spe.c
>>> +++ b/tools/perf/util/arm-spe.c
>>> @@ -234,7 +234,7 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
>>>  	struct arm_spe_record *record = &speq->decoder->record;
>>>  
>>>  	if (!spe->timeless_decoding)
>>> -		sample->time = speq->timestamp;
>>> +		sample->time = tsc_to_perf_time(record->timestamp, &spe->tc);
>>
>>
>> I noticed that in arm_spe_recording_options() the TIME sample bit is set regardless of any options.
>> I don't know of a way to remove this, and if there isn't, does that mean that all the code in this
>> file that looks at spe->timeless_decoding is untested and has never been hit?
>>
>> Unless there is a way to get a perf file with only the AUXTRACE event and no others? I think that one
>> might have no timestamp set. Otherwise other events will always have timestamps so spe->timeless_decoding
>> is always false.
> 
> Good point.  To be honest, I never noticed this issue until you
> mentioned this.
> 
> We should fix for the "timeless" flow; and it's questionable for the
> function arm_spe_recording_options(), except for setting
> PERF_SAMPLE_TIME, it also hard codes for setting
> PERF_SAMPLE_CPU and PERF_SAMPLE_TID.  Might need to carefully go
> through this function.
> 

Yeah, it's not strictly related to your change, which is definitely an improvement.
But maybe we should have a look at the SPE implementation relating to timestamps as a whole.

> Thanks,
> Leo
> 

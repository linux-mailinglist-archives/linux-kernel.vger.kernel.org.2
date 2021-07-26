Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED033D6294
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhGZPgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 11:36:22 -0400
Received: from foss.arm.com ([217.140.110.172]:54662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237078AbhGZPUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:20:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1145E1042;
        Mon, 26 Jul 2021 09:01:23 -0700 (PDT)
Received: from [10.57.85.65] (unknown [10.57.85.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F0EE3F66F;
        Mon, 26 Jul 2021 09:01:20 -0700 (PDT)
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
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <064baefd-1213-1e54-20a0-b28f7565a810@arm.com>
Date:   Mon, 26 Jul 2021 17:01:19 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAJ9a7Vi28GuPUx8jvGoYhqBRzWanwhiLJJuLnaZuPj46g3ex2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 26/07/2021 13:34, Mike Leach wrote:
> Hi Suzuki,
> 
> On Fri, 23 Jul 2021 at 13:46, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> The TRBE driver marks the AUX buffer as TRUNCATED when we get an IRQ
>> on FILL event. This has rather unwanted side-effect of the event
>> being disabled when there may be more space in the ring buffer.
>>
>> So, instead of TRUNCATE we need a different flag to indicate
>> that the trace may have lost a few bytes (i.e from the point of
>> generating the FILL event until the IRQ is consumed). Anyways, the
>> userspace must use the size from RECORD_AUX headers to restrict
>> the "trace" decoding.
>>
>> Using PARTIAL flag causes the perf tool to generate the
>> following warning:
>>
>>    Warning:
>>    AUX data had gaps in it XX times out of YY!
>>
>>    Are you running a KVM guest in the background?
>>
>> which is pointlessly scary for a user. The other remaining options
>> are :
>>    - COLLISION - Use by SPE to indicate samples collided
>>    - Add a new flag - Specifically for CoreSight, doesn't sound
>>      so good, if we can re-use something.
>>
> 
> What is the user visible behaviour when using COLLISION?

If you meant a Warning from the perf tool (similar to TRUNCATE or
PARTIAL), the answer is none. We could add one in the perf tool
if you think this is necessary.

> The TRUNCATE warning is at least accurate - even if the KVM thing is
> something of a red herring.


> It is easier to explain a "scary" warning, than try to debug someones
> problems if perf is silent or misleading when using the COLLISION
> flag.

The RECORD_AUX still has this flag. So, if someone really wanted to
know how many times the TRBE fired the IRQ and thus potentially lost a
few bytes of the trace, they could always look at this.

Definitely this is not something similar to "TRUNCATED", which we
realized the hard way, nor the PARTIAL. But the perf tool could
report something similar. Please remember that the perf tool always
uses the "size" field from the RECORD_AUX to limit the trace decoding.

So, I am not sure how this could create new problems.

Suzuki

> 
> Regards
> 
> Mike
> 
> 
>> Given that we don't already use the "COLLISION" flag, the above
>> behavior can be notified using this flag for CoreSight.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: James Clark <james.clark@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-trbe.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index 503bea0137ae..d50f142e86d1 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -615,7 +615,7 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>>                   * for correct size. Also, mark the buffer truncated.
>>                   */
>>                  write = get_trbe_limit_pointer();
>> -               perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>> +               perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
>>          }
>>
>>          offset = write - base;
>> @@ -708,7 +708,7 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
>>           * collection upon the WRAP event, without stopping the source.
>>           */
>>          perf_aux_output_flag(handle, PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW |
>> -                                    PERF_AUX_FLAG_TRUNCATED);
>> +                                    PERF_AUX_FLAG_COLLISION);
>>          perf_aux_output_end(handle, size);
>>          event_data = perf_aux_output_begin(handle, event);
>>          if (!event_data) {
>> --
>> 2.24.1
>>
> 
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C7D30F15E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhBDK6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:58:11 -0500
Received: from foss.arm.com ([217.140.110.172]:55976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235346AbhBDK6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:58:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB101D6E;
        Thu,  4 Feb 2021 02:57:23 -0800 (PST)
Received: from [10.57.60.124] (unknown [10.57.60.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF72B3F73B;
        Thu,  4 Feb 2021 02:57:19 -0800 (PST)
Subject: Re: [PATCH v2 6/7] perf cs-etm: Detect pid in VMID for kernel running
 at EL2
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
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
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Grant <al.grant@arm.com>
References: <20210202163842.134734-1-leo.yan@linaro.org>
 <20210202163842.134734-7-leo.yan@linaro.org>
 <f5158216-c3d1-10bb-02eb-00ff9a78f617@arm.com>
 <20210204040021.GF11059@leoy-ThinkPad-X240s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a8116024-76df-4c42-15ef-de3f02436b8c@arm.com>
Date:   Thu, 4 Feb 2021 10:57:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204040021.GF11059@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 4:00 AM, Leo Yan wrote:
> On Tue, Feb 02, 2021 at 11:29:47PM +0000, Suzuki Kuruppassery Poulose wrote:
>> On 2/2/21 4:38 PM, Leo Yan wrote:
>>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>
>>> The PID of the task could be traced as VMID when the kernel is running
>>> at EL2.  Teach the decoder to look for VMID when the CONTEXTIDR (Arm32)
>>> or CONTEXTIDR_EL1 (Arm64) is invalid but we have a valid VMID.
>>>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Al Grant <al.grant@arm.com>
>>> Co-developed-by: Leo Yan <leo.yan@linaro.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>> ---
>>>    .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 32 ++++++++++++++++---
>>>    1 file changed, 28 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> index 3f4bc4050477..fb2a163ff74e 100644
>>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> @@ -6,6 +6,7 @@
>>>     * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>     */
>>> +#include <linux/coresight-pmu.h>
>>>    #include <linux/err.h>
>>>    #include <linux/list.h>
>>>    #include <linux/zalloc.h>
>>> @@ -491,13 +492,36 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
>>>    			const ocsd_generic_trace_elem *elem,
>>>    			const uint8_t trace_chan_id)
>>>    {
>>> -	pid_t tid;
>>> +	pid_t tid = -1;
>>> +	u64 pid_fmt;
>>> +	int ret;
>>> -	/* Ignore PE_CONTEXT packets that don't have a valid contextID */
>>> -	if (!elem->context.ctxt_id_valid)
>>> +	ret = cs_etm__get_pid_fmt(trace_chan_id, &pid_fmt);
>>> +	if (ret)
>>
>> Is this something we can cache in this function ? e.g,
>> 	static u64 pid_fmt;
>>
>> 	if (!pid_pfmt)
>> 		ret = cs_etm__get_pid_fmt(trace_chan_id, &pid_fmt);
>>
>> As all the ETMs will be running at the same exception level.
> 
> Sorry that I let you repeated your comments again.
> 
> To be honest, I considered this after read your comment in the previous
> series, but I thought it's possible that multiple CPUs have different
> PID format, especially for big.LITTLE arch.  After read your suggestion
> again, I think my concern is not valid, even for big.LITTLE, all CPUs
> should run on the same kernel exception level.
> 
> So will follow up your suggestion to cache "pid_fmt".

No problem.

> 
>>
>>> +		return OCSD_RESP_FATAL_SYS_ERR;
>>> +
>>> +	/*
>>> +	 * Process the PE_CONTEXT packets if we have a valid contextID or VMID.
>>> +	 * If the kernel is running at EL2, the PID is traced in CONTEXTIDR_EL2
>>> +	 * as VMID, Bit ETM_OPT_CTXTID2 is set in this case.
>>> +	 */
>>> +	switch (pid_fmt) {
>>> +	case BIT(ETM_OPT_CTXTID):
>>> +		if (elem->context.ctxt_id_valid)
>>> +			tid = elem->context.context_id;
>>> +		break;
>>> +	case BIT(ETM_OPT_CTXTID2) | BIT(ETM_OPT_CTXTID):
>>
>> I would rather fix the cs_etm__get_pid_fmt() to return either of these
>> as commented. i.e, ETM_OPT_CTXTID or ETM_OPT_CTXTID2. Thus we don't
>> need the this case.
> 
> I explained why I set both bits for ETM_OPT_CTXTID and ETM_OPT_CTXTID2
> in the patch 05/07.  Could you take a look for it?

I have responded to the comment in the patch.

> 
>> With the above two addressed:
>>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 


Thanks
Suzuki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA8930F14D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhBDKz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:55:29 -0500
Received: from foss.arm.com ([217.140.110.172]:55882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234873AbhBDKz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:55:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C2DBD6E;
        Thu,  4 Feb 2021 02:54:41 -0800 (PST)
Received: from [10.57.60.124] (unknown [10.57.60.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95B653F73B;
        Thu,  4 Feb 2021 02:54:37 -0800 (PST)
Subject: Re: [PATCH v2 5/7] perf cs-etm: Add helper cs_etm__get_pid_fmt()
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
        linux-kernel@vger.kernel.org
References: <20210202163842.134734-1-leo.yan@linaro.org>
 <20210202163842.134734-6-leo.yan@linaro.org>
 <51a1e845-f9a4-3c6e-88a2-c105f5b5adfe@arm.com>
 <20210204034743.GE11059@leoy-ThinkPad-X240s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <afb60e3b-697d-4503-a8de-11cd1a0bf97d@arm.com>
Date:   Thu, 4 Feb 2021 10:54:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204034743.GE11059@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 3:47 AM, Leo Yan wrote:
> On Tue, Feb 02, 2021 at 11:19:22PM +0000, Suzuki Kuruppassery Poulose wrote:
>> On 2/2/21 4:38 PM, Leo Yan wrote:
>>> This patch adds helper function cs_etm__get_pid_fmt(), by passing
>>> parameter "traceID", it returns the PID format.
>>>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>> ---
>>>    tools/perf/util/cs-etm.c | 43 ++++++++++++++++++++++++++++++++++++++++
>>>    tools/perf/util/cs-etm.h |  1 +
>>>    2 files changed, 44 insertions(+)
>>>
>>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>> index a2a369e2fbb6..8194ddbd01e5 100644
>>> --- a/tools/perf/util/cs-etm.c
>>> +++ b/tools/perf/util/cs-etm.c
>>> @@ -7,6 +7,7 @@
>>>     */
>>>    #include <linux/bitops.h>
>>> +#include <linux/coresight-pmu.h>
>>>    #include <linux/err.h>
>>>    #include <linux/kernel.h>
>>>    #include <linux/log2.h>
>>> @@ -156,6 +157,48 @@ int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
>>>    	return 0;
>>>    }
>>> +/*
>>> + * The returned PID format is presented by two bits:
>>> + *
>>> + *   Bit ETM_OPT_CTXTID: CONTEXTIDR or CONTEXTIDR_EL1 is traced;
>>> + *   Bit ETM_OPT_CTXTID2: CONTEXTIDR_EL2 is traced.
>>> + *
>>> + * It's possible that these two bits are set together, this means the tracing
>>> + * contains PIDs for both CONTEXTIDR_EL1 and CONTEXTIDR_EL2.
>>
>> This is a bit confusing. If both the bits are set, the session
>> was run on an EL2 kernel. Thus, the PID is always in CONTEXTIDR_EL2.
> 
> Sorry for confusion.  I'd like to rephrase as:
> 
> It's possible that the two bits ETM_OPT_CTXTID and ETM_OPT_CTXTID2 are
> enabled at the same time when the session runs on an EL2 kernel.  This
> means the CONTEXTIDR_EL1 and CONTEXTIDR_EL2 both will be recorded in
> the trace data, the tool will selectively use CONTEXTIDR_EL2 as PID.
> 
>>> + */
>>> +int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
>>> +{
>>> +	struct int_node *inode;
>>> +	u64 *metadata, val;
>>> +
>>> +	inode = intlist__find(traceid_list, trace_chan_id);
>>> +	if (!inode)
>>> +		return -EINVAL;
>>> +
>>> +	metadata = inode->priv;
>>> +
>>> +	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
>>> +		val = metadata[CS_ETM_ETMCR];
>>> +		/* CONTEXTIDR is traced */
>>> +		if (val & BIT(ETM_OPT_CTXTID))
>>> +			*pid_fmt = BIT(ETM_OPT_CTXTID);
>>> +	} else {
>>> +		val = metadata[CS_ETMV4_TRCCONFIGR];
>>> +
>>> +		*pid_fmt = 0;
>>> +
>>> +		/* CONTEXTIDR_EL2 is traced */
>>> +		if (val & (BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT)))
>>> +			*pid_fmt = BIT(ETM_OPT_CTXTID2);
>>> +
>>> +		/* CONTEXTIDR_EL1 is traced */
>>> +		if (val & BIT(ETM4_CFG_BIT_CTXTID))
>>
>> I haven't looked at how this gets used. But, Shouldn't this be :
>>
>> 		else if (val & BIT(ETM4_CFG_BIT_CTXTID)) ?
> 
> Actually it's deliberately to set both bits ETM_OPT_CTXTID2 and
> ETM_OPT_CTXTID if user has enable configs "contextid1" and
> "contextid2".  So this is exactly the reversed flow in the
> function cs_etmv4_get_config().

The point is, we don't care if the user selected both options. What we
care is, where can we find the PID. CONTEXTIDR_EL1 or CONTEXTIDR_EL2.
As such, get_pid_fmt simply should make that decision and pass it on.
So, if the CONTEXTIDR_EL2 is selected (which can only be done successfully
on an EL2 kernel), thats our pid.

So we should return the format for the PID here. i.e
  ETM_OPT_CTXTID2 OR ETM_OPT_CTXTID. But not both.

Cheers
Suzuki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFAA30CFD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 00:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbhBBXU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 18:20:29 -0500
Received: from foss.arm.com ([217.140.110.172]:59844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232665AbhBBXU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 18:20:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 202A131B;
        Tue,  2 Feb 2021 15:19:39 -0800 (PST)
Received: from [10.57.35.108] (unknown [10.57.35.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AECDC3F694;
        Tue,  2 Feb 2021 15:19:35 -0800 (PST)
Subject: Re: [PATCH v2 5/7] perf cs-etm: Add helper cs_etm__get_pid_fmt()
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <51a1e845-f9a4-3c6e-88a2-c105f5b5adfe@arm.com>
Date:   Tue, 2 Feb 2021 23:19:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202163842.134734-6-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 4:38 PM, Leo Yan wrote:
> This patch adds helper function cs_etm__get_pid_fmt(), by passing
> parameter "traceID", it returns the PID format.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   tools/perf/util/cs-etm.c | 43 ++++++++++++++++++++++++++++++++++++++++
>   tools/perf/util/cs-etm.h |  1 +
>   2 files changed, 44 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index a2a369e2fbb6..8194ddbd01e5 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <linux/bitops.h>
> +#include <linux/coresight-pmu.h>
>   #include <linux/err.h>
>   #include <linux/kernel.h>
>   #include <linux/log2.h>
> @@ -156,6 +157,48 @@ int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
>   	return 0;
>   }
>   
> +/*
> + * The returned PID format is presented by two bits:
> + *
> + *   Bit ETM_OPT_CTXTID: CONTEXTIDR or CONTEXTIDR_EL1 is traced;
> + *   Bit ETM_OPT_CTXTID2: CONTEXTIDR_EL2 is traced.
> + *
> + * It's possible that these two bits are set together, this means the tracing
> + * contains PIDs for both CONTEXTIDR_EL1 and CONTEXTIDR_EL2.

This is a bit confusing. If both the bits are set, the session
was run on an EL2 kernel. Thus, the PID is always in CONTEXTIDR_EL2.

> + */
> +int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
> +{
> +	struct int_node *inode;
> +	u64 *metadata, val;
> +
> +	inode = intlist__find(traceid_list, trace_chan_id);
> +	if (!inode)
> +		return -EINVAL;
> +
> +	metadata = inode->priv;
> +
> +	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
> +		val = metadata[CS_ETM_ETMCR];
> +		/* CONTEXTIDR is traced */
> +		if (val & BIT(ETM_OPT_CTXTID))
> +			*pid_fmt = BIT(ETM_OPT_CTXTID);
> +	} else {
> +		val = metadata[CS_ETMV4_TRCCONFIGR];
> +
> +		*pid_fmt = 0;
> +
> +		/* CONTEXTIDR_EL2 is traced */
> +		if (val & (BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT)))
> +			*pid_fmt = BIT(ETM_OPT_CTXTID2);
> +
> +		/* CONTEXTIDR_EL1 is traced */
> +		if (val & BIT(ETM4_CFG_BIT_CTXTID))

I haven't looked at how this gets used. But, Shouldn't this be :

		else if (val & BIT(ETM4_CFG_BIT_CTXTID)) ?

Suzuki

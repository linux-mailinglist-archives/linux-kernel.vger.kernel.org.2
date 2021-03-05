Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DB032F13B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhCERba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:31:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhCERa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:30:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB0DF65020;
        Fri,  5 Mar 2021 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614965456;
        bh=CVsvv7UFetXQMMq5IPnSWLmRDhBKI97RD+pTVdoh59w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QP9DdUp+bEXDQFvCjM93ztF7f8GOJVXE2yEOpN8fxjEht6I4KhKTjyA8A2LmnuzIk
         /74zvQgQL1+Ia4jhoGKD/cuZsgv1Ey3xeAcd9Rl/iJTdl/4Yq1NGLMErfoBKYB6iYb
         uQdzucQ6dDYESpORgeumLKzjO7BJjkrzLcVSbn3IxCnl7n9LBndHENKs78rJDuvcwP
         JmDw+nj1Dd5U9s21ocoKbW+4kDHOwwbiSJ1hhe+oni0Kib3KHQIoMZ7VHG4lcVfuDN
         AtgXXkNyesV5aYJARInuDqR2x/Pz+weLCt3JXMuIN1OZRrtHQa+jXlRyKFsAmH5MeV
         h3k9y7p0uMBPA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3494340647; Fri,  5 Mar 2021 14:30:54 -0300 (-03)
Date:   Fri, 5 Mar 2021 14:30:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] perf cs-etm: Support PID tracing in config
Message-ID: <YEJqzqd/tLVLTmm6@kernel.org>
References: <20210206150833.42120-1-leo.yan@linaro.org>
 <20210206150833.42120-6-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206150833.42120-6-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Feb 06, 2021 at 11:08:30PM +0800, Leo Yan escreveu:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> If the kernel is running at EL2, the pid of a task is exposed via VMID
> instead of the CONTEXTID.  Add support for this in the perf tool.
> 
> This patch respects user setting if user has specified any configs
> from "contextid", "contextid1" or "contextid2"; otherwise, it
> dynamically sets config based on PMU format "contextid".

Since the merge window is closed, I'll continue processing this from
here onwards on my perf/core branch, as soon as I get what I have in
perf/urgent sent upstream and merged.

- Arnaldo

> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Al Grant <al.grant@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Co-developed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> ---
>  tools/include/linux/coresight-pmu.h |  3 ++
>  tools/perf/arch/arm/util/cs-etm.c   | 61 +++++++++++++++++++++++------
>  2 files changed, 52 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> index 5dc47cfdcf07..4ac5c081af93 100644
> --- a/tools/include/linux/coresight-pmu.h
> +++ b/tools/include/linux/coresight-pmu.h
> @@ -20,14 +20,17 @@
>   */
>  #define ETM_OPT_CYCACC		12
>  #define ETM_OPT_CTXTID		14
> +#define ETM_OPT_CTXTID2		15
>  #define ETM_OPT_TS		28
>  #define ETM_OPT_RETSTK		29
>  
>  /* ETMv4 CONFIGR programming bits for the ETM OPTs */
>  #define ETM4_CFG_BIT_CYCACC	4
>  #define ETM4_CFG_BIT_CTXTID	6
> +#define ETM4_CFG_BIT_VMID	7
>  #define ETM4_CFG_BIT_TS		11
>  #define ETM4_CFG_BIT_RETSTK	12
> +#define ETM4_CFG_BIT_VMID_OPT	15
>  
>  static inline int coresight_get_trace_id(int cpu)
>  {
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index c25c878fd06c..fa6f91a7c8a1 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -67,6 +67,7 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
>  	char path[PATH_MAX];
>  	int err = -EINVAL;
>  	u32 val;
> +	u64 contextid;
>  
>  	ptr = container_of(itr, struct cs_etm_recording, itr);
>  	cs_etm_pmu = ptr->cs_etm_pmu;
> @@ -86,25 +87,59 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
>  		goto out;
>  	}
>  
> +	/* User has configured for PID tracing, respects it. */
> +	contextid = evsel->core.attr.config &
> +			(BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_CTXTID2));
> +
>  	/*
> -	 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID tracing
> -	 * is supported:
> -	 *  0b00000 Context ID tracing is not supported.
> -	 *  0b00100 Maximum of 32-bit Context ID size.
> -	 *  All other values are reserved.
> +	 * If user doesn't configure the contextid format, parse PMU format and
> +	 * enable PID tracing according to the "contextid" format bits:
> +	 *
> +	 *   If bit ETM_OPT_CTXTID is set, trace CONTEXTIDR_EL1;
> +	 *   If bit ETM_OPT_CTXTID2 is set, trace CONTEXTIDR_EL2.
>  	 */
> -	val = BMVAL(val, 5, 9);
> -	if (!val || val != 0x4) {
> -		err = -EINVAL;
> -		goto out;
> +	if (!contextid)
> +		contextid = perf_pmu__format_bits(&cs_etm_pmu->format,
> +						  "contextid");
> +
> +	if (contextid & BIT(ETM_OPT_CTXTID)) {
> +		/*
> +		 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID
> +		 * tracing is supported:
> +		 *  0b00000 Context ID tracing is not supported.
> +		 *  0b00100 Maximum of 32-bit Context ID size.
> +		 *  All other values are reserved.
> +		 */
> +		val = BMVAL(val, 5, 9);
> +		if (!val || val != 0x4) {
> +			pr_err("%s: CONTEXTIDR_EL1 isn't supported\n",
> +			       CORESIGHT_ETM_PMU_NAME);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	if (contextid & BIT(ETM_OPT_CTXTID2)) {
> +		/*
> +		 * TRCIDR2.VMIDOPT[30:29] != 0 and
> +		 * TRCIDR2.VMIDSIZE[14:10] == 0b00100 (32bit virtual contextid)
> +		 * We can't support CONTEXTIDR in VMID if the size of the
> +		 * virtual context id is < 32bit.
> +		 * Any value of VMIDSIZE >= 4 (i.e, > 32bit) is fine for us.
> +		 */
> +		if (!BMVAL(val, 29, 30) || BMVAL(val, 10, 14) < 4) {
> +			pr_err("%s: CONTEXTIDR_EL2 isn't supported\n",
> +			       CORESIGHT_ETM_PMU_NAME);
> +			err = -EINVAL;
> +			goto out;
> +		}
>  	}
>  
>  	/* All good, let the kernel know */
> -	evsel->core.attr.config |= (1 << ETM_OPT_CTXTID);
> +	evsel->core.attr.config |= contextid;
>  	err = 0;
>  
>  out:
> -
>  	return err;
>  }
>  
> @@ -489,7 +524,9 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
>  		config |= BIT(ETM4_CFG_BIT_TS);
>  	if (config_opts & BIT(ETM_OPT_RETSTK))
>  		config |= BIT(ETM4_CFG_BIT_RETSTK);
> -
> +	if (config_opts & BIT(ETM_OPT_CTXTID2))
> +		config |= BIT(ETM4_CFG_BIT_VMID) |
> +			  BIT(ETM4_CFG_BIT_VMID_OPT);
>  	return config;
>  }
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo

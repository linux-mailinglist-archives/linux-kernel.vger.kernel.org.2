Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D743B31404D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbhBHUVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbhBHS4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:56:34 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5EAC06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 10:55:49 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q131so10282484pfq.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N4KhQPQ6emhLg5aJ4b7dThJbGJewBnLMix1/QSQMqOA=;
        b=SOzX6/jCm+05D0b/F4L0OfnNCZ+3/22OT8te5W4qnWAMm56snQxMxI+5v1L8wTfflj
         m/SRcAEM+ENa5LQQpWkkNWXHlrz0S9r/gQQ6oJ1cxsyGcYKjt3B/yyHriscmwIh9NOUq
         GXguzHrcce0Tx+lKtDfomwEKWqT9eXpbt3hTKHVOgDZePsB3c6y0vCFlD1kjcXVg5BxS
         QmTyVb2zbtOB0k2kzvPPRUlIuTvHGvXPZLwb/u+crDxKpXUItlB3OQXwZTeahrfMN9zS
         XgrOVBDbGRZ9ep0CgDc7Uzy59ApznxhmJzr0NWK4Dk1d2AmtF5MuA/GmDLaa6diupeX8
         njIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N4KhQPQ6emhLg5aJ4b7dThJbGJewBnLMix1/QSQMqOA=;
        b=fpKaUVqP7LG/JPsAydSzdXtoq+E9cXtr5tobt3aA66itto+tjjgzJjaEMoE07t9E3N
         dmvKona6aKRkNeydmbMxCg2ZLMeRx8cU+NYDcl8p7PCSPqakwcEYcEWU0i6wdxLR0e1B
         sGPQqnTnz5LQ+u997x3kXD2FCRY/il5rUbvsZAkSr0wfGCBzbgdpIcEhCYDN+l0kM0Oh
         laqYpae4/sollNiZEmlHH07zUJFFVGlnZUErlR2x/9lsAbmZIEGum95dPR4LJx6ib+qW
         tKt4PILHo7fCKc7HMJ4i08lkNmuUG2YpyxN1FDkg+YO/iwscOYc322FYcmdBYzZvCjBG
         li3w==
X-Gm-Message-State: AOAM533fvkxnW+R8nBgDudLcJZX9dJppMoHnzQ1QXpXnWFAReLI615+3
        QAgjrTfYsIzsVlZiWVuZyxgkEg==
X-Google-Smtp-Source: ABdhPJzYRj43AK6KfV8pLfoL75pOWCUL2YG1YlxxwOUPuEJhKfWiBXL06aHlIgJtCrEdwAYusTd4fA==
X-Received: by 2002:a63:7cf:: with SMTP id 198mr18333758pgh.448.1612810549041;
        Mon, 08 Feb 2021 10:55:49 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 1sm45336pjk.34.2021.02.08.10.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 10:55:48 -0800 (PST)
Date:   Mon, 8 Feb 2021 11:55:46 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20210208185546.GB2077938@xps15>
References: <20210206150833.42120-1-leo.yan@linaro.org>
 <20210206150833.42120-6-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206150833.42120-6-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 06, 2021 at 11:08:30PM +0800, Leo Yan wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> If the kernel is running at EL2, the pid of a task is exposed via VMID
> instead of the CONTEXTID.  Add support for this in the perf tool.
> 
> This patch respects user setting if user has specified any configs
> from "contextid", "contextid1" or "contextid2"; otherwise, it
> dynamically sets config based on PMU format "contextid".
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Al Grant <al.grant@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Co-developed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

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

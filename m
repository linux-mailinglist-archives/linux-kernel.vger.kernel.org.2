Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034C230CF8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 00:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhBBXBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 18:01:52 -0500
Received: from foss.arm.com ([217.140.110.172]:59564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233513AbhBBXBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 18:01:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8F54ED1;
        Tue,  2 Feb 2021 15:00:59 -0800 (PST)
Received: from [10.57.35.108] (unknown [10.57.35.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 100F03F694;
        Tue,  2 Feb 2021 15:00:55 -0800 (PST)
Subject: Re: [PATCH v2 1/7] coresight: etm-perf: Clarify comment on perf
 options
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
 <20210202163842.134734-2-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <071d1235-c8c4-7b3f-11ce-91c1f907ea8d@arm.com>
Date:   Tue, 2 Feb 2021 23:00:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202163842.134734-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo

On 2/2/21 4:38 PM, Leo Yan wrote:
> In theory, the options should be arbitrary values and are neutral for
> any ETM version; so far perf tool uses ETMv3.5/PTM ETMCR config bits
> except for register's bit definitions, also uses as options.
> 
> This can introduce confusion, especially if we want to add a new option
> but the new option is not supported by ETMv3.5/PTM ETMCR.  But on the
> other hand, we cannot change options since these options are generic
> CoreSight PMU ABI.
> 
> For easier maintenance and avoid confusion, this patch refines the
> comment to clarify perf options, and gives out the background info for
> these bits are coming from ETMv3.5/PTM.  Afterwards, we should take
> these options as general knobs, and if there have any confliction with
> ETMv3.5/PTM, should consider to define saperate macros for ETMv3.5/PTM
> ETMCR config bits.
> 
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

The patch looks good to me.  The only concern I have is, whether
we should split this patch to kernel vs tools ? As the kernel
changes go via coresight tree and the tools patch may go via
perf tree ?

Either way, for the patch:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


> ---
>   .../hwtracing/coresight/coresight-etm-perf.c    |  5 ++++-
>   include/linux/coresight-pmu.h                   | 17 ++++++++++++-----
>   tools/include/linux/coresight-pmu.h             | 17 ++++++++++++-----
>   3 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index bdc34ca449f7..465ef1aa8c82 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -27,7 +27,10 @@ static bool etm_perf_up;
>   static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
>   static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
>   
> -/* ETMv3.5/PTM's ETMCR is 'config' */
> +/*
> + * The PMU formats were orignally for ETMv3.5/PTM's ETMCR 'config';
> + * now take them as general formats and apply on all ETMs.
> + */
>   PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
>   PMU_FORMAT_ATTR(contextid,	"config:" __stringify(ETM_OPT_CTXTID));
>   PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> index b0e35eec6499..5dc47cfdcf07 100644
> --- a/include/linux/coresight-pmu.h
> +++ b/include/linux/coresight-pmu.h
> @@ -10,11 +10,18 @@
>   #define CORESIGHT_ETM_PMU_NAME "cs_etm"
>   #define CORESIGHT_ETM_PMU_SEED  0x10
>   
> -/* ETMv3.5/PTM's ETMCR config bit */
> -#define ETM_OPT_CYCACC  12
> -#define ETM_OPT_CTXTID	14
> -#define ETM_OPT_TS      28
> -#define ETM_OPT_RETSTK	29
> +/*
> + * Below are the definition of bit offsets for perf option, and works as
> + * arbitrary values for all ETM versions.
> + *
> + * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
> + * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
> + * directly use below macros as config bits.
> + */
> +#define ETM_OPT_CYCACC		12
> +#define ETM_OPT_CTXTID		14
> +#define ETM_OPT_TS		28
> +#define ETM_OPT_RETSTK		29
>   
>   /* ETMv4 CONFIGR programming bits for the ETM OPTs */
>   #define ETM4_CFG_BIT_CYCACC	4
> diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> index b0e35eec6499..5dc47cfdcf07 100644
> --- a/tools/include/linux/coresight-pmu.h
> +++ b/tools/include/linux/coresight-pmu.h
> @@ -10,11 +10,18 @@
>   #define CORESIGHT_ETM_PMU_NAME "cs_etm"
>   #define CORESIGHT_ETM_PMU_SEED  0x10
>   
> -/* ETMv3.5/PTM's ETMCR config bit */
> -#define ETM_OPT_CYCACC  12
> -#define ETM_OPT_CTXTID	14
> -#define ETM_OPT_TS      28
> -#define ETM_OPT_RETSTK	29
> +/*
> + * Below are the definition of bit offsets for perf option, and works as
> + * arbitrary values for all ETM versions.
> + *
> + * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
> + * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
> + * directly use below macros as config bits.
> + */
> +#define ETM_OPT_CYCACC		12
> +#define ETM_OPT_CTXTID		14
> +#define ETM_OPT_TS		28
> +#define ETM_OPT_RETSTK		29
>   
>   /* ETMv4 CONFIGR programming bits for the ETM OPTs */
>   #define ETM4_CFG_BIT_CYCACC	4
> 


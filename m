Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DBE3DB420
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbhG3G5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:57:50 -0400
Received: from foss.arm.com ([217.140.110.172]:38180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238009AbhG3G5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:57:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5DA631B;
        Thu, 29 Jul 2021 23:57:29 -0700 (PDT)
Received: from [10.163.66.9] (unknown [10.163.66.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 032513F66F;
        Thu, 29 Jul 2021 23:57:26 -0700 (PDT)
Subject: Re: [PATCH v2 10/10] coresight: trbe: Prohibit trace before disabling
 TRBE
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        jinlmao@qti.qualcomm.com
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
 <20210723124611.3828908-11-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <bca52780-a66e-5dda-eb4f-0f2f3f9ad78c@arm.com>
Date:   Fri, 30 Jul 2021 12:28:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210723124611.3828908-11-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/21 6:16 PM, Suzuki K Poulose wrote:
> We must prohibit the CPU from tracing before we disable
> the TRBE and only re-enable it when we are sure the TRBE
> has been enabled back. Otherwise, leave the CPU in
> prohibited state.
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../hwtracing/coresight/coresight-self-hosted-trace.h    | 4 +++-
>  drivers/hwtracing/coresight/coresight-trbe.c             | 9 +++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-self-hosted-trace.h b/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
> index 586d26e0cba3..34372482a3cd 100644
> --- a/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
> +++ b/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
> @@ -22,11 +22,13 @@ static inline void write_trfcr(u64 val)
>  	isb();
>  }
>  
> -static inline void cpu_prohibit_trace(void)
> +static inline u64 cpu_prohibit_trace(void)
>  {
>  	u64 trfcr = read_trfcr();
>  
>  	/* Prohibit tracing at EL0 & the kernel EL */
>  	write_trfcr(trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE));
> +	/* Return the original value of the TRFCR */
> +	return trfcr;
>  }
>  #endif			/*  __CORESIGHT_SELF_HOSTED_TRACE_H */
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index e7567727e8fc..b8586c170889 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -16,6 +16,7 @@
>  #define pr_fmt(fmt) DRVNAME ": " fmt
>  
>  #include <asm/barrier.h>
> +#include "coresight-self-hosted-trace.h"
>  #include "coresight-trbe.h"
>  
>  #define PERF_IDX2OFF(idx, buf) ((idx) % ((buf)->nr_pages << PAGE_SHIFT))
> @@ -764,6 +765,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>  	enum trbe_fault_action act;
>  	u64 status;
>  	bool truncated = false;
> +	u64 trfcr;
>  
>  	/* Reads to TRBSR_EL1 is fine when TRBE is active */
>  	status = read_sysreg_s(SYS_TRBSR_EL1);
> @@ -774,6 +776,8 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>  	if (!is_trbe_irq(status))
>  		return IRQ_NONE;
>  
> +	/* Prohibit the CPU from tracing before we disable the TRBE */
> +	trfcr = cpu_prohibit_trace();
>  	/*
>  	 * Ensure the trace is visible to the CPUs and
>  	 * any external aborts have been resolved.
> @@ -805,9 +809,14 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>  	/*
>  	 * If the buffer was truncated, ensure perf callbacks
>  	 * have completed, which will disable the event.
> +	 *
> +	 * Otherwise, restore the trace filter controls to
> +	 * allow the tracing.
>  	 */
>  	if (truncated)
>  		irq_work_run();
> +	else
> +		write_trfcr(trfcr);
>  
>  	return IRQ_HANDLED;
>  }
> 

The change LGTM. But the commit message needs to add some more details
like that in V2 which explained how traces from ETE could be routed to
ATB if not put in trace prohibited state, for all exception levels etc.

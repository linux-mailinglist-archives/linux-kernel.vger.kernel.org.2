Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0E3C5AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhGLKnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:43:19 -0400
Received: from foss.arm.com ([217.140.110.172]:53290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233738AbhGLKnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:43:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38BB81FB;
        Mon, 12 Jul 2021 03:40:18 -0700 (PDT)
Received: from [10.57.35.32] (unknown [10.57.35.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3102F3F694;
        Mon, 12 Jul 2021 03:40:15 -0700 (PDT)
Subject: Re: [PATCH v4 02/11] coresight: tmc-etr: Add barrier after updating
 AUX ring buffer
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-3-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f9734d69-b1f5-825c-f152-705626f4b256@arm.com>
Date:   Mon, 12 Jul 2021 11:40:12 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711104105.505728-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2021 11:40, Leo Yan wrote:
> Since a memory barrier is required between AUX trace data store and
> aux_head store, and the AUX trace data is filled with memcpy(), it's
> sufficient to use smp_wmb() so can ensure the trace data is visible
> prior to updating aux_head.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index acdb59e0e661..713205db15a1 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1563,6 +1563,14 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>   	 */
>   	if (etr_perf->snapshot)
>   		handle->head += size;
> +
> +	/*
> +	 * It requires the ordering between the AUX trace data and aux_head
> +	 * store, below smp_wmb() ensures the AUX trace data is visible prior
> +	 * to updating aux_head.
> +	 */

Please could we reword this a bit, something like :

	/*
	 * Ensure that the AUX trace data is visible before the aux_head
	 * is updated via perf_aux_output_end(), as expected by the
	 * perf ring buffer.
	 */
> +	smp_wmb();
> +

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

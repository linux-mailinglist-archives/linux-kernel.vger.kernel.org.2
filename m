Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529B741431C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 09:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhIVIAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:00:10 -0400
Received: from foss.arm.com ([217.140.110.172]:44558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233394AbhIVIAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:00:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6D7811B3;
        Wed, 22 Sep 2021 00:58:38 -0700 (PDT)
Received: from [10.163.73.113] (unknown [10.163.73.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD4D33F719;
        Wed, 22 Sep 2021 00:58:34 -0700 (PDT)
Subject: Re: [PATCH v2 12/17] coresight: trbe: Add a helper to fetch cpudata
 from perf handle
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        leo.yan@linaro.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-13-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <eacda231-eb0b-fb33-bc95-1b37d116e3b2@arm.com>
Date:   Wed, 22 Sep 2021 13:29:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210921134121.2423546-13-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/21 7:11 PM, Suzuki K Poulose wrote:
> Add a helper to get the CPU specific data for TRBE instance, from
> a given perf handle. This also adds extra checks to make sure that
> the event associated with the handle is "bound" to the CPU and is
> active on the TRBE.
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 983dd5039e52..797d978f9fa7 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -268,6 +268,15 @@ static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
>  	return buf->nr_pages * PAGE_SIZE;
>  }
>  
> +static inline struct trbe_cpudata *
> +trbe_handle_to_cpudata(struct perf_output_handle *handle)

This is actually a perf handle not a TRBE handle. Hence
should be renamed as 'perf_handle_to_cpudata' instead.

> +{
> +	struct trbe_buf *buf = etm_perf_sink_config(handle);
> +
> +	BUG_ON(!buf || !buf->cpudata);
> +	return buf->cpudata;
> +}
> +
>  /*
>   * TRBE Limit Calculation
>   *
> @@ -533,8 +542,7 @@ static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *hand
>  {
>  	int ec = get_trbe_ec(trbsr);
>  	int bsc = get_trbe_bsc(trbsr);
> -	struct trbe_buf *buf = etm_perf_sink_config(handle);
> -	struct trbe_cpudata *cpudata = buf->cpudata;
> +	struct trbe_cpudata *cpudata = trbe_handle_to_cpudata(handle);
>  
>  	WARN_ON(is_trbe_running(trbsr));
>  	if (is_trbe_trg(trbsr) || is_trbe_abort(trbsr))
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB953DB25E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 06:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhG3EZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 00:25:53 -0400
Received: from foss.arm.com ([217.140.110.172]:36144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhG3EZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 00:25:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3451631B;
        Thu, 29 Jul 2021 21:25:48 -0700 (PDT)
Received: from [10.163.66.9] (unknown [10.163.66.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 879E43F73D;
        Thu, 29 Jul 2021 21:25:45 -0700 (PDT)
Subject: Re: [PATCH v2 04/10] coresight: trbe: Ensure the format flag is set
 on truncation
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        jinlmao@qti.qualcomm.com
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
 <20210723124611.3828908-5-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c7c09fa6-8010-ab7c-1c32-8598e519ac97@arm.com>
Date:   Fri, 30 Jul 2021 09:56:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210723124611.3828908-5-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/21 6:16 PM, Suzuki K Poulose wrote:
> When the TRBE is stopped on truncating an event, we may not
> set the FORMAT flag, even though the size of the record is 0.
> Let us be consistent and not confuse the user. Always set the
> format flag for TRBE generated records.
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 176868496879..446f080f8320 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -132,7 +132,8 @@ static void trbe_stop_and_truncate_event(struct perf_output_handle *handle)
>  	 * the update_buffer() to return a 0 size.
>  	 */
>  	trbe_drain_and_disable_local();
> -	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> +	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED |
> +				     PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
>  	*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
>  }

But why should not PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW also be set on
zero sized records as well ? Otherwise there are two instances during
TRBE buffer management, where PERF_AUX_FLAG_TRUNCATED is marked alone
without PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW. Those could be changed as
well.

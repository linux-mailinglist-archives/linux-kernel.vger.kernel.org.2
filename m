Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1A452E52
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhKPJtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:49:21 -0500
Received: from foss.arm.com ([217.140.110.172]:42726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231770AbhKPJtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:49:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A34D61FB;
        Tue, 16 Nov 2021 01:46:23 -0800 (PST)
Received: from [10.57.76.160] (unknown [10.57.76.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 637873F766;
        Tue, 16 Nov 2021 01:46:22 -0800 (PST)
Message-ID: <07dbd4ac-5847-96cf-eb3c-d24561bb052c@arm.com>
Date:   Tue, 16 Nov 2021 09:46:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v1 3/4] coresight: etm4x: Don't trace contextID for
 non-root namespace in perf mode
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211031144214.237879-1-leo.yan@linaro.org>
 <20211031144214.237879-4-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20211031144214.237879-4-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 31/10/2021 14:42, Leo Yan wrote:
> When runs in perf mode, the driver always enables the contextID tracing.
> This can lead to confusion if the program runs in non-root PID namespace
> and potentially leak kernel information.
> 
> When programs running in perf mode, this patch changes to only enable
> contextID tracing for root PID namespace.
> 

The only concern with the patch here is we silently ignore the CTXTID
flag and the perf assumes the CTXTID is traced, when traced from a 
non-root namespace. Does the decoder handle this case gracefully ? We are
fine if that is the case.

Either way, we don't want to enforce the policy in the perf tool, if we
can transparently handle the missing CTXTID and allow the trace session
and decode complete. That said, your approach is the safe bet here.


> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index e24252eaf8e4..6e614bfb38c6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -615,7 +615,9 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   		config->cfg |= BIT(11);
>   	}
>   
> -	if (attr->config & BIT(ETM_OPT_CTXTID))
> +	/* Only trace contextID when runs in root PID namespace */
> +	if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
> +	    (task_active_pid_ns(current) == &init_pid_ns))
>   		/* bit[6], Context ID tracing bit */
>   		config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
>   

As mentioned in the previous comment, please add a helper here, than 
open coding the check.

Kind regards
Suzuki

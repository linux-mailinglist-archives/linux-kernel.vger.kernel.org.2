Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2363134BD0E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 17:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhC1PtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 11:49:23 -0400
Received: from foss.arm.com ([217.140.110.172]:59904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhC1PtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 11:49:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34CD61474;
        Sun, 28 Mar 2021 08:49:05 -0700 (PDT)
Received: from [10.57.22.222] (unknown [10.57.22.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1364C3F694;
        Sun, 28 Mar 2021 08:49:03 -0700 (PDT)
Subject: Re: [PATCH v2] coresight: core: Fix typo in coresight-core.c
To:     Qi Liu <liuqi115@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@openeuler.org
References: <1616487086-50418-1-git-send-email-liuqi115@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <de6934c4-f5b9-cc2b-2f50-3382255d778f@arm.com>
Date:   Sun, 28 Mar 2021 16:49:02 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616487086-50418-1-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 08:11, Qi Liu wrote:
> Fix the following checkpatch warning:
> WARNING: 'compoment' may be misspelled - perhaps 'component'?
> 
> Fixes: 8e264c52e1da  ("coresight: core: Allow the coresight core driver to be built as a module")
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 0062c89..b57bea1 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -86,7 +86,7 @@ static int coresight_id_match(struct device *dev, void *data)
>   	    i_csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
>   		return 0;
>   
> -	/* Get the source ID for both compoment */
> +	/* Get the source ID for both components */
>   	trace_id = source_ops(csdev)->trace_id(csdev);
>   	i_trace_id = source_ops(i_csdev)->trace_id(i_csdev);

Applied.

Thanks
Suzuki


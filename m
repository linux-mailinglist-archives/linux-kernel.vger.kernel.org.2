Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656F337C65C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbhELPuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:50:52 -0400
Received: from foss.arm.com ([217.140.110.172]:42120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234385AbhELPZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:25:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D06931B;
        Wed, 12 May 2021 08:23:51 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 051603F718;
        Wed, 12 May 2021 08:23:49 -0700 (PDT)
Subject: Re: [PATCH -next] drm/panfrost: Fix PM reference leak in
 panfrost_job_hw_submit()
To:     Zou Wei <zou_wei@huawei.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, airlied@linux.ie, daniel@ffwll.ch,
        alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1620714551-106976-1-git-send-email-zou_wei@huawei.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <7ebf35ef-58c3-7bc7-f0e9-ad487bae6686@arm.com>
Date:   Wed, 12 May 2021 16:23:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1620714551-106976-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2021 07:29, Zou Wei wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Thanks for the patch, but this is actually incorrect. 
panfrost_job_hw_submit() is expected to unconditionally increment the pm 
usage counter. This is because panfrost_job_hw_submit() can (currently) 
never fail, so in this case the job is considered "submitted" (even 
though it never reaches the hardware) and it's handled by the job timeout.

However this is at least the second time[1] this phantom "reference 
leak" has been raised, so perhaps it's time to handle this better. I'll 
post a patch reworking panfrost_job_hw_submit() so it can fail.

Thanks,

Steve

[1] 
https://lore.kernel.org/r/20200520110504.24388-1-dinghao.liu%40zju.edu.cn

> ---
>   drivers/gpu/drm/panfrost/panfrost_job.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 6003cfe..42d8dbc 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -157,7 +157,7 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>   
>   	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
>   
> -	ret = pm_runtime_get_sync(pfdev->dev);
> +	ret = pm_runtime_resume_and_get(pfdev->dev);
>   	if (ret < 0)
>   		return;
>   
> 


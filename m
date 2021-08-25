Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4183F7171
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbhHYJHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:07:04 -0400
Received: from foss.arm.com ([217.140.110.172]:46312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239546AbhHYJGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:06:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 474A031B;
        Wed, 25 Aug 2021 02:06:08 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 359D13F66F;
        Wed, 25 Aug 2021 02:06:07 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Use upper/lower_32_bits helpers
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20210824172614.7299-1-alyssa.rosenzweig@collabora.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <38b0aa7e-6657-2ca3-ccc9-3bfa9ae8fab8@arm.com>
Date:   Wed, 25 Aug 2021 10:06:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824172614.7299-1-alyssa.rosenzweig@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2021 18:26, Alyssa Rosenzweig wrote:
> Use upper_32_bits/lower_32_bits helpers instead of open-coding them.
> This is easier to scan quickly compared to bitwise manipulation, and it
> is pleasingly symmetric. I noticed this when debugging lock_region,
> which had a particularly "creative" way of writing upper_32_bits.
> 
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

It looks like there's another case (slightly different format) in
perfcnt:

---8<---
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index 5ab03d605f57..e116a4d9b8e5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -51,8 +51,8 @@ static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
 
        reinit_completion(&pfdev->perfcnt->dump_comp);
        gpuva = pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
-       gpu_write(pfdev, GPU_PERFCNT_BASE_LO, gpuva);
-       gpu_write(pfdev, GPU_PERFCNT_BASE_HI, gpuva >> 32);
+       gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
+       gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
        gpu_write(pfdev, GPU_INT_CLEAR,
                  GPU_IRQ_CLEAN_CACHES_COMPLETED |
                  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
---8<--


With that squashed in:

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,

Steve

> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c |  8 ++++----
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 12 ++++++------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 71a72fb50e6b..763b7abfc88e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -137,8 +137,8 @@ static void panfrost_job_write_affinity(struct panfrost_device *pfdev,
>  	 */
>  	affinity = pfdev->features.shader_present;
>  
> -	job_write(pfdev, JS_AFFINITY_NEXT_LO(js), affinity & 0xFFFFFFFF);
> -	job_write(pfdev, JS_AFFINITY_NEXT_HI(js), affinity >> 32);
> +	job_write(pfdev, JS_AFFINITY_NEXT_LO(js), lower_32_bits(affinity));
> +	job_write(pfdev, JS_AFFINITY_NEXT_HI(js), upper_32_bits(affinity));
>  }
>  
>  static u32
> @@ -203,8 +203,8 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  
>  	cfg = panfrost_mmu_as_get(pfdev, job->file_priv->mmu);
>  
> -	job_write(pfdev, JS_HEAD_NEXT_LO(js), jc_head & 0xFFFFFFFF);
> -	job_write(pfdev, JS_HEAD_NEXT_HI(js), jc_head >> 32);
> +	job_write(pfdev, JS_HEAD_NEXT_LO(js), lower_32_bits(jc_head));
> +	job_write(pfdev, JS_HEAD_NEXT_HI(js), upper_32_bits(jc_head));
>  
>  	panfrost_job_write_affinity(pfdev, job->requirements, js);
>  
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 0da5b3100ab1..c3fbe0ad9090 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -80,8 +80,8 @@ static void lock_region(struct panfrost_device *pfdev, u32 as_nr,
>  	region |= region_width;
>  
>  	/* Lock the region that needs to be updated */
> -	mmu_write(pfdev, AS_LOCKADDR_LO(as_nr), region & 0xFFFFFFFFUL);
> -	mmu_write(pfdev, AS_LOCKADDR_HI(as_nr), (region >> 32) & 0xFFFFFFFFUL);
> +	mmu_write(pfdev, AS_LOCKADDR_LO(as_nr), lower_32_bits(region));
> +	mmu_write(pfdev, AS_LOCKADDR_HI(as_nr), upper_32_bits(region));
>  	write_cmd(pfdev, as_nr, AS_COMMAND_LOCK);
>  }
>  
> @@ -123,14 +123,14 @@ static void panfrost_mmu_enable(struct panfrost_device *pfdev, struct panfrost_m
>  
>  	mmu_hw_do_operation_locked(pfdev, as_nr, 0, ~0UL, AS_COMMAND_FLUSH_MEM);
>  
> -	mmu_write(pfdev, AS_TRANSTAB_LO(as_nr), transtab & 0xffffffffUL);
> -	mmu_write(pfdev, AS_TRANSTAB_HI(as_nr), transtab >> 32);
> +	mmu_write(pfdev, AS_TRANSTAB_LO(as_nr), lower_32_bits(transtab));
> +	mmu_write(pfdev, AS_TRANSTAB_HI(as_nr), upper_32_bits(transtab));
>  
>  	/* Need to revisit mem attrs.
>  	 * NC is the default, Mali driver is inner WT.
>  	 */
> -	mmu_write(pfdev, AS_MEMATTR_LO(as_nr), memattr & 0xffffffffUL);
> -	mmu_write(pfdev, AS_MEMATTR_HI(as_nr), memattr >> 32);
> +	mmu_write(pfdev, AS_MEMATTR_LO(as_nr), lower_32_bits(memattr));
> +	mmu_write(pfdev, AS_MEMATTR_HI(as_nr), upper_32_bits(memattr));
>  
>  	write_cmd(pfdev, as_nr, AS_COMMAND_UPDATE);
>  }
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0843ACB41
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhFRMpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:45:38 -0400
Received: from foss.arm.com ([217.140.110.172]:40142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhFRMph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:45:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB27F1424;
        Fri, 18 Jun 2021 05:43:27 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 436BD3F719;
        Fri, 18 Jun 2021 05:43:26 -0700 (PDT)
Subject: Re: [PATCH v2] drm/panfrost:report the full raw fault information
 instead
To:     ChunyouTang <tangchunyou@163.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     ChunyouTang <tangchunyou@icubecorp.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20210617062054.1864-1-tangchunyou@163.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <2dcbb36a-b550-4c9d-cff8-73ca4b5abb11@arm.com>
Date:   Fri, 18 Jun 2021 13:43:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617062054.1864-1-tangchunyou@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2021 07:20, ChunyouTang wrote:
> From: ChunyouTang <tangchunyou@icubecorp.cn>
> 
> of the low 8 bits.

Please don't split the subject like this. The first line of the commit
should be a (very short) summary of the patch. Then a blank line and
then a longer description of what the purpose of the patch is and why
it's needed.

Also you previously had this as part of a series (the first part adding
the "& 0xFF" in the panfrost_exception_name() call). I'm not sure we
need two patches for the single line, but as it stands this patch
doesn't apply.

Also I'm still not receiving any emails from you directly (only via the
list), so it's possible I might have missed something you sent.

Steve

> 
> Signed-off-by: ChunyouTang <tangchunyou@icubecorp.cn>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index 1fffb6a0b24f..d2d287bbf4e7 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -33,7 +33,7 @@ static irqreturn_t panfrost_gpu_irq_handler(int irq, void *data)
>  		address |= gpu_read(pfdev, GPU_FAULT_ADDRESS_LO);
>  
>  		dev_warn(pfdev->dev, "GPU Fault 0x%08x (%s) at 0x%016llx\n",
> -			 fault_status & 0xFF, panfrost_exception_name(pfdev, fault_status & 0xFF),
> +			 fault_status, panfrost_exception_name(pfdev, fault_status & 0xFF),
>  			 address);
>  
>  		if (state & GPU_IRQ_MULTIPLE_FAULT)
> 


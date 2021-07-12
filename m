Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA2D3C5A80
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbhGLKFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:05:54 -0400
Received: from foss.arm.com ([217.140.110.172]:52536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233683AbhGLKFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:05:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 919D21FB;
        Mon, 12 Jul 2021 03:02:47 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 765B13F694;
        Mon, 12 Jul 2021 03:02:46 -0700 (PDT)
Subject: Re: [PATCH v3] drm/panfrost:fix the exception name always "UNKNOWN"
To:     ChunyouTang <tangchunyou@163.com>
Cc:     tomeu.vizoso@collabora.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alyssa.rosenzweig@collabora.com,
        ChunyouTang <tangchunyou@icubecorp.cn>
References: <20210708073407.2015-1-tangchunyou@163.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <814ae174-a247-bcd8-b2d6-847982a9fc6b@arm.com>
Date:   Mon, 12 Jul 2021 11:02:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708073407.2015-1-tangchunyou@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2021 08:34, ChunyouTang wrote:
> From: ChunyouTang <tangchunyou@icubecorp.cn>
> 
> The exception_code in register is only 8 bits,So if
> fault_status in panfrost_gpu_irq_handler() don't
> (& 0xFF),it can't get correct exception reason.
> 
> and it's better to show all of the register value
> to custom,so it's better fault_status don't (& 0xFF).
> 
> Signed-off-by: ChunyouTang <tangchunyou@icubecorp.cn>

Reviewed-by: Steven Price <steven.price@arm.com>

Boris's change has actually modified panfrost_exception_name() to no
longer take pfdev in drm-misc-next. However, I'll just fix this up when
I apply it.

Thanks,

Steve

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


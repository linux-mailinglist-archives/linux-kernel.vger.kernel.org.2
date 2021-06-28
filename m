Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5113B5BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhF1J4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:56:55 -0400
Received: from foss.arm.com ([217.140.110.172]:55342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232512AbhF1J4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:56:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AEA41FB;
        Mon, 28 Jun 2021 02:54:28 -0700 (PDT)
Received: from [10.57.8.89] (unknown [10.57.8.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 862B33F694;
        Mon, 28 Jun 2021 02:54:27 -0700 (PDT)
Subject: Re: [PATCH] drm/rockchip: Check iommu itself instead of it's parent
 for device_is_available
To:     Andy Yan <andy.yan@rock-chips.com>, hjc@rock-chips.com,
        heiko@sntech.de, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210627084737.309163-1-andy.yan@rock-chips.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <66fb4977-4e6f-f7ed-0dac-18710ebd782a@arm.com>
Date:   Mon, 28 Jun 2021 10:54:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210627084737.309163-1-andy.yan@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-27 09:47, Andy Yan wrote:
> When iommu itself is disabled in dts, we should
> fallback to non-iommu buffer, check iommu parent
> is meanless here.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 212bd87c0c4a..0d20c8cc1ffa 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -366,7 +366,7 @@ static int rockchip_drm_platform_of_probe(struct device *dev)
>   		}
>   
>   		iommu = of_parse_phandle(port->parent, "iommus", 0);
> -		if (!iommu || !of_device_is_available(iommu->parent)) {
> +		if (!iommu || !of_device_is_available(iommu)) {

Just wondering, could you use device_iommu_mapped() to avoid poking at 
the DT at all here, or is it that you need to check remote graph 
endpoints whose struct device may not be ready yet?

Robin.

>   			DRM_DEV_DEBUG(dev,
>   				      "no iommu attached for %pOF, using non-iommu buffers\n",
>   				      port->parent);
> 

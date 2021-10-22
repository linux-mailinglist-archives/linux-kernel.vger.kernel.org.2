Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177494378A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 16:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhJVOFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 10:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhJVOFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:05:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD307C061764;
        Fri, 22 Oct 2021 07:03:23 -0700 (PDT)
Received: from [IPv6:2a02:810a:880:f54:50fa:5c7d:20f4:e8d3] (unknown [IPv6:2a02:810a:880:f54:50fa:5c7d:20f4:e8d3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3DBD31F454AB;
        Fri, 22 Oct 2021 15:03:21 +0100 (BST)
Subject: Re: [PATCH v3 13/33] iommu/mediatek: Remove the power status checking
 in tlb flush all
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, chao.hao@mediatek.com,
        yen-chang.chen@mediatek.com,
        Collabora Kernel ML <kernel@collabora.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-14-yong.wu@mediatek.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <6cff0b97-b861-e02d-e76f-2510c962c452@collabora.com>
Date:   Fri, 22 Oct 2021 16:03:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-14-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


On 23.09.21 13:58, Yong Wu wrote:
> To simplify the code, Remove the power status checking in the
> tlb_flush_all, remove this:
>     if (pm_runtime_get_if_in_use(data->dev) <= 0)
> 	    continue;
> 
> After this patch, the mtk_iommu_tlb_flush_all will be called from
> a) isr
> b) pm runtime resume callback
> c) tlb flush range fail case
> d) iommu_create_device_direct_mappings
>     -> iommu_flush_iotlb_all
> In first three cases, the power and clock always are enabled; d) is direct

Regarding case "c) tlb flush range fail case", I found out that this often happens
when the iommu is used while it is runtime suspended. For example the mtk-vcodec
encoder driver calls "pm_runtime_resume_and_get" only when it starts streaming but
buffers allocation is done in 'v4l2_reqbufs' before "pm_runtime_resume_and_get" is called
and then I see the warning "Partial TLB flush timed out, falling back to full flush"
I am not sure how to fix that issue, but it seems that case 'c)' might indicate that
power and clock are actually not enabled.

> mapping, the tlb flush is unnecessay since we already have tlb_flush_all
> in the pm_runtime_resume callback. When the iommu's power status is
> changed to active, the tlb always is clean.
> 
> In addition, there still are 2 reasons that don't add PM status checking
> in the tlb flush all:
> a) Write tlb flush all register also is ok even though the HW has no
> power and clocks. Write ignore.
> b) pm_runtime_get_if_in_use(m4udev) is 0 when the tlb_flush_all
> is called frm pm_runtime_resume cb. From this point, we can not add
> this code above in this tlb_flush_all.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index e9e94944ed91..4a33b6c6b1db 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -204,10 +204,14 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
>   	return container_of(dom, struct mtk_iommu_domain, domain);
>   }
>   
> -static void mtk_iommu_tlb_do_flush_all(struct mtk_iommu_data *data)
> +static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
>   {
>   	unsigned long flags;
>   
> +	/*
> +	 * No need get power status since the HW PM status nearly is active
> +	 * when entering here.
> +	 */
>   	spin_lock_irqsave(&data->tlb_lock, flags);
>   	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>   		       data->base + data->plat_data->inv_sel_reg);
> @@ -216,16 +220,6 @@ static void mtk_iommu_tlb_do_flush_all(struct mtk_iommu_data *data)
>   	spin_unlock_irqrestore(&data->tlb_lock, flags);
>   }
>   
> -static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
> -{
> -	if (pm_runtime_get_if_in_use(data->dev) <= 0)
> -		return;
> -
> -	mtk_iommu_tlb_do_flush_all(data);
> -
> -	pm_runtime_put(data->dev);
> -}
> -
>   static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>   					   struct mtk_iommu_data *data)
>   {
> @@ -263,7 +257,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>   		if (ret) {
>   			dev_warn(data->dev,
>   				 "Partial TLB flush timed out, falling back to full flush\n");
> -			mtk_iommu_tlb_do_flush_all(data);
> +			mtk_iommu_tlb_flush_all(data);
>   		}
>   
>   		if (has_pm)
> @@ -993,7 +987,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
>   	 *
>   	 * Thus, Make sure the tlb always is clean after each PM resume.
>   	 */
> -	mtk_iommu_tlb_do_flush_all(data);
> +	mtk_iommu_tlb_flush_all(data);
>   
>   	/*
>   	 * Uppon first resume, only enable the clk and return, since the values of the
> 

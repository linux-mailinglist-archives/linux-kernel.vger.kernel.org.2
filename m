Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FF141D8BB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 13:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350460AbhI3L1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 07:27:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60440 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350488AbhI3L1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 07:27:54 -0400
Received: from [IPv6:2a02:810a:880:f54:fd5c:7cb1:aaa8:78b1] (unknown [IPv6:2a02:810a:880:f54:fd5c:7cb1:aaa8:78b1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E54671F44AE1;
        Thu, 30 Sep 2021 12:26:09 +0100 (BST)
Subject: Re: [PATCH v2 11/29] iommu/mediatek: Always pm_runtime_get while tlb
 flush
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
References: <20210813065324.29220-1-yong.wu@mediatek.com>
 <20210813065324.29220-12-yong.wu@mediatek.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <11fe281d-4873-245b-f506-452900f33d3b@collabora.com>
Date:   Thu, 30 Sep 2021 13:26:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813065324.29220-12-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.08.21 08:53, Yong Wu wrote:
> Prepare for 2 HWs that sharing pgtable in different power-domains.
> 
> The previous SoC don't have PM. Only mt8192 has power-domain,
> and it is display's power-domain which nearly always is enabled.

hi, I see that in mt1873.dtsi, many devices that uses the iommu have the
'power-domains' property.

> 
> When there are 2 M4U HWs, it may has problem.
> In this function, we get the pm_status via the m4u dev, but it don't
> reflect the real power-domain status of the HW since there may be other
> HW also use that power-domain.
> 
> Currently we could not get the real power-domain status, thus always
> pm_runtime_get here.
> 
> Prepare for mt8195, thus, no need fix tags here.
> 
> This patch may drop the performance, we expect the user could
> pm_runtime_get_sync before dma_alloc_attrs which need tlb ops.
> 

Could you explain this sentence a bit? should the user call pm_runtime_get_sync
before calling dma_alloc_attrs?

Thanks,
Dafna

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index add23a36a5e2..abc721a1da21 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -238,8 +238,11 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>   
>   	for_each_m4u(data, head) {
>   		if (has_pm) {
> -			if (pm_runtime_get_if_in_use(data->dev) <= 0)
> +			ret = pm_runtime_resume_and_get(data->dev);
> +			if (ret < 0) {
> +				dev_err(data->dev, "tlb flush: pm get fail %d.\n", ret);
>   				continue;
> +			}
>   		}
>   
>   		spin_lock_irqsave(&data->tlb_lock, flags);
> 

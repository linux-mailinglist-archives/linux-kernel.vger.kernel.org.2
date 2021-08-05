Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1484D3E0F04
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbhHEHTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:19:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:20252 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbhHEHTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:19:09 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210805071853euoutp01644937b31118073d619b59c82f14110d~YV_tELRCx2569925699euoutp01b
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 07:18:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210805071853euoutp01644937b31118073d619b59c82f14110d~YV_tELRCx2569925699euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628147933;
        bh=/7/dB7i3HbiH5ZOX3GUioiB5FGehO2PLdS0nLTB5L4Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=B7O3aB40HAN7k9T5APOpfuTwesw2DPH0CCJ3JY+O7IEZk+iZNw3ONodlF848kbsyT
         wPKsh+5DWd3eRvLcpYvxEDi3JZvWnyDpkagrNFZujal7xQ/zeY/ObHU2VARACE5FgN
         /QvsKoS1vTac7DuG1bOimn3y1KDTHupnKR6nAxsY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210805071852eucas1p285687f988e51d39dadf43dd07cbae24a~YV_soh8PL2475224752eucas1p2O;
        Thu,  5 Aug 2021 07:18:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A2.CB.42068.CD09B016; Thu,  5
        Aug 2021 08:18:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210805071852eucas1p248ba2fc11f29b05d4cb4ed154c0915a4~YV_sDg9xs2479024790eucas1p2B;
        Thu,  5 Aug 2021 07:18:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210805071852eusmtrp187e5b91d8d2f4a9c9d9dccb63beefb77~YV_sBeGIw2998329983eusmtrp1k;
        Thu,  5 Aug 2021 07:18:52 +0000 (GMT)
X-AuditID: cbfec7f4-c71ff7000002a454-f1-610b90dc6fdc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EB.1D.20981.CD09B016; Thu,  5
        Aug 2021 08:18:52 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210805071851eusmtip27cdf6abb678f285692fa22219002662a~YV_q_BtTi2022320223eusmtip2L;
        Thu,  5 Aug 2021 07:18:50 +0000 (GMT)
Subject: Re: [PATCH v3 01/25] iommu: Pull IOVA cookie management into the
 core
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yong Wu <yong.wu@mediatek.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <6bfafe1c-fc8f-8836-fb80-c6a61788ddc8@samsung.com>
Date:   Thu, 5 Aug 2021 09:18:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <46f4cda8215bd5f8a9f9fd5a4a6451805f75efa3.1628094600.git.robin.murphy@arm.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZduzned07E7gTDa7e17HYPHErm8X1a1cY
        LR62H2SyOLvsIJvF3NmTGC3+P3rNarFgv7VFw+oLrBab9jexWnTO3sBusenxNVaLy7vmsFm0
        dS5jtVixagajxcEPT1gtJv5YwGjRcsfU4v6kzSwWX/d+ZnMQ9nhycB6TR+ulv2wea+atYfSY
        3XCRxWPiWV2PBZtKPR7P3cju0XLkLavHplWdbB53ru1h85h3MtBj85J6j8k3ljN6tJzcz+Lx
        7cxEFo/t1+YxBwhFcdmkpOZklqUW6dslcGXsWLaSpeCnWMXFCSuYGxhvCXUxcnJICJhIHOrs
        Yuti5OIQEljBKHF4SjMjhPOFUeLJ2kdQzmdGief9l1hgWq7u6GWHSCxnlGjunMgE4XxklPj3
        7A8rSJWwQIDEx32dYB0iAp4SZ3t3sIIUMQtsYpHYcPwXE0iCTcBQoustyHZODl4BO4nz83aA
        NbAIqEic+LYZzBYVSJa4c/o9VI2gxMmZT8DinALREnPuz2EEsZkF5CW2v53DDGGLS9x6Mh/s
        IgmBX5wS3162QN3tIrH6/UI2CFtY4tXxLewQtozE6ck9LBANzYwSD8+tZYdwehglLjfNYISo
        spa4c+4XUDcH0ApNifW79CHCjhI9y1vBwhICfBI33gpCHMEnMWnbdGaIMK9ERxs0tNUkZh1f
        B7f24IVLzBMYlWYheW0WkndmIXlnFsLeBYwsqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3
        MQKT7Ol/x7/sYFz+6qPeIUYmDsZDjBIczEoivMmLuRKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        8yZtWRMvJJCeWJKanZpakFoEk2Xi4JRqYErZlG9id0vbm3deYPJrWaMVT/bxWRnIXv4q8aMt
        flZeUlDHK4azEcZRO7/3hvi+eHkwnL2BY1/6RfH95XK3ll7QTZ1x8P7XO1rapunf19XNMox0
        YxJ31Z6rGNlxpHJ5HK/z6Z38D3qCzpWvX/Lh2sWeh/ZOhRlq0z/5rzPwPtR9SvDgm52zbzP1
        sm1aWfCzSmm9ToCzx1kXxdNG/jeny1m2LP4qWR0+/dOrqcsCt3Vk2D4vPh+vvJ5308rFGb+W
        SXVqb56iwLz0rQPfD8Gq64duqIfU5j1wFaiwrb3a31ql5rh+fVRo5/SZMblfutx+9FqcFTBc
        1Pl/0xferPt/rslsyl+49V+awA5B3dJ9gkosxRmJhlrMRcWJAPesTdMhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xe7p3JnAnGkzaxWyxeeJWNovr164w
        WjxsP8hkcXbZQTaLubMnMVr8f/Sa1WLBfmuLhtUXWC027W9iteicvYHdYtPja6wWl3fNYbNo
        61zGarFi1QxGi4MfnrBaTPyxgNGi5Y6pxf1Jm1ksvu79zOYg7PHk4Dwmj9ZLf9k81sxbw+gx
        u+Eii8fEs7oeCzaVejyeu5Hdo+XIW1aPTas62TzuXNvD5jHvZKDH5iX1HpNvLGf0aDm5n8Xj
        25mJLB7br81jDhCK0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3J
        LEst0rdL0MvYsWwlS8FPsYqLE1YwNzDeEupi5OSQEDCRuLqjl72LkYtDSGApo8S0s+9ZIRIy
        EienNUDZwhJ/rnWxQRS9Z5SYteAWM0hCWMBP4sjD/WwgtoiAp8TZ3h1gDcwCW1gkdl+Lgmi4
        wyjx/OQLdpAEm4ChRNfbLrAGXgE7ifPzdrCA2CwCKhInvm0Gs0UFkiX6vkxghKgRlDg58wlY
        nFMgWmLO/TmMEAvMJOZtfsgMYctLbH87B8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsY
        RVJLi3PTc4uN9IoTc4tL89L1kvNzNzECU8q2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrzJi7kS
        hXhTEiurUovy44tKc1KLDzGaAv0zkVlKNDkfmNTySuINzQxMDU3MLA1MLc2MlcR5TY6siRcS
        SE8sSc1OTS1ILYLpY+LglGpgihO4tP4q96Wnns+qBALmTLvbNztS8sY0hRv3404d1vKX9nn6
        WvIB63+Nv+Uz13MLHfZ58fvSIQ638hty8u9vqrNJTFqiFjR9DcOGPKP/Wk25Po5Vl8q+V56c
        EmyZurh7ZSer0gvTRjuNJk3L2QfzrOu6GIW/nmIrt8+19fPvbN8cNEfcqrTw37teO5tr0ouf
        RSVU/zhRbmiqxbqgduFpwd2blTV0td32dR0QNnzLvbLgkHVxQX5w13x/L9eQOPPuHTOirk5t
        yI97vMdZv2zvB2GVc6WafqI/r33p1DT7+GHV5afGe6/+ljqfviDCxe2lheXMBzrG8wWr6xfu
        zJ/5dufTR4EG/mtFr2bMCvirxFKckWioxVxUnAgAAlB8ZrIDAAA=
X-CMS-MailID: 20210805071852eucas1p248ba2fc11f29b05d4cb4ed154c0915a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210804171613eucas1p2a1884dfd6436605d8aa58ca106a59804
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210804171613eucas1p2a1884dfd6436605d8aa58ca106a59804
References: <cover.1628094600.git.robin.murphy@arm.com>
        <CGME20210804171613eucas1p2a1884dfd6436605d8aa58ca106a59804@eucas1p2.samsung.com>
        <46f4cda8215bd5f8a9f9fd5a4a6451805f75efa3.1628094600.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.08.2021 19:15, Robin Murphy wrote:
> Now that everyone has converged on iommu-dma for IOMMU_DOMAIN_DMA
> support, we can abandon the notion of drivers being responsible for the
> cookie type, and consolidate all the management into the core code.
>
> CC: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> CC: Geert Uytterhoeven <geert+renesas@glider.be>
> CC: Yong Wu <yong.wu@mediatek.com>
> CC: Heiko Stuebner <heiko@sntech.de>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> ---
>
> v3: Use a simpler temporary check instead of trying to be clever with
>      the error code
> ---
>   drivers/iommu/iommu.c | 7 +++++++
>   include/linux/iommu.h | 3 ++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f2cda9950bd5..b65fcc66ffa4 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -7,6 +7,7 @@
>   #define pr_fmt(fmt)    "iommu: " fmt
>   
>   #include <linux/device.h>
> +#include <linux/dma-iommu.h>
>   #include <linux/kernel.h>
>   #include <linux/bits.h>
>   #include <linux/bug.h>
> @@ -1946,6 +1947,11 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>   	/* Assume all sizes by default; the driver may override this later */
>   	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>   
> +	/* Temporarily avoid -EEXIST while drivers still get their own cookies */
> +	if (type == IOMMU_DOMAIN_DMA && !domain->iova_cookie && iommu_get_dma_cookie(domain)) {
> +		iommu_domain_free(domain);
> +		domain = NULL;
> +	}
>   	return domain;
>   }
>   
> @@ -1957,6 +1963,7 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>   
>   void iommu_domain_free(struct iommu_domain *domain)
>   {
> +	iommu_put_dma_cookie(domain);
>   	domain->ops->domain_free(domain);
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_free);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 4997c78e2670..141779d76035 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -40,6 +40,7 @@ struct iommu_domain;
>   struct notifier_block;
>   struct iommu_sva;
>   struct iommu_fault_event;
> +struct iommu_dma_cookie;
>   
>   /* iommu fault flags */
>   #define IOMMU_FAULT_READ	0x0
> @@ -86,7 +87,7 @@ struct iommu_domain {
>   	iommu_fault_handler_t handler;
>   	void *handler_token;
>   	struct iommu_domain_geometry geometry;
> -	void *iova_cookie;
> +	struct iommu_dma_cookie *iova_cookie;
>   };
>   
>   enum iommu_cap {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


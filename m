Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4F142F3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbhJONlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbhJONk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:40:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A89DC061767;
        Fri, 15 Oct 2021 06:38:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 92E011F4536E
Subject: Re: [PATCH v4 03/13] memory: mtk-smi: Use clk_bulk clock ops
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, anthony.huang@mediatek.com,
        Ikjoon Jang <ikjn@chromium.org>
References: <20210914113703.31466-1-yong.wu@mediatek.com>
 <20210914113703.31466-4-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <e466b3fb-d9fe-bb20-23c2-f9766a35f120@collabora.com>
Date:   Fri, 15 Oct 2021 15:38:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914113703.31466-4-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Use clk_bulk interface instead of the orginal one to simplify the code.
> 
> For SMI larbs: Require apb/smi clocks while gals is optional.
> For SMI common: Require apb/smi/gals0/gal1 in has_gals case. Otherwise,
>                  also only require apb/smi, No optional clk here.
> 
> About the "has_gals" flag, for smi larbs, the gals clock also may be
> optional even this platform support it. thus it always use
> *_bulk_get_optional, then the flag has_gals is unnecessary. Remove it.
> The smi_common's has_gals still keep it.
> 
> Also remove clk fail logs since bulk interface already output fail log.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Hello Yong,
thanks for the patch! However, I have an improvement to point out:

> ---
>   drivers/memory/mtk-smi.c | 143 +++++++++++++++------------------------
>   1 file changed, 55 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index c5fb51f73b34..f91eaf5c3ab0 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -60,6 +60,20 @@ enum mtk_smi_gen {
>   	MTK_SMI_GEN2
>   };
>   
> +#define MTK_SMI_CLK_NR_MAX			4

This refers to mtk_smi_common_clks[] and should be probably moved after that.
In any case, I don't think that there's any need to manually define this as 4,
as you can simply use the macro ARRAY_SIZE(mtk_smi_common_clks).
Using that will make you able to not update this definition everytime an update
occurs to the mtk_smi_common_clks array.

> +
> +/* larbs: Require apb/smi clocks while gals is optional. */
> +static const char * const mtk_smi_larb_clks[] = {"apb", "smi", "gals"};
> +#define MTK_SMI_LARB_REQ_CLK_NR		2
> +#define MTK_SMI_LARB_OPT_CLK_NR		1
> +
> +/*
> + * common: Require these four clocks in has_gals case. Otherwise, only apb/smi are required.
> + */
> +static const char * const mtk_smi_common_clks[] = {"apb", "smi", "gals0", "gals1"};
> +#define MTK_SMI_COM_REQ_CLK_NR		2
> +#define MTK_SMI_COM_GALS_REQ_CLK_NR	MTK_SMI_CLK_NR_MAX
> +

Apart from that,
Acked-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Regards,
- Angelo


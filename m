Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4678E3C5BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 14:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhGLLxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:53:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52668 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhGLLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:53:03 -0400
Received: from [IPv6:2a02:810a:880:f54:e464:19d5:3655:dde7] (unknown [IPv6:2a02:810a:880:f54:e464:19d5:3655:dde7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B6CA01F42190;
        Mon, 12 Jul 2021 12:50:13 +0100 (BST)
Subject: Re: [PATCH] soc: mediatek: mmsys: fix HDMI output on
 mt7623/bananapi-r2
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
References: <20210710132431.265985-1-linux@fw-web.de>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <456f0611-1fc7-75ac-ff45-9afd94190283@collabora.com>
Date:   Mon, 12 Jul 2021 13:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210710132431.265985-1-linux@fw-web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 10.07.21 15:24, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> HDMI output was broken on mt7623/BPI-R2 in 5.13 because function for
> special output selection (mtk_mmsys_ddp_sout_sel) was dropped.
> This function wrote 3 registers at one time and so it is not compatible
> with the array-approach.
> 
> I re-added the old function and call this after the default routing table
> was applied. This default routing table can still be used as the only
> connection handled by mmsys on BPI-R2 is OVL0->RDMA0 and this is already
> present in the default routing table
> 
> Fixes: 440147639ac7 ("soc: mediatek: mmsys: Use an array for setting the routing registers")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   drivers/soc/mediatek/mtk-mmsys.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 080660ef11bf..f91b7fdd417a 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -57,6 +57,25 @@ struct mtk_mmsys {
>   	const struct mtk_mmsys_driver_data *data;
>   };
>   
> +static void mtk_mmsys_ddp_sout_sel(struct device *dev,
> +				   enum mtk_ddp_comp_id cur,
> +				   enum mtk_ddp_comp_id next)
> +{
> +	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
> +
> +	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
> +		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
> +			       mmsys->regs + DISP_REG_CONFIG_OUT_SEL);
> +	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
> +		writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
> +			       mmsys->regs + DISP_REG_CONFIG_OUT_SEL);
> +		writel_relaxed(DSI_SEL_IN_RDMA,
> +			       mmsys->regs + DISP_REG_CONFIG_DSI_SEL);
> +		writel_relaxed(DPI_SEL_IN_BLS,
> +			       mmsys->regs + DISP_REG_CONFIG_DPI_SEL);

you can still use the array approach for this like that:

         {
                 DDP_COMPONENT_BLS, DDP_COMPONENT_DSI0,
                 DISP_REG_CONFIG_OUT_SEL, BLS_TO_DSI_RDMA1_TO_DPI1
         }, {
         {
                 DDP_COMPONENT_BLS, DDP_COMPONENT_DPI0,
                 DISP_REG_CONFIG_OUT_SEL, BLS_TO_DPI_RDMA1_TO_DSI
         }, {
         {
                 DDP_COMPONENT_BLS, DDP_COMPONENT_DPI0,
                 DISP_REG_CONFIG_DSI_SEL, DSI_SEL_IN_RDMA
         }, {
         {
                 DDP_COMPONENT_BLS, DDP_COMPONENT_DPI0,
                 DISP_REG_CONFIG_DPI_SEL, DPI_SEL_IN_BLS
         }, {


Thanks,
Dafna

> +	}
> +}
> +
>   void mtk_mmsys_ddp_connect(struct device *dev,
>   			   enum mtk_ddp_comp_id cur,
>   			   enum mtk_ddp_comp_id next)
> @@ -71,6 +90,8 @@ void mtk_mmsys_ddp_connect(struct device *dev,
>   			reg = readl_relaxed(mmsys->regs + routes[i].addr) | routes[i].val;
>   			writel_relaxed(reg, mmsys->regs + routes[i].addr);
>   		}
> +
> +	mtk_mmsys_ddp_sout_sel(dev, cur, next);
>   }
>   EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
>   
> 

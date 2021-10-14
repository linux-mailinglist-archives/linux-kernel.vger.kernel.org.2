Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4142DC10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhJNOy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhJNOy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:54:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2616FC061570;
        Thu, 14 Oct 2021 07:52:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1E93B1F44D01
Subject: Re: [PATCH v6 06/16] soc: mediatek: add mtk-mmsys support for mt8195
 vdosys1
To:     "Nancy.Lin" <nancy.lin@mediatek.com>, CK Hu <ck.hu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        singo.chang@mediatek.com, srv_heupstream@mediatek.com
References: <20211004062140.29803-1-nancy.lin@mediatek.com>
 <20211004062140.29803-7-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <c6dd417c-a575-8054-9d10-d56d925ec6bc@collabora.com>
Date:   Thu, 14 Oct 2021 16:52:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211004062140.29803-7-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add mt8195 vdosys1 clock driver name and routing table to
> the driver data of mtk-mmsys.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> ---
>   drivers/soc/mediatek/mt8195-mmsys.h    | 136 +++++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-mmsys.c       |  10 ++
>   include/linux/soc/mediatek/mtk-mmsys.h |   2 +
>   3 files changed, 148 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mt8195-mmsys.h b/drivers/soc/mediatek/mt8195-mmsys.h
> index 0c97a5f016c1..f19ec72c1243 100644
> --- a/drivers/soc/mediatek/mt8195-mmsys.h
> +++ b/drivers/soc/mediatek/mt8195-mmsys.h
> @@ -59,6 +59,70 @@
>   #define MT8195_SOUT_DSC_WRAP1_OUT_TO_SINA_VIRTUAL0		(2 << 16)
>   #define MT8195_SOUT_DSC_WRAP1_OUT_TO_VPP_MERGE			(3 << 16)
>   
> +#define MT8195_VDO1_VPP_MERGE0_P0_SEL_IN			0xf04
> +#define MT8195_VPP_MERGE0_P0_SEL_IN_FROM_MDP_RDMA0		(1 << 0)

There is no bitshifting action here: this is simply 1.

> +
> +#define MT8195_VDO1_VPP_MERGE0_P1_SEL_IN			0xf08
> +#define MT8195_VPP_MERGE0_P1_SEL_IN_FROM_MDP_RDMA1		(1 << 0)

Same here.

> +
> +#define MT8195_VDO1_DISP_DPI1_SEL_IN				0xf10
> +#define MT8195_DISP_DPI1_SEL_IN_FROM_VPP_MERGE4_MOUT		(0 << 0)

And this is 0.

> +
> +#define MT8195_VDO1_DISP_DP_INTF0_SEL_IN			0xf14
> +#define MT8195_DISP_DP_INTF0_SEL_IN_FROM_VPP_MERGE4_MOUT	(0 << 0)
> +
> +#define MT8195_VDO1_MERGE4_SOUT_SEL				0xf18
> +#define MT8195_MERGE4_SOUT_TO_DPI1_SEL				(2 << 0)

This is simply 0x2...

> +#define MT8195_MERGE4_SOUT_TO_DP_INTF0_SEL			(3 << 0)

...and this is 0x3.

There are other occurrences of the same logic, so please fix them all.

Regards,
- Angelo


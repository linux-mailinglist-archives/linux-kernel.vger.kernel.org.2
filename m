Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F5A34E430
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhC3JTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhC3JTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:19:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9323EC061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:19:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e18so15499269wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QvSPBsb1lX0xL/5H9a1UCrWMqQfmW3P/W0ClVOEXkcY=;
        b=FLYPoItdLnPVnobh+XNzuyR4z9WMc8WPFKBfEMEPW6x1zFwBTOD3iC/9NMNBpJ8vIm
         kKk7ol4ou1Q3qooRlctN9Lv0u5Bwb24w5OcAdWuFFB/Q2pwO0jFANizAyuP5S0fonAG0
         QSoMdSaqnvf5FZ9ezoDj+cSGcAVhVHbG5A2MI/pBfsoWYqz/uBso5uAZtGHHB+1Z06EZ
         SoGpZRgEJXBZGX3nrCm4dr2o0BLWG8xngQltHLTR1q6Foxb1Ln/wwLBIyIWY745qjXf2
         TuKtZ2TQ5rAko21AayJ24x5cZ5h4YS/9nZeab10y7F9sLlmSRC5NJxOkSmkxbnFYMzUh
         IXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QvSPBsb1lX0xL/5H9a1UCrWMqQfmW3P/W0ClVOEXkcY=;
        b=RXNBCbq/tXU9nuu6g+qEb8i+nfNRsVHe9uiQ4oK+VCQXpisvW9+jy7cu74BPm5KnrF
         Qz/N/Qr/aIEesrHDRDGAwWBr6RReOENfV1dxePUYp5pcCV4ItDAZXQyiM501fSsElaej
         aI+Y/a1HG3uuet/enXhhqZPP7SV8RWfpbzHR02rR18EXDKAXAgvoCUigVO1V3K05zdd/
         BWtSr4AAJ1sP/aueyvXJQpx0siIaX4XP4afcaMBMyDkIlw7q+8aTwL1/4V6FXob51v+z
         BNyR9vScxrPMhp0R122r3aENgOVoyU6GiqLqcDkU54IGcCdBuJGfH92DDLl+el+cE3cY
         lYJQ==
X-Gm-Message-State: AOAM5336TKZ8bCXzohAblfYH5SH8seiORZ2/lhXkL+bPy1x8fDXOBbWE
        lQBGAPquOokFa4t4v38nXQ8=
X-Google-Smtp-Source: ABdhPJxeyzFtZrKGc2ZRNCcxz2PDVWkgayeNybrCwmfKzdHqD0LTm2JSuBNUIXsehLethKQ1oW/cqQ==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr33573108wrw.334.1617095968330;
        Tue, 30 Mar 2021 02:19:28 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id a6sm3600749wmm.0.2021.03.30.02.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 02:19:27 -0700 (PDT)
Subject: Re: [PATCH] soc: mediatek: mmsys: Add mt8183 mmsys routing table
To:     Hsin-Yi Wang <hsinyi@chromium.org>, linux-kernel@vger.kernel.org
Cc:     drinkcat@chromium.org, weiyi.lu@mediatek.com, ck.hu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, enric.balletbo@collabora.com
References: <20210323055143.607529-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d816e7c7-5bf8-4b4c-f807-1337db4a4241@gmail.com>
Date:   Tue, 30 Mar 2021 11:19:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323055143.607529-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Patch looks good but please use the new, just merged format, see [1]
Please put the defines and the routing table in a new header file mt8183-mmsys.h

Thanks
Matthias

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=v5.12-next/soc

On 23/03/2021 06:51, Hsin-Yi Wang wrote:
> mt8183 has different routing registers than mt8173.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> This patch is based on series ("soc: mediatek: Prepare MMSYS for DDP routing using tables")[1]
> and tested with mt8183 krand and mt8183 juniper device.
> The register value is referenced from [2].
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/cover/20210317181711.795245-1-enric.balletbo@collabora.com/
> [2] https://patchwork.kernel.org/project/linux-mediatek/patch/1609815993-22744-6-git-send-email-yongqiang.niu@mediatek.com/
> ---
>  drivers/soc/mediatek/mtk-mmsys.c |  2 ++
>  drivers/soc/mediatek/mtk-mmsys.h | 47 ++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index c46d8ab8b0c2..16bb55b0463a 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -40,6 +40,8 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>  
>  static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
>  	.clk_driver = "clk-mt8183-mm",
> +	.routes = mmsys_mt8183_routing_table,
> +	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
>  };
>  
>  struct mtk_mmsys {
> diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
> index a760a34e6eca..c55baf5932b8 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.h
> +++ b/drivers/soc/mediatek/mtk-mmsys.h
> @@ -66,6 +66,28 @@
>  #define DPI_SEL_IN_BLS				0x0
>  #define DSI_SEL_IN_RDMA				0x1
>  
> +#define MT8183_DISP_OVL0_MOUT_EN		0xf00
> +#define MT8183_DISP_OVL0_2L_MOUT_EN		0xf04
> +#define MT8183_DISP_OVL1_2L_MOUT_EN		0xf08
> +#define MT8183_DISP_DITHER0_MOUT_EN		0xf0c
> +#define MT8183_DISP_PATH0_SEL_IN		0xf24
> +#define MT8183_DISP_DSI0_SEL_IN			0xf2c
> +#define MT8183_DISP_DPI0_SEL_IN			0xf30
> +#define MT8183_DISP_RDMA0_SOUT_SEL_IN		0xf50
> +#define MT8183_DISP_RDMA1_SOUT_SEL_IN		0xf54
> +
> +#define MT8183_OVL0_MOUT_EN_OVL0_2L		BIT(4)
> +#define MT8183_OVL0_2L_MOUT_EN_DISP_PATH0	BIT(0)
> +#define MT8183_OVL1_2L_MOUT_EN_RDMA1		BIT(4)
> +#define MT8183_DITHER0_MOUT_IN_DSI0		BIT(0)
> +#define MT8183_DISP_PATH0_SEL_IN_OVL0_2L	0x1
> +#define MT8183_DSI0_SEL_IN_RDMA0		0x1
> +#define MT8183_DSI0_SEL_IN_RDMA1		0x3
> +#define MT8183_DPI0_SEL_IN_RDMA0		0x1
> +#define MT8183_DPI0_SEL_IN_RDMA1		0x2
> +#define MT8183_RDMA0_SOUT_COLOR0		0x1
> +#define MT8183_RDMA1_SOUT_DSI0			0x1
> +
>  struct mtk_mmsys_routes {
>  	u32 from_comp;
>  	u32 to_comp;
> @@ -212,4 +234,29 @@ static const struct mtk_mmsys_routes mmsys_default_routing_table[] = {
>  	}
>  };
>  
> +static const struct mtk_mmsys_routes mmsys_mt8183_routing_table[] = {
> +	{
> +		DDP_COMPONENT_OVL0, DDP_COMPONENT_OVL_2L0,
> +		MT8183_DISP_OVL0_MOUT_EN, MT8183_OVL0_MOUT_EN_OVL0_2L
> +	}, {
> +		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
> +		MT8183_DISP_OVL0_2L_MOUT_EN, MT8183_OVL0_2L_MOUT_EN_DISP_PATH0
> +	}, {
> +		DDP_COMPONENT_OVL_2L1, DDP_COMPONENT_RDMA1,
> +		MT8183_DISP_OVL1_2L_MOUT_EN, MT8183_OVL1_2L_MOUT_EN_RDMA1
> +	}, {
> +		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
> +		MT8183_DISP_DITHER0_MOUT_EN, MT8183_DITHER0_MOUT_IN_DSI0
> +	}, {
> +		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
> +		MT8183_DISP_PATH0_SEL_IN, MT8183_DISP_PATH0_SEL_IN_OVL0_2L
> +	}, {
> +		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
> +		MT8183_DISP_DPI0_SEL_IN, MT8183_DPI0_SEL_IN_RDMA1
> +	}, {
> +		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
> +		MT8183_DISP_RDMA0_SOUT_SEL_IN, MT8183_RDMA0_SOUT_COLOR0
> +	}
> +};
> +
>  #endif /* __SOC_MEDIATEK_MTK_MMSYS_H */
> 

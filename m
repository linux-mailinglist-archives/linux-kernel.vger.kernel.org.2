Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FF834E424
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhC3JQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhC3JPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:15:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5446DC061764
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:15:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p19so7979032wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hIgRZy+uhzo2sm3mfgG8b97EVLTEtVQu0/b6m7/PEy0=;
        b=nfJNyYMEpiF5OLVr1kgEXrnL92SfohV6IFzRb+r0IGLC/GfO5cxWFBxU2QhGb4ZR38
         pIDJ2ouKyWDdIwJbwnUYBitt/25W8hKphRFP0MH9utQGaBDLPNkxfoKo55rDgrj0Ki1N
         Uy5uOAKHvQ8ZFTUyd7yqknni57TUFeCaqIVDFjs4zESgG53i8qXgKCjPiPLDm+trMudW
         KG92+MgmPNvtz7PulLYg9khQeeK+gwPl5OJt81CdO96BXO6Zmwmj41A959P0kRD7otyg
         54jwGZpvV2MmZtiYZOwn2JD+ZlTCpM9wRlALH6JAzlRRY4UCZf7yl1BZGgxEl6CM2Jdv
         SZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hIgRZy+uhzo2sm3mfgG8b97EVLTEtVQu0/b6m7/PEy0=;
        b=CtIpi4PY7peezmJEl2zBXbYgmS0G2YnU21F8u9EQrPYmK6k4nkRbc43I1YYYx6ecjT
         /fxIvcBybUAMc77j+trXK+u2LHLMwnrLZwbLhqJf7Cl84/o0KHkFe0nuKAKq8b1seadp
         H4xe0deefUvloV9EPKMDL0YcHI7d56lDxZigtbPNMXTyYa16ErNLaip3SFSOHQDbkEp1
         ucu3pg2Ng3tZunhgYH1SLOgWUvFEEbqj5jct+go1n5zhYUJt6wSPw/SAKxi4GUi4iBbb
         c8U36AM7mFSC2FYnMx+uaLdKTiAzGpi146dQTPUBRa4+KoCh/q2Ha8GyoIeL2/lehnzZ
         w6vQ==
X-Gm-Message-State: AOAM533TGovPzrgfitqbs4KrPMo15hMyW/LEUYirlMqkTY7prr+uXAGg
        UCs3yBgEp01yrqwiduSu6dPN1/eQ4z9vFUUI
X-Google-Smtp-Source: ABdhPJzlMzoisYqiE27vtPAOQuSEopagM/LZtkENxUaO7gh2wflYciSxqGQSVHCo+T37hqWbiqZe5A==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr3010285wml.44.1617095749128;
        Tue, 30 Mar 2021 02:15:49 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id p17sm2328492wmd.42.2021.03.30.02.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 02:15:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] soc: mediatek: mmsys: Add support for MT8167 SoC
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201027160631.608503-1-fparent@baylibre.com>
 <20201027160631.608503-2-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <052990a7-673f-31f4-2453-a84b007cdbcf@gmail.com>
Date:   Tue, 30 Mar 2021 11:15:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20201027160631.608503-2-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

Sorry for taking so long on that patch.
Generally the patch looks good, but I just merged a small change how we add new
SoC to the driver.
Please see comments below.

On 27/10/2020 17:06, Fabien Parent wrote:
> Add routing table for DSI on MT8167 SoC. The registers are mostly
> incompatible with the current defines, so new one for MT8167 are added.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> 
> This patch depends on the patch series
> "soc: mediatek: Prepare MMSYS for DDP routing using tables"
> 
> [0] https://lore.kernel.org/patchwork/cover/1317813/
> 
>  drivers/soc/mediatek/mtk-mmsys.c | 50 ++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index f00d6d08c9c5..9890990a74a9 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -85,6 +85,22 @@
>  #define DSI_SEL_IN_RDMA				0x1
>  #define DSI_SEL_IN_MASK				0x1
>  
> +/* MT8167 */
> +#define MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN	0x030
> +#define MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN	0x038
> +#define MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x058
> +#define MT8167_DISP_REG_CONFIG_DISP_DSI0_SEL_IN		0x064
> +#define MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN	0x06c
> +
> +#define MT8167_DITHER_MOUT_EN_RDMA0			BIT(0)
> +#define MT8167_DITHER_MOUT_EN_MASK			0x7
> +
> +#define MT8167_RDMA0_SOUT_DSI0				0x2
> +#define MT8167_RDMA0_SOUT_MASK				0x3
> +
> +#define MT8167_DSI0_SEL_IN_RDMA0			0x1
> +#define MT8167_DSI0_SEL_IN_MASK				0x3
> +
>  struct mtk_mmsys_routes {
>  	u32 from_comp;
>  	u32 to_comp;
> @@ -124,6 +140,30 @@ struct mtk_mmsys {
>  	const struct mtk_mmsys_driver_data *data;
>  };
>  
> +static const struct mtk_mmsys_routes mt8167_mmsys_routing_table[] = {

Please put the defines and the routing table in a separate header file
mt8167-mmsys.h

Thanks and once again sorry for the inconvenience.
Matthias

> +	{
> +		DDP_COMPONENT_OVL0, DDP_COMPONENT_COLOR0,
> +		MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN,
> +		OVL0_MOUT_EN_COLOR0, OVL0_MOUT_EN_COLOR0
> +	}, {
> +		DDP_COMPONENT_DITHER, DDP_COMPONENT_RDMA0,
> +		MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN,
> +		MT8167_DITHER_MOUT_EN_MASK, MT8167_DITHER_MOUT_EN_RDMA0
> +	}, {
> +		DDP_COMPONENT_OVL0, DDP_COMPONENT_COLOR0,
> +		MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN,
> +		COLOR0_SEL_IN_OVL0, COLOR0_SEL_IN_OVL0
> +	}, {
> +		DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI0,
> +		MT8167_DISP_REG_CONFIG_DISP_DSI0_SEL_IN,
> +		MT8167_DSI0_SEL_IN_MASK, MT8167_DSI0_SEL_IN_RDMA0
> +	}, {
> +		DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI0,
> +		MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN,
> +		MT8167_RDMA0_SOUT_MASK, MT8167_RDMA0_SOUT_DSI0
> +	},
> +};
> +
>  static const struct mtk_mmsys_routes mt8173_mmsys_routing_table[] = {
>  	{
>  		DDP_COMPONENT_BLS, DDP_COMPONENT_DSI0,
> @@ -288,6 +328,12 @@ static const struct mtk_mmsys_routes mt8173_mmsys_routing_table[] = {
>  	}
>  };
>  
> +static const struct mtk_mmsys_driver_data mt8167_mmsys_driver_data = {
> +	.clk_driver = "clk-mt8167-mm",
> +	.routes = mt8167_mmsys_routing_table,
> +	.num_routes = ARRAY_SIZE(mt8167_mmsys_routing_table),
> +};
> +
>  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>  	.clk_driver = "clk-mt8173-mm",
>  	.routes = mt8173_mmsys_routing_table,
> @@ -385,6 +431,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
>  		.compatible = "mediatek,mt6797-mmsys",
>  		.data = &mt6797_mmsys_driver_data,
>  	},
> +	{
> +		.compatible = "mediatek,mt8167-mmsys",
> +		.data = &mt8167_mmsys_driver_data,
> +	},
>  	{
>  		.compatible = "mediatek,mt8173-mmsys",
>  		.data = &mt8173_mmsys_driver_data,
> 

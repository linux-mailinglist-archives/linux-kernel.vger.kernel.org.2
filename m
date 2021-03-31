Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F82634FFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhCaLyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbhCaLyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:54:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F50FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:54:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p19so10037418wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wOUvR5UZkhr2U8Db9QDiTATjD+koxDFWTiWbqaITOdI=;
        b=E1x/9BvV21kUWB1h48F2mlMhFSlXG/eoXFucxVazGTFHI5bbjx0PR0+BF/2ePiJGhV
         munPoUHN+Hc6IddswFdxoErn78k2OzhAE5aZLeMTwpm5FUi8XXLSMp68Ot4pv7TVpLJT
         4royuAZKga/EytxKLmx+iaAjUr/Yz/c3kSkqhKPQiq9fhdMkmGjLRXITrOaaoUQkwD3x
         l7q3RsTzsKzgpcFzZ0T1gREW70Sbj5Y4Af6TDUxzkyGEmejhcKTXo9ImsdM6TffRhihL
         g7wT1Z1zlBmbJSDL8VDRDRiw9tGe/HnUKIsNsE+xKWfr0wkCckTitDZB+bBQJ1kJytq9
         7J8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wOUvR5UZkhr2U8Db9QDiTATjD+koxDFWTiWbqaITOdI=;
        b=r6E+md0xFnhCGBrB6UmKBLYfIl2SJXpM5JqH6vlUintiFhpGMb9uWzBAVwmR7LOAjX
         1hE5suWNnk1C6ajkYeqFwKvkQASTU7UVPL0+PPbhNUY8MX1bQLmr1vwk7osUoTQzfC3B
         PpUKryLB0nUtmvXbyU4u3eKeNkJL/hwuZ/f77D+3OhMNoDVaJ+IcDH2wff+7Knqm87EC
         4PB1hDMMVlZfu+A5cuhNadEk9QktgGvus1pedxhAD8vafQKxm9ej5EVJisbDZxtY+n5v
         a8MxiZS7D/sziEbVBUbR4PtBW5PYS7STNZdN/w6qMl3C+uu7BsLHk5sjcwyyAG7L/qDO
         WLEQ==
X-Gm-Message-State: AOAM5339JuW4bD6GWNctlWeLDejzChoezWIPv/30GHkLC8k13KSijVrM
        W4N31Hdf3epBr7jDoMvVQjs=
X-Google-Smtp-Source: ABdhPJyfd4P1sadVVcCK7G1FwTbi2uaOyuSyCHf/gyU7bg4PD08sTXOfNJDXLQOdpv1SpG3e2hELjA==
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr2879392wmj.185.1617191646149;
        Wed, 31 Mar 2021 04:54:06 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id s13sm4183559wrv.80.2021.03.31.04.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 04:54:05 -0700 (PDT)
Subject: Re: [PATCH v3] soc: mediatek: mmsys: Add mt8183 mmsys routing table
To:     Hsin-Yi Wang <hsinyi@chromium.org>, linux-kernel@vger.kernel.org
Cc:     drinkcat@chromium.org, weiyi.lu@mediatek.com, ck.hu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, enric.balletbo@collabora.com
References: <20210330110423.3542163-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e8c75361-69cf-5516-5fcc-4fae79988418@gmail.com>
Date:   Wed, 31 Mar 2021 13:54:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210330110423.3542163-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/03/2021 13:04, Hsin-Yi Wang wrote:
> mt8183 has different routing registers than mt8173.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to v5.12-next/soc

Thanks!

> ---
> v2->v3:
> Fix comments.
> 
> v1->v2:
> Move mt8183 routing table to mt8183-mmsys.h
> 
> This patch is based on https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git v5.12-next/soc
> ---
>  drivers/soc/mediatek/mt8183-mmsys.h | 54 +++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-mmsys.c    |  3 ++
>  2 files changed, 57 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mt8183-mmsys.h
> 
> diff --git a/drivers/soc/mediatek/mt8183-mmsys.h b/drivers/soc/mediatek/mt8183-mmsys.h
> new file mode 100644
> index 000000000000..579dfc8dc8fc
> --- /dev/null
> +++ b/drivers/soc/mediatek/mt8183-mmsys.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __SOC_MEDIATEK_MT8183_MMSYS_H
> +#define __SOC_MEDIATEK_MT8183_MMSYS_H
> +
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
> +#endif /* __SOC_MEDIATEK_MT8183_MMSYS_H */
> +
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index c46d8ab8b0c2..79e55150210e 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -11,6 +11,7 @@
>  #include <linux/soc/mediatek/mtk-mmsys.h>
>  
>  #include "mtk-mmsys.h"
> +#include "mt8183-mmsys.h"
>  
>  static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
>  	.clk_driver = "clk-mt2701-mm",
> @@ -40,6 +41,8 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>  
>  static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
>  	.clk_driver = "clk-mt8183-mm",
> +	.routes = mmsys_mt8183_routing_table,
> +	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
>  };
>  
>  struct mtk_mmsys {
> 

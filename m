Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FBC34E5DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhC3K4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhC3KzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:55:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A77DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:55:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k8so15785307wrc.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zdE5Fc8jLem2B9Qy48G9g0/1kUGnbcvZCpMV8AzrKEM=;
        b=H9tk91yek2J1Y1tyh0XM2q3G/b+Nvp2kUxPqqRIoSggREMNckFAO0SNb1uTBTmuZSB
         teUjQUnAsphpTEZkAT/H7zJNCRShXzU3+HYSpeTTbyjz+ctSKS276oBAUx8IRJ0Ko9e7
         AETVZWZRPxoCW3CZf9JDpbAyrYd9rSXplwUrJEzPqniPsFqSwKxe5hyEYOd+v1fl2bDJ
         g9amZYnjUXwC7+6i1+6rYtcRtuL1meArgxwNMil1RhLyJHKHn+DWqfecEg8Jzg9aqHv1
         XoIi8jP6BNa2PQDwH307OI7cgTHVgMpLLWU4nHe4UjY9Kta31TsldDio8DHZupKpP/dn
         TJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zdE5Fc8jLem2B9Qy48G9g0/1kUGnbcvZCpMV8AzrKEM=;
        b=J2UsqcEANvwu9mK2pcgaHnl61my5+J4BZvZjL/E28H4wvS6HzCcj7ec8bfPo8VseAe
         RNGeFTG4zrW3l4CNqlfAeGRSKImkeDXNFZCo6Efl9fvKwRSq8u32SpfYHOerDuKPwbQ/
         0uDge5yA3PXGt17W2uRzTE9a3nB98g4J/TSiY0kHhASTA5xkXs6BjLWjrn8mHhG5Kx+8
         fw+6miHZc+2x9T/62aAnB3P+ReDjSlxk0o+N4qHJb2bBpSJoKImvuDklNTcjV9J0R6WR
         EBoGxggWHdfeyMwrCxC9D8JJhKjzi4PVi21+HvSPHjStQex4pnpmvP4DWe9Wi/fnJoaq
         djRw==
X-Gm-Message-State: AOAM533plzY8W1hdLQv3yl15rvnwOae/FPhdM+IeUatugW29KL0eIriV
        OgyM1kEn8OJm3pf0C+stTp4=
X-Google-Smtp-Source: ABdhPJz81MZ4dAglYXBBgnyQTkAYA3/Xi5muiyQxbDAJWWnx3S/5t2YuFkHCrMeVqoIE7E4pnLGxWA==
X-Received: by 2002:adf:f307:: with SMTP id i7mr33454467wro.142.1617101723156;
        Tue, 30 Mar 2021 03:55:23 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id j123sm2970592wmb.1.2021.03.30.03.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:55:22 -0700 (PDT)
Subject: Re: [PATCH v2] soc: mediatek: mmsys: Add mt8183 mmsys routing table
To:     Hsin-Yi Wang <hsinyi@chromium.org>, linux-kernel@vger.kernel.org
Cc:     drinkcat@chromium.org, weiyi.lu@mediatek.com, ck.hu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, enric.balletbo@collabora.com
References: <20210330104432.3432574-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <bb100c42-a295-1b94-ada2-069ab397dffd@gmail.com>
Date:   Tue, 30 Mar 2021 12:55:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210330104432.3432574-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/03/2021 12:44, Hsin-Yi Wang wrote:
> mt8183 has different routing registers than mt8173.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> v1->v2:
> Move mt8183 routing table to mt8183-mmsys.h
> 
> This patch is based on https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git v5.12-next/soc
> ---
>  drivers/soc/mediatek/mt8183-mmsys.h | 56 +++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-mmsys.c    |  3 ++
>  2 files changed, 59 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mt8183-mmsys.h
> 
> diff --git a/drivers/soc/mediatek/mt8183-mmsys.h b/drivers/soc/mediatek/mt8183-mmsys.h
> new file mode 100644
> index 000000000000..38e9f683e5bd
> --- /dev/null
> +++ b/drivers/soc/mediatek/mt8183-mmsys.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __SOC_MEDIATEK_MT8183_MMSYS_H
> +#define __SOC_MEDIATEK_MT8183_MMSYS_H
> +
> +#include "mtk-mmsys.h"

We can drop this, see below.

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
> index c46d8ab8b0c2..ac68a989854e 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -10,6 +10,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/soc/mediatek/mtk-mmsys.h>
>  
> +#include "mt8183-mmsys.h"

Just add the SoC specific header after mtk-mmsys.h include.

Other then that patch looks good.

Matthias


>  #include "mtk-mmsys.h"
>  
>  static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
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

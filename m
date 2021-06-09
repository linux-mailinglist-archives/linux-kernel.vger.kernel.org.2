Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40343A0DF0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhFIHoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhFIHog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:44:36 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FED1C061574;
        Wed,  9 Jun 2021 00:42:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e11so14122136wrg.3;
        Wed, 09 Jun 2021 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=So7c7JWPkLjUFwh5Mbzg+5acl7ZVlcpT5mPSiX7o4aQ=;
        b=ak/Oj0b7S2bRhaYUxnwunkIfDMKJLwBrLUHurksp7KJFEWifeLlzqDfEF118CCOREt
         W35tGqAIrHkjCav8TxrI2FTqonrRPWvTYYyCWJ2onfsLlc/8CJ5lcpgIqZPIMRhTKrub
         75ZxBq1Pi0iHFRlomG/3yoGuxe39NXEB7kehy9oz6lJcauqhWi7/5oFiUDJGK61WQWlu
         lJ1KqjdotIDP7f6mrXKg6x/jLK0VRMmEj3Ge98U0LWpYrgzdPOTmYVoP20GGWLnkPr+W
         jKL+jHNr8Cv3qJfkL//tu20lqsZof1ry8uhdJ+sRy8jpv8y5LJT3BxfaiGiYvDoOqYLd
         67dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=So7c7JWPkLjUFwh5Mbzg+5acl7ZVlcpT5mPSiX7o4aQ=;
        b=XClcM/ulnDmba+URYK4ROmFR6ndpuM+GEgqwAlEik13ni/iZVY/WI5knJnqoiW/yOi
         Zh1rZmA6Zv24yjh07RuV9ColnY9q1F3rfdfzs/6Cwq09ycMwYPBQvPs0u7NP4v4flVJ3
         kMWx/868emUxgFgwWZ7Kgx2YI9n39y3NDEluRgiMKDJLZ54m280MJPvmc9MNOP8Ot7CB
         lb5zk34xf/BxGMDTLMYZ9PryOxb4+JAQB+snQTvf7Kum9jF191Ey9dPnKLIYw8uKEDz0
         bVcLsHxPVynrUx70BzMVGNs5AqvMjqtVI7QOVBfhqS9uQQLDPX9sYmXYJyOQAqf8lovD
         iMOQ==
X-Gm-Message-State: AOAM533r+7tV5wp+jArHSts5Gfj9YUndQEmnLGJAl8txvMql6V3Qc7hI
        9kfFFj1vN79+VgdWgDkqL/w=
X-Google-Smtp-Source: ABdhPJzlKoBTyl107ZDIoOMGsxhiXisYxLa5tONf+ZkcfDuiJGC/CjWXYkP3mkHWKyfav5i5xCwmsw==
X-Received: by 2002:adf:efc3:: with SMTP id i3mr26786450wrp.356.1623224546286;
        Wed, 09 Jun 2021 00:42:26 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id n7sm4709769wmq.37.2021.06.09.00.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 00:42:25 -0700 (PDT)
Subject: Re: [PATCH v5, 4/4] soc: mediatek: mmsys: Add mt8192 mmsys routing
 table
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1618236288-1617-1-git-send-email-yongqiang.niu@mediatek.com>
 <1618236288-1617-5-git-send-email-yongqiang.niu@mediatek.com>
 <f7fd0d7038361c7efae54ba96924105baa3fb033.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <2e855ea5-232f-1fe6-46df-aeafd01a9ba6@gmail.com>
Date:   Wed, 9 Jun 2021 09:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <f7fd0d7038361c7efae54ba96924105baa3fb033.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2021 00:59, Chun-Jie Chen wrote:
> On Mon, 2021-04-12 at 22:04 +0800, Yongqiang Niu wrote:
>> mt8192 has different routing registers than mt8183
>>
>> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
>> ---
>>  drivers/soc/mediatek/mt8192-mmsys.h | 68
>> +++++++++++++++++++++++++++++++++++++
>>  drivers/soc/mediatek/mtk-mmsys.c    |  7 ++++
>>  2 files changed, 75 insertions(+)
>>  create mode 100644 drivers/soc/mediatek/mt8192-mmsys.h
>>
>> diff --git a/drivers/soc/mediatek/mt8192-mmsys.h
>> b/drivers/soc/mediatek/mt8192-mmsys.h
>> new file mode 100644
>> index 0000000..3179029
>> --- /dev/null
>> +++ b/drivers/soc/mediatek/mt8192-mmsys.h
>> @@ -0,0 +1,68 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#ifndef __SOC_MEDIATEK_MT8192_MMSYS_H
>> +#define __SOC_MEDIATEK_MT8192_MMSYS_H
>> +
>> +#define MT8192_MMSYS_OVL_MOUT_EN		0xf04
>> +#define MT8192_DISP_OVL1_2L_MOUT_EN		0xf08
>> +#define MT8192_DISP_OVL0_2L_MOUT_EN		0xf18
>> +#define MT8192_DISP_OVL0_MOUT_EN		0xf1c
>> +#define MT8192_DISP_RDMA0_SEL_IN		0xf2c
>> +#define MT8192_DISP_RDMA0_SOUT_SEL		0xf30
>> +#define MT8192_DISP_CCORR0_SOUT_SEL		0xf34
>> +#define MT8192_DISP_AAL0_SEL_IN			0xf38
>> +#define MT8192_DISP_DITHER0_MOUT_EN		0xf3c
>> +#define MT8192_DISP_DSI0_SEL_IN			0xf40
>> +#define MT8192_DISP_OVL2_2L_MOUT_EN		0xf4c
>> +
>> +#define MT8192_DISP_OVL0_GO_BLEND			BIT(0)
>> +#define MT8192_DITHER0_MOUT_IN_DSI0			BIT(0)
>> +#define MT8192_OVL0_MOUT_EN_DISP_RDMA0			BIT(0)
>> +#define MT8192_OVL2_2L_MOUT_EN_RDMA4			BIT(0)
>> +#define MT8192_DISP_OVL0_GO_BG				BIT(1)
>> +#define MT8192_DISP_OVL0_2L_GO_BLEND			BIT(2)
>> +#define MT8192_DISP_OVL0_2L_GO_BG			BIT(3)
>> +#define MT8192_OVL1_2L_MOUT_EN_RDMA1			BIT(4)
>> +#define MT8192_OVL0_MOUT_EN_OVL0_2L			BIT(4)
>> +#define MT8192_RDMA0_SEL_IN_OVL0_2L			0x3
>> +#define MT8192_RDMA0_SOUT_COLOR0			0x1
>> +#define MT8192_CCORR0_SOUT_AAL0				0x1
>> +#define MT8192_AAL0_SEL_IN_CCORR0			0x1
>> +#define MT8192_DSI0_SEL_IN_DITHER0			0x1
>> +
>> +static const struct mtk_mmsys_routes mmsys_mt8192_routing_table[] =
>> {
>> +	{
>> +		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
>> +		MT8192_DISP_OVL0_2L_MOUT_EN,
>> MT8192_OVL0_MOUT_EN_DISP_RDMA0,
>> +	}, {
>> +		DDP_COMPONENT_OVL_2L2, DDP_COMPONENT_RDMA4,
>> +		MT8192_DISP_OVL2_2L_MOUT_EN,
>> MT8192_OVL2_2L_MOUT_EN_RDMA4
>> +	}, {
>> +		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
>> +		MT8192_DISP_DITHER0_MOUT_EN,
>> MT8192_DITHER0_MOUT_IN_DSI0
>> +	}, {
>> +		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
>> +		MT8192_DISP_RDMA0_SEL_IN, MT8192_RDMA0_SEL_IN_OVL0_2L
>> +	}, {
>> +		DDP_COMPONENT_CCORR, DDP_COMPONENT_AAL0,
>> +		MT8192_DISP_AAL0_SEL_IN, MT8192_AAL0_SEL_IN_CCORR0
>> +	}, {
>> +		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
>> +		MT8192_DISP_DSI0_SEL_IN, MT8192_DSI0_SEL_IN_DITHER0
>> +	}, {
>> +		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
>> +		MT8192_DISP_RDMA0_SOUT_SEL, MT8192_RDMA0_SOUT_COLOR0
>> +	}, {
>> +		DDP_COMPONENT_CCORR, DDP_COMPONENT_AAL0,
>> +		MT8192_DISP_CCORR0_SOUT_SEL, MT8192_CCORR0_SOUT_AAL0
>> +	}, {
>> +		DDP_COMPONENT_OVL0, DDP_COMPONENT_OVL_2L0,
>> +		MT8192_MMSYS_OVL_MOUT_EN, MT8192_DISP_OVL0_GO_BG,
>> +	}, {
>> +		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
>> +		MT8192_MMSYS_OVL_MOUT_EN, MT8192_DISP_OVL0_2L_GO_BLEND,
>> +	}
>> +};
>> +
>> +#endif /* __SOC_MEDIATEK_MT8192_MMSYS_H */
>> +
>> diff --git a/drivers/soc/mediatek/mtk-mmsys.c
>> b/drivers/soc/mediatek/mtk-mmsys.c
>> index 79e5515..c755617 100644
>> --- a/drivers/soc/mediatek/mtk-mmsys.c
>> +++ b/drivers/soc/mediatek/mtk-mmsys.c
>> @@ -12,6 +12,7 @@
>>  
>>  #include "mtk-mmsys.h"
>>  #include "mt8183-mmsys.h"
>> +#include "mt8192-mmsys.h"
>>  
>>  static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data =
>> {
>>  	.clk_driver = "clk-mt2701-mm",
>> @@ -45,6 +46,12 @@
>>  	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
>>  };
>>  
>> +static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data =
>> {
>> +	.clk_driver = "clk-mt8192-mm",
>> +	.routes = mmsys_mt8192_routing_table,
>> +	.num_routes = ARRAY_SIZE(mmsys_mt8192_routing_table),
>> +};
>> +
>>  struct mtk_mmsys {
>>  	void __iomem *regs;
>>  	const struct mtk_mmsys_driver_data *data;
> 
> Hi Yongqiang,
> 
> There is 8192 mmsys compatible data in [1], but seems to lack of it in
> this patch, because mm clock driver will be bound to platform device 
> in mtk_mmsys_probe.
> 
> [1] 
> https://patchwork.kernel.org/project/linux-mediatek/patch/1609815993-22744-11-git-send-email-yongqiang.niu@mediatek.com/

Yes, you should add a match in of_match_mtk_mmsys[] for the compatbile. The
clock driver should be implemented as a platform device.

Regards,
Matthias

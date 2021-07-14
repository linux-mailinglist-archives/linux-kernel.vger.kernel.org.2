Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A873C8854
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhGNQHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhGNQHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:07:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B845C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:04:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f17so3878504wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KeoHpRgYUTJ0S5+Hv5ew+oefqraw0KaZeuZmCofRk54=;
        b=txAceZx/B7qal36RxAdz+Glxy+07f7XoLNjmkEaANwvBt+VapKxDrHktJcgt7JWJ3Q
         YDPjTdw2zh+eqz3WUcwST1A6+1mHeN3wC6AYIRolotq29Rfe14eY/wg9rlPGkIcxNi77
         +xvLLBqpFZPjs0zdh1A3Q9DmtJzchgVOHQMpifFzqXqq+UFbKrmZEPuQA5hbVnWYm3I4
         du7uw5iwRC8MczfazKNG0T7fLgXWiXi/P+sxWer6i9qL8hiGNTjJMJYE3raI8/IqvQnE
         j2KSUy/OJAYewZx2BlrCFWJHe9WjDI1HS22TLhCPDmjv8B9X1xR46cTdTkTYruFUhEAo
         0uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KeoHpRgYUTJ0S5+Hv5ew+oefqraw0KaZeuZmCofRk54=;
        b=p6T1YSjqtJaDOgldRMpf6NrnaSh8yGcGTlaA6JsBynCxvqstjIwfXBTluaTzPVGI19
         qz8EknCH9ahN6RrxHvAdaARQv+beBHvUklqN52+gCkYYaABTcwstZHoGm2MtFugxCVvb
         aII2eq+SILwbGzdxNGX1OXxrXdzR4vaJTFy6tIlk6fAg5IrJKwuFTEtQUWT1ryF0h8xC
         6xV2M5hCHp8lCu0B6Kn41FcOZxrOAwoXaSDruRxF+2jfsZgnTE6NwsL7sUo1IGZ7w7Sc
         DVso9DuAZRzbKa00pqn/1Xd2QAAJRsYeZ1DmwFPxbbCtOSViCTtCibepkqpB7B8fbFr0
         X/9A==
X-Gm-Message-State: AOAM533hJ17KFYHe8TVfbJ1KjI2A5dDBSddx0FZXGpxF4C+PzvQAWsRP
        8qeoUG/6KYYUNiDOTRcbRbY=
X-Google-Smtp-Source: ABdhPJyl8djWloOoHKBbA9OsBIuhFO8YaWtV729KyXlkdLVyqBsQ4pgctjCZ4I7Q3T/YB2CHUdxqNA==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr14233461wro.311.1626278692971;
        Wed, 14 Jul 2021 09:04:52 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id r9sm2315778wmq.25.2021.07.14.09.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 09:04:51 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] soc: mediatek: add mtk-mutex support for mt8195
 vdosys0
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>, chunkuang.hu@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        fshao@google.com, nancy.lin@mediatek.com, singo.chang@mediatek.com
References: <20210710113819.5170-1-jason-jh.lin@mediatek.com>
 <20210710113819.5170-7-jason-jh.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <aa0a598d-574f-427a-b9b9-a24364202779@gmail.com>
Date:   Wed, 14 Jul 2021 18:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210710113819.5170-7-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/2021 13:38, jason-jh.lin wrote:
> Add mtk-mutex support for mt8195 vdosys0.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-mutex.c | 107 +++++++++++++++++++++++++++++--
>  1 file changed, 102 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> index 2e4bcc300576..d74eb3f97f1d 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -17,6 +17,9 @@
>  #define MT8183_MUTEX0_MOD0			0x30
>  #define MT8183_MUTEX0_SOF0			0x2c
>  
> +#define MT8195_DISP_MUTEX0_MOD0			0x30
> +#define MT8195_DISP_MUTEX0_SOF			0x2c
> +
>  #define DISP_REG_MUTEX_EN(n)			(0x20 + 0x20 * (n))
>  #define DISP_REG_MUTEX(n)			(0x24 + 0x20 * (n))
>  #define DISP_REG_MUTEX_RST(n)			(0x28 + 0x20 * (n))
> @@ -67,6 +70,36 @@
>  #define MT8173_MUTEX_MOD_DISP_PWM1		24
>  #define MT8173_MUTEX_MOD_DISP_OD		25
>  
> +#define MT8195_MUTEX_MOD_DISP_OVL0		0
> +#define MT8195_MUTEX_MOD_DISP_WDMA0		1
> +#define MT8195_MUTEX_MOD_DISP_RDMA0		2
> +#define MT8195_MUTEX_MOD_DISP_COLOR0		3
> +#define MT8195_MUTEX_MOD_DISP_CCORR0		4
> +#define MT8195_MUTEX_MOD_DISP_AAL0		5
> +#define MT8195_MUTEX_MOD_DISP_GAMMA0		6
> +#define MT8195_MUTEX_MOD_DISP_DITHER0		7
> +#define MT8195_MUTEX_MOD_DISP_DSI0		8
> +#define MT8195_MUTEX_MOD_DISP_DSC_WRAP0_CORE0	9
> +#define MT8195_MUTEX_MOD_DISP_OVL1		10
> +#define MT8195_MUTEX_MOD_DISP_WDMA1		11
> +#define MT8195_MUTEX_MOD_DISP_RDMA1		12
> +#define MT8195_MUTEX_MOD_DISP_COLOR1		13
> +#define MT8195_MUTEX_MOD_DISP_CCORR1		14
> +#define MT8195_MUTEX_MOD_DISP_AAL1		15
> +#define MT8195_MUTEX_MOD_DISP_GAMMA1		16
> +#define MT8195_MUTEX_MOD_DISP_DITHER1		17
> +#define MT8195_MUTEX_MOD_DISP_DSI1		18
> +#define MT8195_MUTEX_MOD_DISP_DSC_WRAP0_CORE1	19
> +#define MT8195_MUTEX_MOD_DISP_VPP_MERGE		20
> +#define MT8195_MUTEX_MOD_DISP_DP_INTF0		21
> +#define MT8195_MUTEX_MOD_DISP_VPP1_DL_RELAY0	22
> +#define MT8195_MUTEX_MOD_DISP_VPP1_DL_RELAY1	23
> +#define MT8195_MUTEX_MOD_DISP_VDO1_DL_RELAY2	24
> +#define MT8195_MUTEX_MOD_DISP_VDO0_DL_RELAY3	25
> +#define MT8195_MUTEX_MOD_DISP_VDO0_DL_RELAY4	26
> +#define MT8195_MUTEX_MOD_DISP_PWM0		27
> +#define MT8195_MUTEX_MOD_DISP_PWM1		28
> +
>  #define MT2712_MUTEX_MOD_DISP_PWM2		10
>  #define MT2712_MUTEX_MOD_DISP_OVL0		11
>  #define MT2712_MUTEX_MOD_DISP_OVL1		12
> @@ -101,11 +134,36 @@
>  #define MT2712_MUTEX_SOF_DSI3			6
>  #define MT8167_MUTEX_SOF_DPI0			2
>  #define MT8167_MUTEX_SOF_DPI1			3
> +
>  #define MT8183_MUTEX_SOF_DSI0			1
>  #define MT8183_MUTEX_SOF_DPI0			2
>  
> -#define MT8183_MUTEX_EOF_DSI0			(MT8183_MUTEX_SOF_DSI0 << 6)
> -#define MT8183_MUTEX_EOF_DPI0			(MT8183_MUTEX_SOF_DPI0 << 6)
> +#define MT8183_MUTEX_EOF_CONVERT(sof)	((sof) << 6)
> +#define MT8183_MUTEX_EOF_DSI0 \
> +	MT8183_MUTEX_EOF_CONVERT(MT8183_MUTEX_SOF_DSI0)
> +#define MT8183_MUTEX_EOF_DPI0 \
> +	MT8183_MUTEX_EOF_CONVERT(MT8183_MUTEX_SOF_DPI0)

Not needed here, please drop.

> +
> +#define MT8195_MUTEX_SOF_DSI0			1
> +#define MT8195_MUTEX_SOF_DSI1			2
> +#define MT8195_MUTEX_SOF_DP_INTF0		3
> +#define MT8195_MUTEX_SOF_DP_INTF1		4
> +#define MT8195_MUTEX_SOF_DPI0			6 /* for HDMI_TX */
> +#define MT8195_MUTEX_SOF_DPI1			5 /* for digital video out */
> +
> +#define MT8195_MUTEX_EOF_CONVERT(sof)	((sof) << 7)

Same here.

Regards,
Matthias

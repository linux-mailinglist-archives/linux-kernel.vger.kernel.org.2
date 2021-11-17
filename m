Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A254547CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbhKQNxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbhKQNxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:53:44 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BA4C061570;
        Wed, 17 Nov 2021 05:50:45 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so2190740wmd.1;
        Wed, 17 Nov 2021 05:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xBxipzjATkt55wg+4IoNm4uk0hAivd514jMf6Kcw/FM=;
        b=OOUgU+m4H6/c1+8tPBYgJTglkzF+N0PsP1nXfwaWUSl0K20l1uyRdCthcASF8wpfWZ
         F2SBlvngKsaq5l46ahXaCM9MeUJP6hZ2ixst3hRsEZWqbgPgw0pqJKENfUclTIy7yHGV
         ELuWfUp/93iMvrZPWSs0biDH2687gXR2Obo02fR0wMRL10CmQN+lbIV35T5sIQ4BkgO4
         5xUjwBPsmDgZq3stpLqhlEJYFWbJsQ8OUFMi0kuG0INu2SUf1FIH8Ab6Pf+7vgjJtjRo
         OpX3174kZdOv43gnWpscWcpIJ6gyPVLamT69Zj8Bx+EoattV/XMo8y7v4c9/H+JMaThs
         5HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xBxipzjATkt55wg+4IoNm4uk0hAivd514jMf6Kcw/FM=;
        b=Ctm3iq/6DLI7H1R+rUiJFtiOa6cggEJDslw/k/FMF1LT3nI4LKK2h4I/Mdaw9ukYoj
         789KOY9tiGWKf8Pa1PyW99TzEAcXHh5GH/ciGPepImbo4LU6ft11XsTs707G0k5/DLNN
         PQL2KIn5cO6BTGFOKPGxD8lAneoemE/YxEXMKbI1Z/Xokws+KDjuKTDVbU4LKFG0P/TP
         O7ABVYxeTHIqBvfJL6+sa0z9rxYjuaeFoCTiuriA4B1cacdZl1ijFvb18tGxETR2XNln
         iQsEnvy4mESbR0rtLOn+YH0UZsxZ54IO5pJvBaWejZ0EhNiP+NZUVaco3MbTvDF7dez4
         nRMw==
X-Gm-Message-State: AOAM5324bZl13fKplHvUruWERZEpMCxX5aVBV172bjM2MzEATa43BP9m
        RKe/cXL8T7sTYN9s5cPd3l9Y7c7AX78=
X-Google-Smtp-Source: ABdhPJz/jGtiBVkJ6cPG+jFnrw5EJmmuDVPHMYaiRSDvJDZeFWzqzWjVRDr1Dq5rXqe1YdCTX+4HWQ==
X-Received: by 2002:a05:600c:3505:: with SMTP id h5mr78049482wmq.22.1637157044328;
        Wed, 17 Nov 2021 05:50:44 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id l4sm20022944wrv.94.2021.11.17.05.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 05:50:43 -0800 (PST)
Message-ID: <d4fdde8b-24e0-34ee-a517-766626f859d9@gmail.com>
Date:   Wed, 17 Nov 2021 14:50:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v15 4/4] spmi: mediatek: Add support for MT8195
Content-Language: en-US
To:     James Lo <james.lo@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Henry Chen <henryc.chen@mediatek.com>
References: <20211115042030.30293-1-james.lo@mediatek.com>
 <20211115042030.30293-5-james.lo@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211115042030.30293-5-james.lo@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/11/2021 05:20, James Lo wrote:
> Add spmi support for MT8195.
> Refine indent in spmi-mtk-pmif.c.
> 
> Signed-off-by: James Lo <james.lo@mediatek.com>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> Acked-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/spmi/spmi-mtk-pmif.c | 202 +++++++++++++++++++++++++----------
>   1 file changed, 145 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
> index 3283d0a5903c..ad511f2c3324 100644
> --- a/drivers/spmi/spmi-mtk-pmif.c
> +++ b/drivers/spmi/spmi-mtk-pmif.c
> @@ -105,51 +105,99 @@ enum pmif_regs {
>   };
>   
>   static const u32 mt6873_regs[] = {
> -	[PMIF_INIT_DONE] =	0x0000,
> -	[PMIF_INF_EN] =		0x0024,
> -	[PMIF_ARB_EN] =		0x0150,
> -	[PMIF_CMDISSUE_EN] =	0x03B4,
> -	[PMIF_TIMER_CTRL] =	0x03E0,
> -	[PMIF_SPI_MODE_CTRL] =	0x0400,
> -	[PMIF_IRQ_EVENT_EN_0] =	0x0418,
> -	[PMIF_IRQ_FLAG_0] =	0x0420,
> -	[PMIF_IRQ_CLR_0] =	0x0424,
> -	[PMIF_IRQ_EVENT_EN_1] =	0x0428,
> -	[PMIF_IRQ_FLAG_1] =	0x0430,
> -	[PMIF_IRQ_CLR_1] =	0x0434,
> -	[PMIF_IRQ_EVENT_EN_2] =	0x0438,
> -	[PMIF_IRQ_FLAG_2] =	0x0440,
> -	[PMIF_IRQ_CLR_2] =	0x0444,
> -	[PMIF_IRQ_EVENT_EN_3] =	0x0448,
> -	[PMIF_IRQ_FLAG_3] =	0x0450,
> -	[PMIF_IRQ_CLR_3] =	0x0454,
> -	[PMIF_IRQ_EVENT_EN_4] =	0x0458,
> -	[PMIF_IRQ_FLAG_4] =	0x0460,
> -	[PMIF_IRQ_CLR_4] =	0x0464,
> -	[PMIF_WDT_EVENT_EN_0] =	0x046C,
> -	[PMIF_WDT_FLAG_0] =	0x0470,
> -	[PMIF_WDT_EVENT_EN_1] =	0x0474,
> -	[PMIF_WDT_FLAG_1] =	0x0478,
> -	[PMIF_SWINF_0_ACC] =	0x0C00,
> -	[PMIF_SWINF_0_WDATA_31_0] =	0x0C04,
> -	[PMIF_SWINF_0_RDATA_31_0] =	0x0C14,
> -	[PMIF_SWINF_0_VLD_CLR] =	0x0C24,
> -	[PMIF_SWINF_0_STA] =	0x0C28,
> -	[PMIF_SWINF_1_ACC] =	0x0C40,
> -	[PMIF_SWINF_1_WDATA_31_0] =	0x0C44,
> -	[PMIF_SWINF_1_RDATA_31_0] =	0x0C54,
> -	[PMIF_SWINF_1_VLD_CLR] =	0x0C64,
> -	[PMIF_SWINF_1_STA] =	0x0C68,
> -	[PMIF_SWINF_2_ACC] =	0x0C80,
> -	[PMIF_SWINF_2_WDATA_31_0] =	0x0C84,
> -	[PMIF_SWINF_2_RDATA_31_0] =	0x0C94,
> -	[PMIF_SWINF_2_VLD_CLR] =	0x0CA4,
> -	[PMIF_SWINF_2_STA] =	0x0CA8,
> -	[PMIF_SWINF_3_ACC] =	0x0CC0,
> -	[PMIF_SWINF_3_WDATA_31_0] =	0x0CC4,
> -	[PMIF_SWINF_3_RDATA_31_0] =	0x0CD4,
> -	[PMIF_SWINF_3_VLD_CLR] =	0x0CE4, > -	[PMIF_SWINF_3_STA] =	0x0CE8,

Please fix format in patch 3/4.

> +	[PMIF_INIT_DONE] = 0x0000,
> +	[PMIF_INF_EN] = 0x0024,
> +	[PMIF_ARB_EN] = 0x0150,
> +	[PMIF_CMDISSUE_EN] = 0x03B4,
> +	[PMIF_TIMER_CTRL] = 0x03E0,
> +	[PMIF_SPI_MODE_CTRL] = 0x0400,
> +	[PMIF_IRQ_EVENT_EN_0] = 0x0418,
> +	[PMIF_IRQ_FLAG_0] = 0x0420,
> +	[PMIF_IRQ_CLR_0] = 0x0424,
> +	[PMIF_IRQ_EVENT_EN_1] = 0x0428,
> +	[PMIF_IRQ_FLAG_1] = 0x0430,
> +	[PMIF_IRQ_CLR_1] = 0x0434,
> +	[PMIF_IRQ_EVENT_EN_2] = 0x0438,
> +	[PMIF_IRQ_FLAG_2] = 0x0440,
> +	[PMIF_IRQ_CLR_2] = 0x0444,
> +	[PMIF_IRQ_EVENT_EN_3] = 0x0448,
> +	[PMIF_IRQ_FLAG_3] = 0x0450,
> +	[PMIF_IRQ_CLR_3] = 0x0454,
> +	[PMIF_IRQ_EVENT_EN_4] = 0x0458,
> +	[PMIF_IRQ_FLAG_4] = 0x0460,
> +	[PMIF_IRQ_CLR_4] = 0x0464,
> +	[PMIF_WDT_EVENT_EN_0] = 0x046C,
> +	[PMIF_WDT_FLAG_0] = 0x0470,
> +	[PMIF_WDT_EVENT_EN_1] = 0x0474,
> +	[PMIF_WDT_FLAG_1] = 0x0478,
> +	[PMIF_SWINF_0_ACC] = 0x0C00,
> +	[PMIF_SWINF_0_WDATA_31_0] = 0x0C04,
> +	[PMIF_SWINF_0_RDATA_31_0] = 0x0C14,
> +	[PMIF_SWINF_0_VLD_CLR] = 0x0C24,
> +	[PMIF_SWINF_0_STA] = 0x0C28,
> +	[PMIF_SWINF_1_ACC] = 0x0C40,
> +	[PMIF_SWINF_1_WDATA_31_0] = 0x0C44,
> +	[PMIF_SWINF_1_RDATA_31_0] = 0x0C54,
> +	[PMIF_SWINF_1_VLD_CLR] = 0x0C64,
> +	[PMIF_SWINF_1_STA] = 0x0C68,
> +	[PMIF_SWINF_2_ACC] = 0x0C80,
> +	[PMIF_SWINF_2_WDATA_31_0] = 0x0C84,
> +	[PMIF_SWINF_2_RDATA_31_0] = 0x0C94,
> +	[PMIF_SWINF_2_VLD_CLR] = 0x0CA4,
> +	[PMIF_SWINF_2_STA] = 0x0CA8,
> +	[PMIF_SWINF_3_ACC] = 0x0CC0,
> +	[PMIF_SWINF_3_WDATA_31_0] = 0x0CC4,
> +	[PMIF_SWINF_3_RDATA_31_0] = 0x0CD4,
> +	[PMIF_SWINF_3_VLD_CLR] = 0x0CE4,
> +	[PMIF_SWINF_3_STA] = 0x0CE8,
> +};
> +
> +static const u32 mt8195_regs[] = {
> +	[PMIF_INIT_DONE] = 0x0000,
> +	[PMIF_INF_EN] = 0x0024,
> +	[PMIF_ARB_EN] = 0x0150,
> +	[PMIF_CMDISSUE_EN] = 0x03B8,
> +	[PMIF_TIMER_CTRL] = 0x03E4,
> +	[PMIF_SPI_MODE_CTRL] = 0x0408,
> +	[PMIF_IRQ_EVENT_EN_0] = 0x0420,
> +	[PMIF_IRQ_FLAG_0] = 0x0428,
> +	[PMIF_IRQ_CLR_0] = 0x042C,
> +	[PMIF_IRQ_EVENT_EN_1] = 0x0430,
> +	[PMIF_IRQ_FLAG_1] = 0x0438,
> +	[PMIF_IRQ_CLR_1] = 0x043C,
> +	[PMIF_IRQ_EVENT_EN_2] = 0x0440,
> +	[PMIF_IRQ_FLAG_2] = 0x0448,
> +	[PMIF_IRQ_CLR_2] = 0x044C,
> +	[PMIF_IRQ_EVENT_EN_3] = 0x0450,
> +	[PMIF_IRQ_FLAG_3] = 0x0458,
> +	[PMIF_IRQ_CLR_3] = 0x045C,
> +	[PMIF_IRQ_EVENT_EN_4] = 0x0460,
> +	[PMIF_IRQ_FLAG_4] = 0x0468,
> +	[PMIF_IRQ_CLR_4] = 0x046C,
> +	[PMIF_WDT_EVENT_EN_0] = 0x0474,
> +	[PMIF_WDT_FLAG_0] = 0x0478,
> +	[PMIF_WDT_EVENT_EN_1] = 0x047C,
> +	[PMIF_WDT_FLAG_1] = 0x0480,
> +	[PMIF_SWINF_0_ACC] = 0x0800,
> +	[PMIF_SWINF_0_WDATA_31_0] = 0x0804,
> +	[PMIF_SWINF_0_RDATA_31_0] = 0x0814,
> +	[PMIF_SWINF_0_VLD_CLR] = 0x0824,
> +	[PMIF_SWINF_0_STA] = 0x0828,
> +	[PMIF_SWINF_1_ACC] = 0x0840,
> +	[PMIF_SWINF_1_WDATA_31_0] = 0x0844,
> +	[PMIF_SWINF_1_RDATA_31_0] = 0x0854,
> +	[PMIF_SWINF_1_VLD_CLR] = 0x0864,
> +	[PMIF_SWINF_1_STA] = 0x0868,
> +	[PMIF_SWINF_2_ACC] = 0x0880,
> +	[PMIF_SWINF_2_WDATA_31_0] = 0x0884,
> +	[PMIF_SWINF_2_RDATA_31_0] = 0x0894,
> +	[PMIF_SWINF_2_VLD_CLR] = 0x08A4,
> +	[PMIF_SWINF_2_STA] = 0x08A8,
> +	[PMIF_SWINF_3_ACC] = 0x08C0,
> +	[PMIF_SWINF_3_WDATA_31_0] = 0x08C4,
> +	[PMIF_SWINF_3_RDATA_31_0] = 0x08D4,
> +	[PMIF_SWINF_3_VLD_CLR] = 0x08E4,
> +	[PMIF_SWINF_3_STA] = 0x08E8,
>   };
>   
>   enum spmi_regs {
> @@ -165,21 +213,52 @@ enum spmi_regs {
>   	SPMI_REC3,
>   	SPMI_REC4,
>   	SPMI_MST_DBG,
> +
> +	/* MT8195 spmi regs */
> +	SPMI_MST_RCS_CTRL,
> +	SPMI_SLV_3_0_EINT,
> +	SPMI_SLV_7_4_EINT,
> +	SPMI_SLV_B_8_EINT,
> +	SPMI_SLV_F_C_EINT,
> +	SPMI_REC_CMD_DEC,
> +	SPMI_DEC_DBG,
>   };
>   
>   static const u32 mt6873_spmi_regs[] = {
> -	[SPMI_OP_ST_CTRL] =	0x0000,
> -	[SPMI_GRP_ID_EN] =	0x0004,
> -	[SPMI_OP_ST_STA] =	0x0008,
> -	[SPMI_MST_SAMPL] =	0x000c,
> -	[SPMI_MST_REQ_EN] =	0x0010,
> -	[SPMI_REC_CTRL] =	0x0040,
> -	[SPMI_REC0] =		0x0044,
> -	[SPMI_REC1] =		0x0048,
> -	[SPMI_REC2] =		0x004c,
> -	[SPMI_REC3] =		0x0050,
> -	[SPMI_REC4] =		0x0054,
> -	[SPMI_MST_DBG] =	0x00fc,

Same here.

Regards,
Matthias

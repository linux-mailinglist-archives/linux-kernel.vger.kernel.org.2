Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC02E3555D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbhDFNzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344800AbhDFNzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:55:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB2C06174A;
        Tue,  6 Apr 2021 06:55:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l76so10397211pga.6;
        Tue, 06 Apr 2021 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qzi+xZuEe7YL8nR3XrQA5qGB550pcYqlu0ZeykRMdAg=;
        b=HaE3Y5iTRVyhOC5Hr9Zn3j3wRMmZbn1X3zNXgGA1HvrJZDXYf4Z9TrzYbbh6jfpG1O
         UXXpfv7qZ1GuDaMguK5iyZBqD6NQs8gydcdl7BRU9bosmQhCwN+fRH06n273M6JkwCzr
         SwgDLz/bP03NhL6/VwvLbw49xsBl2ISaBe7GjkHTEWiEubMz4HUQr3piwvvBN4ak/DFH
         KwnvpEC1l9ra1lHNjjcgCLuXTjCr4Toa2ojx0vBcC/+I6279Qo+xzofTdZx3JudEXOlc
         UY68t3KR6rodYZGy03eWcOA2lBrt98rdx5IvWB8WBKG0JaSuwCipb189LjKNlxcyfK+9
         3YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qzi+xZuEe7YL8nR3XrQA5qGB550pcYqlu0ZeykRMdAg=;
        b=EIPqeRC7A8PjtLMkHiZZMGCLxTHJH/MoiWkoNEooTaIFbnudZA5XjNqxfKv781eoji
         j9vOl1R0EUjshFEXvFMpIchgDUrEspnHyU7W8RZYa2wkdmQAZsK5+WYdex+t/kWaCxRH
         S3Bq3D9Csl8AtMVSr+R0nJ0k5RW4GvY8HAv+ONRrwoBkHp1/DwGsAgYGG+3nvBjFV1jH
         rf9W98uBcHQc3BO47VSeoPRMDT1PPbgxabJpQi6sXwBgZahjvKifX0/dKrmzKmtkNtnN
         lmlLoKKtw/y3FRS6uyl/Dj6LMkP/gR+KGQlhofxbbB6qokGEwATfg3Z75QC16axbINsX
         8T2w==
X-Gm-Message-State: AOAM530IfuxHVPNQwlrmIrb/g7RXnsF/6nsvBKKUgpUc1CuElTHgbzVt
        Oua9HCCrHyEu8Eb3q99/n0g=
X-Google-Smtp-Source: ABdhPJzu7pyeVqM0Lx3pmuMpeUTlU8rx58GW0kCSbh3X33ZJScOrnqfvqW6yYkSrhFiNZsDxN2KipA==
X-Received: by 2002:a63:d61:: with SMTP id 33mr27507180pgn.201.1617717326012;
        Tue, 06 Apr 2021 06:55:26 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id d13sm19081937pgb.6.2021.04.06.06.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:55:25 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] soc: mediatek: devapc: support mt8192
To:     Nina Wu <nina-cm.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Jackson-kt.Chang@mediatek.com
References: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
 <1617259087-5502-6-git-send-email-nina-cm.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <f52189e3-26b2-fd44-7059-f3bf0f79fbae@gmail.com>
Date:   Tue, 6 Apr 2021 15:55:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1617259087-5502-6-git-send-email-nina-cm.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/04/2021 08:38, Nina Wu wrote:
> From: Nina Wu <Nina-CM.Wu@mediatek.com>
> 
> Add compatible to support mt8192.
> 
> Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
> ---


Looks good, I'd like to see DTS for this as well, although I understand it
depends on the clock patch series. Please note so in either below the '---' or
in a cover letter.

Regards,
Matthias


>  drivers/soc/mediatek/mtk-devapc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
> index af55c01..a5c15b5 100644
> --- a/drivers/soc/mediatek/mtk-devapc.c
> +++ b/drivers/soc/mediatek/mtk-devapc.c
> @@ -251,11 +251,26 @@ static const struct mtk_devapc_data devapc_mt6779 = {
>  	.vio_shift_con_offset = 0xF20,
>  };
>  
> +static const struct mtk_devapc_data devapc_mt8192 = {
> +	.vio_mask_offset = 0x0,
> +	.vio_sta_offset = 0x400,
> +	.vio_dbg0_offset = 0x900,
> +	.vio_dbg1_offset = 0x904,
> +	.vio_dbg2_offset = 0x908,
> +	.apc_con_offset = 0xF00,
> +	.vio_shift_sta_offset = 0xF20,
> +	.vio_shift_sel_offset = 0xF30,
> +	.vio_shift_con_offset = 0xF10,
> +};
> +
>  static const struct of_device_id mtk_devapc_dt_match[] = {
>  	{
>  		.compatible = "mediatek,mt6779-devapc",
>  		.data = &devapc_mt6779,
>  	}, {
> +		.compatible = "mediatek,mt8192-devapc",
> +		.data = &devapc_mt8192,
> +	}, {
>  	},
>  };
>  
> 

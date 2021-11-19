Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A955B456E87
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhKSL4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhKSL4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:56:40 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA51C061574;
        Fri, 19 Nov 2021 03:53:38 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w29so17676740wra.12;
        Fri, 19 Nov 2021 03:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oR+4Ugm243EsWWYHBT9vURlenDoMi3/hy1iFqPAmvS8=;
        b=MGFOlH5IHYuiXtFmz2gc83iHKFHpx65rDT3iE3Ev6o0WJLcVUFPTCKTYHs7zIyGVyD
         SYwRnT/xAz30tntNWlTpUqyk3fCV3NjHRNeGfyjTKE19U2h0+SJc7P3/juMRK0Ha+G0m
         tWGfZTsAMOVRUoOLZVw8I/lrvVrgUTEOd28DIN8V/3l/bslPYWIanKSb7np+IBr4X/eG
         PywaeRinsQXYpwHfazA1K4wXFdeeDG1AyeVG0W2Czaj/I+kwZLWeUNd2kba/HRm4ksK6
         NXbAwCqyP1mueldg83SzVgG/csreiw5GfX58FAKq7y4zTvuI29u1R3TK8GxHfoeVbwOV
         NxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oR+4Ugm243EsWWYHBT9vURlenDoMi3/hy1iFqPAmvS8=;
        b=uDo31dXm/ftlnJyDv3j+Q/h6HUCLmtcZFIHytOcXW7Vqp4X6hWeAUD8dLMMc48zmQp
         AbrSgkRuBCFs0olZNSe3O+orTMkWn74EI9OBnRC+x6kvM2Pqz50hAxmEufIjVn3GgiNJ
         FkSzlhjONBK6mNAQHJf1TezBlDnnvEhAUDeQFX93kpcYAAXandC3W17FWde942K6V8YN
         dOzVfJq88uv7u7eJqE50PdaRueQEM6bzLMjc1IGbmlE8SOZju8rhABOvvxqftxMMS9ct
         Kfw9TQUgOK2tkodPPOABd7PK398QMxMsYWGR9Ttxslv0AlV2xNoVuSWcmQuwQWCCbyij
         keiQ==
X-Gm-Message-State: AOAM531et94dpqi8RY26u+oWsU4g25CkDq1KnxkJNq1Kd7w/sPuck/20
        eJakLNJBb33GoJfoHsN2oA4=
X-Google-Smtp-Source: ABdhPJzQsLrtW0In3DEbR+IjqSiaaiOSFxUzGF2EBp+WZZTiEtq1c8MEOsgteKa0jy7YjN4CA3+d5w==
X-Received: by 2002:a05:6000:252:: with SMTP id m18mr6536146wrz.117.1637322817365;
        Fri, 19 Nov 2021 03:53:37 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id v15sm2747012wro.35.2021.11.19.03.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 03:53:36 -0800 (PST)
Message-ID: <4dd739b0-bed7-d932-d56c-96b20143ee79@gmail.com>
Date:   Fri, 19 Nov 2021 12:53:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] clk/mediatek: fix missing null-check for mt7622
Content-Language: en-US
To:     Chengfeng Ye <cyeaa@connect.ust.hk>, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20211030140740.6947-1-cyeaa@connect.ust.hk>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211030140740.6947-1-cyeaa@connect.ust.hk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/2021 16:07, Chengfeng Ye wrote:
> The return pointer of mtk_alloc_clk_data could
> be null, adding null check for all the call sites.
> 
> Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>

This pattern is seen in nearly all MediaTek clock drivers. Is there any specific 
reason that you only fix the three?

Would you mind to check all of them and send the patches as a series instead of 
every patch one by one?

Regards,
Matthias

> ---
>   drivers/clk/mediatek/clk-mt7622.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
> index ef5947e15c75..f16b3655ff76 100644
> --- a/drivers/clk/mediatek/clk-mt7622.c
> +++ b/drivers/clk/mediatek/clk-mt7622.c
> @@ -620,6 +620,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
>   		return PTR_ERR(base);
>   
>   	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
>   
>   	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
>   				    clk_data);
> @@ -650,6 +652,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
>   	int r;
>   
>   	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
>   
>   	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
>   			       clk_data);
> @@ -700,6 +704,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
>   		return PTR_ERR(base);
>   
>   	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
>   
>   	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
>   			       clk_data);
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4EC326458
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhBZOsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhBZOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:48:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148BDC06174A;
        Fri, 26 Feb 2021 06:47:33 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l18so6224697pji.3;
        Fri, 26 Feb 2021 06:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=06hoVuL+4FkXVA5D70wEqeJNXy4eA4qnPKR2e/Lq8tI=;
        b=GybIpNgNKurPC5wMmuAKUv1px2nTFUQkPadiGBtJl7j3Y40Eu4ATUSNW1cju9DooDH
         TKYQqvoj+HlZ//KC2DKuoKuCy+wlbAIuw0qYxS6wh2Sj8bRAuT+qoAPuPTUX6324lmY/
         qzLx97pLBaMw526GvVB84kV7m9QAJ4DjV8GbamwZWb5Hqwc0X7UvNkCAo/Qs0Q5xVXRe
         j0rBxb1AHoOUOgjz2Ozzi1WAtdSD4MSWTx5Y7h4pJjQvkX4aXkkSQsjvxF8f8sJckwtQ
         3vYti+TPYBqmuy922KUy/176T5J5i34eBI4I19jsGiUV0tqzQu1U7fBGBRvv+hraMcN0
         PNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=06hoVuL+4FkXVA5D70wEqeJNXy4eA4qnPKR2e/Lq8tI=;
        b=uFq8hiZW19WKFfbgvRAd2PoJ9ozfRAt0mibWqh5fFbsU2ZF5XeOrMGQ0Lp+tRLluHm
         e8diyH/bQyV+zSvw3fcOGKJpX/C4Sc2sphtd6+uLWENgcfL3rewTpUcEiuOrBPpX3835
         8USd1rim0aVzdbKTkwuVDEHXZE27rJoIta+OpMppU3kXG0O0okWcHTX2NaLo80yLLcLM
         mVLfMRMjptomWZ5AifVR6T5Wo0KrzudCTDyWDnyzgApYQd3G7NF6C2GtRBM3SwZjl4/K
         sYjHmayVtc99G0Uqq+MQw1RWOury0kcpPLiTNG5Njl7lKLbZ8zictblffciT9wRqITtb
         bIwg==
X-Gm-Message-State: AOAM531W06bai5YO3IY/vy0rFAm3VMBZ0twiKv0GMRW14RMR/1OvzRYz
        VugOpHocXGCvqiWp85P7z3Y=
X-Google-Smtp-Source: ABdhPJy6+B41oTn4lehC44EJr5d4guyexK7uc0xzPWi86zzobJ/b+P61+cY1dlPrVfdKHUAVmSfhjg==
X-Received: by 2002:a17:902:7898:b029:e4:182f:e31d with SMTP id q24-20020a1709027898b02900e4182fe31dmr3524091pll.13.1614350852531;
        Fri, 26 Feb 2021 06:47:32 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id k69sm10042620pfd.4.2021.02.26.06.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 06:47:31 -0800 (PST)
Subject: Re: [RFC 05/19] devfreq: imx8m-ddrc: Change governor to powersave
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
 <1613750416-11901-6-git-send-email-abel.vesa@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <28f71f5f-9fad-38ed-340a-6086b002f5c3@gmail.com>
Date:   Fri, 26 Feb 2021 23:47:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1613750416-11901-6-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21. 2. 20. 오전 1:00, Abel Vesa wrote:
> By switching to powersave governor, we allow the imx8m-ddrc to always
> run at minimum rate needed by all the running masters.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>   drivers/devfreq/imx8m-ddrc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index bc82d3653bff..3a6c04ba4f2e 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -379,7 +379,7 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct imx8m_ddrc *priv;
> -	const char *gov = DEVFREQ_GOV_USERSPACE;
> +	const char *gov = DEVFREQ_GOV_POWERSAVE;
>   	int ret;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB4D3EDD22
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhHPSfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhHPSfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:35:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C3BC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:34:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g13so36270944lfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uFoizD91rABkFIcWHSzEWuX3hfrFZBSWrwl/QtKpAiU=;
        b=oFNy3cH0ASHTjVBWzJXJtojGzpn3ptld69kfnNagomXNGKcQaRdAxvH6yh51NmocmG
         MBXis16EBBwqcs+XiKcAzL5rwoH/OT/gMIGkGPj1yI2h4nOSsUl/ZhNLcdYRPIkQJZib
         aNIvVnVncu5G4g2ZNovJ3n4yvSGUgyE7NZl7Uq3a4JzZPmLg/cSPGtYqdNHtfV1SOeiH
         nJ8J55kXehL9kDQOFiCmn8PWMKSqjEfGM/5Q2g6Bl1TWAhTaRakqLdGntxed5gWXQqSg
         aaHwYXzldWnJ4NrIOIh9w38zlNdEWxLjD44TmfCopZQS5pRcsj+jD0tQoiY71SBao2sD
         /iWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uFoizD91rABkFIcWHSzEWuX3hfrFZBSWrwl/QtKpAiU=;
        b=qkqG1dpjLfSUZTCPS2T8RQB6mXBklVCYrVSz5RgIywf/G+eOdxXYUVoGPXcDG+fWFR
         KALezPW5Q8j2S1eZv6ylxN/Yfqq2kULSkjAWWbaws+zf3nOjVigtiuH7NVZi+FJrDj/Q
         AUHf22A7gNnU/9Vwj/GV4NRoT17aS4yIgbbbFZR3QQUmie2H/kqPsGm6P9/AzD01E5r0
         cYGChd5daI2DIjJ5479Li/HWIzYutfY00jE882x4VmcPoN5X2O7hSzgUZkm/Oj/naNAY
         MymXAimiatH7KfHaFACc2Z7HRHM9IeriYk0dnvF9BHXfe/AtkM2uWZXeGIM76I/YCfIi
         HzZA==
X-Gm-Message-State: AOAM532fHZNvrOoEXOJdJ1unzQUWxv8Ii4T0puHOidck/U36/FmJOnGv
        XaWVhaei0ZI9FD0TmqKhdQU=
X-Google-Smtp-Source: ABdhPJziOViJn7QDLtX6gHrzZuO48V6h3j0n8idKXpMfINxC1WqPkQblzeiYIpUM7DO/U3MN0SQiPw==
X-Received: by 2002:a05:6512:3231:: with SMTP id f17mr12041211lfe.364.1629138896736;
        Mon, 16 Aug 2021 11:34:56 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id r3sm2379lfc.114.2021.08.16.11.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 11:34:56 -0700 (PDT)
Subject: Re: [PATCH 2/3] ASoC: ti: omap-mcbsp: Use of_device_get_match_data
To:     Aakash Hemadri <aakashhemadri123@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jawoslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>
References: <cover.1628972198.git.aakashhemadri123@gmail.com>
 <44f3b21198dd1e40e1e5e783db2b3dd76505b562.1628972198.git.aakashhemadri123@gmail.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <ed02b26b-d1cc-dfc2-ef35-1430677fb1df@gmail.com>
Date:   Mon, 16 Aug 2021 21:35:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <44f3b21198dd1e40e1e5e783db2b3dd76505b562.1628972198.git.aakashhemadri123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/08/2021 23:19, Aakash Hemadri wrote:
> Prefer `of_device_get_match_data` over `of_match_device`
> 
> Retrieve OF match data using `of_device_get_match_data`, this is cleaner
> and better expresses intent.
> 
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
>  sound/soc/ti/omap-mcbsp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
> index 4479d74f0a45..fcb651487854 100644
> --- a/sound/soc/ti/omap-mcbsp.c
> +++ b/sound/soc/ti/omap-mcbsp.c
> @@ -1373,7 +1373,7 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  	int ret;
>  
> -	match = of_match_device(omap_mcbsp_of_match, &pdev->dev);
> +	match = of_device_get_match_data(&pdev->dev);

Similarly incorrect,
of_device_get_match_data() is retrieving the match->data

>  	if (match) {
>  		struct device_node *node = pdev->dev.of_node;
>  		struct omap_mcbsp_platform_data *pdata_quirk = pdata;
> 

-- 
Péter

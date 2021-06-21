Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D555B3AE5ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhFUJZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:25:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40800 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhFUJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:24:59 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lvG8i-0000ch-OY
        for linux-kernel@vger.kernel.org; Mon, 21 Jun 2021 09:22:44 +0000
Received: by mail-ed1-f71.google.com with SMTP id cb4-20020a0564020b64b02903947455afa5so5640880edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9hRe7zjfZNvSRfKJkWKSh5Dej/dPL2l2W1UbNWsYK2U=;
        b=ogG0Q70ZiQOupLzFs36HzDd319gumjASTHl3tAL6HEccc/O/Eh91YGw3b64tRmBpZn
         c508X4Der3NIu6DQrCiv15whKETifqCUSOf4v2UF+maQRQtbGQkTwW5Q4iNI7y/58Cb3
         xArLxzEsxY+8Gfs7joRBcGAw0mXU/xTVgJbLhF1s9+Nb5/wJl8M0TfyEqzP/SCJinkT5
         Bc6TrWzjJbwn7lhVnqMbey8Qfymf0YX6wPGGFDJrpfFN/jIRGPG/s/KuYB2YX1otJIla
         VxnAO8LhynjP4YlWPQ2LFEgA2esZ62yrBt2EOchlFM59GAQ5CEDZb6mXV8qArMmGOlFu
         IQDg==
X-Gm-Message-State: AOAM5300E4OPqUpBjji28h40TR9dq2bv8FYGFYMevCR+Tf4oqLGhJunZ
        m80gklMefIf5xKGz21m1KrhnArfSepTpbWuX0IoXotQNJKuRETH8xLFdvfMdZlEfwTnQOB+VSG0
        Ga06DWdkyUgbHW1WJNaR3b0l3QJS7+Fq5zx8abYuh9Q==
X-Received: by 2002:aa7:ce86:: with SMTP id y6mr20052614edv.309.1624267364568;
        Mon, 21 Jun 2021 02:22:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdTF04BSdUZTAZjRPtmzyfYfNWL/XJ9f/4aweEYPF/XycKnP7nFSxN+HP8ORuLjmJWF1Se3g==
X-Received: by 2002:aa7:ce86:: with SMTP id y6mr20052598edv.309.1624267364414;
        Mon, 21 Jun 2021 02:22:44 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id df20sm10047400edb.76.2021.06.21.02.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 02:22:44 -0700 (PDT)
Subject: Re: [PATCH -next 2/4] ASoC: samsung: pcm: Use
 devm_platform_get_and_ioremap_resource()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     s.nawrocki@samsung.com, broonie@kernel.org
References: <20210616091652.2552927-1-yangyingliang@huawei.com>
 <20210616091652.2552927-3-yangyingliang@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <88808fcb-d89b-9e90-bd5e-c9074f373192@canonical.com>
Date:   Mon, 21 Jun 2021 11:22:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616091652.2552927-3-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2021 11:16, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  sound/soc/samsung/pcm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
> index bfd76e9cc0ca..4c4dfde0568f 100644
> --- a/sound/soc/samsung/pcm.c
> +++ b/sound/soc/samsung/pcm.c
> @@ -512,8 +512,7 @@ static int s3c_pcm_dev_probe(struct platform_device *pdev)
>  	/* Default is 128fs */
>  	pcm->sclk_per_fs = 128;
>  
> -	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	pcm->regs = devm_ioremap_resource(&pdev->dev, mem_res);
> +	pcm->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
>  	if (IS_ERR(pcm->regs))
>  		return PTR_ERR(pcm->regs);
>  
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof

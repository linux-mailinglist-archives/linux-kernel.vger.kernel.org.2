Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034A74348A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 12:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJTKMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 06:12:15 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60708
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhJTKMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:12:07 -0400
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 228733FFE7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634724592;
        bh=TR31enh52EtLPemABVvecmv1e4qo03jIZpvpMSfV0QE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=kA+trALnY5X9A7qeSFIyUniaiTswQOQDHVcQ0qq0xdWb/Y09q1aDZmZOcwIDRZScl
         HMYgWiKdox7Z7iPphPRjVPO1djSoamXC2DtRDwS96KOIlhJSw5gb95NXQt3+JCBeQn
         Ez8p+7LVl0LaOlUnHCXtDbLzV/7dlsaGJXjK+ImJ3zEG477h+FB5vgtPrPioSpj6Wx
         csurHd5H/89h18WVIzb0U9VCPSO4uEPs1k5RfKf4kXCvDqlG3/tuJqnbriPlRmmga9
         cw2QHhcilYsDVUu7BKp3Szc8yFECx4ii5G8moeoU+7R3vxpCrkBn2oxwc1vI6o8wpR
         a5ZWO0Q6wOTWg==
Received: by mail-lj1-f200.google.com with SMTP id w9-20020a2e9989000000b00210af61ebbdso1627255lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 03:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TR31enh52EtLPemABVvecmv1e4qo03jIZpvpMSfV0QE=;
        b=pYqH7Z0xt1e3IqOU++XzSwqBLs1L1xrEqSp30/0grAiBoKDPQW9NNGinSTdyy4W00J
         AmluRG4usiB1NOCcJRSj1yDZR3WCT3QYrSPUjcQarz8kB7L6vz+tWXZ4QdPzn7zFe4dr
         3ptcbdbWmm8gpr0PXbB2OmPimWSql/E1l0zMdEbedodRmBvtp9w009xEx64RHSU3pzxl
         g0d49QLqCnuC5mEFGE9CZPSSGhoTcsxcXx7B0H6uFuZ+FCSQCEAlC7p7sp8/iJFpvxpc
         o7MT3FFkmA4t85g3SJDpz5aeYV80T7N3tBrE+r/BSGyHxr6SWrDahv6a7IQuTW1AaT6t
         2BAQ==
X-Gm-Message-State: AOAM533AaNJ2R2Rzp22nEYyltL7AQsIZkkEMEX2mFAs8ciivsdh8/+cc
        eEWECqBzDVRq7usX4QsIfODDACjfLU7OoVsioYpPBVurEtHgRzbPZKkJRiyOKkq6eLa8cDDelck
        xggiR0AQmWgbI071VyZtPs1jVBxGMGETYjaL4YiafMA==
X-Received: by 2002:a2e:8e8a:: with SMTP id z10mr12472202ljk.102.1634724591303;
        Wed, 20 Oct 2021 03:09:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMw8tmUC2ubi2DJeQzC4XY2GeMIQa1zjfJ9Kr5Qrs7LPCjvfGARNfghc7xWtS7P3kutDdovA==
X-Received: by 2002:a2e:8e8a:: with SMTP id z10mr12472175ljk.102.1634724591039;
        Wed, 20 Oct 2021 03:09:51 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o13sm155571lfl.111.2021.10.20.03.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 03:09:50 -0700 (PDT)
Subject: Re: [PATCH] crypto: s5p-sss - Add error handling in s5p_aes_probe()
To:     Tang Bin <tangbin@cmss.chinamobile.com>, vz@mleia.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211020100348.42896-1-tangbin@cmss.chinamobile.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <8c043f4e-76e7-0b0b-dda8-c85623709f1f@canonical.com>
Date:   Wed, 20 Oct 2021 12:09:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211020100348.42896-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2021 12:03, Tang Bin wrote:
> The function s5p_aes_probe() does not perform sufficient error
> checking after executing platform_get_resource(), thus fix it.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/crypto/s5p-sss.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
> index 55aa3a711..7717e9e59 100644
> --- a/drivers/crypto/s5p-sss.c
> +++ b/drivers/crypto/s5p-sss.c
> @@ -2171,6 +2171,8 @@ static int s5p_aes_probe(struct platform_device *pdev)
>  
>  	variant = find_s5p_sss_version(pdev);
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
>  
>  	/*
>  	 * Note: HASH and PRNG uses the same registers in secss, avoid
> 

You need fixes and cc-stable:
Fixes: c2afad6c6105 ("crypto: s5p-sss - Add HASH support for Exynos")
Cc: <stable@vger.kernel.org>

With above added:
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof

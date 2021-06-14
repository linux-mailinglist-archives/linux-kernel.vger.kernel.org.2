Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6158F3A6773
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhFNNL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:11:57 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:43581 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbhFNNLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:11:53 -0400
Received: by mail-wm1-f47.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso12758617wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R81uREkUogO+0I18Z26XftVz6AP1SWmqajE8u/Zgwak=;
        b=ZDzj1DcTYJDDnMMrH9pPIe9zXsQZgj4quciaM6vTD+poAcJu9VFol+t4P61zd3Gvwa
         S/PoI8z72mftg8JnNBgWJfjW6htEKBAy73V/rd7u3SoZpa6bXl+C6CoMmZLk8R5DaTSW
         1FX1CynwJKuNxWVrgKuDMuwS+2wCfoc8GuQEkhqcvZ/52O2EKT2bmYHjEhFXymRBHbzb
         RywDDxyTizGHPB6DDVhLRyaxraMfQiRbx103UDeJRWqLTQ1mX1yxdwhGBVDf1YzJm2mW
         PEtDq4BZMAbQckPrkG3FHnzRLx5B9ghbxaXkp0SOfKLlyIqddKzs9BWPTawJkz006Z5F
         FFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=R81uREkUogO+0I18Z26XftVz6AP1SWmqajE8u/Zgwak=;
        b=JvDbQNqZ2NcxSGSkR4/lQSST8wPxiS4lF3kav+jXm/N6OTSvekHL5WsBXpUnANhw0j
         Wu0q+uXDZuBhGtJhSk5gHVJqRSTpOvDzfn4nH5UACnRUBMlXpRdLSDoWzfHGhKAGJCET
         NwNQfHRziSz4C+5++Hmi6Zvqy5PpsiZIvgqHjSLtKjpJKyqbAgiDdzS3mHZaA3QlXGG8
         QH5iuPfG0t2iji7UECu1cMr1X5O/lxLPWSid1igOmG4mGTpGO59qmDikoRazurtEyxQ9
         DdFSVRzy7+EhmSW5pvKhfgp/AecG6mzcR3uxPyqw3epMqyxGspZvhxGqIhxDp1+K475o
         FPYA==
X-Gm-Message-State: AOAM530/W74+u2YLvgbB3gtElkbpb5i/wCZ6gJFsrTUB9ynCb3T/gaKF
        6tzoHjyAy5fUMIjBhxz628+JV2GvAuVLT2v7
X-Google-Smtp-Source: ABdhPJzvOJIpH5I9fsn1C5b8nZomvpQk/22c28tDkwiaE/NCXB8ERgCGdtQ8w2UsbrpGkGyabOiuOQ==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr16341336wmk.97.1623676129021;
        Mon, 14 Jun 2021 06:08:49 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:f0d4:3c02:f06a:77bb? ([2a01:e0a:90c:e290:f0d4:3c02:f06a:77bb])
        by smtp.gmail.com with ESMTPSA id h18sm8957878wrs.64.2021.06.14.06.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 06:08:48 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] spi: meson-spicc: fix a wrong goto jump for
 avoiding memory leak.
To:     zpershuai <zpershuai@gmail.com>, Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1623562172-22056-1-git-send-email-zpershuai@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <b3ea2ad6-6341-df56-9d09-e3e832f8f316@baylibre.com>
Date:   Mon, 14 Jun 2021 15:08:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623562172-22056-1-git-send-email-zpershuai@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/06/2021 07:29, zpershuai wrote:
> In meson_spifc_probe function, when enable the device pclk clock is
> error, it should use clk_disable_unprepare to release the core clock.
> 
> Signed-off-by: zpershuai <zpershuai@gmail.com>
> ---
>  drivers/spi/spi-meson-spicc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> index d675334..b2c4621 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -725,7 +725,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
>  	ret = clk_prepare_enable(spicc->pclk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "pclk clock enable failed\n");
> -		goto out_master;
> +		goto out_core_clk;
>  	}
>  
>  	device_reset_optional(&pdev->dev);
> @@ -764,9 +764,11 @@ static int meson_spicc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  out_clk:
> -	clk_disable_unprepare(spicc->core);
>  	clk_disable_unprepare(spicc->pclk);
>  
> +out_core_clk:
> +	clk_disable_unprepare(spicc->core);
> +
>  out_master:
>  	spi_master_put(master);
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

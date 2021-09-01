Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3613FD608
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243318AbhIAI5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:57:17 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47926
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243292AbhIAI5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:57:14 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C647B3F325
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630486576;
        bh=gwLLa2UOi6T+wtyiAz6ZhhzZsScQOUi/vsbQy5aqFIA=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=pRAcKYSICWmktF4fCJt9ypKrebUFlBZNaJaLPbKUDehkGwTGhhONrhElVGqGyO+vM
         3SXcB8kxHo3YEF/Zf0s/xe1O8/hw/FBNYQtTzGpCp7k6yJwnDgpr5udpQu0xia2TP7
         bu7+16VWHDgHSnuvfIqGlVld6/Qw7s6EZPfalXaNmrcrDb04qJNxqUQAt9DcwJDleT
         9mc6BWe5KQJQv987/nVUaYQgV5/QzOFraCxJcd20Y7jTkGEuMFaotbdL4PeESVO3IY
         NoXDdUI5DOG0MYzcrCksK7JBae0GAiPhMYxNPfCqTznwEC2mxPvmsqWqProJM/PMFC
         +iHfMV3pgzUQA==
Received: by mail-wr1-f70.google.com with SMTP id j1-20020adff541000000b001593715d384so179476wrp.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 01:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gwLLa2UOi6T+wtyiAz6ZhhzZsScQOUi/vsbQy5aqFIA=;
        b=O1wk/RP34uVL3k5Zj35EgAp2I5SXmE/pVwm2Y/iZYOTHPWkK1FOaVwOvrwV02YD12v
         hubakFcTQVfPZDG2yh+3knXh+hEHwyypUpd91FhJEsdRLptVpsXzZOqOa2YLlOxPsKX1
         5UO607jO+gtMmOhGH5cpzkO6B3XPJFAaLQ5WOSZrp241I8O33QS4nEcLAYK2rw/MPCsd
         B/OkECpLCLjKdEtr1vC6k7cy0CEw3E6+7ipkQsN2W2UyaTJzDJRQ1uOOsNTlnYX7XtLG
         L2XYNG+xbWzy3rBNt0MkoXwuJjwM75euJfSnUnDHRWfRB0S2jZPYC4Gf2H+6Y1Fds9hN
         UoHA==
X-Gm-Message-State: AOAM530aoNUcgr7vBhsriC1Xpl+VcLLJJ3QK3UwmShdbv6+TPkAKRhsB
        xdkHNapTCuq/7vjhL3kM52d9NKCEV0HcWe0dXVTH1CR/mZzU+GT6FsCvDEMIkaJVyPF/Hlfk5mg
        8U/DqCRmNQNoIf0dlp6EtOAoK2LYi3scAWMNDIXTizw==
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr8626349wmh.186.1630486576012;
        Wed, 01 Sep 2021 01:56:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEaOo9BEZwzFqFpTCJEA4aMjN7D27ED7IHNXmy9KLSmHPPhFG2nBCpG9+r5QNlOXsLoAMZWg==
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr8626335wmh.186.1630486575883;
        Wed, 01 Sep 2021 01:56:15 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.122])
        by smtp.gmail.com with ESMTPSA id r10sm16036787wrc.85.2021.09.01.01.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 01:56:15 -0700 (PDT)
Subject: Re: [PATCH] pwm: samsung: Simplify using devm_pwmchip_add()
To:     zhaoxiao <zhaoxiao@uniontech.com>, thierry.reding@gmail.com,
        lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210901054230.29678-1-zhaoxiao@uniontech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <79e46f2f-c3ed-d187-2553-e64e0aac4c13@canonical.com>
Date:   Wed, 1 Sep 2021 10:56:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901054230.29678-1-zhaoxiao@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2021 07:42, zhaoxiao wrote:
> With devm_pwmchip_add() we can drop pwmchip_remove() from the device
> remove callback. The latter can then go away, too and as this is the
> only user of platform_get_drvdata(), the respective call to
> platform_set_drvdata() can go, too.
> 
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  drivers/pwm/pwm-samsung.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index f6c528f02d43..b860a7b8bbdf 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -560,9 +560,7 @@ static int pwm_samsung_probe(struct platform_device *pdev)
>  	chip->tclk0 = devm_clk_get(&pdev->dev, "pwm-tclk0");
>  	chip->tclk1 = devm_clk_get(&pdev->dev, "pwm-tclk1");
>  
> -	platform_set_drvdata(pdev, chip);

The test looks untested because this should cause bug during resume.
> -
> -	ret = pwmchip_add(&chip->chip);
> +	ret = devm_pwmchip_add(&pdev->dev, &chip->chip);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to register PWM chip\n");
>  		clk_disable_unprepare(chip->base_clk);
> @@ -577,19 +575,6 @@ static int pwm_samsung_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int pwm_samsung_remove(struct platform_device *pdev)
> -{
> -	struct samsung_pwm_chip *chip = platform_get_drvdata(pdev);
> -	int ret;
> -
> -	ret = pwmchip_remove(&chip->chip);
> -	if (ret < 0)
> -		return ret;
> -
> -	clk_disable_unprepare(chip->base_clk);

NAK, the patch looks bad. You cannot remove some code from remove()
callback just "because".


Best regards,
Krzysztof

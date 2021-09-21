Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6052412F93
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhIUHiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:38:08 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37542
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230168AbhIUHiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:38:03 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8C36E40262
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632209794;
        bh=5xtuLVRlXiTMHH96D8zimgkDHcNXy9X9ihNLTsNCcqE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=KYeovEO7J1SuJYe3ER8quU3K/9bGCFFvYmykARPDPS6wAUODPE/7zPWekYhOdB6sP
         yWHRVHNsJp4ztdxDOSh2db+egrZn83kHDZ1nqgUcJql6y+sIIoackAJ6IUDY4M6H4N
         4yiisoed0JBCFjV/OifNryVt6DqzQ11EnDxoSjNpU5ihZsOJ0S1zDlp2bpldIYguHn
         nBbBMNU3Igu6Vr40Y5HVkKzZE/GELGqi7mfi7R+N30+XJy+HVNRhMnHbkdLu1uATRQ
         1HPaUwT+smKnyeHFwpyKOK8IacFUk0RenPqgUPTlExRD/JaSz8kXiB1NTFSe6I3FaR
         KVoWmhmBg++cw==
Received: by mail-wr1-f72.google.com with SMTP id e1-20020adfa741000000b0015e424fdd01so7614404wrd.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5xtuLVRlXiTMHH96D8zimgkDHcNXy9X9ihNLTsNCcqE=;
        b=fU/tUXL+qRMrfpjaquEQ5o0u1iTgHmrTuzUNfBfTRRD2tEuKklhvVsgWUPnHOt40/1
         yU1pLh5NLybAA/Ar0f2xNjtBmJ2Z/S8LM+ikyXAMKKtwUft2ffkThDXbZ2fcPpwLhvkZ
         eeHWE/2i0itoaV+2loy/DEO3b7qDqA37mTVNhwQJB0qlPyn8KDxqM1IdTEwmWZyqsl4I
         niBA9BjfibKAGawkjVofcbLPzCUu7lKu0jd9LyL2cp9dwhzLmOZ/VMm+2qJzgP9YK62s
         r9hcYNNUdQ5AkvCLe+yBnnUBej4TLBe+wqhV4cB8IWAx0ZB3hBL4t4+lkHWuWHYn3vgQ
         x9jw==
X-Gm-Message-State: AOAM531j+nfT/l5ng/TRmAUHoCvJhU91oV6wYOOCtrFUmssBJXyTQb4n
        4lGnBVi9Kn7e30aFGytt3qz95dPFG8FYfo+cU7wVSQ1jBiuQqm6D9iB18RtYV+4VyGP8O4SET0s
        cPrAN3eQiZhf5jfRYAFr8K3Cmp80Pl/SWZLBFG0p8og==
X-Received: by 2002:a5d:598f:: with SMTP id n15mr30497162wri.74.1632209794145;
        Tue, 21 Sep 2021 00:36:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLKQWe41cx6PvZ19KxjufcOkHR0IX8PQ9IjcFMsfMXm6dylIN5TbRIN773VgRDP6J6eJhhWw==
X-Received: by 2002:a5d:598f:: with SMTP id n15mr30497148wri.74.1632209793950;
        Tue, 21 Sep 2021 00:36:33 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id i203sm1353028wma.7.2021.09.21.00.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 00:36:33 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] rtc: change HAVE_S3C_RTC default config logic
To:     Will McVicker <willmcvicker@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20210920190350.3860821-1-willmcvicker@google.com>
 <20210920190350.3860821-5-willmcvicker@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <1f4efb90-4c6f-0972-de67-eae8e0246f5b@canonical.com>
Date:   Tue, 21 Sep 2021 09:36:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920190350.3860821-5-willmcvicker@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2021 21:03, Will McVicker wrote:
> Switches the default config logic of HAVE_S3C_RTC to use "default y if
> (ARCH_EXYNOS && RTC_CLASS)" versus having ARCH_EXYNOS directly select
> it. This provides vendors flexibility to disable the config if desired
> or modularize it in the presence of a generic kernel.
> 
> Verified this change doesn't impact the .config.
> 
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  arch/arm64/Kconfig.platforms | 1 -
>  drivers/rtc/Kconfig          | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 

It took me some effort to find this patch because you did not send it to
neither me, nor Samsung SoC list.

Since you touch arm64 code, this should go either via SoC tree or with
SoC ack, therefore you should simply use get_maintainers.pl on entire
patchset, not on some pieces.

> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index a884e5da8b0f..f9f829aab511 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -91,7 +91,6 @@ config ARCH_BRCMSTB
>  
>  config ARCH_EXYNOS
>  	bool "ARMv8 based Samsung Exynos SoC family"
> -	select HAVE_S3C_RTC if RTC_CLASS

Just remove HAVE_S3C_RTC entirely like in commit:
7dd3cae90d856e97e93bc1c32904e5aed7210f7b

>  	select PINCTRL
>  	select PM_GENERIC_DOMAINS if PM
>  	help
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index e1bc5214494e..40afdb37d2a5 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1406,6 +1406,7 @@ config RTC_DRV_OMAP
>  
>  config HAVE_S3C_RTC
>  	bool
> +	default y if (ARCH_EXYNOS && RTC_CLASS)
>  	help
>  	  This will include RTC support for Samsung SoCs. If
>  	  you want to include RTC support for any machine, kindly
> 


Best regards,
Krzysztof

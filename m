Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A87442B14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 10:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhKBJzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:55:10 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60664
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhKBJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:55:09 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1899C3F1AB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635846754;
        bh=XRqTNhzYv9GwlgIV1twPbEH66lBurcSMPW0liEplDkQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Tp1UWfIiRflkcwtLqcJLYkrdv6yj921b6Wfu4nTVAPPZzqW8XxEG+kiNWu1lWSSH1
         8PgCJRnl0I8dDUwce7FqqdUkqQPxx0CVc4bxRnQdQz4YCN44BvC3gEy2ZBJbvqJaGS
         vb7CM7IAeo9hqiNWD47rmLH7PPaZWpoxEH1EmZpmgHPIDSa1tQVn0tSRB91rfKOxuX
         GBQH1EeMPjsuXBeLH5eDMS0QajYP3rzxsDf68jgamoExWTsvh6c/T6UJtI+WHOHDvf
         h3zxk80OHZCoGDspMt5RPf9VQ+/x3Lf6CpaQ2LpCUahAyiFUup+lqsFj4lkILqwGSI
         gLvXX6srgcTGQ==
Received: by mail-lf1-f72.google.com with SMTP id f13-20020a056512228d00b003ffd53671d8so6144623lfu.14
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 02:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XRqTNhzYv9GwlgIV1twPbEH66lBurcSMPW0liEplDkQ=;
        b=FEAFq8o9qU+X8coZSDG/18DNvk4l+/lkWQ0u7JHH52j119Q6P9bfmWYCzSOnLZh2PR
         3FBKx3+YZckDInBzBP+Hg+J7Kl2hGi9Ms53pfPZF2d3Gb7maOwX/mDCd/lc4W5gZXi0+
         uE50FubxZPiLC2eYa7sIljF/7cwirVZKHkPPPbAqhBBCH4QFiPdDMQ2retqbcVpsxCoo
         wIkpT1v3wtSnt2j9Jp38wP6B1pkBGnRzGfS/kDbbBF/zhzuBPzQjF5Vy9txVdr+98IcK
         2jneedkxind0ss45m8Y2LExHrA4GYuB5derGu17C4e1xwRe8RN2dLyuT+YE61SMW6f9W
         ukLQ==
X-Gm-Message-State: AOAM5313sv7mCmZ4ottK3JsQH6hfZRfgCNCG3BlhOg1YOXtJqfU4GUjy
        G+cP87KVj2cfje9wozBYtcyAlgvTzoW09fYLwvyEw5oUozbBKpjfJWRg8/vcfkmS6PsDptfypTR
        5SW8Jm40Ytf1Qh0Qk4rIzFrUZSChcw7NsM2/SQsiV4A==
X-Received: by 2002:a05:651c:1601:: with SMTP id f1mr12613665ljq.34.1635846753569;
        Tue, 02 Nov 2021 02:52:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylAQt6mahxpMwyiXSJ50n4Vn8kidCqoFzoThZHoc7kvOdGVy09XjkSnciUNsz2OK/XITBmPQ==
X-Received: by 2002:a05:651c:1601:: with SMTP id f1mr12613642ljq.34.1635846753387;
        Tue, 02 Nov 2021 02:52:33 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id 77sm54429ljj.118.2021.11.02.02.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 02:52:33 -0700 (PDT)
Message-ID: <9846cb60-4628-0d06-4ec2-5687cfaefece@canonical.com>
Date:   Tue, 2 Nov 2021 10:52:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 05/12] watchdog: s3c2410: Make reset disable register
 optional
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211031122216.30212-1-semen.protsenko@linaro.org>
 <20211031122216.30212-6-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211031122216.30212-6-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2021 13:22, Sam Protsenko wrote:
> On new Exynos chips (e.g. Exynos850 and Exynos9) the
> AUTOMATIC_WDT_RESET_DISABLE register was removed, and its value can be
> thought of as "always 0x0". Add correspondig quirk bit, so that the
> driver can omit accessing it if it's not present.
> 
> This commit doesn't bring any functional change to existing devices, but
> merely provides an infrastructure for upcoming chips support.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Used quirks instead of callbacks for all added PMU registers
>   - Used BIT() macro
>   - Extracted splitting the s3c2410wdt_mask_and_disable_reset() function
>     to separate patch
>   - Extracted cleanup code to separate patch to minimize changes and
>     ease the review and porting
> 
>  drivers/watchdog/s3c2410_wdt.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 0845c05034a1..048ca47d0b8a 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -59,10 +59,12 @@
>  #define QUIRK_HAS_PMU_CONFIG			(1 << 0)
>  #define QUIRK_HAS_RST_STAT			(1 << 1)
>  #define QUIRK_HAS_WTCLRINT_REG			(1 << 2)
> +#define QUIRK_HAS_PMU_AUTO_DISABLE		(1 << 3)
>  
>  /* These quirks require that we have a PMU register map */
>  #define QUIRKS_HAVE_PMUREG			(QUIRK_HAS_PMU_CONFIG | \
> -						 QUIRK_HAS_RST_STAT)
> +						 QUIRK_HAS_RST_STAT | \
> +						 QUIRK_HAS_PMU_AUTO_DISABLE)
>  
>  static bool nowayout	= WATCHDOG_NOWAYOUT;
>  static int tmr_margin;
> @@ -137,7 +139,7 @@ static const struct s3c2410_wdt_variant drv_data_exynos5250  = {
>  	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
>  	.rst_stat_bit = 20,
>  	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT \
> -		  | QUIRK_HAS_WTCLRINT_REG,
> +		  | QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_AUTO_DISABLE,
>  };
>  
>  static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
> @@ -147,7 +149,7 @@ static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
>  	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
>  	.rst_stat_bit = 9,
>  	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT \
> -		  | QUIRK_HAS_WTCLRINT_REG,
> +		  | QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_AUTO_DISABLE,
>  };
>  
>  static const struct s3c2410_wdt_variant drv_data_exynos7 = {
> @@ -157,7 +159,7 @@ static const struct s3c2410_wdt_variant drv_data_exynos7 = {
>  	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
>  	.rst_stat_bit = 23,	/* A57 WDTRESET */
>  	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT \
> -		  | QUIRK_HAS_WTCLRINT_REG,
> +		  | QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_AUTO_DISABLE,
>  };
>  
>  static const struct of_device_id s3c2410_wdt_match[] = {
> @@ -213,11 +215,13 @@ static int s3c2410wdt_mask_and_disable_reset(struct s3c2410_wdt *wdt, bool mask)
>  	if (mask)
>  		val = mask_val;
>  
> -	ret = regmap_update_bits(wdt->pmureg,
> -			wdt->drv_data->disable_reg,
> -			mask_val, val);
> -	if (ret < 0)
> -		goto error;
> +	if (wdt->drv_data->quirks & QUIRK_HAS_PMU_AUTO_DISABLE) {
> +		ret = regmap_update_bits(wdt->pmureg,
> +				wdt->drv_data->disable_reg,
> +				mask_val, val);

While shuffling the code, please align the arguments with opening
parentheses.

Beside that looks ok:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof

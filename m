Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5221C3AF894
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 00:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhFUWer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 18:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhFUWed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 18:34:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DAEC061756;
        Mon, 21 Jun 2021 15:32:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso599011wmc.1;
        Mon, 21 Jun 2021 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=D0MoxjXV9Jy8caVcI/fteljqOT1UWv9StnseuzGm+HU=;
        b=M2Lp+uK85bR2WTxlYccVrufOGrMNB5J/hO5b0Vle2OXQISXTCgrPUCmfadVdFk1aeC
         4X8wPXX9IaJXrBc+u7hZcQzKoBbmk0kEouZu1b8ZGLIAj6ZDL5d6ha00Z343pcz64WlI
         5LQwV2QiMU+6qG/z6S2bq8WJQbtRcwNHXJOHzYFUkcOwxteVF0ygguyZnb6n+L9V6Ui7
         8T5jEZkebZUq2J6ncuQAQRC9WBh3E8ZonJL0Wut1A+6HfIfpHRFwCsbm7/3fp1HNyEOd
         tZoy7QuwqpXxWsuOUEbcYR21EhpHFlhdaWP58HLpX4gOPdJ31adiSkhLdKw74BpUQNhK
         zgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D0MoxjXV9Jy8caVcI/fteljqOT1UWv9StnseuzGm+HU=;
        b=Jyp/XN7PdnuamsasnIb1X1uN7WzIvdEARAjS7wyHnos9ACsyXiQHIMW7sHVo+97/Mj
         1zwW0yqcub38e0ZLC2G3hI25jps+J1wSecereLnFWd5ZFYub5aJrDl7MYM3RVV1k9g7s
         +Zo/DrsSf4fi5F3aA6bF67cM+fdMMRrrfTVVDSE8kHgtrzVCQsFrxgU338k9F1a9CMBK
         uFnLFQR0rmGAmpUk12f5NyT3RVtw0OIvIhPavIhkiw+QttKDeNdjosUVGBxa6J9PC3Ej
         J5OAO73cBFjLym1KJLCtOX4hWel+m+tO8tfpOQNnAg6dCCRqrpIZbd5H2IYyBJcHKZji
         8Umw==
X-Gm-Message-State: AOAM532/VR9OS9x0Nn/np2vft7tr7+pzQDIHqT/P3ZP/PqsBUaOh0yGS
        MXs3audppUnLLbmd5iUwmgrp/6FyEdU=
X-Google-Smtp-Source: ABdhPJzqvt3mQhAxzVYmsQmt7bf1sFLMv+bw9tN9BXLDlZ+jCSq/Zc58Qq/aU/4lj3KCEsxfUOv7Xw==
X-Received: by 2002:a1c:ac87:: with SMTP id v129mr867487wme.45.1624314735195;
        Mon, 21 Jun 2021 15:32:15 -0700 (PDT)
Received: from [192.168.1.211] ([2.29.20.116])
        by smtp.gmail.com with ESMTPSA id p5sm20534055wrd.25.2021.06.21.15.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 15:32:14 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] platform/x86: intel_skl_int3472: Free ACPI device
 resources after use
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
References: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
 <20210618125516.53510-2-andriy.shevchenko@linux.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <d5bbf80a-36b1-fd29-dbdb-ae47e06b0c7b@gmail.com>
Date:   Mon, 21 Jun 2021 23:32:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618125516.53510-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

On 18/06/2021 13:55, Andy Shevchenko wrote:
> We may free ACPI device resources immediately after use.
> Refactor skl_int3472_parse_crs() accordingly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sorry, only just got round to these:


Reviewed-by: Daniel Scally <djrscally@gmail.com>

Tested-by: Daniel Scally <djrscally@gmail.com>

> ---
> v2: new patch
>  .../x86/intel-int3472/intel_skl_int3472_discrete.c  | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c b/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
> index 8c18dbff1c43..48a00a1f4fb6 100644
> --- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
> +++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
> @@ -308,8 +308,10 @@ static int skl_int3472_parse_crs(struct int3472_discrete_device *int3472)
>  	ret = acpi_dev_get_resources(int3472->adev, &resource_list,
>  				     skl_int3472_handle_gpio_resources,
>  				     int3472);
> -	if (ret)
> -		goto out_free_res_list;
> +	if (ret < 0)
> +		return ret;
> +
> +	acpi_dev_free_resource_list(&resource_list);
>  
>  	/*
>  	 * If we find no clock enable GPIO pin then the privacy LED won't work.
> @@ -319,7 +321,7 @@ static int skl_int3472_parse_crs(struct int3472_discrete_device *int3472)
>  	if (int3472->clock.ena_gpio) {
>  		ret = skl_int3472_register_clock(int3472);
>  		if (ret)
> -			goto out_free_res_list;
> +			return ret;
>  	} else {
>  		if (int3472->clock.led_gpio)
>  			dev_warn(int3472->dev,
> @@ -329,10 +331,7 @@ static int skl_int3472_parse_crs(struct int3472_discrete_device *int3472)
>  	int3472->gpios.dev_id = int3472->sensor_name;
>  	gpiod_add_lookup_table(&int3472->gpios);
>  
> -out_free_res_list:
> -	acpi_dev_free_resource_list(&resource_list);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  int skl_int3472_discrete_probe(struct platform_device *pdev)

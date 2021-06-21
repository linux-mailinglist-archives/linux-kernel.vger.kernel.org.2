Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F49D3AF8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 00:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhFUWmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 18:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhFUWmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 18:42:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D703C061574;
        Mon, 21 Jun 2021 15:40:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w13so4892831wmc.3;
        Mon, 21 Jun 2021 15:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gg5Nrt23j+TMZ7tzw193EhblKwwxaEj7aLGVZzA+N6M=;
        b=m/pCm741JPF11lL4vntkhm52M4QUZHGhT9ymC6ZQdim4d2u6fT+/QVtfXOGYt4vml/
         Ihfhqhkgj4Llr/UWqWklclUBWgnzxBVtK3l/TOLLeX3T/r3CXEm9IXEbPAgBtkLuF5RJ
         TmVmQSt+JKuA3vFFTV8aBpE0epQ45B77uCjJry6iGEVD0KX8gUeNB9w1vVjswlxKkKFd
         Wgg4C40q/jBHa1zwTZQ8lSwe0OrXKMa7AEi7B2ACTr+i5JFOb9slnidPKbrvphy1k0RG
         eN/r6yF5aw8YbubuzqLhkY3dl+jC32xQeKhBLuaz/YsnFUNqfMr3B7wfVNBWuTYrEiFL
         o4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gg5Nrt23j+TMZ7tzw193EhblKwwxaEj7aLGVZzA+N6M=;
        b=hFeAIg9hU8pM4Mhj0sK50bDmRB49PYdjWlvHotiu4Q9LNRTk3zbyjdhyOuEIxfqq/T
         YwoVdhmQA9A7R6jHeCqn0/6nCoexfEp2djQnrVl7vClz65aGeF6SI0NMGcvd2p4yqufW
         49ywwDSAaMGnFucIPQeVxVWTGGv3wURNGdqYMjDBiDNYOcQ8qoxYhIYnRESR22gkWI9N
         yWgeuiOcdkkVjwx/dBX9Y9evwXphaSGU4r9/zOgjMKHSRa5JmtaxDXdehSIgRBvIWXYi
         neD1ZdTViW6gkVTSKJb80Ve6cteUK2Vyq0nBhxiOlUjDFyQvmozOYQ/E4qnqDhWIHhVH
         u5dQ==
X-Gm-Message-State: AOAM533UaCP3YnyVcb3BendtU7u1jdYbOsZfBoB28L4mreXYYXGFwCrv
        wjkzmvVCRw93+RALq5AyC1E=
X-Google-Smtp-Source: ABdhPJxr8pwl9KJN5vRhj9Ttdt0RdUbs1eGSgCxh2ZA3q1Iky8UgH2CholaWt1qvQDXDQgMi4k8dNA==
X-Received: by 2002:a05:600c:b57:: with SMTP id k23mr876483wmr.133.1624315205678;
        Mon, 21 Jun 2021 15:40:05 -0700 (PDT)
Received: from [192.168.1.211] ([2.29.20.116])
        by smtp.gmail.com with ESMTPSA id s1sm403403wmj.8.2021.06.21.15.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 15:40:05 -0700 (PDT)
Subject: Re: [PATCH v2 5/8] platform/x86: intel_skl_int3472: Provide
 skl_int3472_unregister_regulator()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
References: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
 <20210618125516.53510-5-andriy.shevchenko@linux.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <3f379877-284e-9013-0687-0a0250d85c10@gmail.com>
Date:   Mon, 21 Jun 2021 23:40:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618125516.53510-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

On 18/06/2021 13:55, Andy Shevchenko wrote:
> For the sake of APIs to be properly layered provide
> skl_int3472_unregister_regulator().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Reviewed-by: Daniel Scally <djrscally@gmail.com>

Tested-by: Daniel Scally <djrscally@gmail.com>

And for 6/8 too.

> ---
> v2: new patch
>  .../x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c | 6 ++++++
>  .../platform/x86/intel-int3472/intel_skl_int3472_common.h   | 2 ++
>  .../platform/x86/intel-int3472/intel_skl_int3472_discrete.c | 4 ++--
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c b/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c
> index 49ea1e86c193..60c7128f44ee 100644
> --- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c
> +++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c
> @@ -193,3 +193,9 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
>  
>  	return ret;
>  }
> +
> +void skl_int3472_unregister_regulator(struct int3472_discrete_device *int3472)
> +{
> +	regulator_unregister(int3472->regulator.rdev);
> +	gpiod_put(int3472->regulator.gpio);
> +}
> diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h b/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h
> index 765e01ec1604..50f73c6eab44 100644
> --- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h
> +++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h
> @@ -112,7 +112,9 @@ union acpi_object *skl_int3472_get_acpi_buffer(struct acpi_device *adev,
>  					       char *id);
>  int skl_int3472_fill_cldb(struct acpi_device *adev, struct int3472_cldb *cldb);
>  int skl_int3472_register_clock(struct int3472_discrete_device *int3472);
> +
>  int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
>  				   struct acpi_resource_gpio *agpio);
> +void skl_int3472_unregister_regulator(struct int3472_discrete_device *int3472);
>  
>  #endif
> diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c b/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
> index fd681d2a73fe..2638d375e226 100644
> --- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
> +++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
> @@ -400,15 +400,15 @@ int skl_int3472_discrete_remove(struct platform_device *pdev)
>  	struct int3472_discrete_device *int3472 = platform_get_drvdata(pdev);
>  
>  	gpiod_remove_lookup_table(&int3472->gpios);
> -	regulator_unregister(int3472->regulator.rdev);
>  	clk_unregister(int3472->clock.clk);
>  
>  	if (int3472->clock.cl)
>  		clkdev_drop(int3472->clock.cl);
>  
> -	gpiod_put(int3472->regulator.gpio);
>  	gpiod_put(int3472->clock.ena_gpio);
>  	gpiod_put(int3472->clock.led_gpio);
>  
> +	skl_int3472_unregister_regulator(int3472);
> +
>  	return 0;
>  }

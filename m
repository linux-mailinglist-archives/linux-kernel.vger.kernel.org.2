Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDAC368E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241358AbhDWIFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241395AbhDWIFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:05:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F3AC061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:04:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso711674wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BbAlfrwo2WRXERUJtU5zYuJ3Z63HTo/B8XlPZIzMJFc=;
        b=na1Jxk6XNOFLChzn9la6USRZvv3sr8FCcw5vCRdYVPYBcVAd7F4pdUMPDz5CE659Sm
         3AOE4eehE295iYSdW3ERnPASjw9jPJL7Zn4YN1APnXLMjuwmsBBcYezrIQzaE6larHaj
         n2UweGZY7IMVrXGCgXQSyYDOCLr0X2LC/RoU934VnmkV4COREVnRjJfFsbCNDACB4UJm
         +4fdYNfi76MM7akXx/uusqiCpV+l9qNztoHxarBW49winzZk9VlAzTj/EYDZ7NyiqOrZ
         f8NxzHxExwo7RZwYA8g06llCivvrzWb2p7lSZcWyfI27dpN/hcpZNhZ45L3Ut/XTqzpv
         8SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BbAlfrwo2WRXERUJtU5zYuJ3Z63HTo/B8XlPZIzMJFc=;
        b=PuQqgKYx4gcVxJRliHGrjsvh/s+ma+M60dDGbcQQK3KpsybpQmgMhMCRKVoO41UBmp
         42N27IriXf+Z0x4eOhrcMpfkNaYRn5pdcVZAX6omLh7UmlZUE3ymXAx2xUbiA71dj2zS
         CDrEm+G8saNfHVQKd0a+Su4gEpiNmMfStogiZLHH2002BHIFliszbsqiphxijzopv0tv
         jnJbajEj3iaSs4IYePYU5Fza+kwvKxjjOb1y7RMf9u9wAZKYgH5DtObCGkRagG6PlAzc
         JKKRXxeY9k2fz6PimvLHhHRIAbPX7cZGgdSIwDApeS7WUPpoSaL4FmvsXF62D8Mjla7b
         epew==
X-Gm-Message-State: AOAM530agkm0n1JZOJaZhdpKDburoi0sScoHczXr0ZXV85xr6nzEB4yQ
        W2lvOQPpErINbjbiVCybYiYh0A==
X-Google-Smtp-Source: ABdhPJxOlhfTTDO2kZbt4t7jcd53CauCFDvLwi+o18lwhWG31178YTGd3jxTUmB1SaLsSOh0gmSRMQ==
X-Received: by 2002:a1c:f701:: with SMTP id v1mr4168778wmh.69.1619165077043;
        Fri, 23 Apr 2021 01:04:37 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id c16sm7801320wrm.93.2021.04.23.01.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 01:04:36 -0700 (PDT)
Date:   Fri, 23 Apr 2021 09:04:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH v2 7/7] mfd: twl: Correct kerneldoc
Message-ID: <20210423080434.GA6446@dell>
References: <20210420113929.278082-1-krzysztof.kozlowski@canonical.com>
 <20210420113929.278082-7-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210420113929.278082-7-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021, Krzysztof Kozlowski wrote:

> Correct kerneldoc function name to fix W=1 warning:
> 
>   drivers/mfd/twl-core.c:496: warning:
>     expecting prototype for twl_regcache_bypass(). Prototype was for twl_set_regcache_bypass() instead
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/mfd/twl-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

FYI, a patch already exists for fixing this.

> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 20cf8cfe4f3b..24b77b18b725 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -485,8 +485,8 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
>  EXPORT_SYMBOL(twl_i2c_read);
>  
>  /**
> - * twl_regcache_bypass - Configure the regcache bypass for the regmap associated
> - *			 with the module
> + * twl_set_regcache_bypass - Configure the regcache bypass for the regmap
> + *			     associated with the module
>   * @mod_no: module number
>   * @enable: Regcache bypass state
>   *

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27D537927F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhEJPWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhEJPW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:22:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D0C0610E2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:54:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o26-20020a1c4d1a0000b0290146e1feccdaso9857303wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5g+6f/2kfQi9NilZ1UVhbDUQccW1iRunqSEC2ONAGZ0=;
        b=rXlqh5QOqeq/KshS1xxhdGvxHM6wGSsModBgSxKrnn8DibB+Ap3OwzSdKUesMRhL1x
         McsQaWYoPBBw6XMtq6IJLfeK0y3Y4zRndRhue1i9OaryUgaicvsOQwdFTh20Jcz1pJGg
         6+Gs2Dl54CiqMSV3/lDhy2LuuIBEN+2D5v8vV5DtNAvRIochZbkJV3ykD8gqR6H7R7V6
         pZ8bPUHVfx8Q6qA4GubUX2fC9bkZo0GHvlu1+QZDctvYVZe/00PBAx12jn0nl9YAyrty
         Tap4kkdbOggHuOXdEpz+JRT0ZoGk6IeS8qV7wlcur0yApazA1mEB8aJSjerdcLkLDZg6
         lZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5g+6f/2kfQi9NilZ1UVhbDUQccW1iRunqSEC2ONAGZ0=;
        b=fQ0RZERoSnoDr1Eujo+w3leMoHNq0EcIOdUroKCKyc0MspJFAVajB2PVXdsDyOmw5y
         +Sv8f2D1H4zk833CPpjzseYxy/uwGWoGADMXGn+LwuwK1fk1h8IXqp25/wmGlE5TwfbA
         ECGbJ1fsfGU3Y2HNS9g8oWmPDGb1hPlXI2N66TCUzwUzhFRtUAheF9bZaf68ZUSegMBa
         7u4oPBq2v+HlaFaJFpOdRuFrHCeOytXSveJJbwKGc4VEfWaqPXaXJOv2d9X3ZmO5ZVG7
         VOL1ivcLlyPf44ngYFN3bIHHJm1VkUg6uLFMm4a5D4XSAYu5fWG//OO2xrOyBCce72Pq
         jawQ==
X-Gm-Message-State: AOAM532zNmzdowqQUBO25ikJ1vF5yjtlz+FQcNfff6Lg6fT4V511M+8g
        ub4hwHwP+YBgg0EO/ZJ3h+dIEA==
X-Google-Smtp-Source: ABdhPJyVKXmZnZ8idEqq55DrZkuvhAoZTsAeqjcR2aIkXtCO0qbiQueQFgWzqzT92DZcQ9hX9oE2WQ==
X-Received: by 2002:a1c:e409:: with SMTP id b9mr38061024wmh.189.1620658440287;
        Mon, 10 May 2021 07:54:00 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id a9sm20012526wmj.1.2021.05.10.07.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:53:59 -0700 (PDT)
Date:   Mon, 10 May 2021 15:53:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Meng.Li@windriver.com
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, arnd@arndb.de
Subject: Re: [PATCH] mfd: syscon: free the allocated name field of struct
 regmap_config
Message-ID: <20210510145358.GB5109@dell>
References: <20210407052525.27592-1-Meng.Li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210407052525.27592-1-Meng.Li@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2021, Meng.Li@windriver.com wrote:

> From: Limeng <Meng.Li@windriver.com>
> 
> The commit 529a1101212a("mfd: syscon: Don't free allocated name
> for regmap_config") doesn't free the allocated name field of struct
> regmap_config, but introduce a memory leak. There is another
> commit 94cc89eb8fa5("regmap: debugfs: Fix handling of name string
> for debugfs init delays") fixing this debugfs init issue from root
> cause. With this fixing, the name field in struct regmap_debugfs_node
> is removed. When initialize debugfs for syscon driver, the name
> field of struct regmap_config is not used anymore. So, the allocated
> name field of struct regmap_config is need to be freed directly after
> regmap initialization to avoid memory leak.
> 
> Fixes: 529a1101212a("mfd: syscon: Don't free allocated name for regmap_config")
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index ca465794ea9c..df5cebb372a5 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -108,6 +108,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	syscon_config.max_register = resource_size(&res) - reg_io_width;
>  
>  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
> +	kfree(syscon_config.name);
>  	if (IS_ERR(regmap)) {
>  		pr_err("regmap init failed\n");
>  		ret = PTR_ERR(regmap);
> @@ -144,7 +145,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	regmap_exit(regmap);
>  err_regmap:
>  	iounmap(base);
> -	kfree(syscon_config.name);
>  err_map:
>  	kfree(syscon);
>  	return ERR_PTR(ret);

Would anyone like to have a look at or test this before I merge it?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

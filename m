Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808FD3CB3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbhGPIGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhGPIGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:06:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AF7C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:03:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i94so11026515wri.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OsKyayjHxG1P8h05xSAZTvVABsTx53Uj1VpdHiIKIWA=;
        b=aPYf87ob3aaxxoeLXgm3OKY1JZs+/cErQ/oHDfHA7eRlpryENUjlLT3K3+YSUPSSxQ
         Gvw9O9ZmHbz3QVBLxnJ+Nh6esDyWswk4cOPBrf5KJMBubs81kgEBfecPTs+8tMtPNfrw
         7n23VIS7/ODj0kgrzIaHtiy7zScN2T2DdbiAksQzDgs7Gr9LmlTkand3EFoaMmH59MW1
         EML+/H/vq4bonqY4ctCgJch72JuY6NXBFoeZbD+waSntVmNRK+kPEd2ZHvcO45Q3dpIG
         oYPXd33ulnElx4BsU2IZ0Zpt9xYSSRfkn9M160q2SJGARwqlvi+6ldEI2GlqcVUmjDLE
         OEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OsKyayjHxG1P8h05xSAZTvVABsTx53Uj1VpdHiIKIWA=;
        b=QIKI4yFyxbFoSDV36NAU+ysugwj7C4Vo5f64xmQdHe6uQGYYDJRPxsHTltPPp8+mDI
         LNG5umlkNSRPiUxl6LaPt3VTMz0orHweEjwe28MlMVcNJWvUheH9egYd8yhT4hxO0LgD
         L2NO3EvHnIw4uoJZwQs+q+u/xufRRXhN53B2BK6P1OP66FKfNwYmXhUEi3rddkOembt2
         5x50v8gGiHkg0vEmziduQJqm1GtZEC2XHvdH4IZRhDR5qsdcU7X52ubu0yYV8j9Jef3K
         x9ZLAoP5so376mvyP8avC157eee7Ey0J48IHLT+keo3GLQ/i4bGBnMM+r77gWpyQzwCh
         +8Gg==
X-Gm-Message-State: AOAM531/QAvj7P1Kj7jHkYvj5ngW3uGZ/3YfdapfdKbMoig7L6FKpajQ
        DywxxLpFMaMGKiLRC6fpY2zJLA==
X-Google-Smtp-Source: ABdhPJxavCDniqd1CDp7lkvshfaRVqhNT4fnfIgxPt1S6pPllJlKNx7hLLM0l1ZuI1tXuSt7TImimA==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr11185960wrk.198.1626422632225;
        Fri, 16 Jul 2021 01:03:52 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id y6sm7137528wma.48.2021.07.16.01.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:03:51 -0700 (PDT)
Date:   Fri, 16 Jul 2021 09:03:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fei Shao <fshao@chromium.org>
Cc:     Gene Chen <gene_chen@richtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] mfd: mt6360: Restore error message to regmap_read
 failure
Message-ID: <YPE9ZSu1lYtRb1DA@google.com>
References: <20210629094339.874120-1-fshao@chromium.org>
 <20210629094339.874120-2-fshao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210629094339.874120-2-fshao@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021, Fei Shao wrote:

> This adds back a missing error message for better log readability.
> 
> Fixes: e84702940613 ("mfd: mt6360: Fix flow which is used to check ic
> exist")
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>  drivers/mfd/mt6360-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index 6eaa6775b888..0ff8dae4536c 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -351,8 +351,10 @@ static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
>  	int ret;
>  
>  	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &info);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err(ddata->dev, "Failed to read device info from regmap\n");

I'm not fussed about this change either, but if you insist, please
change the commit message to be a little more generic.  Users don't
care about Regmaps and developers can grep it in the source.

Suggest: "Failed to fetch device information from H/W"

>  		return ret;
> +	}
>  
>  	if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360) {
>  		dev_err(ddata->dev, "Device not supported\n");

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

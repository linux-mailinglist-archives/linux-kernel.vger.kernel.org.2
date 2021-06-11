Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CFB3A3F21
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhFKJg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhFKJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:36:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59952C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:34:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so4989967wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A8TIz1cDlej9+ZUNsR4O5xhIVt925U9+N5LJUNgO/fQ=;
        b=CVaNBmMn5NZaDL8wN6U1Sq99oo2mhoYCZqF9PKZHXIgvVAkYkNOr+KV+1jYNPlzrq+
         aCUcQR1v9BxZzj0x4czDI08Ae4WEkHlyyJlXAEtQpdc77gA63wM0QlbzPPuKmC9gCd9K
         r+D/abexRY/D0eXRTYT6Tk9YInO4eRGuznpIxV46cKzr6gXl7R71peun9wCrgCO7C+0l
         bPCTf8lOCXanzrGmoN5/GeIrAFDNh8FDVVVTlHwwKmiwhQ9FKt9ocbKXDjm2LRbYvKOv
         ABmSsj5wdgpz67bVIy439wV1me3kp+y92MVxej4Vu8iZXKoJJGBSpL/G2F2RUdkEJ1Rm
         SobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A8TIz1cDlej9+ZUNsR4O5xhIVt925U9+N5LJUNgO/fQ=;
        b=msk0cnSgXgFGOJyK8X52X2SIRoJNlAEJL+qQpBcBM81eQqReB5BQ9+7Ku6/ZpKmsj5
         XCvbFTWArOP4ioMJy4giqEMFtELKCQvl6Rv9PkBr72BesfvrNMVs182bj1ZZKJT/krqQ
         ijxMJYXdXArEoRHa8YZj9M934W5B1ozYyJXVU2h/4o/5F6CDv9f1nIvh2KUMPFjzp8Pw
         9hcUDUSwCxJP5VqHYaVe9Nt7VW3mIji4Dls3JzajAYV6TNOayTTPbMi4U0NUoQXGYTYY
         VOafnvlcJHGSo1pyJ3zxL15lICpqxMeIvc5lefoJHqg85ty5f0pjCdNfjNJby0kZNHXN
         8rkg==
X-Gm-Message-State: AOAM530V8tVOJCyj1HVFwQHcDUEWD1fa6f+AJwJD0vld5XHc59WbseMp
        At9xVK4ugLEr/RP8h2A1pUBOkeX7B36Rxka/
X-Google-Smtp-Source: ABdhPJzKJJFONGN/6bSPuZcs8dM9cVLYpIrC7eLXiCIro9zRisQdbkwTqpXI+Nz3xKNyUwdvbHkpOg==
X-Received: by 2002:a05:600c:2284:: with SMTP id 4mr3033049wmf.146.1623404058646;
        Fri, 11 Jun 2021 02:34:18 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e537:d458:d3c4:18e1? ([2a01:e34:ed2f:f020:e537:d458:d3c4:18e1])
        by smtp.googlemail.com with ESMTPSA id g10sm6489552wrq.12.2021.06.11.02.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:34:18 -0700 (PDT)
Subject: Re: [PATCH] thermal: sprd: Add missing MODULE_DEVICE_TABLE
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-pm@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
References: <20210512093752.243168-1-zhang.lyra@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cfe9b793-47a6-b6ad-74f0-3342e5ed4d4b@linaro.org>
Date:   Fri, 11 Jun 2021 11:34:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512093752.243168-1-zhang.lyra@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2021 11:37, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> MODULE_DEVICE_TABLE is used to extract the device information out of the
> driver and builds a table when being compiled. If using this macro,
> kernel can find the driver if available when the device is plugged in,
> and then loads that driver and initializes the device.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Applied, and added the Fixes tag:

Fixes: 554fdbaf19b18 ("thermal: sprd: Add Spreadtrum thermal driver
support")

> ---
>  drivers/thermal/sprd_thermal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
> index 3682edb2f466..fe06cccf14b3 100644
> --- a/drivers/thermal/sprd_thermal.c
> +++ b/drivers/thermal/sprd_thermal.c
> @@ -532,6 +532,7 @@ static const struct of_device_id sprd_thermal_of_match[] = {
>  	{ .compatible = "sprd,ums512-thermal", .data = &ums512_data },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, sprd_thermal_of_match);
>  
>  static const struct dev_pm_ops sprd_thermal_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(sprd_thm_suspend, sprd_thm_resume)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

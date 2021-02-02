Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8219830BAE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhBBJ0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhBBJ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:26:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF99DC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:25:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b3so1507195wrj.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a1OCFu7h0TcIowMDv7zHkZMNSiLVb4YwniBrbKA3xlU=;
        b=uF0X2tH0q3rC8OeRvULloT49lCKeBEQIIw6QI9tlhujC4RF3Y6JwL4phRurV64uvih
         vIy/Bkwwwa+OwUknuhm87RzJbo3TmKLf4F4bTWnWohj0xvbesjcgJf0vvzfBB/IuDpr2
         T5sGY0IN4mRqFiNIkf4AjHGbM1BMcLte31RgDWX4v3q3MchbIgY1ke2jBZT8K57WRNa5
         pIM1hekoQS2WUKBuoyDGNSrnzcifBgBLcCwgYgsxQpKhEok5Eamv5Ksvda7NJQk69CUw
         d2ITCAYRN0sV3AErdVtbrN7+deweE3u94fcS9QmF00PXgEkmZJ1YQlK7NALcXBFTO2LM
         R6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1OCFu7h0TcIowMDv7zHkZMNSiLVb4YwniBrbKA3xlU=;
        b=Y4Q4GvXfAICVGGq5KikDgNxK7E91B92nm+334A14TlJW2t/jDqxSIoDkyrF1pMso7a
         rXVmOW1U9j8pYNC8/kn4fBbldj3NQdzY8WUiR9ssJd4Q2gyrdYl6dv27OvKtyATpYq1y
         v3qyGIvscnFJa1HH/QzSdaHDzYezOsvq4RHP4rRGUjklVYUcnNRIsu5NHY7yerrgSaq1
         zXKYgpfx5YLL+5ynw0sUV5FrA9BlloTupZzjhzbN8H5mUceFnGTeMn6l+LWMcYfckK8t
         ISv1q7dEvS9f0rSF7YENZVb3TZM8DExSEcpk6lWChMZ/+h0Kp+mjLEEwAFlVbCiGbsu3
         jsJg==
X-Gm-Message-State: AOAM532bUPRbey1xuTDiPmxBAUEQXeW5ChJ2gh0adVy/KqQtyVERipCZ
        HU4DA/R3fQyub5eJscdgWisDrg==
X-Google-Smtp-Source: ABdhPJy7kfZ4o7WstsegOSMCSFJFOfW1Ibzofjf5AFjyCjsHJFeZ5+FIwpQN0elV9b07P6x7DgPmdw==
X-Received: by 2002:adf:fc8a:: with SMTP id g10mr23343632wrr.189.1612257944619;
        Tue, 02 Feb 2021 01:25:44 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id q24sm2040048wmq.24.2021.02.02.01.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:25:43 -0800 (PST)
Date:   Tue, 2 Feb 2021 09:25:41 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Wenjia Zhao <driverfuzzing@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pcf50633: pdata may be a null pointer, null
 pointer dereference cause crash
Message-ID: <20210202092541.2wvzpe53mavrd47x@maple.lan>
References: <1612190499-73818-1-git-send-email-driverfuzzing@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612190499-73818-1-git-send-email-driverfuzzing@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:41:38AM -0600, Wenjia Zhao wrote:
> Signed-off-by: Wenjia Zhao <driverfuzzing@gmail.com>

There should be a patch description here explaining why the patch
is needed and how it works.


> ---
>  drivers/video/backlight/pcf50633-backlight.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pcf50633-backlight.c b/drivers/video/backlight/pcf50633-backlight.c
> index 540dd338..43267af 100644
> --- a/drivers/video/backlight/pcf50633-backlight.c
> +++ b/drivers/video/backlight/pcf50633-backlight.c
> @@ -127,7 +127,8 @@ static int pcf50633_bl_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcf_bl);
>  
> -	pcf50633_reg_write(pcf_bl->pcf, PCF50633_REG_LEDDIM, pdata->ramp_time);
> +  if (pdata)
> +    pcf50633_reg_write(pcf_bl->pcf, PCF50633_REG_LEDDIM, pdata->ramp_time);

Assuming you found this issue using a static analyzer then I think it
might be better to if an "if (!pdata) return -EINVAL" further up the
file instead.

In other words it is better to "document" (via the return code) that the
code does not support pdata == NULL than to add another untested code
path.


Daniel.

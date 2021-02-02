Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65F630B9E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhBBI30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhBBI3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:29:17 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F74C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:28:36 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l12so469597wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bFiTMfrDGaWBCg0p94Ve9DO2sWATZ48G3jOzHUgim7g=;
        b=FBJWMelLQhMEkkiGfS95RqrQWLdNPopNfuEOE3bVIxGKfpwQzmatH39kKmkCK+R/mE
         ZvUxBJXkz7bdlKErQVVoxi1XU4wYu8x5Y5C3HVICYvbeLJE7qDi5AzKix0j6Dyl0fPlA
         RaqGwGzrSDDdtAKpu5J7b8iyrYt+1P7FTQ2MsyQ8xulPyL7sWSBxaI4PlOxlnrtv2XDT
         whS+HWuU5CMrHrjCxXKmxWxTfvVBHyexLGTDyIITFCvjri9PwPCPhlntXiDOoxBlbZ9l
         6cXKT9y1z1e8VoX6qC/Vdf0Z+2Yrh9jJFyi6dEdzDff+dIdrCFcj16HaYFLwju7GauDu
         ktzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bFiTMfrDGaWBCg0p94Ve9DO2sWATZ48G3jOzHUgim7g=;
        b=ZVQ+4StY/Px0XUlbY5LzHc3RSg7GyDam5lf2vhsHAXc6Z3MYytDQHICJaHeR7Em7mZ
         HxJR5PzHlnNfIcrh5glbaQmGJNcAf01QxBkTzfpjedSnlU6DhFJAWUrjT047iOZiZXBn
         SH04+79vrVY6jx+sqabuPvGBiLg82s2ZVvj2u7dTrorqjF03GaPW/O0LGNK2EBWOle9v
         Wwv6Y4U7V8hQRl5eWkHD/ePVMPUtVEf8KXK3kfgBoYC2MPR7U9tRx8s76QGyh5AqW17y
         OnZxcC+wa7OhTJ5/Kuen4nOzOzpV8UMoGJ6j7DDjFTNUzBo5vqQlSKi39UnpowrzfZCb
         nzqw==
X-Gm-Message-State: AOAM532qZ4SJRWJ/5NeY6vqJ0J6lKPTB7M5+wOSx8y3oFFdgc7ghDFDx
        Ca1dM1u9Nm4AgQPqeRT0Miat7g==
X-Google-Smtp-Source: ABdhPJxlkgBIS/VbsDJv1LdNt0bSAI4XsoXwQotmWBDepPddTczE/Ide+Q97wd0zG6r/nHPHYmU+3A==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr2471242wmd.128.1612254514666;
        Tue, 02 Feb 2021 00:28:34 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id l1sm29630262wrp.40.2021.02.02.00.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 00:28:34 -0800 (PST)
Date:   Tue, 2 Feb 2021 08:28:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Wenjia Zhao <driverfuzzing@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pcf50633: pdata may be a null pointer, null
 pointer dereference cause crash
Message-ID: <20210202082832.GA4774@dell>
References: <1612190499-73818-1-git-send-email-driverfuzzing@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1612190499-73818-1-git-send-email-driverfuzzing@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021, Wenjia Zhao wrote:

Please provide a suitable commit messages.

Describe the problem.
Describe the issue was found.
Describe the solution.  

> Signed-off-by: Wenjia Zhao <driverfuzzing@gmail.com>
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

A tab should be 8 chars in Linux.

>  	/*
>  	 * Should be different from bl_props.brightness, so we do not exit

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

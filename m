Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319214385F0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 01:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhJWXuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 19:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhJWXuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 19:50:08 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A61CC061764;
        Sat, 23 Oct 2021 16:47:49 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so9301852otl.11;
        Sat, 23 Oct 2021 16:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9EhtECxpEHT4/S8i65sw49IoenLttWhucmR7R+ka9Tw=;
        b=o5jZt61rJg1Bg1+MiK5QwxEdeWklbBG0IGst2aRCzPb1P5O2+CdelnpeR4gwtHiO2B
         RicJ96SYY2l0BwQ9ndqLuUKFgpIsEjklxUEUNsnPSFuwFwEa7DA9bcEgfsKNl6okpY37
         dp1XfyyUR4x5OBfAT3gn3Nlq2lTHeqly8lVc/zQ1HZ9C/v8EjNRpkNqAM6GSuTAP2dbv
         0AXTsh7kLD0iqD2csTRzEQB05+9tUea4tte0IvYV0VkD5mUaEhn4kCPLjxt9ZQRd/n9+
         mHXtZSFP0upWK0f9QAT4+P9v5rj9ppyBCmH7h5JRQkvD8/vrIriV/KzrQh2sp8ae92x7
         ihzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9EhtECxpEHT4/S8i65sw49IoenLttWhucmR7R+ka9Tw=;
        b=Cij11eK4QqcpKB/g1VvATiZaQKKxeks11JqvZJgrD2OoFTAe4uBJbxEIamoxNQg+43
         SYDJoEpCgI6ZHKZ2eM5Kb4JVw3wZ4dRFi9Az1xDPZuuo/x9cwfeMmLbd0avcEbu6zQW0
         YDlkTosJXh9h76GrSUzlEuWNnPMSXqwxonvxKrHcrov5hIF7TQUhnXbc7mDEH+2vpaGn
         ulYdhrbhKGBcclBQcpGIMFEj3ViSN0XT02+D9m3A7jIIiQQ8dM8cR4NMniyf2QwFnlQ2
         yCrgxBLDnToETrDyr1nIH3SvQ107a+KpT42/xUDyp7Z0dXtERRulVDnROjniaIj5HGhh
         OYlg==
X-Gm-Message-State: AOAM533AIi1n0rN+0tXWZK4Z4B3cmz3mInHoAUEGxfeVke2ywV3Uk1ic
        6bMIrw3JSyuMv6MdV+dm1TE=
X-Google-Smtp-Source: ABdhPJxdan+q2jqR22n6WqBpuNNuYW4hjQziIGsPymwPST3qn07it/6SqJUfVDzjseZzGGqCMZRgwQ==
X-Received: by 2002:a05:6830:4c8:: with SMTP id s8mr7120609otd.359.1635032868244;
        Sat, 23 Oct 2021 16:47:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a2sm2608077otf.46.2021.10.23.16.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 16:47:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Oct 2021 16:47:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kai Song <songkai01@inspur.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (xgene) fix return value in xgene_hwmon_probe()
Message-ID: <20211023234745.GA3703155@roeck-us.net>
References: <20211022084446.16728-1-songkai01@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022084446.16728-1-songkai01@inspur.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 04:44:46PM +0800, Kai Song wrote:
> It uses IS_ERR to judge the return value of mbox_request_channel()
> and pcc_mbox_request_channel().If it is invalid, maybe we should
> use PTR_ERR to get the correct return value.
> 

Only if the error reflects something else than -ENODEV, ie than
a missing device.

Guenter

> Signed-off-by: Kai Song <songkai01@inspur.com>
> ---
>  drivers/hwmon/xgene-hwmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
> index 382ef0395d8e..fd0847f251c0 100644
> --- a/drivers/hwmon/xgene-hwmon.c
> +++ b/drivers/hwmon/xgene-hwmon.c
> @@ -648,7 +648,7 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
>  		if (IS_ERR(ctx->mbox_chan)) {
>  			dev_err(&pdev->dev,
>  				"SLIMpro mailbox channel request failed\n");
> -			rc = -ENODEV;
> +			rc = PTR_ERR(ctx->mbox_chan);
>  			goto out_mbox_free;
>  		}
>  	} else {
> @@ -675,7 +675,7 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
>  		if (IS_ERR(ctx->mbox_chan)) {
>  			dev_err(&pdev->dev,
>  				"PPC channel request failed\n");
> -			rc = -ENODEV;
> +			rc = PTR_ERR(ctx->mbox_chan);
>  			goto out_mbox_free;
>  		}
>  
> -- 
> 2.27.0
> 

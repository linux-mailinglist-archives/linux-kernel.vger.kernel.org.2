Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF6A34CDF1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhC2K0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhC2K0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:26:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BADAC061756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 03:26:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id e14so18555374ejz.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1PyRrHa88gP4fv3wzdBtGmE3s8qTaZ8kXi0Y5jLPfiM=;
        b=pOayFRW2XXssf7jvduFdDt/MTNW5dPU7zDIMbPZv7keXD0uhfdyiSib33dcSnA8Hu3
         Nd+m1hKYpbHlPA5PItXcCpemOcZIuqTUxD4CLZmQHKfuDrLWJpKcSE99/2WKCXx/WHae
         hBbdV4k3P9g5FmFGcS75iT5ULopTuJoESaOqijBnXYZRXgmLARrGmpyT/E0jqh/UtuFZ
         cH4x1wJBN7UMJBHfhKKRX49gL9a3nTG/jXjigM2MFXILb4enVacil07wnTKeex7niRpe
         Y2b24ft5kDHQLN5jVRiGZ11LtjeRRJ9Zfvat/PCZQWtGgC29mPTZJST1VdOER7CBbxRr
         zA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1PyRrHa88gP4fv3wzdBtGmE3s8qTaZ8kXi0Y5jLPfiM=;
        b=WF4I39/7S/22cah/y4/jNGBfk7mtlAUgFNLm88UvuDhfa6+4jU/EbPGQ6EFc2aehcf
         jYIz4jzyBKYFV8VO/O1SMrqcMEFJY/8k0y/tJy0ZvYOwfbve5QMdXldaWJmxjw0/3dow
         4dtkLeLbrFAMSo2F1rCDYdxit0RwOuUuU8QYw2h5jRV7rWiQfUnwOWJ1DVBjLqifJ/eF
         XIYY9KSps/Sg7f4g6lX22CqFPRE1SVIf5+eQ4z+6XpEIo6HzTQLMLfRabUSAt1rmcIce
         6I1BzmgFLYX0jvhsUXgGfAlITWpH5pE6b8SjtSAO4xcW32LdN1UKFXxMXHqTto2AwJgx
         v4ow==
X-Gm-Message-State: AOAM533oLaGucn7ClB8tkguN0D36yCGnKNeR66/m+UjYvB/Z54nRKfrI
        JOCfHKZLuGWDzzB/mWjFb1+Eag==
X-Google-Smtp-Source: ABdhPJwEpp/sTgjo1+tUndCYaoZ9JuP+Qb7/WRdkeCt0wFxr5qiwBvoIfCh+KQZ/+TzyZd8kqkweMA==
X-Received: by 2002:a17:906:3949:: with SMTP id g9mr27002955eje.7.1617013593990;
        Mon, 29 Mar 2021 03:26:33 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id bx2sm8795750edb.80.2021.03.29.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:26:33 -0700 (PDT)
Date:   Mon, 29 Mar 2021 11:26:31 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v6 4/4] backlight: rt4831: Adds support for Richtek
 RT4831 backlight
Message-ID: <20210329102631.sh5ttefjvfsfg6tk@maple.lan>
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <1616945059-8718-4-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616945059-8718-4-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 11:24:19PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds support for Richtek RT4831 backlight.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> since v6
> - Fix Kconfig typo.
> - Remove internal mutex lock.
> - Add the prefix for max brightness.
> - rename init_device_properties to parse_backlight_properties.
> - Remove some warning message if default value is adopted.
> - Add backlight property scale to LINEAR mapping.
> - Fix regmap get to check NULL not IS_ERR.
> ---
>  drivers/video/backlight/Kconfig            |   8 ++
>  drivers/video/backlight/Makefile           |   1 +
>  drivers/video/backlight/rt4831-backlight.c | 203 +++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 drivers/video/backlight/rt4831-backlight.c
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index d83c87b..de96441 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -289,6 +289,14 @@ config BACKLIGHT_QCOM_WLED
>  	  If you have the Qualcomm PMIC, say Y to enable a driver for the
>  	  WLED block. Currently it supports PM8941 and PMI8998.
>  
> +config BACKLIGHT_RT4831
> +	tristate "Richtek RT4831 Backlight Driver"
> +	depends on MFD_RT4831
> +	help
> +	  This enables support for Richtek RT4831 Backlight driver.
> +	  It's common used to drive the display WLED. There're four channels

Nitpicking but I was expecting the original typo be converted to
"commonly".


With that addressed:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

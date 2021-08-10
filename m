Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9415B3E54A2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhHJHxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbhHJHxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:53:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26083C061796
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:53:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso1271349wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q5Khjq0P5dUoi4+YoKsNSXqU9T/AqXo0eDbT+tyOlOw=;
        b=LafTDgc2DN3RcqO6tTAoD3+Cq7kpvrALwXF0K+WUYXqjOabk/n1f38wRxaBYOSWQZd
         sGuQesIt/6/r+zg7ex6u3bDbHOiQALbnxJbne6eSCGtuLWgNTQNk0N7XPoYpqcsn3paB
         Lc7+Kz3ud4kxkfmI1QVcHW94FZwJNi4n+2uaC/cTXjnfuyJW6f+8bD1bZe2HAeHM1gr4
         cEUVHFj7TsEiT3Fvg2SyIkkg6nAm9Siz31hy/nRtoIAXQPTybNYo77bh4hJr1bwxTHG2
         4NrI7PFgJDO4VdE5ops5VuvPf6iCJWeT1qYtN+gJua9K6jgjmB2pQnttEG6YiJ5aA3xt
         aujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q5Khjq0P5dUoi4+YoKsNSXqU9T/AqXo0eDbT+tyOlOw=;
        b=MpabAl+BwfX1JD2Tj+QbxYrBMzXO960XV82NaDahvsJ7V76V4GNOtpoMnd3wc45l8q
         bZd4WdAJqzB7u+SqmQLiFIJzstqmab1olchBN84D+b/4v6jh+3sPN8Sn1CCGm7wU8WD+
         fHAnFD2CNef5Z+bCHd36SzmdhZEx45KbkJBrsYc0zTcgkUw12PWWXjANGzD3g6V4jq0e
         /jBVrSLY4zjOfD0wj9Nj6hFiixmZ42M6wscEtjZ0S4NMOzSeWXIQBB3Usky4knKBVzxd
         ph3z6IQuE0GI4rI2Lv+NptxJg1Pe1toJ2dVBrD1ZdX/L0XmAhhpdWx8DTp7f6BRk+ZLx
         EO/A==
X-Gm-Message-State: AOAM533gXj4zy62W2P/1yohFH6Fob27q6T+/Mp7Tf8Qnt9f2N9iPs0eC
        7+BFhpQcTZcvq7bnS6eD+GpsOw==
X-Google-Smtp-Source: ABdhPJwlgmtCDjJTJh+p90vQ43ECslBWsc4t7nliVX+YUVzINdgdRAl9M4yUdcAej9aVeH6dFgBg4w==
X-Received: by 2002:a1c:43c1:: with SMTP id q184mr3074006wma.173.1628582004750;
        Tue, 10 Aug 2021 00:53:24 -0700 (PDT)
Received: from google.com ([95.146.142.85])
        by smtp.gmail.com with ESMTPSA id o24sm1826269wmm.37.2021.08.10.00.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:53:24 -0700 (PDT)
Date:   Tue, 10 Aug 2021 08:53:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v10 02/11] mfd: simple-mfd-i2c: Add a Kconfig name
Message-ID: <YRIwcXggWWj1+DDf@google.com>
References: <20210807103940.152-1-alistair@alistair23.me>
 <20210807103940.152-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210807103940.152-3-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Aug 2021, Alistair Francis wrote:

You need a better commit message.

What are you doing?
Why are you doing it?
What happens if you don't do it?

> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I guess there's no harm in it.

That does mean you'll need a bespoke defconfig to run your build,
which is not advisable for generic maintenance and testing purposes.
What architecture does your H/W operate on?

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6a3fd2d75f96..09a939f8b7ff 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1176,7 +1176,7 @@ config MFD_SI476X_CORE
>  	  module will be called si476x-core.
>  
>  config MFD_SIMPLE_MFD_I2C
> -	tristate
> +	tristate "Simple MFD device"

That's not right.  You're saying:

  "Simple Multi-Functional Device device"

It should be something more like:

  "Simple Multi-Functional Device support (I2C)"

>  	depends on I2C
>  	select REGMAP_I2C
>  	help

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

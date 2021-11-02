Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5004442C57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhKBLUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBLUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:20:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2EDC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:17:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso1379842wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LMHrZiJqV7S0JuH1izO6L2hdtZQgXaQXDt7dk8GGzPY=;
        b=M8+SDVg2dlzMqHLw4Lsjc8SwZ6celGapRcFhXVzvU3BVKaTY6JtYxBXhZrkjSdRbSt
         jcyvAYxqKLWWOLRECIPVONHHi0khZP2SjqXAtjrL39qu1kUQNBuzEZi7HsZwRIknMzR6
         96YYKICBfsahTvJ8aamjaQ07/lw4MT6tqrFQipD+APMOPbnN0KELS/P/KarqDGF4fTKi
         i3tDzZ99uICsbtqZDMXrRayD9CgaMQjdt1PF9zyX3sFPAJSIpEf+qEVOjEM3zzWumx4W
         48ou2WqE5TRucn90ipWgzfXc2+yTNAVhB1TTSj4ALkVkdV5nbxic4brpW37Bj+ZP4MpB
         cpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LMHrZiJqV7S0JuH1izO6L2hdtZQgXaQXDt7dk8GGzPY=;
        b=ew80nr2XVUNHXYSvgTVVBLIl3TG/8xa09LKuEvLg/ctUl/lW3QzQl6jzOiL9bhssV1
         Sjawubx9EGFcFrlzP9kybXXfrmCAhe8QTMw9a1se0Ud24q6CaydO8fMtZ0E/EA1ZwrUA
         vbgUtt2PlsMB1wzbo/+knLKeWfG+rJHj+lFecw5KD999yujTh6eUDNVECiKnlazL4j1u
         LAt6LeWh3/dkcEzLDwO3lyGDEagSpuBezteMFQZsJtnu4CmTCU8KkHlCshtCBL+L0gmt
         nKk76gnq0z6M3qsseD6mHZFdixdUxJX9Jd7suREi467ftSuNK+oz8zr8S7q//AKJmzPp
         my7A==
X-Gm-Message-State: AOAM531YBcoRwXezen2n+smNMr7ov8EjrazJ31Lk0N1evHGYKs+ty7Oh
        WHtP+NTbFXUVgaEe+EMsrchjQ7ZypPz+pA==
X-Google-Smtp-Source: ABdhPJxCcObd+QRyFIzBLvnmYXiZKqSA10ff+r6tn/nQo4XhpaZmA3NxfyXPpUkhgxM+6xDanai89w==
X-Received: by 2002:a05:600c:3511:: with SMTP id h17mr6020459wmq.144.1635851853082;
        Tue, 02 Nov 2021 04:17:33 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id o1sm9395816wrn.63.2021.11.02.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 04:17:32 -0700 (PDT)
Date:   Tue, 2 Nov 2021 11:17:31 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     michael@walle.cc, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Select MFD_CORE to fix build error
Message-ID: <YYEeS8gz8TBW63X8@google.com>
References: <20211102100420.112215-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102100420.112215-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021, Robert Marko wrote:

> MFD_SIMPLE_MFD_I2C should select the MFD_CORE to a prevent build error:
> 
> aarch64-linux-ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
> drivers/mfd/simple-mfd-i2c.c:55: undefined reference to `devm_mfd_add_devices'

What is your use-case?

How are you enabling this symbol?

> Fixes: 3abee4579484 ("mfd: Add simple regmap based I2C driver")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/mfd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 61992edf6a4d..2de69892b631 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1204,6 +1204,7 @@ config MFD_SI476X_CORE
>  config MFD_SIMPLE_MFD_I2C
>  	tristate
>  	depends on I2C
> +	select MFD_CORE
>  	select REGMAP_I2C
>  	help
>  	  This driver creates a single register map with the intention for it

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

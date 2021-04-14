Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930BD35EB63
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 05:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346862AbhDNDRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 23:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244296AbhDNDRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 23:17:10 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBDCC06138C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:16:49 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so4297552oot.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y50XFghg6HQfih5h4TykTs5BEOGp/ySwrLPAYyEdZXk=;
        b=jnJOG/SM+QFMH16v5UorIVDpwY1Lo5BvRqF3BNYH4O0zJ6klP+Qd447YaHvje7cdA3
         5oMmvIDx2XbSIKPgpF1/N2xk3IgjY8OCoKFVunB8kGbrY2x3BYjbNzQqSZdIUpQEPYXZ
         KbIFUFa5GnYFjzbmi6cYsObd04QwbReZ7JyJRGLzRz7fkDCXKPuw/Lac/MWQdf74LuvG
         RKAzzfxJrOQF5oKrOFfmqKJsz4b/5Pkf3A8Sw1XGo7SxN71bnoVtjr80yUlFOstQgCso
         I9S0EargRRiDK5IoOQSkNDW1JfXhodeVICr6usAwy4pe4evHaexmvba/Ss7oai5yNbgI
         VohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y50XFghg6HQfih5h4TykTs5BEOGp/ySwrLPAYyEdZXk=;
        b=smUDKHeWTWc2bO/N6DNDvwiltFQkbP/vXH+fG+ocnE2UuGHC5+nMxc1qyx4bHqfgrU
         bfJpbPcuoRTuBX3UWvUgc7b0yIa4lnLBRpI+eRyiym60QoGZ8exCEbhe4j68/XE08n+e
         agKhdhM15AF/OB6rdQW/xcvk4Iayt/FhQsxsedXFzWQvei+dtC4H1EM6FJ2ZgBOKPFrn
         LUsZutQs5NM7eMujb90Ltk6T+yPF7J3CkOhbefu1MsucxCEN8q1OjYqzx7ccPRc4xlrN
         zcmWzv/tsNnwodnxUwtqBNnJbQHrjkT6LmkvwUJ+DLdxguG3Zit8PhsgdiKoHASsR68S
         6XSg==
X-Gm-Message-State: AOAM530YA/Rb4jnrTUD1l3gZK2RF+klH59xIBUCMe7hW35UDGzDFrJ6o
        BkOVtEy6DsisuifD85c869pFUA==
X-Google-Smtp-Source: ABdhPJzX9DHwmA4K1nNEs55o1ZduYVHryNh72PqiJNZ5oNbukdg0pYlzFhkCKyL0WU65Lyv4xd7VLw==
X-Received: by 2002:a4a:8247:: with SMTP id t7mr29206339oog.53.1618370208992;
        Tue, 13 Apr 2021 20:16:48 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f129sm3365917oia.9.2021.04.13.20.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 20:16:48 -0700 (PDT)
Date:   Tue, 13 Apr 2021 22:16:46 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] drivers: pinctrl: qcom: fix Kconfig dependency on
 GPIOLIB
Message-ID: <20210414031646.GA1538589@yoga>
References: <20210414025138.480085-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414025138.480085-1-julianbraha@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13 Apr 21:51 CDT 2021, Julian Braha wrote:

> When PINCTRL_MSM is enabled, and GPIOLIB is disabled,
> Kbuild gives the following warning:
> 
> WARNING: unmet direct dependencies detected for GPIOLIB_IRQCHIP
>   Depends on [n]: GPIOLIB [=n]
>   Selected by [y]:
>   - PINCTRL_MSM [=y] && PINCTRL [=y] && (ARCH_QCOM || COMPILE_TEST [=y])
> 
> This is because PINCTRL_MSM selects GPIOLIB_IRQCHIP,
> without selecting or depending on GPIOLIB, despite
> GPIOLIB_IRQCHIP depending on GPIOLIB. Having PINCTRL_MSM
> select GPIOLIB will cause a recursive dependency error.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  drivers/pinctrl/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 6853a896c476..d42ac59875ab 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -3,7 +3,7 @@ if (ARCH_QCOM || COMPILE_TEST)
>  
>  config PINCTRL_MSM
>  	tristate "Qualcomm core pin controller driver"
> -	depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
> +	depends on GPIOLIB && (QCOM_SCM || !QCOM_SCM) #if QCOM_SCM=m this can't be =y
>  	select PINMUX
>  	select PINCONF
>  	select GENERIC_PINCONF
> -- 
> 2.27.0
> 

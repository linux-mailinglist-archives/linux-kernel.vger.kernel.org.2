Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14B53A97FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhFPKq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhFPKq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:46:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3A8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:44:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a11so2090510wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yIgZCro/xGHMQPDFToE0BlBOJ2lV8EoMohjNG5xzYe8=;
        b=Ak6k7vUgdh5gXJSVOZgvPOKFQDdOF962MgoXddaTUtSRomraNAzxWwoGgdA+at4M3I
         wyIvHHqg7n4Vobz9qH6fn6IB17H1JnPuHpo8K+WLXcT+2SMZ0XSoCfNP4zHfyzFlrZ6w
         MjAI0719rMUdEjQozes7Ouif74tfs8qNOzI2hrRdVbGPy1TJz0PVAlBbMR4JyHbA2oGg
         hDcrTiMgMn4h4//jjncx88lLknhZPIznNT4+hNwDgDO8QKEEmRtkglSd/8L+ax1NX+FR
         aUktKL1CsTudBgORiN6oCcgxk6NTGXEhBl5wuLOnIG2Dayv2fGh+rD+blR/v/o/p9aSI
         b2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yIgZCro/xGHMQPDFToE0BlBOJ2lV8EoMohjNG5xzYe8=;
        b=Rm4rRUpUy7gRxP1EOMCnY53D7MrVFu9FssCrRi2ykMq7iZHyDW89Aze1WDhmBWwQcF
         jIlrXnZvrdw/wtFkjmO/je+gyr+txIOoTc9CuFSXpHGa6eFSakEkZOZzy3EHoE1VACG6
         ELsfNwl3Bx1K3/9/xk7yizfqev5R33iY7dgRKG1KeQKv7mSI8oeyvnZz5fX5l4pv0rJb
         PZUfPRJaVIaSVDplZrULMgl/9Cjw5UMfsCCQFbmIuqsdm3EkjIfQuhrsRQ3vvDUQa2e+
         +6Gd+YPMhlwCmULfF0BLVrpxN8w0XQsAC/GKt5z98YxR5wHqtUcTX/bBgFz06+qGsX0i
         WGbw==
X-Gm-Message-State: AOAM533N4yAxgSjT/r8XAm3LSttGVeGSRfMW5/w2EZwy3/jdzVv6CfNv
        pXIgdjTqMg8KU1Qd0bPuLEQrNQ==
X-Google-Smtp-Source: ABdhPJwAs7adbwcdpEVatnO4zLP35T+CI3OKOSdx7YGxx5VljLvFeTnd2jPabZa796sNnN8uH3OCXw==
X-Received: by 2002:adf:a191:: with SMTP id u17mr4571058wru.150.1623840289168;
        Wed, 16 Jun 2021 03:44:49 -0700 (PDT)
Received: from dell (94-30-15-53.xdsl.murphx.net. [94.30.15.53])
        by smtp.gmail.com with ESMTPSA id n18sm1624445wmq.41.2021.06.16.03.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 03:44:48 -0700 (PDT)
Date:   Wed, 16 Jun 2021 11:44:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] mfd: cros_ec: Add peripheral device charger
Message-ID: <YMnWH4VyLTaUCzwF@dell>
References: <20210615202051.1411878-1-dnojiri@chromium.org>
 <20210615202051.1411878-2-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210615202051.1411878-2-dnojiri@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021, Daisuke Nojiri wrote:

> This patch adds a cell entry for PCHG (Peripheral CHarGer). PCHG is a
> framework managing power supplies for peripheral devices.
> 
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> v2
> * None
> v3
> * None
> v4
> * None
> V5
> * None
> V6
> * None
> ---
>  drivers/mfd/cros_ec_dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 6135321592b76c..f3bc1cb6891ba5 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -116,6 +116,7 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
>  	{ .name = "cros-ec-pd-sysfs" },
>  	{ .name = "cros-ec-sysfs", },
>  	{ .name = "cros-ec-pd-update", },
> +	{ .name = "cros-ec-pchg", },
>  };
>  
>  static const struct mfd_cell cros_ec_vbc_cells[] = {

What's this based on?  The patch doesn't apply.

Please rebase and resend.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

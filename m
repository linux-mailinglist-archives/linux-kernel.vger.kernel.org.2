Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5F2428096
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhJJKws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 06:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhJJKwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 06:52:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5CAC061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:50:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w14so3463318edv.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GxinhD93p6jNHOzdHJBzaHDpg/GHkcxp7GHbNqNh6Q0=;
        b=Z+a6KTs/ZZdxBuVVyTdIhZzfPDmygpA/GnzcQsp51rMOCrVcapFqMB0TIIWX8q1m8A
         TzZuUjNG1USa1mz+tgzVsxxnFC97Br4QEHMz1Sx0wCp2jEPQjDDICBghCQ1AkXL8Y9Va
         3AhodvROWR/6K+Zj7D20ekWoSSxz2uOI7kADdkNac30ESq1sFiJ4BFWPTY4qf91GsGIl
         Q/BDqUGk/WJf6+uZQhUBA7f06fftD5Vds7V5DLuWHJbLrBCc7M1InAvjdog17dNYVNvt
         vT1gMEd3KdMnUDtOhxHaPTFw76ncsKdWWp3ygrQtpPO8gOcwNvfE/zV5IBh/RmPrZv7L
         veiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GxinhD93p6jNHOzdHJBzaHDpg/GHkcxp7GHbNqNh6Q0=;
        b=gBcBVS43B3J5LACe4fBY4sdATy9PUdyG2f8bnMNFBKWBQMzelZ1KYw+36wSyXHQmeK
         cReyVrxn+JxVoPSHFjhI2u0S8VZ2PBe7p/XfbxpGaA5fzWJmG508dJw9TnrHwYebP01I
         4W40lJlsPd7C5otrPvf+bQrAwcQniqwoGjzZP+yQXgVhsmFopl/rcUU5jXt7iLf6zpF6
         I7cXS17C9syNRI06m5/WOLhIhfvkx8SpWwSIxShEMoSP8/mn3t9MsJBBGv59o5nUA6QU
         +Fc22950JELu3MST/kOcZivfOwdJLx1C7Y5P4T1Ma8MzmqCKqx5lq1eCmldZTH8Q6hk5
         AtTA==
X-Gm-Message-State: AOAM530bz4nk01Bct2uVmJID+RlXIyT7/0/I0S0c2p2BzXsgFVNyHC0s
        ExrkX+DujxSMJ4n6TLH8CoE=
X-Google-Smtp-Source: ABdhPJwoB0bgCTw9dPFXXbRD19l6fylhoQ2SB4fiQMXGCmCZKn74h61kA1FsFv2wEEZ3r1NTQGXQiQ==
X-Received: by 2002:a05:6402:270e:: with SMTP id y14mr15251616edd.190.1633863043350;
        Sun, 10 Oct 2021 03:50:43 -0700 (PDT)
Received: from agape.jhs ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id k15sm635596eje.37.2021.10.10.03.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 03:50:42 -0700 (PDT)
Date:   Sun, 10 Oct 2021 12:50:39 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        dan.carpenter@oracle.com, lee.jones@linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8723bs: hal: remove if condition which is
 always false
Message-ID: <YWLFf1zPvK9gz+7+@agape.jhs>
References: <YWKXKGuA/Io9sEjf@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWKXKGuA/Io9sEjf@user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Surav,

thanks for your patch, see a comment below,

On Sun, Oct 10, 2021 at 01:02:56PM +0530, Saurav Girepunje wrote:
> Remove the if condition which is always false. The last update on
> variable max_rf_path is value 1. It's value is not changing after that.
> So if condition check for value 2 will be always false only.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
> index 392cc8a398f5..612575ba961a 100644
> --- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
> +++ b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
> @@ -106,12 +106,10 @@ static s16 odm_InbandNoise_Monitor_NSeries(
>  	pDM_Odm->noise_level.noise[RF_PATH_A] = -110 + reg_c50 + noise_data.sum[RF_PATH_A];
>  	pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_A];
> 
> -	if (max_rf_path == 2) {
> -		reg_c58 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XBAGCCore1, bMaskByte0);
> -		reg_c58 &= ~BIT7;
> -		pDM_Odm->noise_level.noise[RF_PATH_B] = -110 + reg_c58 + noise_data.sum[RF_PATH_B];
> -		pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_B];
> -	}
> +	reg_c58 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XBAGCCore1, bMaskByte0);
> +	reg_c58 &= ~BIT7;
> +	pDM_Odm->noise_level.noise[RF_PATH_B] = -110 + reg_c58 + noise_data.sum[RF_PATH_B];
> +	pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_B];
>  	pDM_Odm->noise_level.noise_all /= max_rf_path;

If the condition is always false the whole block can be wiped out,
why did you keep it? Did you change the logic here?

> 
>  	/*  */
> --
> 2.32.0
> 

thank you,

fabio

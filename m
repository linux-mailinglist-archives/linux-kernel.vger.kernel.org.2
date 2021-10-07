Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885EB425CED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 22:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbhJGUJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 16:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbhJGUJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 16:09:11 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CCCC061760
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 13:07:17 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n63so10586762oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FFdR5Q8dgTLESN1Y4gNMob3whbKhRrjkjEmOmQ6y9yQ=;
        b=aX7Admelts4w34rqAbdl/SbF4t8Z67F8SAXPtFtaijXHf4rJx1NusmvOd2KPijxVah
         AKLOdbtFlBTf+2lvoyZXVo74ssS0WgZHhK3gwlsyNEkuoFDlC+g/+uIHaaOolEVA2r/w
         S4ZKu5DWg3rY5VXN983RhELO+szcRn7HNmRL5G7tKYtzGEeOr1wgMyRV24oMWLJhlU0a
         /S03IyLnxjYn9eDNXWZAqazdU9rqQ9m6/e4v8xm85uUwsE1ojvMPFazbwgY3ttxnKgnY
         AnIJnhKuLgCSlQHKC+Mw34SMrYSU7ErUufVzCMRzH6Mc53JCgl+l6OYVcnqylGdI0BO2
         /wsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FFdR5Q8dgTLESN1Y4gNMob3whbKhRrjkjEmOmQ6y9yQ=;
        b=Z1qgM0srJMtajS2IwHrdsTU8SZvLzsg6tzNHlSj5N9nQ7/7e+Unbi2B0ZJwpGxNN6u
         9v5uWKuciizgpRpxal+cTtn2/jjQZ7IPas6C04CuOH+HSgDzbXOWqYYcRCWzzsD8wF0v
         ehbdRVrSNtkWOMKRbpaZdUhxGygKGq5OSrEAmD56qwYmqNrDjtLmqCkrPSBH5FNyvPyW
         P6EGS2KClb+R64wp6KBOXuMiZSkAl3ol2o57NMSxmIQqEC6nXAH2fMFjvy6+t0uzph4o
         1uZn7fLyjmLrYQ7sG1uri/T+Ynkp4RIkk/JV1GhKOozFEJr8RcF9pEcjhPvnigJE7/zi
         hTxQ==
X-Gm-Message-State: AOAM532X41IMmohBoDmkLLc+ok83O0Mn7OuHPFDzX2XLAlFs/CMC7RrQ
        eQ546m2PRSvqmm93sMRb4rNVNg==
X-Google-Smtp-Source: ABdhPJx7H7wjQ1XMkdMLSYMQSnlDHjAaVETulRelH3QWqNk4dhNy4p2yg4mORba1D+SfMGWMldVNkA==
X-Received: by 2002:aca:bd02:: with SMTP id n2mr13066786oif.113.1633637236885;
        Thu, 07 Oct 2021 13:07:16 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id f10sm76209otl.57.2021.10.07.13.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:07:16 -0700 (PDT)
Date:   Thu, 7 Oct 2021 13:08:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3] drivers: thermal: tsens: add timeout to
 get_temp_tsens_valid
Message-ID: <YV9T2Bq16Z6SdBDM@ripper>
References: <20211007172859.583-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007172859.583-1-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Oct 10:28 PDT 2021, Ansuel Smith wrote:

> The function can loop and lock the system if for whatever reason the bit
> for the target sensor is NEVER valid. This is the case if a sensor is
> disabled by the factory and the valid bit is never reported as actually
> valid. Add a timeout check and exit if a timeout occurs. As this is
> a very rare condition, handle the timeout only if the first read fails.
> While at it also rework the function to improve readability and convert
> to poll_timeout generic macro.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/thermal/qcom/tsens.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index b1162e566a70..99a8d9f3e03c 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -603,22 +603,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>  	int ret;
>  
>  	/* VER_0 doesn't have VALID bit */
> -	if (tsens_version(priv) >= VER_0_1) {
> -		ret = regmap_field_read(priv->rf[valid_idx], &valid);
> -		if (ret)
> -			return ret;
> -		while (!valid) {
> -			/* Valid bit is 0 for 6 AHB clock cycles.
> -			 * At 19.2MHz, 1 AHB clock is ~60ns.
> -			 * We should enter this loop very, very rarely.
> -			 */
> -			ndelay(400);
> -			ret = regmap_field_read(priv->rf[valid_idx], &valid);
> -			if (ret)
> -				return ret;
> -		}
> -	}
> +	if (tsens_version(priv) == VER_0)
> +		goto get_temp;
> +
> +	/* Valid bit is 0 for 6 AHB clock cycles.
> +	 * At 19.2MHz, 1 AHB clock is ~60ns.
> +	 * We should enter this loop very, very rarely.
> +	 * Wait 1 us since it's the min of poll_timeout macro.
> +	 * Old value was 400 ns.
> +	 */
> +	ret = regmap_field_read_poll_timeout(priv->rf[valid_idx], valid,
> +					     valid, 1, 20 * USEC_PER_MSEC);
> +	if (ret)
> +		return ret;
>  
> +get_temp:
>  	/* Valid bit is set, OK to read the temperature */
>  	*temp = tsens_hw_to_mC(s, temp_idx);
>  
> -- 
> 2.32.0
> 

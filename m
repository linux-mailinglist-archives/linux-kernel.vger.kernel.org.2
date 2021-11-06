Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F536446EC0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 16:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbhKFPxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 11:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhKFPxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 11:53:08 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0141C061746
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 08:50:27 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id y11so19780317oih.7
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Qra9akannOKhHfzF9P4EEi/dtPKcdfqFmb0pyjRQ68=;
        b=dzv9XWCCxRprjKKXScrpOCvs+6FdSi28Gvt0E1xNYibSuwbNIz+resh9bS19/F+rFB
         t3N9/psI/V5V06B0wdF1Q83rUvrwpFcMIi8ABjTLHFXJZZxNYQbhP+IKTkB56rXKdRaA
         iGWrck51xPr9+jbs1gdQIJFuj8WU778qgruuT2oafrCA+iyRBsKXKYPGeGly0kJKqjv5
         8LonxpWyKsTkJVtKSNpsh2smJm7vHFECuaTsIw+4feUfOXUnEheE2rD6/Dx4652yVGCa
         3FXl0NyG2/wiL7MF8EqEGDY2mZFMIY4EniTD16YqZy5xcXtfvLoVHx6bSTkA5DoFrTBb
         gqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Qra9akannOKhHfzF9P4EEi/dtPKcdfqFmb0pyjRQ68=;
        b=TAJFkf3SoMKdiLsizeGXcOtEUcq8WNzwq+wjqMeWzGDIJP9TTegWEzPUYjwtoIZLby
         Jvzw0kmk9ReJxdtSGIJ0KNYiGhBRUlo3C2OhMRV+udJWl8YhxdLtC0U8tjL3v7fC7yoY
         x8CpD8Uyah+lW74ufXpKswVcDQyG0LjRpAAkeqh+O/uBNuNt69p2QKMXCUeI1abc02+P
         vGY4yZktuPeW+R3yt+hVHWrKYxKro3EWFEi7Yf2bpwqmKnA2bZDA5xB+IAv5b3Gt7WqR
         +0ufW11oU4ufUtLOn7fnksGHqtd1bLEIIySSbIme0RxACDAASXBA18Mu5RA7fOS9tD+E
         fplg==
X-Gm-Message-State: AOAM532kWvGh7MX78gXBhxL+YjmWNBpo+aTrmmBqfDKnagEXVZbDiytF
        7wrjubDX+GgDl3OT0qugOz6/gg==
X-Google-Smtp-Source: ABdhPJwBJ9YCa16fxUpZolirtN5bLSZpdYhwFTjrajGd+orwqE/4zEDLYu89/vMhKXVRAg59/mmxIw==
X-Received: by 2002:a05:6808:144f:: with SMTP id x15mr27350233oiv.132.1636213826928;
        Sat, 06 Nov 2021 08:50:26 -0700 (PDT)
Received: from yoga (rrcs-97-77-166-58.sw.biz.rr.com. [97.77.166.58])
        by smtp.gmail.com with ESMTPSA id o42sm3797396ooi.9.2021.11.06.08.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 08:50:26 -0700 (PDT)
Date:   Sat, 6 Nov 2021 10:50:24 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     agross@kernel.org, amitk@kernel.org, thara.gopinath@linaro.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/qcom/spmi-adc-tm5: Remove unnecessary
 print function dev_err()
Message-ID: <YYakQHd3Hr944k1B@yoga>
References: <20211105013340.38300-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105013340.38300-1-vulab@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04 Nov 20:33 CDT 2021, Xu Wang wrote:

> The print function dev_err() is redundant because
> platform_get_irq() already prints an error.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index 824671cf494a..8492dd3bfed6 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -612,10 +612,8 @@ static int adc_tm5_probe(struct platform_device *pdev)
>  	adc_tm->base = reg;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "get_irq failed: %d\n", irq);
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	ret = adc_tm5_get_dt_data(adc_tm, node);
>  	if (ret) {
> -- 
> 2.25.1
> 

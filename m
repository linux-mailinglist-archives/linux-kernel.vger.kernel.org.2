Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFEC3A8AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhFOVKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhFOVKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:10:02 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B389DC061760
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:07:57 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id l12so61013oig.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PbZ0N3oI5rxba+H0GeCrLqD8E7sIQh2NCz/SFfq/xI0=;
        b=CaAcslFXiE8P1tk1USD6rRPo5zXsuvpEq9ZpHnyYRhWU+FTyJP8aWYAYXZtF62jrZE
         lRaR41ChtPdUEhFYpPsaGdAZ0IG3Fh9EmkQtqVlY/GPQ8v4CFHSpDxO4nPJwOiLYhXEQ
         hVdN3p598hLVTfc4d07OLK+d7cJIFGEwMTqBeGrMb8ggNqRC47u7gbDaiZG5D+DjiTiE
         L1OjdxD2MofN0s+LnQrMtlYZU/FdK4qWpOrBlezM28lCBeHQuMFM9NLuJiWmRwJFffvO
         1oBncrdDVROOJdCx+7/Hx2I9hQ7HOBmZj1ZoTEmTn3cwbHqKDzomx2iiRzZVUNN10piY
         CaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PbZ0N3oI5rxba+H0GeCrLqD8E7sIQh2NCz/SFfq/xI0=;
        b=Xt/8YIH/rNvhK0OdfhlrRz0hixTb4Oic2oGZWemZ0I48+oBRAPVvcoRAAkKF+2jb4B
         x3yAgQ6oGC9kb+aHOb0FD/EMuVakl/euy/+iVzhsKDf2uGAT1jUCKczSuU0t9Z2SuAZz
         +YCHS+oXL8B72V7ggThuh/jPemM/k30+iZZQEDucRQgHM3IELG7W+K2xX6W3qq5SXjB6
         LLLlcM+S/R/Nef4iufhURwGwC3S04eV+TKkBamkfe7t6XLDcKhM8AJ47p+ra1Iw9F1Ro
         1mKoFy4YBiSARZSP/yG6iEROecR9t184Dmj+8EI4XnTiv36cb2fiHK5lUr0iF2jv/WcJ
         tT6w==
X-Gm-Message-State: AOAM533mUdBDCmRU4OhBf1ew8QAd7tEY0QA6n9RxNFXIdNZoQyWFZ0aJ
        RlcIuMcPOWLJ/Ajj47fizIY2cw==
X-Google-Smtp-Source: ABdhPJwxEwygKHn84iNtoFbYWINQIjWIRWBmB1/JU2TR3NYEDqRcp3PlD4dDHTiCjl0VfzEbyJ5Gew==
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr748714oic.48.1623791277134;
        Tue, 15 Jun 2021 14:07:57 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m23sm24561otk.55.2021.06.15.14.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 14:07:56 -0700 (PDT)
Date:   Tue, 15 Jun 2021 16:07:55 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 07/10] pinctrl: qcom/pinctrl-spmi-gpio: Add compatible
 for pmic-gpio on SA8155p-adp
Message-ID: <YMkWq9+mSf4K7SFy@builder.lan>
References: <20210615074543.26700-1-bhupesh.sharma@linaro.org>
 <20210615074543.26700-8-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615074543.26700-8-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15 Jun 02:45 CDT 2021, Bhupesh Sharma wrote:

> SA8155p-adp PMIC (PMM8155AU) exposes 10 GPIOs.
> 
> Add support for the same in the pinctrl driver.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andy Gross <agross@kernel.org>

I don't think the Cc tags provides any value.

> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index 00870da0c94e..f886c683e2bd 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -1127,6 +1127,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
>  	{ .compatible = "qcom,pm8150b-gpio", .data = (void *) 12 },
>  	/* pm8150l has 12 GPIOs with holes on 7 */
>  	{ .compatible = "qcom,pm8150l-gpio", .data = (void *) 12 },
> +	{ .compatible = "qcom,pmm8155au-gpio", .data = (void *) 10 },

But we want to keep these sorted alphabetically.

Regards,
Bjorn

>  	{ .compatible = "qcom,pm8350-gpio", .data = (void *) 10 },
>  	{ .compatible = "qcom,pm8350b-gpio", .data = (void *) 8 },
>  	{ .compatible = "qcom,pm8350c-gpio", .data = (void *) 9 },
> -- 
> 2.31.1
> 

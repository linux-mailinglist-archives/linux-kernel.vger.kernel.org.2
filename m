Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A921F3B877F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhF3RP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhF3RPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:15:54 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056DAC0617AE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 10:13:24 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so3444239otk.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jvZWepwL1G14uE4LBC+UAM7L1L1Q+rV5kcOeGj8qP9U=;
        b=upmXr5DFLsVrOoR6J9W793kI99xmrLiW7jjYHtTF+6bjNzOUGTCL31xU7TWNTg1NQ4
         oAU4L51KjXYdwSYTK92OaQBUvY8ZKqXvcXkqg0BhwiW2gBsylMoJpCWVN0dZ2qzFKgsW
         O5o5yao5VNyVASENvu8OUHk4QZnLoF+RjS0OdT5DFbzgEEtQi+yYbS0kGng93VrYMLDG
         IuHRG7ie78kgf7PIV4W+pIpUXEfjDH3qI5F0R+rCZ9o519dJKnhjpriHH5h666uCDjF8
         mdjccHeIWBb9WspcEW2/00CHFlXL+0oiPO0wFnIkXYFQPf0lfZSkAiJ6VakG/+3eeeZz
         sLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jvZWepwL1G14uE4LBC+UAM7L1L1Q+rV5kcOeGj8qP9U=;
        b=il9CSEBrr+EQi+jWI1teFiXDupW1kplZxBs+8DZ3dMZl/KChaiZHpbZdeRlbNsI8k7
         b8u4pEc4cLbkNx4M58TB5D2lZ0AbMj4KKt60AjGWKk6KpcIgaUtI7vvkTipxe6gpYqEY
         U5LJEAGz6FLM9W+FKVPyE35OXGnm/m9EHT+iBPuKdVih5LrBc4zKkgkSsiYGVgq8cJN1
         xpGPf3izaAZuDHtG+OiuDwvqgfsn1xwSPDe8xfMpuOAF1qefqhiZkloES9cfR8B13sOJ
         328D6KkboifRBby6lJ+ztP8JF+OLoAWrU5IE5Ur2eOej1A+ZrRNLY0vHHz1ivTk0wb0G
         c4ww==
X-Gm-Message-State: AOAM5302uRrQ5iN3fmMvmJdvIp/6iegUjapL5b4tlVyGa55iBOfCVbLm
        SU4juYkZIEbkTYKIFS4ioRTtBw==
X-Google-Smtp-Source: ABdhPJwAqdr+f/kdCkP44QvzdmkAYMv7aNdhdMYKEA4dUfvT7EvSlnO1GNaDFy2XRcGdmjUK/b+UbA==
X-Received: by 2002:a9d:57ca:: with SMTP id q10mr9694037oti.224.1625073204149;
        Wed, 30 Jun 2021 10:13:24 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b11sm1204779otl.55.2021.06.30.10.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 10:13:23 -0700 (PDT)
Date:   Wed, 30 Jun 2021 12:13:21 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] clk: qcom: videocc-sm8250: stop using mmcx regulator
Message-ID: <YNymMeXHMQspwlzR@yoga>
References: <20210630133149.3204290-1-dmitry.baryshkov@linaro.org>
 <20210630133149.3204290-7-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630133149.3204290-7-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30 Jun 08:31 CDT 2021, Dmitry Baryshkov wrote:

> Now as the common qcom clock controller code has been taught about power
> domains, stop mentioning mmcx supply as a way to power up the clock
> controller's gdscs.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/videocc-sm8250.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
> index 7b435a1c2c4b..eedef85d90e5 100644
> --- a/drivers/clk/qcom/videocc-sm8250.c
> +++ b/drivers/clk/qcom/videocc-sm8250.c
> @@ -276,7 +276,6 @@ static struct gdsc mvs0c_gdsc = {
>  	},
>  	.flags = 0,
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.supply = "mmcx",
>  };
>  
>  static struct gdsc mvs1c_gdsc = {
> @@ -286,7 +285,6 @@ static struct gdsc mvs1c_gdsc = {
>  	},
>  	.flags = 0,
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.supply = "mmcx",
>  };
>  
>  static struct gdsc mvs0_gdsc = {
> @@ -296,7 +294,6 @@ static struct gdsc mvs0_gdsc = {
>  	},
>  	.flags = HW_CTRL,
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.supply = "mmcx",
>  };
>  
>  static struct gdsc mvs1_gdsc = {
> @@ -306,7 +303,6 @@ static struct gdsc mvs1_gdsc = {
>  	},
>  	.flags = HW_CTRL,
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.supply = "mmcx",
>  };
>  
>  static struct clk_regmap *video_cc_sm8250_clocks[] = {
> -- 
> 2.30.2
> 

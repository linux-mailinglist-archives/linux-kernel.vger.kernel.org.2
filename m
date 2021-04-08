Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB16357AD0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhDHDho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhDHDhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:37:40 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D05C061762
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 20:37:28 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id i3so752059oik.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 20:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pPJoEjIADtMSYqf0Oa1ErjETc00pLfQ3w68UDMPlgnc=;
        b=jNBkokWuNT8XwU++AtI4hD+oU41vAVGNABOg1x0mNuddD0q0Sed0heV56LVmZ2Yqby
         l+na0YCJi3nkmfdyvRH+7pQYRinv0mrfogiW6qfBENuZ1WkZyHR2N/ulWzgYf+KM96ae
         edk+/S0lP8DEpTrURrSMWeIYjdH4uHSB+Qxy66R4sQPWG+2UOh7oqvK22ARpJCbb8RJS
         20oYHGLceLJxmKakRpAjMP0aeQTFtinXyeOUO5FB2BZzaDh9QLv4/sE4zF49B2dOfJ+d
         95TNDIeVhTJASmD0DXrDceiYHNmaJbIKdYgSc8gTdU6NTt3XcBguIPmn0+hkBm6rJZ6A
         fsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pPJoEjIADtMSYqf0Oa1ErjETc00pLfQ3w68UDMPlgnc=;
        b=Iz4CK7W9R6RfH6ci4LwcntF+4znzg8JTSMvdnbLS4eOFwE+SlkbLCumJITcE2CylO7
         fYLOY+/+LLU17lbnykl0760S0n2SAxjePj8iux+mBQqI3yrCEpLWY+uN2RQzEG9iythh
         9r3JsnqJs4gnt9XMf5hW1/aQgl2H3gt+FXgH29gty93wLQEWNXqaYRLZPItc+lpDFc9h
         J/vcxUdOUb7eecaAm2eBqwuoALqPryu82MeUi+NE0WmzmfhoJkcTLWBidxEw3Gt1fdMi
         hZ+SR4pEl+RMvEozAqVYEzzuyskBr4RnNjHshlvBm9OKinOISU0bN4WCzFfVhIxCG6S9
         OIIQ==
X-Gm-Message-State: AOAM532mjDP762pufE9y8omdifQTUlPP8+o79+iOy1vnRnJv+I/frfON
        g5xJLl+b20mfEd8Gw/2m1eS68A==
X-Google-Smtp-Source: ABdhPJz22Iy8T7rCPwrSX0DCE93mSQjgqA9px+yfiTf+T3vrLBTSFY67OiStjJzUwd4tZMqTDqBgGw==
X-Received: by 2002:aca:f597:: with SMTP id t145mr4683354oih.121.1617853047958;
        Wed, 07 Apr 2021 20:37:27 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c12sm5109319oou.26.2021.04.07.20.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 20:37:27 -0700 (PDT)
Date:   Wed, 7 Apr 2021 22:37:25 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 2/2] pinctrl: qcom-pmic-gpio: Add support for pm8008
Message-ID: <20210408033725.GO904837@yoga>
References: <1568107824b071265b5fc3a195a1d91089ad617a.1617834404.git.gurus@codeaurora.org>
 <67ce531c58ba5663ec74021b01617e3d5cd106c7.1617834404.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ce531c58ba5663ec74021b01617e3d5cd106c7.1617834404.git.gurus@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07 Apr 17:35 CDT 2021, Guru Das Srinagesh wrote:

> Add support for the two GPIOs present on PM8008.
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index c2b9f2e..76e997a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -1137,6 +1137,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
>  	{ .compatible = "qcom,pm6150l-gpio", .data = (void *) 12 },
>  	/* pmx55 has 11 GPIOs with holes on 3, 7, 10, 11 */
>  	{ .compatible = "qcom,pmx55-gpio", .data = (void *) 11 },
> +	{ .compatible = "qcom,pm8008-gpio", .data = (void *) 2 },

As with the binding, please keep these sorted alphabetically.

With that:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

>  	{ },
>  };
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

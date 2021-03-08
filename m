Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53EF3315B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhCHSRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhCHSQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:16:42 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37177C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 10:16:42 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id g46so2403210ooi.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 10:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RRpVWdGZmpXzNxOD/XVu2j6LVoCAQEL9B4W4DbjgOgc=;
        b=oANctcJtCCsLCz0IpAdOXsegOQ7gLwg64DHHOw9UqyLf7kDCOA57BGhXrSBMR2Vmjr
         fMxD16DdIoZXSnUdJHGyOzjIll4TUKZ74NH76C+8xSaPKjP1H3r9Gub8E8UA1g88LvXW
         Befq2stmL3dOMDTTOTfxaZHSYhbfgWspbJecaMTTCcgdLmaJGeg8ZN4+gCMOm299kT/E
         F5DgNsob9ik0D1y1ppLRXMdew78Q1Fo7rGDb/VCl5UtFDD2YrZFNqjf/SNwdLvFmVNiU
         I6v1ZGOYNzsqaaiAovzS8O0AaLTardC3/GEh1542wxa8EflL/jSGdRUmdBhGAtDuBQPL
         S5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RRpVWdGZmpXzNxOD/XVu2j6LVoCAQEL9B4W4DbjgOgc=;
        b=QRHN4VciP8TEsimiYNHqeoNE+BsMpXs9ZAyRHVrH9/jMwEUpsB51e+AiKCY6/gTu8n
         2PlKCw+l4WTCkdkComUX1rrP8je8+rR66tLMtoJ92/skdIn8NbmfOVCMxkvc5kTG8lgP
         MqdIB10vQuid/jVBHhKF44VNKGvClvP67ZCA46GjmUSz6s1qd4t/nfCed69SJXAyG4sc
         KYQGNahSnmI7K0+PgTD7XpFz15KTPxZJt6eNbVitE5wJ5r2ezI7F0MSrIsCNv+bOBgGp
         kRZBXbqZONAU19MLRiU/7X9ta0vWE5OIU++HaCY+lerR3FJ2VzSZNcStLbMD417x5KKL
         nJ1A==
X-Gm-Message-State: AOAM531YUVGtyRvEemtjrlwfBuT6jUnp3rxNdi+3qKaF2dJ/We3FqBue
        4VmFzG4zOCk17r6co077lDUqFQ==
X-Google-Smtp-Source: ABdhPJyNqBH0M63DeQztwtpNL2Ukge0utegg4wOaj4jao9b9whsrPFrs1xZsgnz/4EGRJLDE7bbwqw==
X-Received: by 2002:a4a:6c19:: with SMTP id q25mr19549105ooc.42.1615227401600;
        Mon, 08 Mar 2021 10:16:41 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c20sm2449191oiw.18.2021.03.08.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:16:41 -0800 (PST)
Date:   Mon, 8 Mar 2021 12:16:39 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pinctrl: qcom: spmi-gpio: Add support for PM8350 and
 friends
Message-ID: <YEZqB9luwyh8B+d3@builder.lan>
References: <20210308164845.3210393-1-vkoul@kernel.org>
 <20210308164845.3210393-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308164845.3210393-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08 Mar 10:48 CST 2021, Vinod Koul wrote:

> Add support for the PM8350, PM8350B, PM8350C, PMK8350, PMR735A and
> PMR735B GPIO support to the Qualcomm PMIC GPIO driver.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index 9801c717e311..c2b9f2e152bb 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -1127,6 +1127,12 @@ static const struct of_device_id pmic_gpio_of_match[] = {
>  	{ .compatible = "qcom,pm8150b-gpio", .data = (void *) 12 },
>  	/* pm8150l has 12 GPIOs with holes on 7 */
>  	{ .compatible = "qcom,pm8150l-gpio", .data = (void *) 12 },
> +	{ .compatible = "qcom,pm8350-gpio", .data = (void *) 10 },
> +	{ .compatible = "qcom,pm8350b-gpio", .data = (void *) 8 },
> +	{ .compatible = "qcom,pm8350c-gpio", .data = (void *) 9 },
> +	{ .compatible = "qcom,pmk8350-gpio", .data = (void *) 4 },
> +	{ .compatible = "qcom,pmr735a-gpio", .data = (void *) 4 },
> +	{ .compatible = "qcom,pmr735b-gpio", .data = (void *) 4 },
>  	{ .compatible = "qcom,pm6150-gpio", .data = (void *) 10 },
>  	{ .compatible = "qcom,pm6150l-gpio", .data = (void *) 12 },
>  	/* pmx55 has 11 GPIOs with holes on 3, 7, 10, 11 */
> -- 
> 2.26.2
> 

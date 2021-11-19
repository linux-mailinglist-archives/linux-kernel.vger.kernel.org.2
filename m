Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212B845688F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 04:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbhKSDWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 22:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhKSDWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 22:22:33 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F2AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 19:19:32 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id be32so18955021oib.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 19:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cqMlyq/jOeLQOkq6GgCwiGzL4h1JflhqJQ3OskES09g=;
        b=TlunxoJX1z1W3zJ6QUKsO0otMHgeB+3x7rg7Y0n7Sswu+G7AK998tcf5SRGFVAnSbX
         Qc1zPHM9C6bnitpD5LDkF4IUoBRWDtbTzwumUSQvki8K4OKPe2gm5Rncr5iV/iLX8Hm8
         XWiKsI99KfT5pGsDFplRTDASYS2OEGVm47YDRjoKaAv1gsyBO2QK7fuMzhumMkzmNLwM
         BnqNCfzCbA0ipqTPOSWPySsLbI9mk3Y/YI2QusG0zQ7CYSnBBszJd1mXN4Y+MfVUQTvT
         gXUaFkmioqQY8E5euPZLG39o6z+r3C0EU441mlihRUKv945KlUvjwnuyl6y3sIEO4vlF
         iqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cqMlyq/jOeLQOkq6GgCwiGzL4h1JflhqJQ3OskES09g=;
        b=GY4jwpcwmH9GkRHye0TmwgFitaZfHPw2+Td7MDsVqvQ89JXZugQVJLsKgirzoQkXiH
         nwPtxtgrJQwhzqyTa1uMGn5PbR/sevG9Ki2/QnQIFeYePedJtU8RZSUrZlzEvGhwofME
         XGb7AUd6gEOrBJNAl9AR70R3yB9LhfYeQ2zxcunOxGgm6TnyhHDCU6Y2jBmxY+PIMxSa
         Mrqe6WY+nRWxWbsWVq0qs32/uU/K0elceR37/yCqHAoHkyQVX9L2PymiidwPi/6LY5uC
         7ns75f2nuQnaRrdcn0BbTptkGLMXPWRCgcv1V/vjif9gYCh2o72hFfIQp6SiVAJRRVdB
         GDiA==
X-Gm-Message-State: AOAM533TacxZBYAqVvFzV6ISZPwq0E+smO12M1BzeXyfDbeINqFWV+FJ
        QeiAusuY72TjccNzCuDCF49weQ==
X-Google-Smtp-Source: ABdhPJyL4AjN3Xi6Eo0L0bQBAyWmRogoFGKNPZQV0Xzaiv3K/OwfIo9sNVn+tJAw2tRYNrvQ3/Z+Rg==
X-Received: by 2002:aca:ac8a:: with SMTP id v132mr2087438oie.44.1637291972186;
        Thu, 18 Nov 2021 19:19:32 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s9sm354502otg.42.2021.11.18.19.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 19:19:31 -0800 (PST)
Date:   Thu, 18 Nov 2021 21:19:27 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org
Subject: Re: [PATCH 2/2] soc: qcom: rpmhpd: Make mx as a parent of cx only
 for sdm845
Message-ID: <YZcXvw0KExXvPwSV@builder.lan>
References: <1637040382-22987-1-git-send-email-rnayak@codeaurora.org>
 <1637040382-22987-2-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637040382-22987-2-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15 Nov 23:26 CST 2021, Rajendra Nayak wrote:

> The requirement to specify the active + sleep and active-only MX power
> domains as the parents of the corresponding CX power domains is applicable
> only on the sdm845 SoC. With the same struct definition reused for all the
> SoCs this condition was wrongly applied to all those SoCs as well, which
> isn't needed. Define new sdm845 specific structures to manage this
> dependency and remove the parent assignements from the common structure.
> 

Looking at the downstream sm8150 dts I see that both cx and mmcx
specifies mx as parent "supply".

Is this not needed or should we instead name these resources
"cx_with_mx_parent" and have sm8150 opt in as well?

Regards,
Bjorn

> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmhpd.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index c71481d..12d8ce9 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -108,7 +108,6 @@ static struct rpmhpd cx_ao;
>  static struct rpmhpd cx = {
>  	.pd = { .name = "cx", },
>  	.peer = &cx_ao,
> -	.parent = &mx.pd,
>  	.res_name = "cx.lvl",
>  };
>  
> @@ -116,7 +115,6 @@ static struct rpmhpd cx_ao = {
>  	.pd = { .name = "cx_ao", },
>  	.active_only = true,
>  	.peer = &cx,
> -	.parent = &mx_ao.pd,
>  	.res_name = "cx.lvl",
>  };
>  
> @@ -149,12 +147,28 @@ static struct rpmhpd mxc_ao = {
>  };
>  
>  /* SDM845 RPMH powerdomains */
> +static struct rpmhpd sdm845_cx_ao;
> +static struct rpmhpd sdm845_cx = {
> +	.pd = { .name = "cx", },
> +	.peer = &sdm845_cx_ao,
> +	.parent = &mx.pd,
> +	.res_name = "cx.lvl",
> +};
> +
> +static struct rpmhpd sdm845_cx_ao = {
> +	.pd = { .name = "cx_ao", },
> +	.active_only = true,
> +	.peer = &sdm845_cx,
> +	.parent = &mx_ao.pd,
> +	.res_name = "cx.lvl",
> +};
> +
>  static struct rpmhpd *sdm845_rpmhpds[] = {
>  	[SDM845_EBI] = &ebi,
>  	[SDM845_MX] = &mx,
>  	[SDM845_MX_AO] = &mx_ao,
> -	[SDM845_CX] = &cx,
> -	[SDM845_CX_AO] = &cx_ao,
> +	[SDM845_CX] = &sdm845_cx,
> +	[SDM845_CX_AO] = &sdm845_cx_ao,
>  	[SDM845_LMX] = &lmx,
>  	[SDM845_LCX] = &lcx,
>  	[SDM845_GFX] = &gfx,
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

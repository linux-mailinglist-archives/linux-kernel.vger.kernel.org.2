Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E27143F33E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 01:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhJ1XBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 19:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhJ1XBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 19:01:49 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D8EC061767
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:59:21 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so10826683otq.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UM3UPmM29d/eFua6xPkjjMmDAG+lYOy+FzK4rJP6nWQ=;
        b=g25IrA98fzp1oONkM54UmVUW1Wfy9BSfo9pM7YSMXqJW4aAqxr5eRHGzMJH9uUdBQO
         jSp4nCv5WfYJSd8LO+0VXWSILoqjBDVreCeRGWVTtqPOTXG1G7rnVoQIZ5FzdBHIP0h+
         xLNZB2PgrPnNMQ317fnoqgpMLgx1uLQ3EH9bZuFbFgMY+P4lL+Y+vlKVsaApdOMOjOz4
         SKQ1rrle0MfTj7kkL6BeHj3ix6XtAlZDUH0wIqLR8xXjOx6AF3r1z24ZjW4tw+0EGvD+
         aWBjyqPhblJYjW7uJnfHzcBN7yn4uMm9uAWRiBlRRpt7j6R43tWVPu4T0va0WPRufWeM
         Iv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UM3UPmM29d/eFua6xPkjjMmDAG+lYOy+FzK4rJP6nWQ=;
        b=YjvniFPJgLabVRHcvcu2o2HSljHgLlKuQ2udmDCBcU705CibzGTXuFCyaNaCxlGbCz
         6yrnvWK5qUjd0Uv857pZ1pKfLqJTyHrUTTaiq7zG2z6o9QQqT6BNAV8hbJvCpN9DVqcw
         jK+/iUE+v+lTEE819+N9WNQunubyDszn+1IpoCm5ymHcZToGwjwsDGt8sS/VjIdjH11Z
         4RK6CazsFgaPvwhtIu9Bv/H2aoOnrAp7WvJ5M1fSoecqYQeV5SUXAWbaZPzMIBa3V79J
         Q25pFfNw4W46SbexhqKO03zw0rTXAKGh6FkyqXX80RHVbp9bZW//sUY6mgcOUb0D+hy/
         WdcQ==
X-Gm-Message-State: AOAM530iJiLnXaVXGS/lclgh7t93Ztd3+gkhVXy/dnZXQVn5nZkZ7FlV
        rsgPHQq1rdVQiXLMhHLRbuijeQ==
X-Google-Smtp-Source: ABdhPJzyfs1hvl7qTeVzKHMS0ZXJqBz/+W6QmOhFcp0/rKhsvy6Ft9Mm3edgHCRdAkcHE9mQ7NJOrg==
X-Received: by 2002:a05:6830:19d7:: with SMTP id p23mr5709971otp.33.1635461961149;
        Thu, 28 Oct 2021 15:59:21 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p14sm1269607oov.0.2021.10.28.15.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 15:59:20 -0700 (PDT)
Date:   Thu, 28 Oct 2021 16:01:09 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        dianders@chromium.org
Subject: Re: [PATCH v2 1/2] pinctrl: qcom: Add egpio feature support
Message-ID: <YXsrtTGZW66mUtkU@ripper>
References: <1635250056-20274-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635250056-20274-1-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26 Oct 05:07 PDT 2021, Rajendra Nayak wrote:

> From: Prasad Sodagudi <psodagud@codeaurora.org>
> 
> egpio is a scheme which allows special power Island Domain IOs
> (LPASS,SSC) to be reused as regular chip GPIOs by muxing regular
> TLMM functions with Island Domain functions.
> With this scheme, an IO can be controlled both by the cpu running
> linux and the Island processor. This provides great flexibility to
> re-purpose the Island IOs for regular TLMM usecases.
> 
> 2 new bits are added to ctl_reg, egpio_present is a read only bit
> which shows if egpio feature is available or not on a given gpio.
> egpio_enable is the read/write bit and only effective if egpio_present
> is 1. Once its set, the Island IO is controlled from Chip TLMM.
> egpio_enable when set to 0 means the GPIO is used as Island Domain IO.
> 
> To support this we add a new function 'egpio' which can be used to
> set the egpio_enable to 0, for any other TLMM controlled functions
> we set the egpio_enable to 1.
> 
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 17 +++++++++++++++--
>  drivers/pinctrl/qcom/pinctrl-msm.h |  4 ++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 8476a8a..bfdba3a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -185,6 +185,7 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
>  	unsigned int irq = irq_find_mapping(gc->irq.domain, group);
>  	struct irq_data *d = irq_get_irq_data(irq);
>  	unsigned int gpio_func = pctrl->soc->gpio_func;
> +	unsigned int egpio_func = pctrl->soc->egpio_func;
>  	const struct msm_pingroup *g;
>  	unsigned long flags;
>  	u32 val, mask;
> @@ -218,8 +219,20 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
>  	val = msm_readl_ctl(pctrl, g);
> -	val &= ~mask;
> -	val |= i << g->mux_bit;
> +
> +	if (egpio_func && i == egpio_func) {
> +		if (val & BIT(g->egpio_present))
> +			val &= ~BIT(g->egpio_enable);
> +		else
> +			return -EINVAL;

You're returning here with pctrl->lock held and irqs disabled.

> +	} else {
> +		val &= ~mask;
> +		val |= i << g->mux_bit;
> +		/* Check if egpio present and enable that feature */

I never remember if egpio_enable means apss or lpass, so I think this
comment would be better as:

		/* Claim ownership of pin if egpio capable */

> +		if (egpio_func && (val & BIT(g->egpio_present)))

Can't you drop the parenthesis around the second expression?

Regards,
Bjorn

> +			val |= BIT(g->egpio_enable);
> +	}
> +
>  	msm_writel_ctl(val, pctrl, g);
>  
>  	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> index e31a516..b7110ac 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> @@ -77,6 +77,8 @@ struct msm_pingroup {
>  	unsigned drv_bit:5;
>  
>  	unsigned od_bit:5;
> +	unsigned egpio_enable:5;
> +	unsigned egpio_present:5;
>  	unsigned oe_bit:5;
>  	unsigned in_bit:5;
>  	unsigned out_bit:5;
> @@ -119,6 +121,7 @@ struct msm_gpio_wakeirq_map {
>   *                            to be aware that their parent can't handle dual
>   *                            edge interrupts.
>   * @gpio_func: Which function number is GPIO (usually 0).
> + * @egpio_func: Which function number is eGPIO
>   */
>  struct msm_pinctrl_soc_data {
>  	const struct pinctrl_pin_desc *pins;
> @@ -136,6 +139,7 @@ struct msm_pinctrl_soc_data {
>  	unsigned int nwakeirq_map;
>  	bool wakeirq_dual_edge_errata;
>  	unsigned int gpio_func;
> +	unsigned int egpio_func;
>  };
>  
>  extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

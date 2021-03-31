Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270F6350689
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbhCaSjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbhCaSjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:39:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05282C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:39:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t140so7456847pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=llqF04O4PQsCaSZ89F3HLQSCFB6Kpqqo+5c1JBHky7Q=;
        b=h6AJYyLFxtpUjVxidaNlwIEQme0YLI5fkPJtRlje+3qHhdAvUCOWJKt5cE9EkaUhuR
         65Q3TGXMYkR2tuFQr0dT5sUATELXE+O01WJ+UTihImNdFAgxbWxZ5BohB5FBHfunp32J
         NcMMMAOCblmWelKFulc0hiq9hOcI6ecPoPgpK8NWqMaTjwBmI1FTa4jtlpX49LF3Z1s1
         QzufFV+0psTzT+Vx3kEZO/BVPjvOmew561N+muELVtLB0fCWDfrctVdsWnXtSay0K3zU
         gQK8SempgwkwZNeszr0Eu7PGA2D6UTv8smvE+/ca0stYCi2LiMC1jjifMADVcErZXgiO
         sKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=llqF04O4PQsCaSZ89F3HLQSCFB6Kpqqo+5c1JBHky7Q=;
        b=o8+FJJ3KHuMFc6GdICbJQ0/Mq+mWYhCtRbxox3nH5y3z9PXJy8rKZlHzD4jSCWuO3x
         AE1IfQIYtGKsq6dTpwIMnhF2xyXX238HUKnLnWJBuKBpPyqgFztddZWYTUa3VEdMLBle
         SkHyCGickPUeQPxThyhjCG/OAstsYcwJzRyPkkq40DI84Oy7tX5LZViR8BZTjqBNOAgW
         GQ0VBet9+Op0ciXpd+JkODP85JF380Gfap9CT1nVpsQI+sxSOstg3RAwKJs0RSDSNv5x
         UUy55gar/gU5/PTBUOGXWCDUTSktxIN9gQ5nVWmkKYusHEWHLhwB+0rcIEDcwJ/K0ysk
         goDg==
X-Gm-Message-State: AOAM530zlmbfhUIJ2Tzre4/gmumEA3rGYfxunZI323W3juJg7sESr0+4
        qpVViBG9coZRdR6kUH3A7JEmqSorTpAgkog=
X-Google-Smtp-Source: ABdhPJzGoh0M7Jz1qYdbXwVSEBGS0+vDNahj69eJV3prk/eH+irICsixxMiXlVfY2XZ/tV/C1LPuMg==
X-Received: by 2002:a65:43c6:: with SMTP id n6mr4393295pgp.170.1617215963447;
        Wed, 31 Mar 2021 11:39:23 -0700 (PDT)
Received: from work ([103.77.37.129])
        by smtp.gmail.com with ESMTPSA id z4sm3582113pgv.73.2021.03.31.11.39.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Mar 2021 11:39:22 -0700 (PDT)
Date:   Thu, 1 Apr 2021 00:09:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org
Subject: Re: [PATCH v6 2/2] bus: mhi: core: Move to polling method to wait
 for MHI ready
Message-ID: <20210331183919.GN15610@work>
References: <1617215665-19593-1-git-send-email-bbhatt@codeaurora.org>
 <1617215665-19593-3-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617215665-19593-3-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 11:34:25AM -0700, Bhaumik Bhatt wrote:
> In certain devices, it is likely that there is no incoming MHI
> interrupt for a transition to MHI READY state. One such example
> is the move from Pass Through to an SBL or AMSS execution
> environment. In order to facilitate faster bootup times as there
> is no need to wait until timeout_ms completes, MHI host can poll
> every 25 milliseconds to check if device has entered MHI READY
> until a maximum timeout of twice the timeout_ms is reached.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/pm.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index b6920a5..e4aff77 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -153,35 +153,33 @@ static void mhi_toggle_dev_wake(struct mhi_controller *mhi_cntrl)
>  /* Handle device ready state transition */
>  int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
>  {
> -	void __iomem *base = mhi_cntrl->regs;
>  	struct mhi_event *mhi_event;
>  	enum mhi_pm_state cur_state;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> -	u32 reset = 1, ready = 0;
> +	u32 interval_us = 25000; /* poll register field every 25 milliseconds */
>  	int ret, i;
>  
> -	/* Wait for RESET to be cleared and READY bit to be set by the device */
> -	wait_event_timeout(mhi_cntrl->state_event,
> -			   MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state) ||
> -			   mhi_read_reg_field(mhi_cntrl, base, MHICTRL,
> -					      MHICTRL_RESET_MASK,
> -					      MHICTRL_RESET_SHIFT, &reset) ||
> -			   mhi_read_reg_field(mhi_cntrl, base, MHISTATUS,
> -					      MHISTATUS_READY_MASK,
> -					      MHISTATUS_READY_SHIFT, &ready) ||
> -			   (!reset && ready),
> -			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
> -
>  	/* Check if device entered error state */
>  	if (MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
>  		dev_err(dev, "Device link is not accessible\n");
>  		return -EIO;
>  	}
>  
> -	/* Timeout if device did not transition to ready state */
> -	if (reset || !ready) {
> -		dev_err(dev, "Device Ready timeout\n");
> -		return -ETIMEDOUT;
> +	/* Wait for RESET to be cleared and READY bit to be set by the device */
> +	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
> +				 MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 0,
> +				 interval_us);
> +	if (ret) {
> +		dev_err(dev, "Device failed to clear MHI Reset\n");
> +		return ret;
> +	}
> +
> +	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
> +				 MHISTATUS_READY_MASK, MHISTATUS_READY_SHIFT, 1,
> +				 interval_us);
> +	if (ret) {
> +		dev_err(dev, "Device failed to enter MHI Ready\n");
> +		return ret;
>  	}
>  
>  	dev_dbg(dev, "Device in READY State\n");
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

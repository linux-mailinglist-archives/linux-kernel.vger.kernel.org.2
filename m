Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DE73AD7D7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 06:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhFSEby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 00:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhFSEbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 00:31:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE3C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 21:29:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id q192so2707845pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 21:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dVypxQO/ystk+sEBGLRe5z+I1DU4hTu1EwpK2tUkJg8=;
        b=rAG2YQHtob0FjUhKeUogBI6V0jj1Z+UV/A7MF93aLKU/ZhupfxoQV+f77N/vVGi17+
         4s3RtcH6IwpenJR+6vScb3Sf9345UFCN3aCrM7WC0zSFinRo3r35z0ZE6CXYVH7P/zba
         ScPmrcPQxfZoXqewb0CywP6WS4OQB4oijD0uFktj3RPsvqU89MabK2CpCXdSAzSJhI0t
         AlzX6/Yz1CwBfVp02FCrg8W9zhJap2QzGFxoEXQLrOwiG1sMK39tLnzWXfmW885dJDKx
         /MRnuNfMhy0lBvDsHSrx4OTDzMCw+up3dfTuSF/72839YdxiJj6h5Wph9XOGPqLWYC1y
         wqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVypxQO/ystk+sEBGLRe5z+I1DU4hTu1EwpK2tUkJg8=;
        b=rbXGrKPNNOajEkT8cclYxoHItkgIug55adYf2KhLlwWWhUDxt2JyjduRIlBoqyO/rL
         F8jgpTMc21HzptA/IcqJDl8cXWRLK9ybFdRiJwstz4MG5autGYAO0F1uhGAXqH8/ZC4j
         W0rHPTpK7A/I+rOXsGLX3E9WvKqieYA02lKXtt7R+JIbBJ7nenzJzS905MfXmjVnF05S
         DZ08nNCS1p65CEzcCI0gUYlPD1Fg6bz9AUoJdSnalV74aiiT9ZwGU/aXgiiaWjwX5MzH
         pifI/1HogtYu/Mx3yatY8ux8p4IMdD1M7/K35AUWMEjfrwAQBDugF33t2usEKa1nrvFr
         somQ==
X-Gm-Message-State: AOAM530fFKyR1fT2zzuLEAg/j8YbbB8XGZ5m+6xugwuZYUDeZuZqkJOo
        IgC5FkeuA3ROAaPeBg6dQMnx
X-Google-Smtp-Source: ABdhPJxGQriPYyZzghfb7mghFQhGw2pDz2zplyGxSSbdq20iO1FmfG7WIKk1UBav+oDwywUIywFYBw==
X-Received: by 2002:a62:5e05:0:b029:2fb:2ee4:2b9c with SMTP id s5-20020a625e050000b02902fb2ee42b9cmr8444371pfb.0.1624076980606;
        Fri, 18 Jun 2021 21:29:40 -0700 (PDT)
Received: from workstation ([120.138.12.53])
        by smtp.gmail.com with ESMTPSA id y13sm9865994pgp.16.2021.06.18.21.29.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jun 2021 21:29:39 -0700 (PDT)
Date:   Sat, 19 Jun 2021 09:59:36 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v2] bus: mhi: core: Add support for processing priority
 of event ring
Message-ID: <20210619042936.GA4889@workstation>
References: <1624053903-24653-1-git-send-email-bbhatt@codeaurora.org>
 <1624053903-24653-2-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624053903-24653-2-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 03:05:03PM -0700, Bhaumik Bhatt wrote:
> From: Hemant Kumar <hemantk@codeaurora.org>
> 
> Event ring priorities are currently set to 1 and are unused.
> Default processing priority for event rings is set to regular
> tasklet. Controllers can choose to use high priority tasklet
> scheduling for certain event rings critical for processing such
> as ones transporting control information if they wish to avoid
> system scheduling delays for those packets. In order to support
> these use cases, allow controllers to set event ring priority to
> high.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c | 3 +--
>  drivers/bus/mhi/core/main.c | 9 +++++++--
>  include/linux/mhi.h         | 2 +-
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index c81b377..4446760 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -673,8 +673,7 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
>  				&mhi_cntrl->mhi_chan[mhi_event->chan];
>  		}
>  
> -		/* Priority is fixed to 1 for now */
> -		mhi_event->priority = 1;
> +		mhi_event->priority = event_cfg->priority;
>  
>  		mhi_event->db_cfg.brstmode = event_cfg->mode;
>  		if (MHI_INVALID_BRSTMODE(mhi_event->db_cfg.brstmode))
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 8ac73f9..3775c77 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -454,10 +454,15 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
>  
>  		if (mhi_dev)
>  			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
> -	} else {
> -		tasklet_schedule(&mhi_event->task);
> +
> +		return IRQ_HANDLED;
>  	}
>  
> +	if (!mhi_event->priority)
> +		tasklet_hi_schedule(&mhi_event->task);
> +	else
> +		tasklet_schedule(&mhi_event->task);
> +
>  	return IRQ_HANDLED;
>  }
>  
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 86cea52..bf23c21 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -250,7 +250,7 @@ struct mhi_channel_config {
>   * @irq_moderation_ms: Delay irq for additional events to be aggregated
>   * @irq: IRQ associated with this ring
>   * @channel: Dedicated channel number. U32_MAX indicates a non-dedicated ring
> - * @priority: Priority of this ring. Use 1 for now
> + * @priority: Processing priority of this ring. 0 is high and 1 is regular
>   * @mode: Doorbell mode
>   * @data_type: Type of data this ring will process
>   * @hardware_event: This ring is associated with hardware channels
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

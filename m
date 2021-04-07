Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205EB3563E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345605AbhDGG1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345581AbhDGG1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:27:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7BFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 23:27:09 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h25so12267835pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZAsEP7CDCAOT6qcwA8OMDuBunynai3sKp6dXAwfPiG8=;
        b=XnkgaCluKxzSBthIlFoSwPfq3bgU4+E38d7QbJH7VsqKH/fsLb6PNSX6nlm+4pWkC9
         xPZ046hLahieXakdRA0rXbP7kFJCHmEmjTliJeVB9hQ69TKoGagSvptssFZH6FU7ouqF
         KIk5Y3qORmM+T6kakwZOAzwUmbT9mL6pmGA/CL3tdo0oW2EHktzHzc4pZHJUxgDW9u8B
         pZGfOd8yWFZ8HS3Yd66/1FDx8T/iHgpf+/vf8XUXJQHGoFJsX9GU7s8+WJ7cdZ4TkieP
         T3yxkkxWfWLtENxJbFYHBmpeOcpTA/GcGWeWv0WDzxtwoSQfOpAULpy7VxO6hid51FV3
         /Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZAsEP7CDCAOT6qcwA8OMDuBunynai3sKp6dXAwfPiG8=;
        b=GJfDoN0k7pmfiY7WSQyoUbKmxI52QfVQZg+hN3oQG0jWmloE7V2KR5UKYVp91er+9i
         8oAMQqWzjemx/iKtGP/1QElvsWVpuOGb0l1smIzwUOJI9vQGnXyqVrNRmJMuzOxIWjiP
         QMbKR79nbaXaMfNFE9zSKfJb6V80/PmL8CAoeGiYdkdf382sQ4QJ2NuCTmknNQ5ZVo1T
         JbbPmAwoQjs8IeJCDFgK70sbTDovWIMgmT+IMwumqLGls/61WSjRXo2k182QyVu56Bi0
         PB4KMH3BFiWxEckfhataqBIl1hT3T+9RGDEJSZw8QrvFemj6FqDhIIerAcyE/qF2eaki
         nPIA==
X-Gm-Message-State: AOAM533siR0CeNwKfknX4/9XwN2XP7SWRaJcZQB6W8xQ1gKYb85vzNzU
        4MSHgXgXLq5yPpD1GCae8had7PbEcONk
X-Google-Smtp-Source: ABdhPJzXLh067Ou6hO+HgW4rdso63ny7X/Vw+zmBqB4+xSgJfiSKidvww2TXBY9Y7wt+nvw415XHcg==
X-Received: by 2002:aa7:9804:0:b029:1f1:5340:77c1 with SMTP id e4-20020aa798040000b02901f1534077c1mr1646668pfl.72.1617776829282;
        Tue, 06 Apr 2021 23:27:09 -0700 (PDT)
Received: from work ([103.77.37.180])
        by smtp.gmail.com with ESMTPSA id w124sm20617346pfb.73.2021.04.06.23.27.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Apr 2021 23:27:08 -0700 (PDT)
Date:   Wed, 7 Apr 2021 11:57:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org
Subject: Re: [PATCH v8 4/9] bus: mhi: core: Update debug messages to use
 client device
Message-ID: <20210407062705.GF8675@work>
References: <1617311778-1254-1-git-send-email-bbhatt@codeaurora.org>
 <1617311778-1254-5-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617311778-1254-5-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:16:13PM -0700, Bhaumik Bhatt wrote:
> Debug messages dealing with client devices use the generic MHI
> controller or parent device along with a channel number. It would
> be better to instead use the client device directly and enable
> better log messages for channel updates.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/main.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 710ca0f..94fdbf7 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -1238,7 +1238,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>  				    struct mhi_chan *mhi_chan,
>  				    enum mhi_ch_state_type to_state)
>  {
> -	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct device *dev = &mhi_chan->mhi_dev->dev;
>  	enum mhi_cmd_type cmd = MHI_CMD_NOP;
>  	int ret;
>  
> @@ -1316,7 +1316,7 @@ static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
>  				    struct mhi_chan *mhi_chan)
>  {
>  	int ret;
> -	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct device *dev = &mhi_chan->mhi_dev->dev;
>  
>  	mutex_lock(&mhi_chan->mutex);
>  
> @@ -1340,13 +1340,11 @@ int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
>  			struct mhi_chan *mhi_chan)
>  {
>  	int ret = 0;
> -	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct device *dev = &mhi_chan->mhi_dev->dev;
>  
>  	if (!(BIT(mhi_cntrl->ee) & mhi_chan->ee_mask)) {
> -		dev_err(dev,
> -			"Current EE: %s Required EE Mask: 0x%x for chan: %s\n",
> -			TO_MHI_EXEC_STR(mhi_cntrl->ee), mhi_chan->ee_mask,
> -			mhi_chan->name);
> +		dev_err(dev, "Current EE: %s Required EE Mask: 0x%x\n",
> +			TO_MHI_EXEC_STR(mhi_cntrl->ee), mhi_chan->ee_mask);
>  		return -ENOTCONN;
>  	}
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABA93563EC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345621AbhDGGbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244556AbhDGGbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:31:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DCCC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 23:31:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ep1-20020a17090ae641b029014d48811e37so754165pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 23:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yC4kTEQ4kt+BQVjx0bEoDu38H7HCXJk31461oTJcfu4=;
        b=ckXsfmztXzYPiE+OehHQkEMGBOYlMxAQD5RpQgX0BsulbzXC5X0CjwhQc18yorwINL
         uw5WA/uu7sBplI+OGisR03HlLfildDNhgzBmdmE8dmKFnnJu1CvAT/gi1GR8w2XzPPS6
         5dGMpjLr8PiGb/LaeFxPEtukEke8zjlsKp2OHdWgZ3wstA/Xt1eRiE3xy+QbsPUaZ8gs
         +6JnPstpz8PtuD4TPfhTKZR9kJGzD8Hi/xGfYGunbU5sZBIwB97FqWeqmbYZpXyLWNbG
         CDAJLFyLIpXoM6nGGQLbNaATnEE08n6Ocofv3IjTEyoufzW3d7s0n9s7EHUd8BE6itxs
         cnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yC4kTEQ4kt+BQVjx0bEoDu38H7HCXJk31461oTJcfu4=;
        b=GqDKMF3Vx9hLKg9ZuWOw19AZQMdzV9Q2gBSrFwkEIuOrQpyUmSuE4auMAzy6YrIuuM
         a1OZvTjQICeVMZTdMhlGArAeJOy6K7pYL5yiWK385GLxrC7v4FmIzHHiLnc1C6QNjJ+4
         80uWuK7KuCMK2CE+4gHg+lnwEM8uYId8Swr7vFhmUcigy4ALGiScwoODmJX0VFtDwOmn
         whfQokyEHvbUsVlXE3Y1r30uDLPggLaWT9IJpXLjrvT1Ca3KvYakUXAAIag9GFVALMG8
         T0bJqTJYIUARAhS34eKHYQf1uRAMMawldA1Rpmp2O7fr02hOHoR95H69V6X+KTx5W/2w
         wSng==
X-Gm-Message-State: AOAM531CytL3MDifbr+J7YfnrHxEq3tOIi7qMbH8MfNF8VjihSPIJOfa
        84lhte/F8rzOlL1siBz0sVyM
X-Google-Smtp-Source: ABdhPJxnfh0KFjN/Fl+m5Dlkmg4dZACXP6vfDVJO3bYPUSQ15+dGuPUWrljFKB6TRaluLdx4pEqJcQ==
X-Received: by 2002:a17:903:31cc:b029:e4:bd48:c8e3 with SMTP id v12-20020a17090331ccb02900e4bd48c8e3mr1624231ple.40.1617777092558;
        Tue, 06 Apr 2021 23:31:32 -0700 (PDT)
Received: from work ([103.77.37.180])
        by smtp.gmail.com with ESMTPSA id m195sm1169352pfd.99.2021.04.06.23.31.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Apr 2021 23:31:32 -0700 (PDT)
Date:   Wed, 7 Apr 2021 12:01:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org
Subject: Re: [PATCH v8 5/9] bus: mhi: core: Hold device wake for channel
 update commands
Message-ID: <20210407063128.GG8675@work>
References: <1617311778-1254-1-git-send-email-bbhatt@codeaurora.org>
 <1617311778-1254-6-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617311778-1254-6-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:16:14PM -0700, Bhaumik Bhatt wrote:
> MHI host can fail early if device is in a bad state by attempting
> to assert device wake and holding the runtime PM vote before
> sending a channel update command instead of performing a wake
> toggle and waiting for a timeout if the send were to fail. This
> can help improve the design and enable shorter wait periods for
> device to respond as votes are already held.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/main.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 94fdbf7..989a2a8 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -1278,16 +1278,18 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>  		return -EINVAL;
>  	}
>  
> -	mhi_cntrl->wake_toggle(mhi_cntrl);
> +	/* bring host and device out of suspended states */
> +	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
> +	if (ret)
> +		return ret;
>  	mhi_cntrl->runtime_get(mhi_cntrl);
> -	mhi_cntrl->runtime_put(mhi_cntrl);
>  
>  	reinit_completion(&mhi_chan->completion);
>  	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, cmd);
>  	if (ret) {
>  		dev_err(dev, "%d: Failed to send %s channel command\n",
>  			mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
> -		return ret;
> +		goto exit_channel_update;
>  	}
>  
>  	ret = wait_for_completion_timeout(&mhi_chan->completion,
> @@ -1296,9 +1298,12 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>  		dev_err(dev,
>  			"%d: Failed to receive %s channel command completion\n",
>  			mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
> -		return -EIO;
> +		ret = -EIO;
> +		goto exit_channel_update;
>  	}
>  
> +	ret = 0;
> +
>  	if (to_state != MHI_CH_STATE_TYPE_RESET) {
>  		write_lock_irq(&mhi_chan->lock);
>  		mhi_chan->ch_state = (to_state == MHI_CH_STATE_TYPE_START) ?
> @@ -1309,7 +1314,11 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>  	dev_dbg(dev, "%d: Channel state change to %s successful\n",
>  		mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
>  
> -	return 0;
> +exit_channel_update:
> +	mhi_cntrl->runtime_put(mhi_cntrl);
> +	mhi_device_put(mhi_cntrl->mhi_dev);
> +
> +	return ret;
>  }
>  
>  static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

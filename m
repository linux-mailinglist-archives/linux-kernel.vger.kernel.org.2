Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734BE33CDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhCPGSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCPGSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:18:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201FBC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 23:18:48 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n17so12897628plc.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 23:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TguaXqmd8x2or75hALM9SNABakfsKUxz8lHQoAaEArU=;
        b=Mj4QyqhV3XdiAqA4SjpUsa5Tq5JsJWiCZkqHI6b+KDlrVz8tR2Nsy1lhorqh9/sxcG
         BQfxwsPZrge3xBoS6WdenSEkCx4/tQS1+wGVfMzng/SjMAs4C8zvEJJGwtIVXpK5yj7m
         j69KRo6wN7A7qXntRCEpDF1RhN5cvRe5SwjAazXBw/4O4K6ITDjcfhbpzicbsNCYXQwE
         EzIo177kEKnibzH2Rxt3YoHtwetg+XjFUnUKW/BYSpCGn22bo8HIKLAlJ+N10Ndh0R4E
         bAgEsoQYuiye/ih5jS+yz6tzYokPqycjCXOqkolf+o6gKpEvG0Qk9rS6aSVwQ4+zKoCx
         iYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TguaXqmd8x2or75hALM9SNABakfsKUxz8lHQoAaEArU=;
        b=tIQmiz+X1n+jnSruKxxaUK47L+V9aA9ytNdy65aFgjznMPcFNlcBlI2F2zUmgeiYLn
         YOB4oL02Gdu5AS2zTnQozII6W70Fp3Rur43Qx5+k16gK50Vg1ffhNw5sR7uZtoLA/prF
         0X3UBaTrT8ntxVVs3CXo01eU/KkiteMoUlpk2Ehp1nwSHRK67Q5U4uuRpDycbfI8rE+A
         4X+w8yBmz5R8hIX9HlMcF80OYZ7p9oGIjFmOZnHcIClXXk6ZPJcPe1ltCkplf8JF8JhA
         exy6olIVyM/+0hBkQ1lcfuvNOqN6CJ3CU3ydgUklg9GRm2ZEW5EDr3sBxaVUidUem5v+
         zmtw==
X-Gm-Message-State: AOAM532gXNobs11zzhiEFD9sm4urjF1aZIhimOfKfHF9aDg1PPc9sBBx
        GofjeilgvU8tDXFE/aWZEqtADdIURnMOxlA=
X-Google-Smtp-Source: ABdhPJyPt9iAovD241Wypbx2549tYfVbiI0PbF3mXX5I55qXsahZMaDBSmHXsW27iSbo9uUtYYHiyQ==
X-Received: by 2002:a17:90a:8a8b:: with SMTP id x11mr3144751pjn.151.1615875527679;
        Mon, 15 Mar 2021 23:18:47 -0700 (PDT)
Received: from thinkpad ([103.66.79.72])
        by smtp.gmail.com with ESMTPSA id v3sm14865198pff.217.2021.03.15.23.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 23:18:47 -0700 (PDT)
Date:   Tue, 16 Mar 2021 11:48:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] bus: mhi: core: Check state before processing
 power_down
Message-ID: <20210316061843.GI1798@thinkpad>
References: <1615409365-8165-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615409365-8165-1-git-send-email-jhugo@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 01:49:25PM -0700, Jeffrey Hugo wrote:
> We cannot process a power_down if the power state is DISABLED.  There is
> no valid mhi_ctxt in that case, so attepting to process the power_down
> will likely result in a null pointer dereference.  If the power state is
> DISABLED, there is nothing to do anyways, so just bail early.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Applied to mhi-next!

Thanks,
Mani

> ---
> 
> v3: Move the pm_lock use up
> v2: Fix subject and tweak the locking to avoid needless lock/unlock/relock
> 
>  drivers/bus/mhi/core/pm.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index 414da4f..ea62549 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -1149,6 +1149,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  		mhi_deinit_dev_ctxt(mhi_cntrl);
>  
>  error_dev_ctxt:
> +	mhi_cntrl->pm_state = MHI_PM_DISABLE;
>  	mutex_unlock(&mhi_cntrl->pm_mutex);
>  
>  	return ret;
> @@ -1160,12 +1161,19 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
>  	enum mhi_pm_state cur_state, transition_state;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  
> +	mutex_lock(&mhi_cntrl->pm_mutex);
> +	write_lock_irq(&mhi_cntrl->pm_lock);
> +	cur_state = mhi_cntrl->pm_state;
> +	if (cur_state == MHI_PM_DISABLE) {
> +		write_unlock_irq(&mhi_cntrl->pm_lock);
> +		mutex_unlock(&mhi_cntrl->pm_mutex);
> +		return; /* Already powered down */
> +	}
> +
>  	/* If it's not a graceful shutdown, force MHI to linkdown state */
>  	transition_state = (graceful) ? MHI_PM_SHUTDOWN_PROCESS :
>  			   MHI_PM_LD_ERR_FATAL_DETECT;
>  
> -	mutex_lock(&mhi_cntrl->pm_mutex);
> -	write_lock_irq(&mhi_cntrl->pm_lock);
>  	cur_state = mhi_tryset_pm_state(mhi_cntrl, transition_state);
>  	if (cur_state != transition_state) {
>  		dev_err(dev, "Failed to move to state: %s from: %s\n",
> -- 
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 

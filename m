Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F87356487
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345715AbhDGGut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhDGGus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:50:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 23:50:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h20so8844702plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BeKfVjCUZvFKJpFiJhFCeM2I1uOgywxl1gHTP4jNdr0=;
        b=rFJlwghnU6O5RYyVv16i2w6FYSjm7GJXSCOJjHR7W0Ez/IlYOLoOlTuF2lAhn6c5WE
         35wVtIGcmXTxO3uigyjwBu2wW+YWM85AV2BYWft+U3CZchF2DCeoEbbcC1uBaH9d8nZ2
         P3XlqrCJsD3oyH608kv207onnIoZ7h/D3Wxu13syY7pOXa1LJ/S/W1iVNsAhsBqmX+p6
         STDVNSsEtcdqhYddH6HHdYZjhS/KgmheCFL+xg515Ql7r0AMr2WkI3YZoDe5IO0qkwP8
         35pt/iyx9nFhtmfnbXQh0RZcYx6I7rv1Vr5IcJzroEQHijBwaIKxVrTvIWOEBpEsyBIA
         T2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BeKfVjCUZvFKJpFiJhFCeM2I1uOgywxl1gHTP4jNdr0=;
        b=OPHibhsBSkhGvUBeyKB2yG2rgJaoG4Lhvg5NxI3FXRMx/uAz52ZwD3/1XVxBqSRYMP
         iZSyIBBUmTWV0qbnZv8/U2Zcj78UTiGUzQjWyosHVf992KnRruTYO+wx0Wzw4kRcQj5K
         150MfkS1Z47vViFO7k/tXHsolXfHrJjsSRihBfV/UlnOqEN4BulbfSWh4eisrXl6CRJF
         9kuK4HLpZIL+oj2x00P4MXfbCSeF/PomxE+BXSw3u2c2h7q6IlTA2+lpmPwFJgxijpv1
         /XDEaJdOOThiskwsIv+HSmVNJFNDMVgRgSXK3+BPsIWYqCxRT66OEqyBHq3r6ga9vC5w
         8RCQ==
X-Gm-Message-State: AOAM532vp0+8cJadZluijzpgrtmKluyUZGPA7JiSyyPAcH4qe8b4Q/74
        bfHyNqnqao/5WYyPdAFZdrgb
X-Google-Smtp-Source: ABdhPJwxBds4w9+ANQaQaY+u6Z9OlbEZjI61MFcKNLqYyRSsdzO4CwwZMqRsDB+dF8Kgbl7p3XJMPw==
X-Received: by 2002:a17:90b:46c1:: with SMTP id jx1mr1871326pjb.220.1617778238498;
        Tue, 06 Apr 2021 23:50:38 -0700 (PDT)
Received: from work ([103.77.37.180])
        by smtp.gmail.com with ESMTPSA id k11sm4379779pjs.1.2021.04.06.23.50.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Apr 2021 23:50:37 -0700 (PDT)
Date:   Wed, 7 Apr 2021 12:20:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, loic.poulain@linaro.org, kvalo@codeaurora.org
Subject: Re: [RESEND PATCH] bus: mhi: core: Remove pre_init flag used for
 power purposes
Message-ID: <20210407065034.GK8675@work>
References: <1617313309-24035-1-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617313309-24035-1-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:41:49PM -0700, Bhaumik Bhatt wrote:
> Some controllers can choose to skip preparation for power up.
> In that case, device context is initialized based on the pre_init
> flag not being set during mhi_prepare_for_power_up(). There is no
> reason MHI host driver should maintain and provide controllers
> with two separate paths for preparing MHI.
> 
> Going forward, all controllers will be required to call the
> mhi_prepare_for_power_up() API followed by their choice of sync
> or async power up. This allows MHI host driver to get rid of the
> pre_init flag and sets up a common way for all controllers to use
> MHI. This also helps controllers fail early on during preparation
> phase in some failure cases.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Applied to mhi-next!

Thanks,
Mani

> ---
> This patch was tested on arm64 architecture.
> 
>  drivers/bus/mhi/core/init.c |  3 ---
>  drivers/bus/mhi/core/pm.c   | 20 --------------------
>  include/linux/mhi.h         |  2 --
>  3 files changed, 25 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index d1d9b0d..1f61352 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -1080,8 +1080,6 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>  			mhi_rddm_prepare(mhi_cntrl, mhi_cntrl->rddm_image);
>  	}
>  
> -	mhi_cntrl->pre_init = true;
> -
>  	mutex_unlock(&mhi_cntrl->pm_mutex);
>  
>  	return 0;
> @@ -1112,7 +1110,6 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
>  	}
>  
>  	mhi_deinit_dev_ctxt(mhi_cntrl);
> -	mhi_cntrl->pre_init = false;
>  }
>  EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
>  
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index e4aff77..b23eec5 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -1062,13 +1062,6 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  	mutex_lock(&mhi_cntrl->pm_mutex);
>  	mhi_cntrl->pm_state = MHI_PM_DISABLE;
>  
> -	if (!mhi_cntrl->pre_init) {
> -		/* Setup device context */
> -		ret = mhi_init_dev_ctxt(mhi_cntrl);
> -		if (ret)
> -			goto error_dev_ctxt;
> -	}
> -
>  	ret = mhi_init_irq_setup(mhi_cntrl);
>  	if (ret)
>  		goto error_setup_irq;
> @@ -1150,10 +1143,6 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  	mhi_deinit_free_irq(mhi_cntrl);
>  
>  error_setup_irq:
> -	if (!mhi_cntrl->pre_init)
> -		mhi_deinit_dev_ctxt(mhi_cntrl);
> -
> -error_dev_ctxt:
>  	mhi_cntrl->pm_state = MHI_PM_DISABLE;
>  	mutex_unlock(&mhi_cntrl->pm_mutex);
>  
> @@ -1203,15 +1192,6 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
>  	flush_work(&mhi_cntrl->st_worker);
>  
>  	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
> -
> -	if (!mhi_cntrl->pre_init) {
> -		/* Free all allocated resources */
> -		if (mhi_cntrl->fbc_image) {
> -			mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
> -			mhi_cntrl->fbc_image = NULL;
> -		}
> -		mhi_deinit_dev_ctxt(mhi_cntrl);
> -	}
>  }
>  EXPORT_SYMBOL_GPL(mhi_power_down);
>  
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index b16afd3..c9b36a3 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -354,7 +354,6 @@ struct mhi_controller_config {
>   * @index: Index of the MHI controller instance
>   * @bounce_buf: Use of bounce buffer
>   * @fbc_download: MHI host needs to do complete image transfer (optional)
> - * @pre_init: MHI host needs to do pre-initialization before power up
>   * @wake_set: Device wakeup set flag
>   * @irq_flags: irq flags passed to request_irq (optional)
>   *
> @@ -447,7 +446,6 @@ struct mhi_controller {
>  	int index;
>  	bool bounce_buf;
>  	bool fbc_download;
> -	bool pre_init;
>  	bool wake_set;
>  	unsigned long irq_flags;
>  };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

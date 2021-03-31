Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9677734FF52
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhCaLOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbhCaLNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:13:36 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5BFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:13:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c204so14318619pfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cTNjg6HvxxtcZIehFPWQaL/bqo7FDl224EWcw1m7hLg=;
        b=W/CdbnGEtLfEUqQ4mGFw35UvqKVrwhUs5Vg0iEUTLHhUvHA4iYdfYKY0560N/nWGtp
         nMMnsI7OR07SSmm6ypy/LkyZJg2ig6nrYKUcA5G/opeh+cbxQA77lXdUkiYxDT9eLggS
         iNnkgW687GVFyrLz68zTeqJAXY2ITalkMo1i1VOl5RNblsqOyCC1VMJ5P1qGFUOKF2Es
         O4iz5U6dHcVFB1BRZxWd1CUL1D3QxXOXWlZw/PYXq0Q6616hE0v7OlW0Wrmo+J4k4z8L
         ApkE/ND63cpOdhL9FLaQAMZphbKFcnuG9elmvdlI21464kBW94zyYVf91Wo5nEDeKSbx
         8csQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cTNjg6HvxxtcZIehFPWQaL/bqo7FDl224EWcw1m7hLg=;
        b=MUeHzQX5+lnlAObgsb6V1a6yihotVMkcxlTdyv25AklRVvOI/kvSOOMrflQPcuC+zi
         noknp9LoTzMxDxnhhvNuNOcwl/5h2QXPMJUzhqMixGu6t46wXNUfvg54PLaPZUglY3NG
         ghKsgzI5teouXDswJ1diF4HZ4tbkKPVTLHEhAYFdN1TLNERWlVWoFFfzGwXQ5EeBUttY
         Irz1Ezif4kwxHa/xi6qIOOEdh77giKcJlBMTru0Xa2dUJDv6DV0GtwkoHgfSofL3NIea
         4ADb0SvTjiXFTdWlF7e1TXFq79Vdy0pHlJh7EbF0/2qxPKb6U5X+VqiAzV1DtYpo78HO
         q9kQ==
X-Gm-Message-State: AOAM530HSw3BSIDfra0e66XhLNyDpGttfhR4eS/0N8BW07450dUqfi3x
        KeawC3EbnKVRQtwb3e+Q+G2l
X-Google-Smtp-Source: ABdhPJyzeAyKVwr4h2tDIF103Vurv3C+PnSrGmAOgcf4inJRsQRwihF8Xvhgig/skjeTyDpvQbbWFA==
X-Received: by 2002:a65:4508:: with SMTP id n8mr2723575pgq.294.1617189215417;
        Wed, 31 Mar 2021 04:13:35 -0700 (PDT)
Received: from work ([103.77.37.129])
        by smtp.gmail.com with ESMTPSA id j20sm8660663pji.3.2021.03.31.04.13.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Mar 2021 04:13:34 -0700 (PDT)
Date:   Wed, 31 Mar 2021 16:43:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org, abickett@codeaurora.org
Subject: Re: [PATCH v1 6/7] bus: mhi: core: Wait for MHI READY state in most
 scenarios
Message-ID: <20210331111331.GD15610@work>
References: <1617067704-28850-1-git-send-email-bbhatt@codeaurora.org>
 <1617067704-28850-7-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617067704-28850-7-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 06:28:23PM -0700, Bhaumik Bhatt wrote:
> When moving from SYS_ERROR transition to a different execution
> environment, MHI host relies on the BHI register read to spawn
> the next image download or wait for READY -> M0 states. The
> device can at times move the execution environment to mission
> mode when a pass through is expected, which can result in a
> stall. Initiate a wait for MHI READY and write M0 such that the
> device can proceed with state change event updates for any new
> execution environment being entered. This allows us to remove
> conditionals in handling firmware load for PBL modes and keeps
> the execution environment out of the picture as it can change at
> any time.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/boot.c | 4 ++--
>  drivers/bus/mhi/core/pm.c   | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 0f0ae88..8100cf5 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -416,8 +416,8 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  		}
>  	}
>  
> -	/* If device is in pass through, do reset to ready state transition */
> -	if (mhi_cntrl->ee == MHI_EE_PTHRU)
> +	/* wait for ready on pass through or any other execution environment */
> +	if (mhi_cntrl->ee != MHI_EE_EDL && mhi_cntrl->ee != MHI_EE_PBL)
>  		goto fw_load_ready_state;
>  
>  	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index 7ac9dfe..b6920a5 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -763,8 +763,7 @@ void mhi_pm_st_worker(struct work_struct *work)
>  			if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
>  				mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
>  			write_unlock_irq(&mhi_cntrl->pm_lock);
> -			if (MHI_IN_PBL(mhi_cntrl->ee))
> -				mhi_fw_load_handler(mhi_cntrl);
> +			mhi_fw_load_handler(mhi_cntrl);
>  			break;
>  		case DEV_ST_TRANSITION_SBL:
>  			write_lock_irq(&mhi_cntrl->pm_lock);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

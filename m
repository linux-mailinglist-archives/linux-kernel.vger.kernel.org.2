Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0951333CDDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhCPGPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhCPGOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:14:39 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C64CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 23:14:39 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v14so14990185pgq.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 23:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sq0aKBuHdwW/nOfuOJWOVsVvDF01fsFJpD2nAbMcEpc=;
        b=ipe1xG3iscsMJZsHqMMcXVPiil9KsEDf1dWlWVhKsFYA+fy+4x7j0K1bJEBd9nUzE0
         PAv5gpEwZdyerwmrPYpX5lTrn10xVRLjq8DPk2zbU3xaJ2AglDi5JJrNioq80lU27oWD
         ohBTGvxHW10AL3BTbBQccJBhdLD18CyA89pOWpLra2pRZEYVFGJDZBb1ewwbderWwuQN
         AgEqs180pjV8CxC0/Rj+L6ihz+B0EnDSXg7cI3a6rsubfEgA96lVBTyizq+6MfMQaGDz
         Hcl6w6w/YVdjr0wikSAR9sRvItI7R6NuPsel4mmLm4CXwszLPRfG909wfqKeSMxhcRO5
         88hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sq0aKBuHdwW/nOfuOJWOVsVvDF01fsFJpD2nAbMcEpc=;
        b=Q6F2ommw8o7WPDm69Hucrtkc6cjl8/DLYUy06BTQ3qUutVZbJi0ZFvBgAFoZd4pMeT
         O6SVNzuQddUAk3u6+UGlKIcBAykpbC3lzuzxZuHLQgfe51lRl9NmR9c5Qc6tZk6wjJWN
         9OUb7Q59Dktp7NbohuwREV5PG4ccYiFss8zpwFfZSQaeXAzW8y8YeC0I2KyCum/Uocnq
         wjTeXhl51Pa8PDFji1MHdXSaX7kQ40eYG2F3XS0+9Uvf0AKU6qjuMppBaMzA6UgkKUzn
         SWGPLlcvlTz5l1+VKktG5a0Ges4B4Cc4ZpuqOpNQg5aFmWlWRHEDk9Yk3aMUuWCPjjft
         Qp8g==
X-Gm-Message-State: AOAM532RVQE85AnzBSMmnWbBeFWqs+MYccm+85wv0Q2JxVirpqrH6nML
        KzJ12wGdN1RLk9mC94ohTj1B
X-Google-Smtp-Source: ABdhPJxZhzDtAm268qxXTCWaVBdt6NMdYcxRAqevo1T7Rlg5vHz84vtMXzy2Y3eK/LFZUIlrxTY4Tg==
X-Received: by 2002:a63:f558:: with SMTP id e24mr2600370pgk.153.1615875278492;
        Mon, 15 Mar 2021 23:14:38 -0700 (PDT)
Received: from thinkpad ([103.66.79.72])
        by smtp.gmail.com with ESMTPSA id v18sm16039362pfn.117.2021.03.15.23.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 23:14:37 -0700 (PDT)
Date:   Tue, 16 Mar 2021 11:44:33 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] bus: mhi: core: Wait for ready state after
 reset
Message-ID: <20210316061433.GG1798@thinkpad>
References: <1615408918-7242-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615408918-7242-1-git-send-email-jhugo@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 01:41:58PM -0700, Jeffrey Hugo wrote:
> After the device has signaled the end of reset by clearing the reset bit,
> it will automatically reinit MHI and the internal device structures.  Once
> That is done, the device will signal it has entered the ready state.
> 
> Signaling the ready state involves sending an interrupt (MSI) to the host
> which might cause IOMMU faults if it occurs at the wrong time.
> 
> If the controller is being powered down, and possibly removed, then the
> reset flow would only wait for the end of reset.  At which point, the host
> and device would start a race.  The host may complete its reset work, and
> remove the interrupt handler, which would cause the interrupt to be
> disabled in the IOMMU.  If that occurs before the device signals the ready
> state, then the IOMMU will fault since it blocked an interrupt.  While
> harmless, the fault would appear like a serious issue has occurred so let's
> silence it by making sure the device hits the ready state before the host
> completes its reset processing.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/bus/mhi/core/pm.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index adb0e80..414da4f 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -467,7 +467,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>  
>  	/* Trigger MHI RESET so that the device will not access host memory */
>  	if (!MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
> -		u32 in_reset = -1;
> +		u32 in_reset = -1, ready = 0;
>  		unsigned long timeout = msecs_to_jiffies(mhi_cntrl->timeout_ms);
>  
>  		dev_dbg(dev, "Triggering MHI Reset in device\n");
> @@ -490,6 +490,21 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>  		 * hence re-program it
>  		 */
>  		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
> +
> +		if (!MHI_IN_PBL(mhi_get_exec_env(mhi_cntrl))) {
> +			/* wait for ready to be set */
> +			ret = wait_event_timeout(mhi_cntrl->state_event,
> +						 mhi_read_reg_field(mhi_cntrl,
> +							mhi_cntrl->regs,
> +							MHISTATUS,
> +							MHISTATUS_READY_MASK,
> +							MHISTATUS_READY_SHIFT,
> +							&ready)
> +						 || ready, timeout);
> +			if (!ret || !ready)
> +				dev_warn(dev,
> +					"Device failed to enter READY state\n");

Wouldn't dev_err be more appropriate here provided that we might get IOMMU fault
anytime soon?

Thanks,
Mani

> +		}
>  	}
>  
>  	dev_dbg(dev,
> -- 
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 

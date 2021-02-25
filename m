Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38973239FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhBXJ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbhBXJzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:55:54 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB669C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:55:08 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o6so972252pjf.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r/zwiQ7rKCXTlfSUTQ7/OYwTvidrNvId9rOU1ZPgLoI=;
        b=XgHs8ypljKL7JMf1XzYByopmcfyRVZI+/UersmvMswPSqXnZ3e/32gdY02owtBDIo+
         zfIV+rbWjH93TkS6P/M9u9lLdJSQf/qkHzb7ozu06o6AUJF9KIZHWISE1MYtjHZGBlC8
         daLPjg3p1Mq9fxCx/JIMw60QFtN3fHp6bFHea9+Z0+cAdKsmdYd9B6K2jJKYzYlTwuSC
         Jc9L8iV218HPt3p4kCJHaAQHQqSBXZGsVGblqUdkl1GYdSDC8W9nhSeYQ+1h1oYbLrju
         JiHlcFc3zdf5J1cMcdj+3tupyG5rGqm2HZfSigFH/oSmdF9RXZcuS09XZRXIklVnbVq7
         /dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/zwiQ7rKCXTlfSUTQ7/OYwTvidrNvId9rOU1ZPgLoI=;
        b=Qx3LD9oP9odU/WtQLHSOsKfJe9JGtCNq1wL89DabV8ZP9HX8/PCUgaxJCi2X7Su5zK
         9VEeFBvrD8K0+N2BzzuGGSX9h7TvRRqSbwdW6bPl4VH5swzLsUScfSlGOLhEHj2s8Yu0
         lyG9j/yt54t9ueCegJMA1OwlPT9fc+Q+w/dbq9KJNGorY8InOoPMC81twOBySArUVndC
         z9QW/fxA85x5/LQhlIrrwRf19nHbyT3LISFvJLVd+UFLMppdDaa64crz5rT4OeebdeFf
         wPshfiee+/yG9uHXoplVqE620wG0VArUnf3Fcv4M/QpKSw8A1yjQ5NfbDuFFgglnNt7e
         Jlvw==
X-Gm-Message-State: AOAM531PKgJxtgGmN9oETTsj/39hzZ67a41kriV3x25jxGHQ6Ji65rq5
        D8OHA8nw0uzAq7iPw91pMuZrVybOQjPo
X-Google-Smtp-Source: ABdhPJxDoLf2AFc1SZlfvTrkELEXdYS9phIZp/94yG32uYo0HOuTqyRCATolHEGImEE1SIbO7KyMdA==
X-Received: by 2002:a17:902:b609:b029:e3:4b8d:994 with SMTP id b9-20020a170902b609b02900e34b8d0994mr31524024pls.44.1614160508295;
        Wed, 24 Feb 2021 01:55:08 -0800 (PST)
Received: from work ([103.66.79.25])
        by smtp.gmail.com with ESMTPSA id b22sm2148547pfo.23.2021.02.24.01.55.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Feb 2021 01:55:07 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:25:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: mhi: core: Check state before processing
 power_down
Message-ID: <20210224095504.GQ27945@work>
References: <1613580211-22744-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613580211-22744-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 09:43:31AM -0700, Jeffrey Hugo wrote:
> We cannot process a power_down if the power state is DISABLED.  There is
> no valid mhi_ctxt in that case, so attepting to process the power_down
> will likely result in a null pointer dereference.  If the power state is
> DISABLED, there is nothing to do anyways, so just bail early.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
> 
> v2: Fix subject and tweak the locking to avoid needless lock/unlock/relock
> 
>  drivers/bus/mhi/core/pm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index 56ba3ab..47f6621 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -1144,6 +1144,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  		mhi_deinit_dev_ctxt(mhi_cntrl);
>  
>  error_dev_ctxt:
> +	mhi_cntrl->pm_state = MHI_PM_DISABLE;
>  	mutex_unlock(&mhi_cntrl->pm_mutex);
>  
>  	return ret;
> @@ -1155,11 +1156,17 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
>  	enum mhi_pm_state cur_state, transition_state;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  
> +	mutex_lock(&mhi_cntrl->pm_mutex);
> +	cur_state = mhi_cntrl->pm_state;

As I said in my previous review, you should use pm_lock for reading the
pm_state.

Thanks,
Mani

> +	if (cur_state == MHI_PM_DISABLE) {
> +		mutex_unlock(&mhi_cntrl->pm_mutex);
> +		return; /* Already powered down */
> +	}
> +
>  	/* If it's not a graceful shutdown, force MHI to linkdown state */
>  	transition_state = (graceful) ? MHI_PM_SHUTDOWN_PROCESS :
>  			   MHI_PM_LD_ERR_FATAL_DETECT;
>  
> -	mutex_lock(&mhi_cntrl->pm_mutex);
>  	write_lock_irq(&mhi_cntrl->pm_lock);
>  	cur_state = mhi_tryset_pm_state(mhi_cntrl, transition_state);
>  	if (cur_state != transition_state) {
> -- 
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1533E34FEF9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhCaLAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbhCaK7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A44C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 03:59:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so957834pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PV/1w7wcR5EE54SMbXvfgl/+KIdSOavaMh3qdPHWkT4=;
        b=xnCxl4xI7gJOzkzfbUOyvakSi2+liF2a2reHCvLFRCK/0VTHfd650+NmCj2axKS9l6
         p60jY0xySGqlq4tbjyV1NSprPfDIj8Sau3A0rU0o8KyetydWcfd9Jmb7VWfO4xnvu9md
         yBwt5GGiwVKTdVQKwPy2lc0kZnT3Zxi/DTi3syWq3J5qRtzovIYdc4Wq4I88BJIp4CUn
         11pdsnzCznAi0+UiwLz5W9YoVb1gJzq4G9GwKheuT+R8+pJgi1jn92Zj0A5/Li+5BAJ/
         JFiWzKEJbP9xJQgFgnUyJKhoPiUuQbtFKIK/i8GxdMbGZgRIBAxQkY+GOW+pbwvDAQj1
         HRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PV/1w7wcR5EE54SMbXvfgl/+KIdSOavaMh3qdPHWkT4=;
        b=pROdgY0XmTnacifnQg0rTVU+pbA5PUMRT09x0YULIfYrY5eMV36iVoTEfeLXdCCIeC
         saPwCEeQKCVwMlvktnHoP947C7xNlXYHc5QkoBjGFs7JzuW9RvyGd1rP1RiGQLHLIetZ
         0pIE98biwFhl7w+qlI1pRIDi6kd6HxPeEVZF+lbsr8jIW8VP2cVhJbs/2n2JSZGPxga+
         DG7Jw/8MctT7HrznI5jPAVGo2SFb2JKB/bp2d5eroVLQoP7LrJDV7sz/heCdaGX5EgdQ
         2YfcyY489hF3d8Vb3uPB+fMnVdh80oRlmM5vz4b1sbTm0K3wXzDSQ2rCTtFRNEhPjoBg
         FLSA==
X-Gm-Message-State: AOAM530hCESuBgL3ejTeNGuSzE5xV4JEqnPXyhyZIUHxNMFmtewZ5Bns
        cj8JhWJ+x1jX1tYbKgTp1i2SdQO4h+wWwyk=
X-Google-Smtp-Source: ABdhPJz0SbkgPFMCGPuS5aBBbWb/X08gINb0l3jm6SHM0ypo7KHZrmu64oBV58Fitx5HjIX5KEI7vw==
X-Received: by 2002:a17:902:bf46:b029:e7:36be:9ce8 with SMTP id u6-20020a170902bf46b02900e736be9ce8mr2775395pls.34.1617188388144;
        Wed, 31 Mar 2021 03:59:48 -0700 (PDT)
Received: from work ([103.77.37.129])
        by smtp.gmail.com with ESMTPSA id ft22sm1841624pjb.8.2021.03.31.03.59.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Mar 2021 03:59:47 -0700 (PDT)
Date:   Wed, 31 Mar 2021 16:29:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org, abickett@codeaurora.org
Subject: Re: [PATCH v1 3/7] bus: mhi: core: Handle EDL mode entry
 appropriately
Message-ID: <20210331105943.GB15610@work>
References: <1617067704-28850-1-git-send-email-bbhatt@codeaurora.org>
 <1617067704-28850-4-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617067704-28850-4-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 06:28:20PM -0700, Bhaumik Bhatt wrote:
> Device entering EDL or Emergency Download Mode will be in a
> SYS_ERROR MHI state. This requires MHI host to proceed with the
> EDL image download over BHI before device can enter an MHI READY
> state and proceed with further bootup. Allow this to be handled
> by relying on the execution environment check after SYS_ERROR
> processing to determine whether to wait for an MHI READY or
> download the EDL image over BHI after moving MHI PM state to
> Power on Reset internally. This way handling is contained well
> within the MHI core driver and helps pave the way for Flash
> Programmer execution environment functionality.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/pm.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index fbe9447..b65222e 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -564,6 +564,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>  static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
>  {
>  	enum mhi_pm_state cur_state, prev_state;
> +	enum dev_st_transition next_state;
>  	struct mhi_event *mhi_event;
>  	struct mhi_cmd_ctxt *cmd_ctxt;
>  	struct mhi_cmd *mhi_cmd;
> @@ -677,7 +678,23 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
>  		er_ctxt->wp = er_ctxt->rbase;
>  	}
>  
> -	mhi_ready_state_transition(mhi_cntrl);
> +	/* Transition to next state */
> +	if (MHI_IN_PBL(mhi_get_exec_env(mhi_cntrl))) {
> +		write_lock_irq(&mhi_cntrl->pm_lock);
> +		cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_POR);
> +		write_unlock_irq(&mhi_cntrl->pm_lock);
> +		if (cur_state != MHI_PM_POR) {
> +			dev_err(dev, "Error moving to state %s from %s\n",
> +				to_mhi_pm_state_str(MHI_PM_POR),
> +				to_mhi_pm_state_str(cur_state));
> +			goto exit_sys_error_transition;
> +		}
> +		next_state = DEV_ST_TRANSITION_PBL;
> +	} else {
> +		next_state = DEV_ST_TRANSITION_READY;
> +	}
> +
> +	mhi_queue_state_transition(mhi_cntrl, next_state);
>  
>  exit_sys_error_transition:
>  	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

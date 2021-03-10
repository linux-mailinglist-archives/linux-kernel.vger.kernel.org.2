Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA111334001
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhCJOLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhCJOLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:11:23 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED27AC061761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:11:22 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v14so4560548pgq.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ID+cF5sGxqc4INkVMaTpr9torK5kx0LGVZUIIlwg9SQ=;
        b=qzgcy7b55cFl1x3kMgWTV6HaZMKrOkHn3ARVS8jUrt0NANQLOqQhBISI3J01BA6hdp
         DrLQFiUFSV1U3RS3WpzQ5UANafEQ1oMMjUdcLLiW+lXgSH4eFCfaqLSnMrfohKQuXz/k
         iqClD1fQS2FrUKHOS7XLo3t68fq+52/SB+TXVII5nkjgwOPNbQlK2gHevy12XDxnu5/r
         Df/Q1yZslCKShqn6525rNLvoFcms8goEoKZfe9mRnmJaCajII0XfxW2Pcrh29s+W0Nrl
         jiGG3qP4fGsoCK6qRTrBaspZP1p73PprYMwaQR2UkYys+N9M46e/WS6jPCUyDRZLa7Mp
         dWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ID+cF5sGxqc4INkVMaTpr9torK5kx0LGVZUIIlwg9SQ=;
        b=rhfsZ0tCFqhnk9UDpDnzKSPPdFn1hZUjuHK3arbY5o6pb3+Y7OBOb0Lh5sz2DVSwQW
         pBvIdqkVa8rbfw3dp7F2hi5ySMdby0N7OQOBTgm8euZnjz68/r+9SP7KEUSgYhKh4seP
         kXj6uVV2xcQtUR9FuT3GA9f0fvSTwPLUDkKAfFqNmqOE4hIEsYW+iVnYMQnHYWsSgO5X
         cvxRf19eXB80dScRgEdEjw5tjdSOQxjReTGETfM1vlDzJ4aelih4i3SXDAXobxC5WF9l
         EKz9M5IMSbWQclpJR5+zzaDusH/r49o077khFloS+FoDBZJRI5KcatWyP3D6l9kgjgyN
         KIXw==
X-Gm-Message-State: AOAM533yh+/avDu2yDz6cO+tiekX8nkeQ1Wg+ApHVycr76gWGNFdFWnS
        sYZjb5drVyDKipCYlh78IRWR
X-Google-Smtp-Source: ABdhPJx4faSiuANxjzifTrn3OBrjQPlIBxNQgtmfUtxdMnCVOPVS5QUGUKgochLcPDd1YQVQkxAlbQ==
X-Received: by 2002:a05:6a00:15cc:b029:1ba:5282:3ab8 with SMTP id o12-20020a056a0015ccb02901ba52823ab8mr2993692pfu.77.1615385482316;
        Wed, 10 Mar 2021 06:11:22 -0800 (PST)
Received: from thinkpad ([103.66.79.59])
        by smtp.gmail.com with ESMTPSA id h14sm6712923pjc.37.2021.03.10.06.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 06:11:21 -0800 (PST)
Date:   Wed, 10 Mar 2021 19:41:16 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: core: Fix check for syserr at power_up
Message-ID: <20210310141116.GS30275@thinkpad>
References: <1613165243-23359-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613165243-23359-1-git-send-email-jhugo@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 02:27:23PM -0700, Jeffrey Hugo wrote:
> The check to see if we have reset the device after detecting syserr at
> power_up is inverted.  wait_for_event_timeout() returns 0 on failure,
> and a positive value on success.  The check is looking for non-zero
> as a failure, which is likely to incorrectly cause a device init failure
> if syserr was detected at power_up.  Fix this.
> 
> Fixes: e18d4e9fa79b ("bus: mhi: core: Handle syserr during power_up")
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Applied to mhi-next!

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index 681960c..36ab7aa 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -1092,7 +1092,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  							   &val) ||
>  					!val,
>  				msecs_to_jiffies(mhi_cntrl->timeout_ms));
> -		if (ret) {
> +		if (!ret) {
>  			ret = -EIO;
>  			dev_info(dev, "Failed to reset MHI due to syserr state\n");
>  			goto error_bhi_offset;
> -- 
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 

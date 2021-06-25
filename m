Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389483B3C35
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhFYF0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbhFYF0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:26:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6819C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 22:23:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c5so7124586pfv.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 22:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cyj6s4sHpfppPnMBo26sZU6xwfPH65HatOyxjgawFg8=;
        b=Lq6ougXAljr42lvCyI2Q9QGuGZ4AncpOqWBJU9/JTotbO/aIG8iOmjyDIlUKs07jxX
         1JeoCX1rpvzkMe+wRAgy31z04xPK2dapXcdg+/qxX24jAf9Ow+Y5k78KNS0Jkbs9dN3X
         SGBHxy66+aLpk5g+yFxhcnvibo0OJbkR4to+hWI55+vf4zb7Sq91m3DRJ7StSYkoqlJm
         5njn9CCyjmh3n/jX74aahHEPZagzi2LbAhd89BXWGBrmssxzFwr6bnUMYNVe1MJdvrSu
         qaAvizXLmEkHJC4a/xS8QrU9MUfNW+jrKHI8ax2gh4b76Qu4VpSpR8lPwLXNYO116Qik
         jjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cyj6s4sHpfppPnMBo26sZU6xwfPH65HatOyxjgawFg8=;
        b=cJOgRhouv8NGvrnuSq3VbvdEwovCJh34CbGyIh6r6EfRV2km3BwGeYAFCU1GV1kaOX
         k9c78n7/2bPSQPCkAaWcwLXpcqUNpxrpGQyOy+oI7f6kUwp+kEAktWYNzZIxzZ5g61+m
         iv/b7sTqyVIuRmV/qrmJmwcZvLFUiHrHX9g4CT34pfPF3A9DHuVAKBtiIOcU3BBlYuZ3
         XgYoLmjofdxNvbGh21K3Z/6qpSk0l2wyzYvfmm9bnTWb8ltstw4mW1U6fRM0t8FlLtfr
         FrPRHsIFVPNzwNNTpJGytrr8/66ugAza64avum4VVuouXloSJWElLNeSbiG6fW+YK2yJ
         Xq2A==
X-Gm-Message-State: AOAM533XtA628rv7I0hGtCnLCE15YcS3BfdYCcI1aJu787EEhgxIXP10
        wrZQMV8nuSPeTq4kN0Y5KgfK
X-Google-Smtp-Source: ABdhPJzJ1yRbMvgaboJE8dC85pliGYUKfTef4n9w2IGaujc/g7tQK4qYZpZ6s0FZH+GwstEj4TxXAQ==
X-Received: by 2002:a63:5446:: with SMTP id e6mr8017440pgm.73.1624598636294;
        Thu, 24 Jun 2021 22:23:56 -0700 (PDT)
Received: from workstation ([120.138.13.204])
        by smtp.gmail.com with ESMTPSA id k35sm4021764pgi.21.2021.06.24.22.23.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jun 2021 22:23:55 -0700 (PDT)
Date:   Fri, 25 Jun 2021 10:53:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: core: Validate channel ID when processing
 command completions
Message-ID: <20210625052353.GE4974@workstation>
References: <1624558141-11045-1-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624558141-11045-1-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 11:09:01AM -0700, Bhaumik Bhatt wrote:
> MHI reads the channel ID from the event ring element sent by the
> device which can be any value between 0 and 255. In order to
> prevent any out of bound accesses, add a check against the maximum
> number of channels supported by the controller and those channels
> not configured yet so as to skip processing of that event ring
> element.
> 
> Fixes: 1d3173a3bae7 ("bus: mhi: core: Add support for processing events from client device")
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Link: https://lore.kernel.org/r/1619481538-4435-1-git-send-email-bbhatt@codeaurora.org

Removed "Link" and applied to mhi-next!

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/main.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 22acde1..fc9196f 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -773,11 +773,18 @@ static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
>  	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
>  
>  	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
> -	mhi_chan = &mhi_cntrl->mhi_chan[chan];
> -	write_lock_bh(&mhi_chan->lock);
> -	mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
> -	complete(&mhi_chan->completion);
> -	write_unlock_bh(&mhi_chan->lock);
> +
> +	if (chan < mhi_cntrl->max_chan &&
> +	    mhi_cntrl->mhi_chan[chan].configured) {
> +		mhi_chan = &mhi_cntrl->mhi_chan[chan];
> +		write_lock_bh(&mhi_chan->lock);
> +		mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
> +		complete(&mhi_chan->completion);
> +		write_unlock_bh(&mhi_chan->lock);
> +	} else {
> +		dev_err(&mhi_cntrl->mhi_dev->dev,
> +			"Completion packet for invalid channel ID: %d\n", chan);
> +	}
>  
>  	mhi_del_ring_element(mhi_cntrl, mhi_ring);
>  }
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E03E357CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhDHG6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhDHG6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:58:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FBCC061761
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 23:57:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso812818pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MBX3bns484y1stq8tRInraTTbv10youMfS0IjvYzmvY=;
        b=V4Nc5lfKomQjb998L4L7qw09/2RF/7IvKOhD8Tv2BxFjg0XGUONyFoXV1B4WzF3WGZ
         ArT89Yac1LT/zp7wPhLB0NzOrTotP8jraZIMp575+Z/Dw+kZwBbLO4lqb/mimQoHJGv+
         wfbX/Kcg+YEJbVb1IE4o5vwCKBRU7S3m3XZkgUGDeJnP4FS6VUeikKMuv7DatYsYb8Ya
         VadFQldk7wUUC1kvxJUddwMwOPWsC75MKNLZJi24vC38RHfC75WE7j4nwjruHWu3PmRV
         6o2SCLM+tE3baA7ZlfASWb5E/YDr+HcyDKcyifhpC8fLcNTj/mkjeM6OptZFBKi99ruu
         zK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MBX3bns484y1stq8tRInraTTbv10youMfS0IjvYzmvY=;
        b=L3Y4UOuKrxPuxhacZ4rW5ToSfEt144u7p+akJ+fjOhJjLGvgateb6cN3Nzu5ZX/gUt
         Fasr9zG+2RwgQMKw1U/UcYSdReT3qX+FHZihEqbfCGnvUMpavKaSqOlFRTB1lRgVpX+f
         GC9eu0FbhoGiUy6J7pSVQCYJLJjA/8R2udFwkggalK+llenYhftjt8uEMZo8nMyiHDNy
         nRLlrgnuOPniVilOSlYSQqYs7pVxLC9qmOMTHGScsU5iGd4RGpxOGtiAJacLZahUm2pG
         b8f9lHeaZ6fI803UPilPvn15eSSKGeYAHwIJPhcLCCGlnyfiV1wPi4+mVarGzmu5Z6Oj
         v0fw==
X-Gm-Message-State: AOAM533EVT2de0YazUYf6tKL0Sa9ZwTwKKdxsC4N9I303w2FVTcWTxql
        XKjPKI9hcLfr1faKz2ZIEG5s
X-Google-Smtp-Source: ABdhPJxLUhYJrBZkejloxBwxaO/HNMd7dzwMZkZk5D/LOQwJrN5R9mh8IQhf49pANIA/LmTW5/wmPw==
X-Received: by 2002:a17:902:8601:b029:e6:7b87:8add with SMTP id f1-20020a1709028601b02900e67b878addmr6365466plo.3.1617865073174;
        Wed, 07 Apr 2021 23:57:53 -0700 (PDT)
Received: from thinkpad ([2409:4072:6e85:565f:2e19:9e93:4526:a814])
        by smtp.gmail.com with ESMTPSA id l25sm25453107pgu.72.2021.04.07.23.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 23:57:52 -0700 (PDT)
Date:   Thu, 8 Apr 2021 12:27:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] bus: mhi: core: Sanity check values from remote
 device before use
Message-ID: <20210408065747.GA3837@thinkpad>
References: <1615411855-15053-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615411855-15053-1-git-send-email-jhugo@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 02:30:55PM -0700, Jeffrey Hugo wrote:
> When parsing the structures in the shared memory, there are values which
> come from the remote device.  For example, a transfer completion event
> will have a pointer to the tre in the relevant channel's transfer ring.
> As another example, event ring elements may specify a channel in which
> the event occurred, however the specified channel value may not be valid
> as no channel is defined at that index even though the index may be less
> than the maximum allowed index.  Such values should be considered to be
> untrusted, and validated before use.  If we blindly use such values, we
> may access invalid data or crash if the values are corrupted.
> 
> If validation fails, drop the relevant event.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Applied to mhi-next!

Thanks,
Mani

> ---
> 
> v3: Add the channel validation example to commit text
> v2: Fix subject
> 
>  drivers/bus/mhi/core/main.c | 81 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index a7811fb..6c0e05d 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -242,6 +242,11 @@ static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
>  	smp_wmb();
>  }
>  
> +static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
> +{
> +	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
> +}
> +
>  int mhi_destroy_device(struct device *dev, void *data)
>  {
>  	struct mhi_chan *ul_chan, *dl_chan;
> @@ -404,7 +409,16 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
>  	struct mhi_event_ctxt *er_ctxt =
>  		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
>  	struct mhi_ring *ev_ring = &mhi_event->ring;
> -	void *dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
> +	dma_addr_t ptr = er_ctxt->rp;
> +	void *dev_rp;
> +
> +	if (!is_valid_ring_ptr(ev_ring, ptr)) {
> +		dev_err(&mhi_cntrl->mhi_dev->dev,
> +			"Event ring rp points outside of the event ring\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	dev_rp = mhi_to_virtual(ev_ring, ptr);
>  
>  	/* Only proceed if event ring has pending events */
>  	if (ev_ring->rp == dev_rp)
> @@ -560,6 +574,11 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>  		struct mhi_buf_info *buf_info;
>  		u16 xfer_len;
>  
> +		if (!is_valid_ring_ptr(tre_ring, ptr)) {
> +			dev_err(&mhi_cntrl->mhi_dev->dev,
> +				"Event element points outside of the tre ring\n");
> +			break;
> +		}
>  		/* Get the TRB this event points to */
>  		ev_tre = mhi_to_virtual(tre_ring, ptr);
>  
> @@ -719,6 +738,12 @@ static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
>  	struct mhi_chan *mhi_chan;
>  	u32 chan;
>  
> +	if (!is_valid_ring_ptr(mhi_ring, ptr)) {
> +		dev_err(&mhi_cntrl->mhi_dev->dev,
> +			"Event element points outside of the cmd ring\n");
> +		return;
> +	}
> +
>  	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
>  
>  	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
> @@ -743,6 +768,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	u32 chan;
>  	int count = 0;
> +	dma_addr_t ptr = er_ctxt->rp;
>  
>  	/*
>  	 * This is a quick check to avoid unnecessary event processing
> @@ -752,7 +778,13 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
>  		return -EIO;
>  
> -	dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
> +	if (!is_valid_ring_ptr(ev_ring, ptr)) {
> +		dev_err(&mhi_cntrl->mhi_dev->dev,
> +			"Event ring rp points outside of the event ring\n");
> +		return -EIO;
> +	}
> +
> +	dev_rp = mhi_to_virtual(ev_ring, ptr);
>  	local_rp = ev_ring->rp;
>  
>  	while (dev_rp != local_rp) {
> @@ -858,6 +890,8 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  			 */
>  			if (chan < mhi_cntrl->max_chan) {
>  				mhi_chan = &mhi_cntrl->mhi_chan[chan];
> +				if (!mhi_chan->configured)
> +					break;
>  				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
>  				event_quota--;
>  			}
> @@ -869,7 +903,15 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  
>  		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
>  		local_rp = ev_ring->rp;
> -		dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
> +
> +		ptr = er_ctxt->rp;
> +		if (!is_valid_ring_ptr(ev_ring, ptr)) {
> +			dev_err(&mhi_cntrl->mhi_dev->dev,
> +				"Event ring rp points outside of the event ring\n");
> +			return -EIO;
> +		}
> +
> +		dev_rp = mhi_to_virtual(ev_ring, ptr);
>  		count++;
>  	}
>  
> @@ -892,11 +934,18 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>  	int count = 0;
>  	u32 chan;
>  	struct mhi_chan *mhi_chan;
> +	dma_addr_t ptr = er_ctxt->rp;
>  
>  	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
>  		return -EIO;
>  
> -	dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
> +	if (!is_valid_ring_ptr(ev_ring, ptr)) {
> +		dev_err(&mhi_cntrl->mhi_dev->dev,
> +			"Event ring rp points outside of the event ring\n");
> +		return -EIO;
> +	}
> +
> +	dev_rp = mhi_to_virtual(ev_ring, ptr);
>  	local_rp = ev_ring->rp;
>  
>  	while (dev_rp != local_rp && event_quota > 0) {
> @@ -910,7 +959,8 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>  		 * Only process the event ring elements whose channel
>  		 * ID is within the maximum supported range.
>  		 */
> -		if (chan < mhi_cntrl->max_chan) {
> +		if (chan < mhi_cntrl->max_chan &&
> +		    mhi_cntrl->mhi_chan[chan].configured) {
>  			mhi_chan = &mhi_cntrl->mhi_chan[chan];
>  
>  			if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
> @@ -924,7 +974,15 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>  
>  		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
>  		local_rp = ev_ring->rp;
> -		dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
> +
> +		ptr = er_ctxt->rp;
> +		if (!is_valid_ring_ptr(ev_ring, ptr)) {
> +			dev_err(&mhi_cntrl->mhi_dev->dev,
> +				"Event ring rp points outside of the event ring\n");
> +			return -EIO;
> +		}
> +
> +		dev_rp = mhi_to_virtual(ev_ring, ptr);
>  		count++;
>  	}
>  	read_lock_bh(&mhi_cntrl->pm_lock);
> @@ -1385,6 +1443,7 @@ static void mhi_mark_stale_events(struct mhi_controller *mhi_cntrl,
>  	struct mhi_ring *ev_ring;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	unsigned long flags;
> +	dma_addr_t ptr;
>  
>  	dev_dbg(dev, "Marking all events for chan: %d as stale\n", chan);
>  
> @@ -1392,7 +1451,15 @@ static void mhi_mark_stale_events(struct mhi_controller *mhi_cntrl,
>  
>  	/* mark all stale events related to channel as STALE event */
>  	spin_lock_irqsave(&mhi_event->lock, flags);
> -	dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
> +
> +	ptr = er_ctxt->rp;
> +	if (!is_valid_ring_ptr(ev_ring, ptr)) {
> +		dev_err(&mhi_cntrl->mhi_dev->dev,
> +			"Event ring rp points outside of the event ring\n");
> +		dev_rp = ev_ring->rp;
> +	} else {
> +		dev_rp = mhi_to_virtual(ev_ring, ptr);
> +	}
>  
>  	local_rp = ev_ring->rp;
>  	while (dev_rp != local_rp) {
> -- 
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 

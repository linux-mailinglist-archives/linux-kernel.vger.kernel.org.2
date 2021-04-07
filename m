Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0323566B0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbhDGIXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347444AbhDGIWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:22:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41113C061764
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:21:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t22so5315863pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 01:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ib8mIPYDxVrIkPAVXTztEZxZOcX36vTdIvB+UB+ssZ0=;
        b=nhF7eMte6bqgYpZliNb7/Fz7Ivcj5udTYJzito4u+YsCWLQwheV+KkuANo+r6ujEa4
         MAdR8aiPPnSefFxIx+/V2JXklYMiVUU/joL46q2YHHGzGIMmnND4gUxokD5VOHrF4mmh
         yC8pwn3C0KJqg5b33qfT3n4iUhJ5XzCYduD2iUtg/xINCZMVhnd2988tbkT/Tt1xeKKo
         0xE0UmnlvPz80mvgGnPTNgKDaNbcgkH9zvkHdqjLX9pmnUkniySbyqnBkpWoKNbuPMtc
         7KFJvoqtxvrmJ+Q3FeA5RfMaY2TaFI9woue98ARtHMV1QtYEllhtCY1GM2SAVu188zhG
         9Dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ib8mIPYDxVrIkPAVXTztEZxZOcX36vTdIvB+UB+ssZ0=;
        b=uZadRk46DS0BvAslH4AREg2Ka3kSaw+ktCUmKj80lohzd9QzmLY6ObXMp7vBmkEirt
         QKJnT0uit47NKJNTuEYwEJHPseZzlLW0fiGzPllUn2ekXb+yorlWCw8QuJd/GZVvd3Zy
         GJ7lk5hWogRUEEkxtjX2W3aCAqgitY3nJHR31xgzJb+LpTi8anQ+dLj/S/gaU/ZoRAUA
         GHRIhYQu9T44zNEZgsxGwo5OjreeuhOI0ulIg49F8t21ZiBNkOGRaTq9sPLxLo4mKImA
         wQVlv3ve6+OFHiM8tUfn+srIZn5QKK6Y3vlp9bgqtkKV60zRmLS8cKlIidog5hwtACGk
         Z0Hw==
X-Gm-Message-State: AOAM53121WR3ZY2s6qUsnPRsd15lEAflCNFP0+nC2FzAL8aJl490AxyN
        vZmMejE6e7mZ9lc2eAYY0BltPL3bqiic
X-Google-Smtp-Source: ABdhPJya8QBJbLrAHm60niLleKj5O6MM8hxdrv/ae3uxfbL4jsHBUwSA5lvnS3nE/x6/Ocf8sJOxQw==
X-Received: by 2002:a63:2214:: with SMTP id i20mr2166422pgi.189.1617783713576;
        Wed, 07 Apr 2021 01:21:53 -0700 (PDT)
Received: from work ([103.77.37.180])
        by smtp.gmail.com with ESMTPSA id t18sm20665664pfh.57.2021.04.07.01.21.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Apr 2021 01:21:52 -0700 (PDT)
Date:   Wed, 7 Apr 2021 13:51:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] bus: mhi: core: Sanity check values from remote
 device before use
Message-ID: <20210407082150.GP8675@work>
References: <1615411855-15053-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615411855-15053-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Looks good to me, but I need an ACK from Hemant/Bhaumik.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2A73B3084
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhFXNyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhFXNx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:53:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94EB0613C7;
        Thu, 24 Jun 2021 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624542700;
        bh=7qiK/Yto9KUIme4wCm8Bs2aYaJcolv2mnT7y527imnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ha1neBu0tqbydq+5rJ5mxAA+BLtIVBtNzAWhMlGkrvupooO6ONtZJwQf7jI7b+Xo/
         IuPgc7HYuEHVpMZq9vK7a16yqDkLVCThdrcsOI7/oDhFjswfgGBhLfesCmIN2vJQXv
         yVMyb1btXiJbd38sKb/GkRzUKkgnuZ86XwKCSUbU=
Date:   Thu, 24 Jun 2021 15:51:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 4/8] bus: mhi: Add inbound buffers allocation flag
Message-ID: <YNSN6Yjk/P05ql8G@kroah.com>
References: <20210621161616.77524-1-manivannan.sadhasivam@linaro.org>
 <20210621161616.77524-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621161616.77524-5-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 09:46:12PM +0530, Manivannan Sadhasivam wrote:
> From: Loic Poulain <loic.poulain@linaro.org>
> 
> Currently, the MHI controller driver defines which channels should
> have their inbound buffers allocated and queued. But ideally, this is
> something that should be decided by the MHI device driver instead,
> which actually deals with that buffers.
> 
> Add a flag parameter to mhi_prepare_for_transfer allowing to specify
> if buffers have to be allocated and queued by the MHI stack.
> 
> Keep auto_queue flag for now, but should be removed at some point.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Tested-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/r/1621603519-16773-1-git-send-email-loic.poulain@linaro.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/bus/mhi/core/internal.h  |  2 +-
>  drivers/bus/mhi/core/main.c      | 11 ++++++++---
>  drivers/net/mhi/net.c            |  2 +-
>  drivers/net/wwan/mhi_wwan_ctrl.c |  2 +-
>  include/linux/mhi.h              | 12 +++++++++++-
>  net/qrtr/mhi.c                   |  2 +-
>  6 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index 5b9ea66b92dc..672052fe3b44 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -682,7 +682,7 @@ void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
>  		      struct image_info *img_info);
>  void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl);
>  int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
> -			struct mhi_chan *mhi_chan);
> +			struct mhi_chan *mhi_chan, enum mhi_chan_flags flags);
>  int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
>  		       struct mhi_chan *mhi_chan);
>  void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index ed07421c4870..8ac73f9e92a6 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -1428,7 +1428,8 @@ static void mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
>  }
>  
>  int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
> -			struct mhi_chan *mhi_chan)
> +			struct mhi_chan *mhi_chan,
> +			enum mhi_chan_flags flags)
>  {
>  	int ret = 0;
>  	struct device *dev = &mhi_chan->mhi_dev->dev;
> @@ -1453,6 +1454,9 @@ int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
>  	if (ret)
>  		goto error_pm_state;
>  
> +	if (mhi_chan->dir == DMA_FROM_DEVICE)
> +		mhi_chan->pre_alloc = !!(flags & MHI_CH_INBOUND_ALLOC_BUFS);
> +
>  	/* Pre-allocate buffer for xfer ring */
>  	if (mhi_chan->pre_alloc) {
>  		int nr_el = get_nr_avail_ring_elements(mhi_cntrl,
> @@ -1608,7 +1612,8 @@ void mhi_reset_chan(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan)
>  }
>  
>  /* Move channel to start state */
> -int mhi_prepare_for_transfer(struct mhi_device *mhi_dev)
> +int mhi_prepare_for_transfer(struct mhi_device *mhi_dev,
> +			     enum mhi_chan_flags flags)
>  {
>  	int ret, dir;
>  	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> @@ -1619,7 +1624,7 @@ int mhi_prepare_for_transfer(struct mhi_device *mhi_dev)
>  		if (!mhi_chan)
>  			continue;
>  
> -		ret = mhi_prepare_channel(mhi_cntrl, mhi_chan);
> +		ret = mhi_prepare_channel(mhi_cntrl, mhi_chan, flags);
>  		if (ret)
>  			goto error_open_chan;
>  	}
> diff --git a/drivers/net/mhi/net.c b/drivers/net/mhi/net.c
> index 0d8293a47a56..774e32960e09 100644
> --- a/drivers/net/mhi/net.c
> +++ b/drivers/net/mhi/net.c
> @@ -327,7 +327,7 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
>  	u64_stats_init(&mhi_netdev->stats.tx_syncp);
>  
>  	/* Start MHI channels */
> -	err = mhi_prepare_for_transfer(mhi_dev);
> +	err = mhi_prepare_for_transfer(mhi_dev, 0);
>  	if (err)
>  		goto out_err;
>  
> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
> index 1bc6b69aa530..1e18420ce404 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c
> @@ -110,7 +110,7 @@ static int mhi_wwan_ctrl_start(struct wwan_port *port)
>  	int ret;
>  
>  	/* Start mhi device's channel(s) */
> -	ret = mhi_prepare_for_transfer(mhiwwan->mhi_dev);
> +	ret = mhi_prepare_for_transfer(mhiwwan->mhi_dev, 0);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 944aa3aa3035..86cea5256e3c 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -59,6 +59,14 @@ enum mhi_flags {
>  	MHI_CHAIN = BIT(2),
>  };
>  
> +/**
> + * enum mhi_chan_flags - MHI channel flags
> + * @MHI_CH_INBOUND_ALLOC_BUFS: Automatically allocate and queue inbound buffers
> + */
> +enum mhi_chan_flags {
> +	MHI_CH_INBOUND_ALLOC_BUFS = BIT(0),

Why is an enumerated type a bitfield?

Please just use integers for enumerated types.

thanks,

greg k-h

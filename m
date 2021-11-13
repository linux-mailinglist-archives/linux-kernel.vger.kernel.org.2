Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CCA44F374
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 14:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbhKMNuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 08:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhKMNuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 08:50:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D83A601FC;
        Sat, 13 Nov 2021 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636811245;
        bh=d2DFsfxjD3VJEdtSd4NR2+6IJc6mbF/tDLoP8GmgU7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kaw0NYNyIwKq6ArEmmNpnwdxP8IkADuvA6W+KW6NjYOp2LtnR/ST6dMreGrxGzqT3
         EM3T2lumAeRTYNM7O1ZL+jeNtdsUeeBbrS98Df8SVzy2d9wqitWz2AJkiiXk5rkPnX
         ntWGZ+Iog46RDjCKHjjG17sIiCSz4FxjNtDT/Lj/nEc+MAbrbPTRAX2SnL0vfnjbDw
         f6XxHZoCvtcrPMrLXnQT3rC/1ank9pvdC7mQnAJmtIFsoiB/0RHGs8JiKq173j5OQ5
         GsoQ6/lInrcS9AM4HnlGdSgJf3mDU/9CoFSin8XW3RZEEk710spu/Q3xWTTb4gfQPW
         RTDzxnbB1PJew==
Date:   Sat, 13 Nov 2021 21:47:18 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Qihang Hu <huqihang@oppo.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] usb: gadget: composite: Show warning if function
 driver's descriptors are incomplete.
Message-ID: <20211113134718.GA26550@Peter>
References: <20211110101129.462357-1-huqihang@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110101129.462357-1-huqihang@oppo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-10 18:11:29, Qihang Hu wrote:
> In the config_ep_by_speed_and_alt function, select the corresponding
> descriptor through g->speed. But some legacy or not well designed
> function drivers may not support the corresponding speed. So, we can
> directly display warnings instead of causing kernel panic. At the
> same time, it indicates the reasons in warning message.
> 
> Signed-off-by: Qihang Hu <huqihang@oppo.com>

Reviewed-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
> Changes in v4:
> -Change commit log
> 
> Changes in v3:
> -Change commit log
> -Delete extra blank lines
> -Modify 'incomplete_desc' to bool type
> 
> Changes in v2:
> -Add warning message
> ---
>  drivers/usb/gadget/composite.c | 39 ++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 72a9797dbbae..cb9c7edf9bbf 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -159,6 +159,8 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
>  	int want_comp_desc = 0;
>  
>  	struct usb_descriptor_header **d_spd; /* cursor for speed desc */
> +	struct usb_composite_dev *cdev;
> +	bool incomplete_desc = false;
>  
>  	if (!g || !f || !_ep)
>  		return -EIO;
> @@ -167,28 +169,43 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
>  	switch (g->speed) {
>  	case USB_SPEED_SUPER_PLUS:
>  		if (gadget_is_superspeed_plus(g)) {
> -			speed_desc = f->ssp_descriptors;
> -			want_comp_desc = 1;
> -			break;
> +			if (f->ssp_descriptors) {
> +				speed_desc = f->ssp_descriptors;
> +				want_comp_desc = 1;
> +				break;
> +			}
> +			incomplete_desc = true;
>  		}
>  		fallthrough;
>  	case USB_SPEED_SUPER:
>  		if (gadget_is_superspeed(g)) {
> -			speed_desc = f->ss_descriptors;
> -			want_comp_desc = 1;
> -			break;
> +			if (f->ss_descriptors) {
> +				speed_desc = f->ss_descriptors;
> +				want_comp_desc = 1;
> +				break;
> +			}
> +			incomplete_desc = true;
>  		}
>  		fallthrough;
>  	case USB_SPEED_HIGH:
>  		if (gadget_is_dualspeed(g)) {
> -			speed_desc = f->hs_descriptors;
> -			break;
> +			if (f->hs_descriptors) {
> +				speed_desc = f->hs_descriptors;
> +				break;
> +			}
> +			incomplete_desc = true;
>  		}
>  		fallthrough;
>  	default:
>  		speed_desc = f->fs_descriptors;
>  	}
>  
> +	cdev = get_gadget_data(g);
> +	if (incomplete_desc)
> +		WARNING(cdev,
> +			"%s doesn't hold the descriptors for current speed\n",
> +			f->name);
> +
>  	/* find correct alternate setting descriptor */
>  	for_each_desc(speed_desc, d_spd, USB_DT_INTERFACE) {
>  		int_desc = (struct usb_interface_descriptor *)*d_spd;
> @@ -244,12 +261,8 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
>  			_ep->maxburst = comp_desc->bMaxBurst + 1;
>  			break;
>  		default:
> -			if (comp_desc->bMaxBurst != 0) {
> -				struct usb_composite_dev *cdev;
> -
> -				cdev = get_gadget_data(g);
> +			if (comp_desc->bMaxBurst != 0)
>  				ERROR(cdev, "ep0 bMaxBurst must be 0\n");
> -			}
>  			_ep->maxburst = 1;
>  			break;
>  		}
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen


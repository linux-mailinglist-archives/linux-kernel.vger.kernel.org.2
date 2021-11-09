Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8C344AD8E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 13:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242543AbhKIMef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 07:34:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241539AbhKIMed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 07:34:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5A8761051;
        Tue,  9 Nov 2021 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636461107;
        bh=S+e5iTV5+Bs/5vsYLLwsUEdlQ/kxNOz+WH4f2I2y4qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lUGj36gvga6j3IfS8HCJXIrDBSy5v3ZccWpqUKD0snvVZh+ss5GUvorDKHh7wNZzV
         0d/e+sWcM6e1cf8mbPMQAtDPuRDlruWExtRJiifU4rl8NTMk22LEupndeEpuJzL2Q8
         Jhyj7SbQ5lNacDNKLdE9pznpcXxAFDmoUQG3XeOb1NmVaYNfLz/MaX3p4CnBa+mqo8
         bGv5u+w/GYbJCIBG0erySFHKZkbH/khRIeOC3uQgqO93SiqKbYSPDYyjMR6qwgDGMN
         OizaZFBIoAw1UAyw0eHa5NIgY/2Bm1+BGcadXQ882IVFDTmPiB908zZNvrcpgwcjLR
         El1OFTkWNgLeg==
Date:   Tue, 9 Nov 2021 20:31:40 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Qihang Hu <huqihang@oppo.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: composite: Show warning if function
 driver's descriptors are incomplete.
Message-ID: <20211109123140.GA5208@Peter>
References: <20211109101936.397503-1-huqihang@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109101936.397503-1-huqihang@oppo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-09 18:19:36, Qihang Hu wrote:
> In the config_ep_by_speed_and_alt function, select the corresponding
> descriptor through g->speed. But some unsound function drivers may

But some 'legacy or not well designed' function drivers

> not support the corresponding speed. So, we can directly display
> warnings instead of panicking the kernel.

instead of 'causing kernel panic'

> At the same time, it
> indicates a problem with the function in the warning message.

It indicates the reasons in warning message.
> 
> Signed-off-by: Qihang Hu <huqihang@oppo.com>
> ---
> Changes in v2:
> -Add warning message
> 
> Changes in v3:
> -Change commit log
> -Delete extra blank lines
> -Modify 'incomplete_desc' to bool type

The latest changelog should be showed at the first.

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

Except the typo issues, other things are ok for me. It shows an warning
message for not well designed function driver, instead of panic
the kernel. It depends on Greg that whether it should be panic directly
or show warning message to indicate the issue.

-- 

Thanks,
Peter Chen


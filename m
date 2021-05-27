Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F084392B22
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhE0Jvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235809AbhE0Jvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:51:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CF87613F0;
        Thu, 27 May 2021 09:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622109010;
        bh=cmBGcT0eRQCBifI792Q3HjHvjS5nOyNVd0fvq4gyHIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VXLkNE34YcBekZ+KiAEGlrxt8hnaZJWlF1hJj67aTiFuVJbWsub9+XFUcD84c9K2W
         UekIIAdHGPa9ToZWZ/gJguTBuoXKysZMnOT16ChOMEJXfiK05oL8F7O0stHUxldTiZ
         2I+z2JsMRh8dhs8Uoa26Tx8L7iWQsIPirpXphd+8=
Date:   Thu, 27 May 2021 11:50:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 17/24] usb: host: xhci: Remove unused variable 'len'
Message-ID: <YK9rT+8oMJWxxhye@kroah.com>
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-18-lee.jones@linaro.org>
 <YK9Ju9/kdaRv1jcT@kroah.com>
 <20210527081609.GF543307@dell>
 <5958f870-1834-3132-a729-2b26a84349ea@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5958f870-1834-3132-a729-2b26a84349ea@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 12:23:24PM +0300, Mathias Nyman wrote:
> On 27.5.2021 11.16, Lee Jones wrote:
> > On Thu, 27 May 2021, Greg Kroah-Hartman wrote:
> > 
> >> On Wed, May 26, 2021 at 02:00:30PM +0100, Lee Jones wrote:
> >>> Fixes the following W=1 kernel build warning(s):
> >>>
> >>>  drivers/usb/host/xhci.c: In function ‘xhci_unmap_temp_buf’:
> >>>  drivers/usb/host/xhci.c:1349:15: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]
> >>>
> >>> Cc: Mathias Nyman <mathias.nyman@intel.com>
> >>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> Cc: linux-usb@vger.kernel.org
> >>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>> ---
> >>>  drivers/usb/host/xhci.c | 9 ++++-----
> >>>  1 file changed, 4 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> >>> index 27283654ca080..ac2a7d4288883 100644
> >>> --- a/drivers/usb/host/xhci.c
> >>> +++ b/drivers/usb/host/xhci.c
> >>> @@ -1346,7 +1346,6 @@ static bool xhci_urb_temp_buffer_required(struct usb_hcd *hcd,
> >>>  
> >>>  static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
> >>>  {
> >>> -	unsigned int len;
> >>>  	unsigned int buf_len;
> >>>  	enum dma_data_direction dir;
> >>>  
> >>> @@ -1362,10 +1361,10 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
> >>>  				 dir);
> >>>  
> >>>  	if (usb_urb_dir_in(urb))
> >>> -		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
> >>> -					   urb->transfer_buffer,
> >>> -					   buf_len,
> >>> -					   0);
> >>> +		sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
> >>> +				     urb->transfer_buffer,
> >>> +				     buf_len,
> >>> +				     0);
> >>
> >> Sorry, but no, I keep rejecting this over and over, it needs to handle
> >> the error handling properly and not paper over it like this :(
> > 
> > Will fix.
> > 
> >> All the bots keep tripping up on it, you are not alone.
> > 
> 
> This is getting a lot of attention. Something like this should fix it:
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 27283654ca08..306ab81421fd 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1361,12 +1361,16 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>  				 urb->transfer_buffer_length,
>  				 dir);
>  
> -	if (usb_urb_dir_in(urb))
> +	if (usb_urb_dir_in(urb)) {
>  		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
>  					   urb->transfer_buffer,
>  					   buf_len,
>  					   0);
> -
> +		if (len != buf_len) {
> +			xhci_dbg(xhci, "Copy from tmp buf to urb sg list failed\n");
> +			urb->actual_length = len;
> +		}
> +	}
>  	urb->transfer_flags &= ~URB_DMA_MAP_SINGLE;
>  	kfree(urb->transfer_buffer);
>  	urb->transfer_buffer = NULL;
>  
> urb->actual_length is now properly set.
> The debug level message will help me find the cause if we ever need
> to debug oddly behaving devices.
> 
> Note this is a very rarly taken codepath for quirky xHC harware that
> can't handle a specific sequence of buffer lengths queued.
> 
> I can write a proper commit message and push this forward

That looks good, I kept waiting for one of the people who kept trying to
report "build warning fixes" to do it right, but I'll gladly take it
from you as well :)

thanks,

greg k-h

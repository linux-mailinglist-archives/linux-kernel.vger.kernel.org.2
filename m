Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5F04113C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbhITLth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231391AbhITLta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:49:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5C0760FED;
        Mon, 20 Sep 2021 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632138484;
        bh=9n3jrqRr0I4rgQ5T6bvqdRjR5RdGCJPu6TR7YWU4HAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rS0A4GOztpx0ALpS/ogEB8WGL9rdrUlhBXSEHIe1hhyjFqFD3DBji4iaIG3O1TlFb
         Df8rEyhu0R50BywEXU85vT6gw5VNMiMZIXl+trGyPjOFLkHgKpPcWRLEfaKPrHClUG
         ZyKeBHbvtVXIAj7aXXMUUOTvoX+e/Ps5gq87qJRc=
Date:   Mon, 20 Sep 2021 13:48:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 04/19] staging: r8188eu: reorder comments in
 usbctrl_vendorreq()
Message-ID: <YUh08Qv+GvLTh5bP@kroah.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
 <20210919235356.4151-5-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919235356.4151-5-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:53:41AM +0200, Fabio M. De Francesco wrote:
> Reorder comments in usbctrl_vendorreq() to follow the Linux style.
> 
> Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index d92bdcc3716d..9138b730490f 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -35,9 +35,11 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
>  	io_buf = dvobjpriv->usb_vendor_req_buf;
>  
>  	if (requesttype == REALTEK_USB_VENQT_READ)
> -		pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> +		/* read in */
> +		pipe = usb_rcvctrlpipe(udev, 0);
>  	else
> -		pipe = usb_sndctrlpipe(udev, 0);/* write_out */
> +		/* write out */
> +		pipe = usb_sndctrlpipe(udev, 0);

For single-line if statements, that's not really needed.  Just drop the
comments entirely, the code here is "obvious".

thanks,

greg k-h

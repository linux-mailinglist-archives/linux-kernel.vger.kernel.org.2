Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9F4113C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhITLue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231391AbhITLuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:50:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B5FD6108C;
        Mon, 20 Sep 2021 11:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632138534;
        bh=OKUMEPr+LdUl+LywNfZOIjZmodlkdEiNYc1QEoqjxJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSbRLGT+SrQhLS5nptVWn1D8yJzYNRwqtCbmIa621N3eW/+UBtRmXXEHgNA3rNCYt
         vRa8YK2IjYxi6GCrlwSReXBqRI+ZJhIRSKcayQ3b1OK63VZhd7024KWFvBdGH4LjZD
         2XzkPqaM4jUiT/yc9JblXLOL1I4CVXqQwnaWwank=
Date:   Mon, 20 Sep 2021 13:48:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 07/19] staging: r8188eu: remove unnecessary comment in
 usbctrl_vendorreq()
Message-ID: <YUh1I694ZxDvOh5f@kroah.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
 <20210919235356.4151-8-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919235356.4151-8-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:53:44AM +0200, Fabio M. De Francesco wrote:
> Remove an unnecessary comment in usbctrl_vendorreq().
> 
> Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index a52aeb2558ad..fc3da0fbf474 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -73,7 +73,6 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
>  				/* status != len && status >= 0 */
>  				if (status > 0) {
>  					if (requesttype == REALTEK_USB_VENQT_READ) {
> -						/*  For Control read transfer, we have to copy the read data from io_buf to data. */
>  						memcpy(data, io_buf,  len);
>  					}

And now you have a coding style issue :(

Don't try to fix up one and add another one please.

thanks,

greg k-h

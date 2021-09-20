Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804C34113C6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhITLvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231391AbhITLvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:51:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 647686108C;
        Mon, 20 Sep 2021 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632138583;
        bh=VU8ZZWNNKOO5hA9rl9KIqcEqVsNm5EyAnCnE6GhPi3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwJrF0AV/DItJq9vDLDDFNj5nridYY7UvxSIc7HtoiGTf8A2XSfUxlHTIf/igM4fk
         nJ9Sby+aYAE2xGint4zwiB22o1Aly6JnwI+hkLTm5FjZspaJOW7WbrD51+04qlync2
         /KGHJ8w7t+Q12KdOIZcxailOQ1Hi67iDgswBNY/M=
Date:   Mon, 20 Sep 2021 13:49:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 09/19] staging: r8188eu: remove unnecessary braces in
 usbctrl_vendorreq()
Message-ID: <YUh1VOBAUpbaUQn9@kroah.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
 <20210919235356.4151-10-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919235356.4151-10-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:53:46AM +0200, Fabio M. De Francesco wrote:
> Remove unnecessary braces in usbctrl_vendorreq().
> 
> Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 3ca2959f4bcd..a270cb4249b5 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -72,9 +72,8 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
>  			} else {
>  				/* status != len && status >= 0 */
>  				if (status > 0) {
> -					if (requesttype == REALTEK_USB_VENQT_READ) {
> +					if (requesttype == REALTEK_USB_VENQT_READ)
>  						memcpy(data, io_buf,  len);
> -					}

This should have gone in the previous commit.



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B4F446192
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 10:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhKEJwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 05:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhKEJwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 05:52:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E87FE61053;
        Fri,  5 Nov 2021 09:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636105802;
        bh=E2drk16sAHpzTFaRkEobTH6+mH6PVvN0aJ5cqnwak34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVolZjlXlIB+mmbCVn2G0w4ygFhc1j4w9zM5cd/xqkmpam825+uxqIx3qybXKIzFj
         vEMDYF5E3M7DThFR+vNl557KqIpnn5lvag85B4iB8wusolrtPgBDADaKujrzywazkQ
         lnOCwNtjncSuTp2UiN4V3blHSPIM5pP5jxJ5lLbM=
Date:   Fri, 5 Nov 2021 10:49:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     hoshinomorimorimo@gmail.com
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix the style problem
Message-ID: <YYT+R5QpaNc3gJIm@kroah.com>
References: <618175c4.1c69fb81.bff5d.9cb8@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618175c4.1c69fb81.bff5d.9cb8@mx.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 01:30:17AM +0800, hoshinomorimorimo@gmail.com wrote:
> From: Hoshinomori-Owari <hoshinomorimorimo@gmail.com>
> 
> Fix block comment at
> rtw_io.c:8:
> rtw_io.c:139:
> rtw_io.c:154:
> 
> Remove not useful filename at
> rtw_io.c:9:
> 
> Add a blank line after declarations
> rtw_io.c:147:
> 
> Issue found by checkpatch.pl
> 
> Signed-off-by: Hoshinomori-Owari <hoshinomorimorimo@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_io.c | 56 +++++++++++++------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
> index 4d3c30ec93b5..6c46c6e295d5 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_io.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_io.c
> @@ -4,26 +4,27 @@
>   * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
>   *
>   ******************************************************************************/
> -/*
> -
> -The purpose of rtw_io.c
> -
> -a. provides the API
> -
> -b. provides the protocol engine
> -
> -c. provides the software interface between caller and the hardware interface
> -
>  
> -Compiler Flag Option:
> -
> -1. CONFIG_SDIO_HCI:
> -    a. USE_SYNC_IRP:  Only sync operations are provided.
> -    b. USE_ASYNC_IRP:Both sync/async operations are provided.
> -
> -jackson@realtek.com.tw
> -
> -*/
> +/*
> + *
> + *Purpose:
> + *
> + *	a. provides the API
> + *
> + *	b. provides the protocol engine
> + *
> + *	c. provides the software interface between caller and the hardware interface
> + *
> + *
> + *Compiler Flag Option:
> + *
> + *1. CONFIG_SDIO_HCI:
> + *	a. USE_SYNC_IRP:  Only sync operations are provided.
> + *	b. USE_ASYNC_IRP:Both sync/async operations are provided.
> + *
> + *jackson@realtek.com.tw
> + *
> + */
>  
>  #include <drv_types.h>
>  #include <rtw_debug.h>
> @@ -135,24 +136,25 @@ int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct adapt
>  	return _SUCCESS;
>  }
>  
> -/*
> -* Increase and check if the continual_io_error of this @param dvobjprive is larger than MAX_CONTINUAL_IO_ERR
> -* @return true:
> -* @return false:
> -*/
> +/**
> + * Increase and check if the continual_io_error of this @param dvobjprive is larger than MAX_CONTINUAL_IO_ERR
> + * @return true:
> + * @return false:
> + */
>  int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
>  {
>  	int ret = false;
>  	int value = atomic_inc_return(&dvobj->continual_io_error);
> +
>  	if (value > MAX_CONTINUAL_IO_ERR)
>  		ret = true;
>  
>  	return ret;
>  }
>  
> -/*
> -* Set the continual_io_error of this @param dvobjprive to 0
> -*/
> +/**
> + * Set the continual_io_error of this @param dvobjprive to 0
> + */
>  void rtw_reset_continual_io_error(struct dvobj_priv *dvobj)
>  {
>  	atomic_set(&dvobj->continual_io_error, 0);
> -- 
> 2.31.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

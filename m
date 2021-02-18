Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40FB31EF6D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhBRTNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:13:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233217AbhBRRsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:48:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49D5D64E79;
        Thu, 18 Feb 2021 17:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613670459;
        bh=9LOodOlDfKK937+aNt2DSiUuo0WvFvZNR/flDCS5HqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sy0dJSOeXe0s6Zw2YQ7niEOCQ5pvu8p7QXDFI2Hpkza4Q6xkiMCpndXOYwkrY/2ka
         FDN9N4qvkY1lqV7vHzBjJSVEJXn95AjEAtEXyzDisbfxZZdPE/hXxGkMcrpR4O4GVn
         POYTooDHYo7UjG4x9dlHZzvNwJmSIlTEsd934i3s=
Date:   Thu, 18 Feb 2021 18:47:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suryashankar Das <suryashankardas.2002@gmail.com>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Align block comments
Message-ID: <YC6oONjckmrSP2ip@kroah.com>
References: <20210218172042.44597-1-suryashankardas.2002@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218172042.44597-1-suryashankardas.2002@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 10:50:43PM +0530, Suryashankar Das wrote:
> This patch fixes the checkpatch.pl warnings:
> WARNING: Block comments use * on subsequent lines
> WARNING: Block comments should align the * on each line
> 
> Signed-off-by: Suryashankar Das <suryashankardas.2002@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_security.c | 82 +++++++++----------
>  1 file changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
> index 46ba55a8952a..73b78740093b 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_security.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_security.c
> @@ -127,8 +127,8 @@ static __le32 getcrc32(u8 *buf, int len)
>  }
>  
>  /*
> -	Need to consider the fragment  situation
> -*/
> + *	Need to consider the fragment  situation
> + */
>  void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
>  {
>  	int	curfragnum, length;
> @@ -465,23 +465,23 @@ static const unsigned short Sbox1[2][256] = {  /* Sbox for hash (can be in ROM)
>    }
>  };
>  
> - /*
> -**********************************************************************
> -* Routine: Phase 1 -- generate P1K, given TA, TK, IV32
> -*
> -* Inputs:
> -*     tk[]      = temporal key			 [128 bits]
> -*     ta[]      = transmitter's MAC address	    [ 48 bits]
> -*     iv32      = upper 32 bits of IV		  [ 32 bits]
> -* Output:
> -*     p1k[]     = Phase 1 key			  [ 80 bits]
> -*
> -* Note:
> -*     This function only needs to be called every 2**16 packets,
> -*     although in theory it could be called every packet.
> -*
> -**********************************************************************
> -*/
> +/*
> + **********************************************************************
> + * Routine: Phase 1 -- generate P1K, given TA, TK, IV32
> + *
> + * Inputs:
> + *     tk[]      = temporal key			 [128 bits]
> + *     ta[]      = transmitter's MAC address	    [ 48 bits]
> + *     iv32      = upper 32 bits of IV		  [ 32 bits]
> + * Output:
> + *     p1k[]     = Phase 1 key			  [ 80 bits]
> + *
> + * Note:
> + *     This function only needs to be called every 2**16 packets,
> + *     although in theory it could be called every packet.
> + *
> + **********************************************************************
> + */

For these, please convert them to the kerneldoc format, don't create a
custom one as that's not needed and would only require someone else to
go back and fix it up again.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BE53189BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhBKLoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:44:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhBKLM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 06:12:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D299764DA8;
        Thu, 11 Feb 2021 11:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613041939;
        bh=AfWh3LS8RGgPFEcFw9yxWHIBiMZsD+b4vCHxRz9Uoqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mx5ujdB+2m2dHARodSMiqRArbBubV1FEfEU2WjoDvbfmOGLhqnQjHFWVCl5yVBorY
         Zpzaiyib1vNNLVa3ZoGyGkt6/pOIWIXuZPmkikjjjrI0mWTaZbZZf2I43UvxH2BgkA
         2gCx6mjYansczUPTaUvqaTDgr1xHKTMjRi8gYA3w=
Date:   Thu, 11 Feb 2021 12:12:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     karthik alapati <mail@karthek.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix function comments to follow
 kernel-doc
Message-ID: <YCURDrcCcAmVOIbL@kroah.com>
References: <YCQvl3+KviQNh2JI@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQvl3+KviQNh2JI@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:40:15AM +0530, karthik alapati wrote:
> fix checkpatch.pl warning for "block comments should align the
>  * on each line" and make function comments follow kernel-doc
> 
> Signed-off-by: karthik alapati <mail@karthek.com>
> ---
>  .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 185 +++++++-----------
>  1 file changed, 73 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> index cf23414d7..1fd504181 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> @@ -20,16 +20,11 @@
>  #define MAX_DOZE_WAITING_TIMES_9x 64
>  
>  /**
> -* Function:	phy_CalculateBitShift
> -*
> -* OverView:	Get shifted position of the BitMask
> -*
> -* Input:
> -*		u32 	BitMask,
> -*
> -* Output:	none
> -* Return:		u32 	Return the shift bit bit position of the mask
> -*/
> + *	phy_CalculateBitShift - Get shifted position of the BitMask.
> + *	@BitMask: Bitmask.
> + *
> + *	Return:	Return the shift bit position of the mask
> + */

Why indent these comments by a tab?  A single space is fine.

thanks,

greg k-h

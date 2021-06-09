Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0BA3A10E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbhFIKNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:13:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234217AbhFIKNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:13:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE6FE61029;
        Wed,  9 Jun 2021 10:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623233479;
        bh=VmFXhB0ZrpuqFDd1YXmA4y9nYU9ndBAjpIJbOp94CPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtfwcnVlN4bHOcewFjusI7hQqsuJL8DKilDDdA8FEXpRKnPCKtMH5AVxzFdFXMZaF
         FDlVjiqNNKiuSZ1WmC1W9BfMQkfaYx2tjXvsrA9TWmRQSD+FuJHWOMlyXH9L03aTMz
         E8R15pEwmp++N/O6RLTl/jonX0uSK4oHiwMy+mCY=
Date:   Wed, 9 Jun 2021 12:11:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Remove unnecessary alias of printk()
Message-ID: <YMCTxLcE/KF+8R5u@kroah.com>
References: <20210606034038.9657-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606034038.9657-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 05:40:38AM +0200, Fabio M. De Francesco wrote:
> This module defines four alias for printk(). Removed them
> all, because they are not used anywhere else in the driver.
> Converted the only exception to the explicit use of printk().
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl8712_cmd.c   |  2 +-
>  drivers/staging/rtl8712/rtl871x_debug.h | 23 -----------------------
>  2 files changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
> index ff3cb09c57a6..e94604cb71fd 100644
> --- a/drivers/staging/rtl8712/rtl8712_cmd.c
> +++ b/drivers/staging/rtl8712/rtl8712_cmd.c
> @@ -55,7 +55,7 @@ static void check_hw_pbc(struct _adapter *padapter)
>  		/* Here we only set bPbcPressed to true
>  		 * After trigger PBC, the variable will be set to false
>  		 */
> -		DBG_8712("CheckPbcGPIO - PBC is pressed !!!!\n");
> +		printk(KERN_DEBUG "CheckPbcGPIO - PBC is pressed !!!!\n");

As an add-on patch, you should move this to netdev_dbg() or dev_dbg().

thanks,

greg k-h

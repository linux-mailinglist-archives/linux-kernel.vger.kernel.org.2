Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82850446030
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhKEHkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhKEHkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:40:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76424601FC;
        Fri,  5 Nov 2021 07:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636097857;
        bh=qqbLiTbnVCwZfnp5eUMkwMEotRiSq7CKH6gzjNBn+Ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VRut6+et+9FaHkhrGhr31uj/zIAlBarPKrRHMRQaOeFjnISkm9+//YCiqkM3mv3aY
         Ti/OXvpXQKQ3zhfyaP4TU73Aoecl60x3RbXDKYRbq4Yy+tIK91suO0r1YNIG5O3Wj4
         nyBQvi0Qq8/l4qtWAYX8VbQyaTkHk0Pt4pes5gVk=
Date:   Fri, 5 Nov 2021 08:37:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     davidcomponentone@gmail.com
Cc:     dan.carpenter@oracle.com, ivan.zaentsev@wirenboard.ru,
        linux-kernel@vger.kernel.org, unixbhaskar@gmail.com,
        yang.guang5@zte.com.cn, yangyingliang@huawei.com, zbr@ioremap.net,
        zealci@zte.com.cn
Subject: Re: [PATCH v2] w1: w1_therm: use swap() to make code cleaner
Message-ID: <YYTfPhg5GKtJGB3o@kroah.com>
References: <20211104110900.GB3164@kadam>
 <d687b56df7dc93497bc78e5c337fc05711b5d98a.1636097083.git.yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d687b56df7dc93497bc78e5c337fc05711b5d98a.1636097083.git.yang.guang5@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 03:32:44PM +0800, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>  drivers/w1/slaves/w1_therm.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> index ca70c5f03206..565578002d79 100644
> --- a/drivers/w1/slaves/w1_therm.c
> +++ b/drivers/w1/slaves/w1_therm.c
> @@ -1785,7 +1785,7 @@ static ssize_t alarms_store(struct device *device,
>  	u8 new_config_register[3];	/* array of data to be written */
>  	int temp, ret;
>  	char *token = NULL;
> -	s8 tl, th, tt;	/* 1 byte per value + temp ring order */
> +	s8 tl, th;	/* 1 byte per value + temp ring order */
>  	char *p_args, *orig;
>  
>  	p_args = orig = kmalloc(size, GFP_KERNEL);
> @@ -1836,9 +1836,8 @@ static ssize_t alarms_store(struct device *device,
>  	th = int_to_short(temp);
>  
>  	/* Reorder if required th and tl */
> -	if (tl > th) {
> -		tt = tl; tl = th; th = tt;
> -	}
> +	if (tl > th)
> +		swap(tl, th);
>  
>  	/*
>  	 * Read the scratchpad to change only the required bits
> -- 
> 2.30.2
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

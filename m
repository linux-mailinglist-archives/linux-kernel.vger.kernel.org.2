Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713313194AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhBKUpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhBKUo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:44:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29CED64DA8;
        Thu, 11 Feb 2021 20:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613076258;
        bh=FtVPNbEO5qXmF5tcWfuPaV62+LSEKiJm7Eq3dBGfqnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdpIAIFg4r+l68fJ5GYFst7DlovuGpweTusBDutQrnhacw626p5eRNJ8Z/VqkaELP
         GzoEoA/uuKh7gBXeXm9ic/PCjTYE7Zs5GmkSN6ioyJt+gUhjWCWCcyRSYoVsw2/m9S
         /sh7k4pDJN0ZYP2nKLwE+Tf/i7tgIAUZo2U50qK8=
Date:   Thu, 11 Feb 2021 21:44:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pritthijit Nath <pritthijit.nath@icloud.com>
Cc:     tvboxspy@gmail.com, devel@driverdev.osuosl.org,
        oscar.carter@gmx.com, forest@alittletooquiet.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Fixed issue with alignment in rf.c
Message-ID: <YCWXH1MZy0cbDB3G@kroah.com>
References: <20210211152426.10008-1-pritthijit.nath@icloud.com>
 <YCWTlWj4KHT6Okq/@kroah.com>
 <141aa6fe-972c-a9a2-f321-65a98ebccc41@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141aa6fe-972c-a9a2-f321-65a98ebccc41@icloud.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 02:07:50AM +0530, Pritthijit Nath wrote:
> On 12/02/21 1:59 am, Greg KH wrote:
> > On Thu, Feb 11, 2021 at 08:54:26PM +0530, Pritthijit Nath wrote:
> >> This change fixes a checkpatch CHECK style issue for "Alignment should match open parenthesis".
> >>
> >> Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> >> ---
> >>  drivers/staging/vt6656/rf.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
> >> index 5b8da06e3916..bcd4d467e03a 100644
> >> --- a/drivers/staging/vt6656/rf.c
> >> +++ b/drivers/staging/vt6656/rf.c
> >> @@ -687,7 +687,7 @@ static int vnt_rf_set_txpower(struct vnt_private *priv, u8 power,
> >>  
> >>  			if (hw_value < ARRAY_SIZE(vt3226d0_lo_current_table)) {
> >>  				ret = vnt_rf_write_embedded(priv,
> >> -					vt3226d0_lo_current_table[hw_value]);
> >> +							    vt3226d0_lo_current_table[hw_value]);
> >>  				if (ret)
> >>  					return ret;
> >>  			}
> >> -- 
> >> 2.25.1
> > 
> > Please run this change, with the changelog above, through
> > checkpatch.pl, fix that, and resend.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> This change fixes a checkpatch CHECK style issue for "Alignment should 
> match open parenthesis".
> 
> Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> ---
>  drivers/staging/vt6656/rf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
> index 5b8da06e3916..bcd4d467e03a 100644
> --- a/drivers/staging/vt6656/rf.c
> +++ b/drivers/staging/vt6656/rf.c
> @@ -687,7 +687,7 @@ static int vnt_rf_set_txpower(struct vnt_private *priv, u8 power,
>  
>  			if (hw_value < ARRAY_SIZE(vt3226d0_lo_current_table)) {
>  				ret = vnt_rf_write_embedded(priv,
> -					vt3226d0_lo_current_table[hw_value]);
> +							    vt3226d0_lo_current_table[hw_value]);
>  				if (ret)
>  					return ret;
>  			}

I can't take this type of submission, do you see other patches submitted
this way on the mailing list?

Also, you have a trailing space in your changelog text :(

thanks,

greg k-h

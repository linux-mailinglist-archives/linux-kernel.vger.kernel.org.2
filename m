Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F94836EB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbhD2Nvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237338AbhD2Nvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:51:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ED2A61408;
        Thu, 29 Apr 2021 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619704253;
        bh=ejVVFvAF84S6Xw7FoyyBDPEBrqddy/u0lA3QZIj11mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLe+SXjLUmpJmtOK1+7GYtqDoEcafxn+I++ZyRCzn5JoYXm0Hoe0mK7QFtL3+9aUl
         VMijpzyLijOKwSOwdUUYTZRctsDlraVyGr378+8m/qu3jjmx2vvLpFKYwcTN59XJtb
         Itrmir0Tjm7gpXbYTLPRian3ohZsSRD5kW/AxAFI=
Date:   Thu, 29 Apr 2021 15:50:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 3/7] Revert "orinoco: avoid assertion in case of NULL
 pointer"
Message-ID: <YIq5uQoBLuYvoFTk@kroah.com>
References: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
 <20210429130811.3353369-4-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429130811.3353369-4-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 03:08:07PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit c705f9fc6a1736dcf6ec01f8206707c108dca824.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper submitted to the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota) but later
> withdrawn.
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/wireless/intersil/orinoco/orinoco_usb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
> index dd31929261ab..60e626eb913d 100644
> --- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
> +++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
> @@ -1392,8 +1392,7 @@ static int ezusb_init(struct hermes *hw)
>  	struct ezusb_priv *upriv = hw->priv;
>  	int retval;
>  
> -	if (!upriv)
> -		return -EINVAL;
> +	BUG_ON(!upriv);
>  
>  	upriv->reply_count = 0;
>  	/* Write the MAGIC number on the simulated registers to keep
> -- 
> 2.31.1
> 

The original commit here looks correct, I'll drop this revert.

thanks,

greg k-h

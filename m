Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0E454A75
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbhKQQGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:06:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhKQQGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:06:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E089461B3A;
        Wed, 17 Nov 2021 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637165032;
        bh=yQVEhZtlbcMVkIwHKjfRrDfiiWcZN5q+YNUK5Szen7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GUeCBicRf0qeeYL+HhLOfAAaVuMuaL3TE8ic9fPwNGNJIlTu24XzzARhDtLgbhtop
         E6hdM2vbwNHaQz/M8aQ2yX2VqyP3peG3F5ufSFKsYEm1+3QDYo+GNWBXA9lHDpFMbg
         9avoITnpIgML1vWTD4c4pOL2DrqeCPlyIBX3fjiE=
Date:   Wed, 17 Nov 2021 17:03:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sven Peter <sven@svenpeter.dev>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: tipd: Fix typo in
 cd321x_switch_power_state
Message-ID: <YZUn5S+RMF4yOnOt@kroah.com>
References: <20211117151450.207168-1-marcan@marcan.st>
 <20211117151450.207168-2-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117151450.207168-2-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 12:14:49AM +0900, Hector Martin wrote:
> SPSS should've been SSPS.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/usb/typec/tipd/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index fb8ef12bbe9c..4da5a0b2aed2 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -653,7 +653,7 @@ static int cd321x_switch_power_state(struct tps6598x *tps, u8 target_state)
>  	if (state == target_state)
>  		return 0;
>  
> -	ret = tps6598x_exec_cmd(tps, "SPSS", sizeof(u8), &target_state, 0, NULL);
> +	ret = tps6598x_exec_cmd(tps, "SSPS", sizeof(u8), &target_state, 0, NULL);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.33.0
> 

This looks like a "Fix" commit.  What commit id does this fix?

thanks,

greg k-h

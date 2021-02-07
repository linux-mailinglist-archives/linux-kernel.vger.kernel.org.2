Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E42E312567
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBGPfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:35:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhBGPfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:35:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B479564E27;
        Sun,  7 Feb 2021 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612712109;
        bh=y+pwhFgfAo4wBpP1y6ygycBPpFQjtHzP+ttAAI+Eslo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T78g36yPRtCo5fdIUlADzAgIqHSa8jaqJDrMXPOTgKiqgaQEGUN1B8sFdqEdC0UgS
         X3mPbZyrQ9+T1M2g9odHxnk8r+F3NxuaoyiNTs0RzxtnpmRw6yPaFcI0zU1pWmGejR
         RR36t48/8CrcOw47MvSuLLdsUGCDM2/VWZ8IVUyM=
Date:   Sun, 7 Feb 2021 16:35:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     devel@driverdev.osuosl.org, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
        alexander.sverdlin@nokia.com, davem@davemloft.net
Subject: Re: [PATCH v2] staging: octeon: convert all uses of strlcpy to
 strscpy in ethernet-mdio.c
Message-ID: <YCAIqrpLLBxZh+47@kroah.com>
References: <20210207151320.88696-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207151320.88696-1-phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 03:13:20PM +0000, Phillip Potter wrote:
> Convert three calls to strlcpy inside the cvm_oct_get_drvinfo function
> to strscpy calls. As return values were not checked for these three
> calls before, change should be safe as functionality is equivalent.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
> 
> v2: Modified changelog to take account of feedback from Greg KH.
> 
>  drivers/staging/octeon/ethernet-mdio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
> index b0fd083a5bf2..b3049108edc4 100644
> --- a/drivers/staging/octeon/ethernet-mdio.c
> +++ b/drivers/staging/octeon/ethernet-mdio.c
> @@ -21,9 +21,9 @@
>  static void cvm_oct_get_drvinfo(struct net_device *dev,
>  				struct ethtool_drvinfo *info)
>  {
> -	strlcpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
> -	strlcpy(info->version, UTS_RELEASE, sizeof(info->version));
> -	strlcpy(info->bus_info, "Builtin", sizeof(info->bus_info));
> +	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
> +	strscpy(info->version, UTS_RELEASE, sizeof(info->version));
> +	strscpy(info->bus_info, "Builtin", sizeof(info->bus_info));
>  }
>  
>  static int cvm_oct_nway_reset(struct net_device *dev)

Sorry, this does not apply to my tree, someone already did this
conversion before you :(

greg k-h

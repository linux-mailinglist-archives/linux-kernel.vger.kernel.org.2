Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1D3124F9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBGPIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:08:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhBGPHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:07:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3B5060200;
        Sun,  7 Feb 2021 15:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612710400;
        bh=22sAeCfIcyufrTC9pcNJGAxYa0qw4wqdKuhVpsRwOkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYe0D8B5RBcilBF/3xmYHmRrUbUgSAXA08DU3JRkmpodc9MspqUIrvbq5KQjf7mTm
         YELPAM6Svl9GOzPrmODWSq+a2X3RusDJCdfsXJI/q5p3mh561EOpr7YL4wpPMs1qpI
         a01RZkj0ePbGix+yQjGt+zAF4Oms9JZbRzf3HpUw=
Date:   Sun, 7 Feb 2021 16:06:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     devel@driverdev.osuosl.org, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
        alexander.sverdlin@nokia.com, davem@davemloft.net
Subject: Re: [PATCH v2] staging: octeon: convert all uses of strlcpy to
 strscpy in ethernet-mdio.c
Message-ID: <YCAB/Sl20KhLIxtb@kroah.com>
References: <20210207150302.88560-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207150302.88560-1-phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 03:03:02PM +0000, Phillip Potter wrote:
> Convert three calls to strlcpy inside the cvm_oct_get_drvinfo function
> to strscpy calls. As return values were not checked for these three
> calls before, change should be safe as functionality is equivalent.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
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
> -- 
> 2.29.2


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

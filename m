Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E3331952D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 22:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhBKVcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 16:32:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhBKVcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:32:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE51E64DEA;
        Thu, 11 Feb 2021 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613079087;
        bh=aIsuo3YD/N88Yx4c/ywWeUam/kTnR9n5/rvhXdOyAPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAavQj13k3DH+DdmtSl48iKOBvayKhpXGmxIoWfk3J7ASWky+96e/mgrNGcnH8SKf
         Kqh47uE3I9BQ1LwZG9iT7WHmoyKXEedIydEgDy3MBaEZLbrQCcqB2AbODicgNFvfTg
         uSzZRCyieCJijEvN4VbJC4bkBZNdJkkSfcIIEXGk=
Date:   Thu, 11 Feb 2021 22:31:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pritthijit Nath <pritthijit.nath@icloud.com>
Cc:     forest@alittletooquiet.net, oscar.carter@gmx.com,
        tvboxspy@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Fixed issue with alignment in rf.c
Message-ID: <YCWiKwTKxvDLcHHP@kroah.com>
References: <20210211212647.7077-1-pritthijit.nath@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211212647.7077-1-pritthijit.nath@icloud.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 02:56:47AM +0530, Pritthijit Nath wrote:
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
> --
> 2.25.1


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

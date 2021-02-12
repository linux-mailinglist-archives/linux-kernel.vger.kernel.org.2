Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639FD319C49
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBLKDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhBLKDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:03:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD0C464E6B;
        Fri, 12 Feb 2021 10:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613124175;
        bh=fWVq8k8RFQBMENGPdSVHmwC5EnHdxReFRfSG9FAZbsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdT6hoQFVFdL97sGhbqS92xz1H0jA9mbFRs536tQn5jrrZ+QruTR7DGTPzpuXHUPH
         SdrFqKSHPLqjpenJ5GVrQq8RGO/R/8yZSRGv+/wAKqoCYCVYfpIQlo9WyAvQMC00r7
         QuKQw453pNxGUXurKkSinXEls8quW+RMPVF8OE84=
Date:   Fri, 12 Feb 2021 11:02:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pritthijit Nath <pritthijit.nath@icloud.com>
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: greybus: Fixed a misspelling in hid.c
Message-ID: <YCZSTJuDiPGaQ1yV@kroah.com>
References: <20210212095008.11741-1-pritthijit.nath@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212095008.11741-1-pritthijit.nath@icloud.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 03:20:08PM +0530, Pritthijit Nath wrote:
> Fixed the spelling of 'transfered' to 'transferred'.
> 
> Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> ---
>  Fixed the typo in the patch which was meant to fix that very typo.
>  Really sorry for last time.
>  Hope this does not have any other typo.
> 
>  drivers/staging/greybus/hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
> index a56c3fb5d35a..adb91286803a 100644
> --- a/drivers/staging/greybus/hid.c
> +++ b/drivers/staging/greybus/hid.c
> @@ -254,7 +254,7 @@ static int __gb_hid_output_raw_report(struct hid_device *hid, __u8 *buf,
>  
>  	ret = gb_hid_set_report(ghid, report_type, report_id, buf, len);
>  	if (report_id && ret >= 0)
> -		ret++; /* add report_id to the number of transfered bytes */
> +		ret++; /* add report_id to the number of transferred bytes */
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

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
  did not list below the --- line any changes from the previous version,
  or properly version the subject line of your patch.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what needs to be done here to
  properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

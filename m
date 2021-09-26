Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89964186C8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 08:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhIZGyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 02:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhIZGyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 02:54:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 538A060EFF;
        Sun, 26 Sep 2021 06:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632639146;
        bh=81xpS3q2UnTLTS7hZjj+PjNPBljHJgePYoS+NnHrNCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AkwGttSCGwnT9qhKGQxrSEduHbkFHr6WKINk4rBJCgsgnFznYy/y9VjydP7hpWJdF
         oKb8x8nCOiXOz1uCmi/sLpKLxRlklKp+yH9Fw5FV8PBPqs8IwSMLa1lF8FzY1w+JIc
         U8i5NwhghUEVIKmBFbomw+htafj2ehQ0Xj4SuMPc=
Date:   Sun, 26 Sep 2021 08:52:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Estner <michaelestner@web.de>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove uneccessary parantheas
Message-ID: <YVAYornUTU7jTNIW@kroah.com>
References: <20210925192018.6745-1-michaelestner@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925192018.6745-1-michaelestner@web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 09:20:15PM +0200, Michael Estner wrote:
> Fix to be conform with the checkpatch style requirements
> 
> Signed-off-by: Michael Estner <michaelestner@web.de>
> ---
>  drivers/staging/pi433/rf69.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
> index 7d86bb8be245..980afa801e08 100644
> --- a/drivers/staging/pi433/rf69.c
> +++ b/drivers/staging/pi433/rf69.c
> @@ -470,9 +470,9 @@ static int rf69_set_bandwidth_intern(struct spi_device *spi, u8 reg,
>  		return -EINVAL;
>  	}
> 
> -	if ((mantisse != mantisse16) &&
> -	    (mantisse != mantisse20) &&
> -	    (mantisse != mantisse24)) {
> +	if (mantisse != mantisse16 &&
> +	    mantisse != mantisse20 &&
> +	    mantisse != mantisse24) {
>  		dev_dbg(&spi->dev, "set: illegal input param");
>  		return -EINVAL;
>  	}
> --
> 2.25.1
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

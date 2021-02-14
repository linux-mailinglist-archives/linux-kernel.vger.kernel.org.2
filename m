Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9988231AFBC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 09:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBNIXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 03:23:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhBNIXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 03:23:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 429EA61494;
        Sun, 14 Feb 2021 08:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613290940;
        bh=eEexJt/J+1tpBvDYB/9nq5c+6LGyEky3FQl08Rf1QYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8kBJ7JTp776CvM8yPf9lFUA0CeebY9zqrkcrC921zNVTCNAW/WbAJizcCaux9EVB
         X4W4BgPLsr9vhYZtWrE75sqkc4NNkc0nezLPqqtppAjC9DaI669hpKs25Azhw0WHbW
         ICKkDV0H7EFw4qO98DqlclV/+k/5eZqSNNWdk7RQ=
Date:   Sun, 14 Feb 2021 09:22:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ashish Vara <ashishvara89@yahoo.com>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        rcy@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixed coding style warning
Message-ID: <YCjdugK8vv6jC4SS@kroah.com>
References: <482ff5a0-9089-c05a-4763-e25e14f588b5.ref@yahoo.com>
 <482ff5a0-9089-c05a-4763-e25e14f588b5@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482ff5a0-9089-c05a-4763-e25e14f588b5@yahoo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 01:48:06AM +0530, Ashish Vara wrote:
> removed unnecessary out of memory message
> 
> Signed-off-by: Ashish Vara <ashishvara89@yahoo.com>
> ---
>  drivers/staging/gasket/gasket_page_table.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
> index 6f6273c83822..2dbf3d9b8f34 100644
> --- a/drivers/staging/gasket/gasket_page_table.c
> +++ b/drivers/staging/gasket/gasket_page_table.c
> @@ -262,8 +262,6 @@ int gasket_page_table_init(struct gasket_page_table **ppg_tbl,
>  	if (bytes != 0) {
>  		pg_tbl->entries = vzalloc(bytes);
>  		if (!pg_tbl->entries) {
> -			dev_dbg(device,
> -				"No memory for address translation metadata\n");
>  			kfree(pg_tbl);
>  			*ppg_tbl = NULL;
>  			return -ENOMEM;


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

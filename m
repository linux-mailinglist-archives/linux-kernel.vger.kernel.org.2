Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81F136C6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbhD0NZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236008AbhD0NZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:25:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5546860FD8;
        Tue, 27 Apr 2021 13:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619529870;
        bh=JXDRNlXLZpJFQol+KTPuA/3OzaJAO9gAwg5E774vJkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/z8N7CNn15YUb1OdZH6kIgTwxHKUmv7rC3bfhgFdDwV1mltoA9j/h/QQYtkZdikk
         8sWwxUtITuPuVJCgozjcS/o2SlAvEj1MCq05vVL58NHzhNk9i2KlNzeoXwiqA7bwoG
         T3u3ZwBQgj8jHq1d0GE2N50KL3zuFeuRTyOhvv4w=
Date:   Tue, 27 Apr 2021 15:24:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 153/190] Revert "media: usb: gspca: add a missed
 return-value check for do_command"
Message-ID: <YIgQi1V/haZOqadM@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-154-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-154-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:28PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 5ceaf5452c1b2a452dadaf377f9f07af7bda9cc3.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/usb/gspca/cpia1.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
> index d93d384286c1..99e594559a0c 100644
> --- a/drivers/media/usb/gspca/cpia1.c
> +++ b/drivers/media/usb/gspca/cpia1.c
> @@ -537,14 +537,10 @@ static int do_command(struct gspca_dev *gspca_dev, u16 command,
>  		}
>  		if (sd->params.qx3.button) {
>  			/* button pressed - unlock the latch */
> -			ret = do_command(gspca_dev, CPIA_COMMAND_WriteMCPort,
> +			do_command(gspca_dev, CPIA_COMMAND_WriteMCPort,
>  				   3, 0xdf, 0xdf, 0);
> -			if (ret)
> -				return ret;
> -			ret = do_command(gspca_dev, CPIA_COMMAND_WriteMCPort,
> +			do_command(gspca_dev, CPIA_COMMAND_WriteMCPort,
>  				   3, 0xff, 0xff, 0);
> -			if (ret)
> -				return ret;
>  		}
>  
>  		/* test whether microscope is cradled */
> -- 
> 2.31.1
> 

This looks correct, I'll drop the revert.

But ick, recursion?  What could go wrong....

greg k-h

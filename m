Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F47836C6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbhD0NU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236001AbhD0NU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:20:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C76B8600CC;
        Tue, 27 Apr 2021 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619529584;
        bh=Ie48lGinW5GRBhoMFVQnXcPzZEu+eS+IAT7HtMWqlGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w/gu7E85VT3W+NW60jdMXyPnt/VS4MdLJhYo/HJAzujvzApHH6sfHN1+zYpVszZFn
         5wNSgvXkjrpzj8vXmKduyLBm3aO8TffSZPOAWDjeeW1frj7Kr0sAqCb0eZK1imBhJK
         rFdmJPXKbwmE89CPieyLss45tq2nKoFhYVOXDuWg=
Date:   Tue, 27 Apr 2021 15:19:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 152/190] Revert "media: usb: gspca: add a missed check
 for goto_low_power"
Message-ID: <YIgPbVT+Tj1F9KRE@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-153-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-153-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:27PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 5b711870bec4dc9a6d705d41e127e73944fa3650.
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
>  drivers/media/usb/gspca/cpia1.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
> index a4f7431486f3..d93d384286c1 100644
> --- a/drivers/media/usb/gspca/cpia1.c
> +++ b/drivers/media/usb/gspca/cpia1.c
> @@ -1424,7 +1424,6 @@ static int sd_config(struct gspca_dev *gspca_dev,
>  {
>  	struct sd *sd = (struct sd *) gspca_dev;
>  	struct cam *cam;
> -	int ret;
>  
>  	sd->mainsFreq = FREQ_DEF == V4L2_CID_POWER_LINE_FREQUENCY_60HZ;
>  	reset_camera_params(gspca_dev);
> @@ -1436,10 +1435,7 @@ static int sd_config(struct gspca_dev *gspca_dev,
>  	cam->cam_mode = mode;
>  	cam->nmodes = ARRAY_SIZE(mode);
>  
> -	ret = goto_low_power(gspca_dev);
> -	if (ret)
> -		gspca_err(gspca_dev, "Cannot go to low power mode: %d\n",
> -			  ret);
> +	goto_low_power(gspca_dev);
>  	/* Check the firmware version. */
>  	sd->params.version.firmwareVersion = 0;
>  	get_version_information(gspca_dev);
> -- 
> 2.31.1
> 

The original commit here did nothing useful, so I am going to keep this
revert.

greg k-h

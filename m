Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA6036CA07
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbhD0RF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236169AbhD0RFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:05:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BF3D61177;
        Tue, 27 Apr 2021 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619543081;
        bh=bDhGZGKzReNUbTyG1hR+JHWjRGrBy35sBAmxQVkNJKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pqPpOETXZy3Ne2Hi7XU4A7XGzqREah/tYFCCliMt7fYQWGJzkPvdzqRYt6HEf7/tq
         5b6swoPwstEY3CWdJKpCdL020KYhCZgoKdWB6QJjrUMbfnfRmi+WsWk76ISuiFHSD9
         JL0LiEnU6kg0AnBw5/XN3QrVEoKTq93BAv45Q+zg=
Date:   Tue, 27 Apr 2021 19:04:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 145/190] Revert "leds: lp5523: fix a missing check of
 return value of lp55xx_read"
Message-ID: <YIhEJxEbOSzCm1+Z@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-146-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-146-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:20PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 248b57015f35c94d4eae2fdd8c6febf5cd703900.
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
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/leds/leds-lp5523.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
> index fc433e63b1dc..5036d7d5f3d4 100644
> --- a/drivers/leds/leds-lp5523.c
> +++ b/drivers/leds/leds-lp5523.c
> @@ -305,9 +305,7 @@ static int lp5523_init_program_engine(struct lp55xx_chip *chip)
>  
>  	/* Let the programs run for couple of ms and check the engine status */
>  	usleep_range(3000, 6000);
> -	ret = lp55xx_read(chip, LP5523_REG_STATUS, &status);
> -	if (ret)
> -		return ret;
> +	lp55xx_read(chip, LP5523_REG_STATUS, &status);
>  	status &= LP5523_ENG_STATUS_MASK;
>  
>  	if (status != LP5523_ENG_STATUS_MASK) {
> -- 
> 2.31.1
> 

The original commit here did not unwind things properly, so I'll keep
the revert and create a correct fix for this later.

thanks,

greg k-h

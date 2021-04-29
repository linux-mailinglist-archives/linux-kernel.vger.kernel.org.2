Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE436EC2D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbhD2ONV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235277AbhD2ONQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:13:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96D9E610A0;
        Thu, 29 Apr 2021 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619705550;
        bh=clzuBZR0L7dnM2q4M2FsHH5sXP6gp/LBlVl9ahY6fQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WI5dazIYLvPU9plyaUXzd4OIFy/lVISsO9F/qbj8kXQG6mtn+glr8hrzRdOHimPHR
         nEKDSW087AjnN+pPQSRopxs9JC1GOtNl3skyiKqIzH6vqx45WC0nyHP8ihfaX0NwHY
         uzZXThxdXcCoeXFImxCoh6pdB+OzGx18uhwcbFDM=
Date:   Thu, 29 Apr 2021 16:12:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 6/7] Revert "leds: lp5523: fix a missing check of return
 value of lp55xx_read"
Message-ID: <YIq+y1dKTOXnJhxy@kroah.com>
References: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
 <20210429130811.3353369-7-gregkh@linuxfoundation.org>
 <YIq4VD0NyUGv0uy1@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIq4VD0NyUGv0uy1@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 03:44:52PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 29, 2021 at 03:08:10PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 248b57015f35c94d4eae2fdd8c6febf5cd703900.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper submitted to the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota) but later
> > withdrawn.
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Kangjie Lu <kjlu@umn.edu>
> > Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/leds/leds-lp5523.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
> > index fc433e63b1dc..5036d7d5f3d4 100644
> > --- a/drivers/leds/leds-lp5523.c
> > +++ b/drivers/leds/leds-lp5523.c
> > @@ -305,9 +305,7 @@ static int lp5523_init_program_engine(struct lp55xx_chip *chip)
> >  
> >  	/* Let the programs run for couple of ms and check the engine status */
> >  	usleep_range(3000, 6000);
> > -	ret = lp55xx_read(chip, LP5523_REG_STATUS, &status);
> > -	if (ret)
> > -		return ret;
> > +	lp55xx_read(chip, LP5523_REG_STATUS, &status);
> >  	status &= LP5523_ENG_STATUS_MASK;
> >  
> >  	if (status != LP5523_ENG_STATUS_MASK) {
> > -- 
> > 2.31.1
> > 
> 
> This looks incorrect to me as lp5523_run_engine() has been called and
> not cleaned up from properly.
> 
> I'll keep the revert and fix this up correctly.

I already reviewed this one too, sorry for the noise.

greg k-h

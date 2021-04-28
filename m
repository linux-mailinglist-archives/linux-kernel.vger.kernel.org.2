Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810BB36D2EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbhD1HTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236394AbhD1HTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:19:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 994AF601FC;
        Wed, 28 Apr 2021 07:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619594286;
        bh=+a3wPK2As0qZPFjLyLysQQNzrUKRo/Xbgi5bzhCpgNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ffXAMZRCkCq4LM+Agk2MiDvpdgIeYNEepKYx0nM+9lEEEbQ9Ow/MPdmGU5XGszody
         UNWzSLJQxq0dCmH0zYOLMiYaRzqXVsCf8bRkG89m/+N+IgeuqQPRbtd/JQuaufRdrQ
         gChblV53JGeF1UkM+UNYct6DISGN3nUqABR5YNBc=
Date:   Wed, 28 Apr 2021 09:18:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 088/190] Revert "mmc_spi: add a status check for
 spi_sync_locked"
Message-ID: <YIkMK5XkUcyhauWH@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-89-gregkh@linuxfoundation.org>
 <YIAmS4jc5W21epzh@pendragon.ideasonboard.com>
 <CAPDyKFr9EgTJAujJnQd4USuLZyYbedjZBwLZRh1Cxz+87CharA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr9EgTJAujJnQd4USuLZyYbedjZBwLZRh1Cxz+87CharA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:08:45AM +0200, Ulf Hansson wrote:
> On Wed, 21 Apr 2021 at 15:19, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Greg,
> >
> > Thank you for the patch.
> >
> > On Wed, Apr 21, 2021 at 02:59:23PM +0200, Greg Kroah-Hartman wrote:
> > > This reverts commit 611025983b7976df0183390a63a2166411d177f1.
> > >
> > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > faith" to try to test the kernel community's ability to review "known
> > > malicious" changes.  The result of these submissions can be found in a
> > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > >
> > > Because of this, all submissions from this group must be reverted from
> > > the kernel tree and will need to be re-reviewed again to determine if
> > > they actually are a valid fix.  Until that work is complete, remove this
> > > change to ensure that no problems are being introduced into the
> > > codebase.
> > >
> > > Cc: Kangjie Lu <kjlu@umn.edu>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > I don't spot an obvious issue with the original patch though.
> >
> > > ---
> > >  drivers/mmc/host/mmc_spi.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> > > index 02f4fd26e76a..cc40b050e302 100644
> > > --- a/drivers/mmc/host/mmc_spi.c
> > > +++ b/drivers/mmc/host/mmc_spi.c
> > > @@ -800,10 +800,6 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
> > >       }
> > >
> > >       status = spi_sync_locked(spi, &host->m);
> > > -     if (status < 0) {
> > > -             dev_dbg(&spi->dev, "read error %d\n", status);
> > > -             return status;
> > > -     }
> 
> Returning here means we never give back the ownership of the buffer to
> the CPU. Can that be considered as vulnerability?

It's a "resource leak", which is a bug.  If you want to declare that as
a "vulnerability" or not, I do not know.  Personally I do not think it
is...

> If that is that a problem, I can point out that there is already one
> more case in this file, where this pattern is repeated. See
> mmc_spi_writeblock(). This code has been there since 2007.

Yeah, these error paths are impossible to hit anyway.

I'll go drop this patch as it is not correct and will create a "correct"
patch for this as well.

thanks,

greg k-h

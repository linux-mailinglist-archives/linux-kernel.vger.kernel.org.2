Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13EC36EC52
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbhD2O0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233862AbhD2O0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:26:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CCBB613E8;
        Thu, 29 Apr 2021 14:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619706343;
        bh=4cbWoy8ggBX8z8BI11Tq/aWLqP6zEfvA4Ch/IOro90w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=riIlnfVs0856IDwhP6yCwMh9Xo6+v2eK6qwLqfj4rp0X4KrZdFgXZSv7C5EJzRkCp
         bE0JZxBer+55N7mw6J0ZzT6RJL07DllKTE8x8lluUxGk4+D7Ix3gN20thJDQLvG6q7
         ZeaUIaBVwkGIJjnB7UX7GJYKwcCkNQkYj0hBGWMA=
Date:   Thu, 29 Apr 2021 16:25:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 088/190] Revert "mmc_spi: add a status check for
 spi_sync_locked"
Message-ID: <YIrB5UR+qIFqXyAm@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-89-gregkh@linuxfoundation.org>
 <YIAmS4jc5W21epzh@pendragon.ideasonboard.com>
 <CAPDyKFr9EgTJAujJnQd4USuLZyYbedjZBwLZRh1Cxz+87CharA@mail.gmail.com>
 <YIkMK5XkUcyhauWH@kroah.com>
 <YIkftQ5YKGVudYk+@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIkftQ5YKGVudYk+@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 11:41:25AM +0300, Laurent Pinchart wrote:
> Hi Greg,
> 
> On Wed, Apr 28, 2021 at 09:18:03AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Apr 22, 2021 at 10:08:45AM +0200, Ulf Hansson wrote:
> > > On Wed, 21 Apr 2021 at 15:19, Laurent Pinchart wrote:
> > > > On Wed, Apr 21, 2021 at 02:59:23PM +0200, Greg Kroah-Hartman wrote:
> > > > > This reverts commit 611025983b7976df0183390a63a2166411d177f1.
> > > > >
> > > > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > > > faith" to try to test the kernel community's ability to review "known
> > > > > malicious" changes.  The result of these submissions can be found in a
> > > > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > > >
> > > > > Because of this, all submissions from this group must be reverted from
> > > > > the kernel tree and will need to be re-reviewed again to determine if
> > > > > they actually are a valid fix.  Until that work is complete, remove this
> > > > > change to ensure that no problems are being introduced into the
> > > > > codebase.
> > > > >
> > > > > Cc: Kangjie Lu <kjlu@umn.edu>
> > > > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > >
> > > > I don't spot an obvious issue with the original patch though.
> > > >
> > > > > ---
> > > > >  drivers/mmc/host/mmc_spi.c | 4 ----
> > > > >  1 file changed, 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> > > > > index 02f4fd26e76a..cc40b050e302 100644
> > > > > --- a/drivers/mmc/host/mmc_spi.c
> > > > > +++ b/drivers/mmc/host/mmc_spi.c
> > > > > @@ -800,10 +800,6 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
> > > > >       }
> > > > >
> > > > >       status = spi_sync_locked(spi, &host->m);
> > > > > -     if (status < 0) {
> > > > > -             dev_dbg(&spi->dev, "read error %d\n", status);
> > > > > -             return status;
> > > > > -     }
> > > 
> > > Returning here means we never give back the ownership of the buffer to
> > > the CPU. Can that be considered as vulnerability?
> > 
> > It's a "resource leak", which is a bug.  If you want to declare that as
> > a "vulnerability" or not, I do not know.  Personally I do not think it
> > is...
> 
> How is that a resource leak ? The dma_sync_single_for_device() calls
> above this block don't take the buffer ownership away from the CPU in a
> way that leaks it.

Ick, this is really twisty.

The calls to dma_sync_single_for_device() call down to
dma_direct_sync_single_for_device() for when you can directly talk to
the hardware, or to the platform sync_single_for_device() callback for
arches that can not.

Those are messy, but the worst they all seem to do is invalidate or
flush some caches, no type of resource allocation that I could determine
here.

So I'll trust you, and drop the revert and mark this one as "good
patch" :)

Thanks again for the review, much appreciated.

greg k-h

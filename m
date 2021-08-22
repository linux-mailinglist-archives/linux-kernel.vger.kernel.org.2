Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCCF3F4242
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 01:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhHVXHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 19:07:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58808 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhHVXHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 19:07:51 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 631014A3;
        Mon, 23 Aug 2021 01:07:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1629673628;
        bh=Lt/044LNVGYtKRh+lwLPxz/NlNccPmFXmhVIRVpWKi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ms9OeAO9j4AP2kN2c5HHn8u3W1HZJWtMVe8r8On6nL3OZm5dvsC4mMuT6YJu0W0+B
         N6gMeHdqgyV38869ERBmxIxsYBPIadeao517RilAxfEgfrmZSOf3DWeVs0GVrOYU99
         L/BGnoksHjoLhG7c3MN7hiwqWfdC7hrKF9N5DOzg=
Date:   Mon, 23 Aug 2021 02:06:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] habanalabs pull request for kernel 5.15
Message-ID: <YSLYklow2ZAPqgK1@pendragon.ideasonboard.com>
References: <20210819110209.GA115485@ogabbay-vm2.habana-labs.com>
 <YR6PIvwYbYG20ZY0@kroah.com>
 <CAPM=9tyT_iouVE2v8J0SMJOLV=pr=QJOm88ud=bht4=5Ms2Y2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPM=9tyT_iouVE2v8J0SMJOLV=pr=QJOm88ud=bht4=5Ms2Y2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 04:48:18AM +1000, Dave Airlie wrote:
> On Fri, 20 Aug 2021 at 03:07, Greg KH wrote:
> > On Thu, Aug 19, 2021 at 02:02:09PM +0300, Oded Gabbay wrote:
> > > Hi Greg,
> > >
> > > This is habanalabs pull request for the merge window of kernel 5.15.
> > > The commits divide roughly 50/50 between adding new features, such
> > > as peer-to-peer support with DMA-BUF or signaling from within a graph,
> > > and fixing various bugs, small improvements, etc.
> >
> > Pulled and pushed out, thanks!
> 
> NAK for adding dma-buf or p2p support to this driver in the upstream
> kernel. There needs to be a hard line between
> "I-can't-believe-its-not-a-drm-driver" drivers which bypass our
> userspace requirements, and I consider this the line.
> 
> This driver was merged into misc on the grounds it wasn't really a
> drm/gpu driver and so didn't have to accept our userspace rules.
> 
> Adding dma-buf/p2p support to this driver is showing it really fits
> the gpu driver model and should be under the drivers/gpu rules since
> what are most GPUs except accelerators.
> 
> We are opening a major can of worms (some would say merging habanalabs
> driver opened it), but this places us in the situation that if a GPU
> vendor just claims their hw is a "vector" accelerator they can use
> Greg to bypass all the work that been done to ensure we have
> maintainability long term. I don't want drivers in the tree using
> dma-buf to interact with other drivers when we don't have access to a
> userspace project to validate the kernel driver assumptions.

I can only voice the strongest agreement here. This is a situation that
is only too familiar and that we're facing in the camera world as well.
For the past ten years, the camera community has worked hard to build
bridges with hardware vendors. The public development in the kernel tree
is only the visible part of the iceberg, lots of efforts have been put
in reaching out, teaching and helping. A few years ago the libcamera
project got started to offer a userspace framework to device vendors
where they can contribute code, similar to Mesa for graphics (and
related) acceleration.

I can't emphasize strongly enough how much effort it took to start
getting vendors on board, and the situation is still fragile at best. If
we now send a message that all of this can be bypassed by merging code
that ignores all rules in drivers/misc/, it would be ten years of
completely wasted work. Beside the technical impact, the effect on the
motivation of the kernel and userspace communities we have slowly built
over time would be catastrophic.

-- 
Regards,

Laurent Pinchart

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAB4311EA7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 17:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBFQbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 11:31:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhBFQbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 11:31:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86CC964DE7;
        Sat,  6 Feb 2021 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612629028;
        bh=+5u8CYGq/oLss2zps/gOmRSFaWlR2k+5OsBfGDsdcSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WX26nVFWIDSvbBRz8/DNvKTCMXGUlMNIgRokFB9uCQYy6Vcp3FBe7gcYSTsp1w4HD
         N7fMGNKgRja2WqRkvKyLw+fUde3lpBMPDIKNBJWCTRAudxys3TG+pj6mCJV8UMOWoO
         gmADyl3acgDsfjuVi3s6t6nxAkHsE6ipQ9t7m1Ws=
Date:   Sat, 6 Feb 2021 17:30:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: [char-misc-next 6/6] mei: bus: add client dma interface
Message-ID: <YB7EIciZrmBrEqUA@kroah.com>
References: <20210206144325.25682-1-tomas.winkler@intel.com>
 <20210206144325.25682-6-tomas.winkler@intel.com>
 <YB6sIi61X5p6Dq6y@kroah.com>
 <2a9b40090acd41438fc6b1d2fb49f38d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a9b40090acd41438fc6b1d2fb49f38d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 06, 2021 at 03:04:34PM +0000, Winkler, Tomas wrote:
> > On Sat, Feb 06, 2021 at 04:43:25PM +0200, Tomas Winkler wrote:
> > > From: Alexander Usyskin <alexander.usyskin@intel.com>
> > >
> > > Expose the client dma mapping via mei client bus interface.
> > >
> > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > ---
> > >  drivers/misc/mei/bus.c     | 46
> > ++++++++++++++++++++++++++++++++++++++
> > >  drivers/misc/mei/hw.h      |  5 +++++
> > >  include/linux/mei_cl_bus.h |  3 +++
> > >  3 files changed, 54 insertions(+)
> > >
> > > diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c index
> > > 34fb5e541fe5..d430710a5fe5 100644
> > > --- a/drivers/misc/mei/bus.c
> > > +++ b/drivers/misc/mei/bus.c
> > > @@ -636,6 +636,52 @@ static void mei_cl_bus_vtag_free(struct
> > mei_cl_device *cldev)
> > >  	kfree(cl_vtag);
> > >  }
> > >
> > > +void *mei_cldev_dma_map(struct mei_cl_device *cldev, u8 buffer_id,
> > > +size_t size) {
> > > +	struct mei_device *bus;
> > > +	struct mei_cl *cl;
> > > +	int ret;
> > > +
> > > +	if (!cldev || !buffer_id || !size)
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	if (!IS_ALIGNED(size, MEI_FW_PAGE_SIZE)) {
> > > +		dev_err(&cldev->dev, "Map size should be aligned to %lu\n",
> > > +			MEI_FW_PAGE_SIZE);
> > > +		return ERR_PTR(-EINVAL);
> > > +	}
> > > +
> > > +	cl = cldev->cl;
> > > +	bus = cldev->bus;
> > > +
> > > +	mutex_lock(&bus->device_lock);
> > > +	ret = mei_cl_dma_alloc_and_map(cl, NULL, buffer_id, size);
> > > +	mutex_unlock(&bus->device_lock);
> > > +	if (ret)
> > > +		return ERR_PTR(ret);
> > > +	return cl->dma.vaddr;
> > > +}
> > > +EXPORT_SYMBOL_GPL(mei_cldev_dma_map);
> > 
> > Why are you exporting symbols without a user of them?
> > 
> > That's a sure way to get them removed by someone right after this lands in
> > the tree :)
> > 
> > Please only add infrastructure for when you have a real user.
> You are right,  the user is coming from wifi tree. We need merge before they do.
> If you prefer we can merge that all from the wifi tree.

That wasn't documented well at all in your changelog comment :(

It can go through whatever tree needs it.

thanks,

greg k-h

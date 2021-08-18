Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3633F0489
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbhHRNW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236892AbhHRNW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:22:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0D7160232;
        Wed, 18 Aug 2021 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629292942;
        bh=mUS2XHoBNSYTIuTRFqsUU57sxADOx3BgsDP98f3EzMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D/jrowO11usaVNWUNbge+kprse4L+XNseJefutlHU6ZDzNuidRBevYMPNo/9Scubx
         W7zY9wGu29+Wfb+b2voB6OMjqKXLQfMtNJj2oqiQhxnyOkRIVF2/fCxoxuvNdvB5/t
         LqtqTz1iIBHfptgtYoXwhTo/5uyyCjwpQEZFFMFk=
Date:   Wed, 18 Aug 2021 15:22:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 1/2] driver core: export
 driver_deferred_probe_trigger()
Message-ID: <YR0Ji7DQXoo0z4vP@kroah.com>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com>
 <20210818115736.GA4177@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818115736.GA4177@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 12:57:36PM +0100, Mark Brown wrote:
> On Wed, Aug 18, 2021 at 07:44:39AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 17, 2021 at 02:00:56PM -0500, Pierre-Louis Bossart wrote:
> 
> > > In these cases, there is no way to notify the deferred probe
> > > infrastructure of the enablement of resources after the driver
> > > binding.
> 
> > Then just wait for it to happen naturally?
> 
> Through what mechanism will it happen naturally?  Deferred probe
> currently only does things if things are being registered or if probes
> complete.
> 
> > > The driver_deferred_probe_trigger() function is currently used
> > > 'anytime a driver is successfully bound to a device', this patch
> > > suggest exporing by exporting it so that drivers can kick-off
> > > re-probing of deferred devices at the end of a deferred processing.
> 
> > I really do not want to export this as it will get really messy very
> > quickly with different drivers/busses attempting to call this.
> 
> I'm not sure I see the mess here - it's just queueing some work, one of
> the things that the workqueue stuff does well is handle things getting
> scheduled while they're already queued.  Honestly having understood
> their problem I think we need to be adding these calls into all the
> resource provider APIs.
> 
> > Either handle it in your driver (why do you have to defer probe at all,
> > just succeed and move on to register the needed stuff after you are
> > initialized) or rely on the driver core here.
> 
> That's exactly what they're doing currently and the driver core isn't
> delivering.
> 
> Driver A is slow to start up and providing a resource to driver B, this
> gets handled in driver A by succeeding immediately and then registering
> the resource once the startup has completed.  Unfortunately while that
> was happening not only has driver B registered and deferred but the rest
> of the probes/defers in the system have completed so the deferred probe
> mechanism is idle.  Nothing currently tells the deferred probe mechanism
> that a new resource is now available so it never retries the probe of
> driver B.  The only way I can see to fix this without modifying the
> driver core is to make driver A block during probe but that would at
> best slow down boot.
> 
> The issue is that the driver core is using drivers completing probe as a
> proxy for resources becoming available.  That works most of the time
> because most probes are fully synchronous but it breaks down if a
> resource provider registers resources outside of probe, we might still
> be fine if system boot is still happening and something else probes but
> only through luck.

The driver core is not using that as a proxy, that is up to the driver
itself or not.  All probe means is "yes, this driver binds to this
device, thank you!" for that specific bus/class type.  That's all, if
the driver needs to go off and do real work before it can properly
control the device, wonderful, have it go and do that async.

So if you know you should be binding to the device, great, kick off some
other work and return success from probe.  There's no reason you have to
delay or defer for no good reason, right?

But yes, if you do get new resources, the probe should be called again,
that's what the deferred logic is for (or is that the link logic, I
can't recall)  This shouldn't be a new thing, no needing to call the
driver core directly like this at all, it should "just happen", right?

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350353458DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCWHiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhCWHiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:38:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1FD1619BD;
        Tue, 23 Mar 2021 07:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616485079;
        bh=eJD7MkMG7NvGUc4AsQ76v4Rl/p1aebxzY1jJ29gQGu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yr3/V827tTXRCgJPvBNjMw164mvK31A6S3uBlyW/qc4i/7xZYi/6W6cUkl0BvVcp7
         fmOave11vFP0Lnh+mj/zGv9xtCef9VO3aiSVZR8yFggqs/rjNFS5q2Yj/aMkkuDCJU
         oNNejvC7GJCy+nvo/rtm/95dGUDr9Xi1pL3IHzhI=
Date:   Tue, 23 Mar 2021 08:37:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel: move to auxiliary bus
Message-ID: <YFma1ClahDe2bZhR@kroah.com>
References: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
 <YFmPTkNkX6QPWiCa@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFmPTkNkX6QPWiCa@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 12:18:46PM +0530, Vinod Koul wrote:
> On 23-03-21, 08:43, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > 
> > Now that the auxiliary_bus exists, there's no reason to use platform
> > devices as children of a PCI device any longer.
> > 
> > This patch refactors the code by extending a basic auxiliary device
> > with Intel link-specific structures that need to be passed between
> > controller and link levels. This refactoring is much cleaner with no
> > need for cross-pointers between device and link structures.
> > 
> > Note that the auxiliary bus API has separate init and add steps, which
> > requires more attention in the error unwinding paths. The main loop
> > needs to deal with kfree() and auxiliary_device_uninit() for the
> > current iteration before jumping to the common label which releases
> > everything allocated in prior iterations.
> > 
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > ---
> >  drivers/soundwire/Kconfig           |   1 +
> >  drivers/soundwire/intel.c           |  52 ++++----
> >  drivers/soundwire/intel.h           |  14 +-
> >  drivers/soundwire/intel_init.c      | 190 +++++++++++++++++++---------
> >  include/linux/soundwire/sdw_intel.h |   6 +-
> >  5 files changed, 175 insertions(+), 88 deletions(-)
> > 
> > diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> > index 016e74230bb7..2b7795233282 100644
> > --- a/drivers/soundwire/Kconfig
> > +++ b/drivers/soundwire/Kconfig
> > @@ -25,6 +25,7 @@ config SOUNDWIRE_INTEL
> >  	tristate "Intel SoundWire Master driver"
> >  	select SOUNDWIRE_CADENCE
> >  	select SOUNDWIRE_GENERIC_ALLOCATION
> > +	select AUXILIARY_BUS
> >  	depends on ACPI && SND_SOC
> >  	help
> >  	  SoundWire Intel Master driver.
> > diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> > index d2254ee2fee2..039a101982c9 100644
> > --- a/drivers/soundwire/intel.c
> > +++ b/drivers/soundwire/intel.c
> > @@ -11,7 +11,7 @@
> >  #include <linux/module.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > -#include <linux/platform_device.h>
> > +#include <linux/auxiliary_bus.h>
> >  #include <sound/pcm_params.h>
> >  #include <linux/pm_runtime.h>
> >  #include <sound/soc.h>
> > @@ -1331,9 +1331,10 @@ static int intel_init(struct sdw_intel *sdw)
> >  /*
> >   * probe and init
> >   */
> > -static int intel_master_probe(struct platform_device *pdev)
> > +static int intel_link_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
> >  {
> > -	struct device *dev = &pdev->dev;
> > +	struct device *dev = &auxdev->dev;
> > +	struct sdw_intel_link_dev *ldev = auxiliary_dev_to_sdw_intel_link_dev(auxdev);
> 
> Do we need another abstractions for resources here, why not aux dev
> creation set the resources required and we skip this step...
> 
> >  	struct sdw_intel *sdw;
> >  	struct sdw_cdns *cdns;
> >  	struct sdw_bus *bus;
> > @@ -1346,14 +1347,14 @@ static int intel_master_probe(struct platform_device *pdev)
> >  	cdns = &sdw->cdns;
> >  	bus = &cdns->bus;
> >  
> > -	sdw->instance = pdev->id;
> > -	sdw->link_res = dev_get_platdata(dev);
> > +	sdw->instance = auxdev->id;
> 
> so auxdev has id and still we pass id as argument :( Not sure if folks
> can fix this now

That's odd, yeah, it should be fixed.

greg k-h

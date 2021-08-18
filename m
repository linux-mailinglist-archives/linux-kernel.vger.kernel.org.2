Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB4C3F0802
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbhHRP2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239509AbhHRP2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:28:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4C6F61056;
        Wed, 18 Aug 2021 15:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629300484;
        bh=6qIatRlyPwGZZZJdwRlRttF/BEGVNA0QhKepy/wJI3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjqNcnimhe4hoip2pxAOu60xIen1V94R7Z2FRA9FWPIk902tv9fET+pTABVivnF8a
         Sb3JStdG0/DJFqPd30DrjlUxeDfV8df/0Y5Ui1iqH5Hrb8+OJPjlUyijP1yPJBlEkR
         HYt3oWDC6ysehNDmBU96COWGwk20SFg2JGSv9JhI=
Date:   Wed, 18 Aug 2021 17:28:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        vkoul@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 1/2] driver core: export
 driver_deferred_probe_trigger()
Message-ID: <YR0nAcC3wJd3b4Vu@kroah.com>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com>
 <20210818115736.GA4177@sirena.org.uk>
 <YR0Ji7DQXoo0z4vP@kroah.com>
 <20210818134814.GF4177@sirena.org.uk>
 <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 09:51:51AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> >>> The issue is that the driver core is using drivers completing probe as a
> >>> proxy for resources becoming available.  That works most of the time
> >>> because most probes are fully synchronous but it breaks down if a
> >>> resource provider registers resources outside of probe, we might still
> >>> be fine if system boot is still happening and something else probes but
> >>> only through luck.
> > 
> >> The driver core is not using that as a proxy, that is up to the driver
> >> itself or not.  All probe means is "yes, this driver binds to this
> >> device, thank you!" for that specific bus/class type.  That's all, if
> >> the driver needs to go off and do real work before it can properly
> >> control the device, wonderful, have it go and do that async.
> > 
> > Right, which is what is happening here - but the deferred probe
> > machinery in the core is reading more into the probe succeeding than it
> > should.
> 
> I think Greg was referring to the use of the PROBE_PREFER_ASYNCHRONOUS
> probe type. We tried just that and got a nice WARN_ON because we are
> using request_module() to deal with HDaudio codecs. The details are in
> [1] but the kernel code is unambiguous...
> 
>         /*
> 	 * We don't allow synchronous module loading from async.  Module
> 	 * init may invoke async_synchronize_full() which will end up
> 	 * waiting for this task which already is waiting for the module
> 	 * loading to complete, leading to a deadlock.
> 	 */
> 	WARN_ON_ONCE(wait && current_is_async());
> 
> 
> The reason why we use a workqueue is because we are otherwise painted in
> a corner by conflicting requirements.
> 
> a) we have to use request_module()

Wait, why?

module loading is async, use auto-loading when the hardware/device is
found and reported to userspace.  Forcing a module to load by the kernel
is not always wise as the module is not always present in the filesystem
at that point in time at boot (think modules on the filesystem, not in
the initramfs).

Try fixing this issue and maybe it will resolve itself as you should be
working async.

thanks,

greg k-h

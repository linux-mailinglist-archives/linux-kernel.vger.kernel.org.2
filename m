Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2753B3EFA52
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 07:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbhHRFpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 01:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237588AbhHRFpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:45:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E282C61029;
        Wed, 18 Aug 2021 05:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629265483;
        bh=7446DzpnOmXY4YsWJJYk17WCKdb6uzLqiGzSw2ucE7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIt3/ctKDnKk1yHUF5CEjOyKodI6tV6uqCyZgbnHxUXsQV9sSGF69aNnJSta7tdP0
         KEcg/j6ezycsgOnXBQhFi9+L33P0xEBC7odObRiNyUNsrjYNgizGq9/AqUo0BqYqeZ
         mO/IaPxHCz0Kdm5Vlphzj8C2/BwLu0Pq26qpTw1c=
Date:   Wed, 18 Aug 2021 07:44:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, liam.r.girdwood@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 1/2] driver core: export
 driver_deferred_probe_trigger()
Message-ID: <YRyeR6imvSwOOasQ@kroah.com>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 02:00:56PM -0500, Pierre-Louis Bossart wrote:
> The premise of the deferred probe implementation is that a successful
> driver binding is a proxy for the resources provided by this driver
> becoming available. While this is a correct assumption in most of the
> cases, there are exceptions to the rule such as
> 
> a) the use of request_firmware_nowait(). In this case, the resources
> may become available when the 'cont' callback completes, for example
> when if the firmware needs to be downloaded and executed on a SoC
> core or DSP.
> 
> b) a split implementation of the probe with a workqueue when one or
> ore request_module() calls are required: a synchronous probe prevents
> other drivers from probing, impacting boot time, and an async probe is
> not allowed to avoid a deadlock. This is the case on all Intel audio
> platforms, with request_module() being required for the i915 display
> audio and HDaudio external codecs.
> 
> In these cases, there is no way to notify the deferred probe
> infrastructure of the enablement of resources after the driver
> binding.

Then just wait for it to happen naturally?

> The driver_deferred_probe_trigger() function is currently used
> 'anytime a driver is successfully bound to a device', this patch
> suggest exporing by exporting it so that drivers can kick-off
> re-probing of deferred devices at the end of a deferred processing.

I really do not want to export this as it will get really messy very
quickly with different drivers/busses attempting to call this.

Either handle it in your driver (why do you have to defer probe at all,
just succeed and move on to register the needed stuff after you are
initialized) or rely on the driver core here.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC313F0999
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhHRQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhHRQu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:50:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BF90610CB;
        Wed, 18 Aug 2021 16:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629305394;
        bh=H+C5HRL1W26JYW1ePOo251FXVM78KF8792qIuWVToy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1W66YysskpVj4mdgZhCaD6Mpek43TxCCguqy7OGT+p4z5oGVaNbvG9dF0nxIHpaVc
         QMPKOl+gPm50Yf6LNwkdkRyk8If8SeoiQw6f9fd/bk3SNg3pLfA8WaL40lsp0f3BPx
         YlmnQlkXuvysNUuCPbBNqA5QiGYwJjoGLdAZ1AaY=
Date:   Wed, 18 Aug 2021 18:49:51 +0200
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
Message-ID: <YR06L+gTzyiYY/rG@kroah.com>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com>
 <20210818115736.GA4177@sirena.org.uk>
 <YR0Ji7DQXoo0z4vP@kroah.com>
 <20210818134814.GF4177@sirena.org.uk>
 <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
 <YR0nAcC3wJd3b4Vu@kroah.com>
 <be1ea414-b2ad-162d-192a-7b55e40b3754@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be1ea414-b2ad-162d-192a-7b55e40b3754@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 10:53:07AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> 
> >> a) we have to use request_module()
> > 
> > Wait, why?
> > 
> > module loading is async, use auto-loading when the hardware/device is
> > found and reported to userspace.  Forcing a module to load by the kernel
> > is not always wise as the module is not always present in the filesystem
> > at that point in time at boot (think modules on the filesystem, not in
> > the initramfs).
> > 
> > Try fixing this issue and maybe it will resolve itself as you should be
> > working async.
> 
> It's been that way for a very long time (2015?) for HDAudio support, see
> sound/pci/hda/hda_bind.c. It's my understanding that it was a conscious
> design decision to use vendor-specific modules, if available, and
> fallback to generic modules if the first pass failed.

If it has been this way for so long, what has caused the sudden change
to need to export this and call this function?


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDF130B698
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhBBEj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhBBEjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:39:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 155F864EC3;
        Tue,  2 Feb 2021 04:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612240754;
        bh=sbBEYF5ak+9t4EThBkvi2dHpSTMhpT5r2z0w2boWngQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ETBNY+MYJ2XizOuGlgif0xzxPKPaOg9H/bnwROlonHLs+2CTaPNgTagT4sXKw24N9
         Wp3yA41mQ4eBT1rft+aoD9MvwRLL6Krlu3QZgI3y6QvhFKo48B4T7EGgYuqq2gg6im
         3fcxcr1bjkSo9KsqIlBuwKfVl5dYBbYdi2jO+0UFI/mUQrW4ZyT4fWwWzyF8EA180a
         NxGrQMDYN6QlLPEqDrdHw7Bb7hsmwZx7cVbTKllMp/iBkJBNnrCrFjKM9A1gHNd601
         DlFnmskLocdaRT4DKEIf8+mbSidcw2expg57iPdERENxr5QzScWKJfi1uXEgn8m032
         gogXVOGKFzQAA==
Date:   Tue, 2 Feb 2021 10:09:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        jank@cadence.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/3] soundwire: bus: clear bus clash interrupt before the
 mask is enabled
Message-ID: <20210202043909.GG2771@vkoul-mobl>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-2-yung-chuan.liao@linux.intel.com>
 <20210201102844.GU2771@vkoul-mobl>
 <20210201103825.GV2771@vkoul-mobl>
 <7c4e1163-a6b3-2886-1963-7e2847dc2836@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c4e1163-a6b3-2886-1963-7e2847dc2836@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-02-21, 10:18, Pierre-Louis Bossart wrote:
> On 2/1/21 4:38 AM, Vinod Koul wrote:
> > On 01-02-21, 15:58, Vinod Koul wrote:
> > > On 26-01-21, 16:37, Bard Liao wrote:
> > 
> > > >   struct sdw_master_prop {
> > > >   	u32 revision;
> > > > @@ -421,8 +422,11 @@ struct sdw_master_prop {
> > > >   	u32 err_threshold;
> > > >   	u32 mclk_freq;
> > > >   	bool hw_disabled;
> > > > +	u32 quirks;
> > > 
> > > Can we do u64 here please.. I dont know where we would end up.. but
> > > would hate if we start running out of space ..
> No objection.
> 
> > Also, is the sdw_master_prop right place for a 'quirk' property. I think
> > we can use sdw_master_device or sdw_bus as this seems like a bus
> > quirk..?
> 
> It's already part of sdw_bus

Right, but the point is that the properties were mostly derived from
DiSco, so am bit skeptical about it adding it there..

> struct sdw_bus {
> 	struct device *dev;
> 	struct sdw_master_device *md;
> 	unsigned int link_id;
> 	int id;
> 	struct list_head slaves;
> 	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
> 	struct mutex bus_lock;
> 	struct mutex msg_lock;
> 	int (*compute_params)(struct sdw_bus *bus);
> 	const struct sdw_master_ops *ops;
> 	const struct sdw_master_port_ops *port_ops;
> 	struct sdw_bus_params params;
> 	struct sdw_master_prop prop;
> 
> The quirks could be set by a firmware property, and it seems logical to add
> them at the same place where we already have properties defined in firmware,
> no? That way all the standard, vendor-specific and quirks are read or added
> in the same place.

Or they could be set by driver as well based on device id, compatible
and so on.. It maybe fw property as well, so limiting to property may not
be best idea IMO.

> the sdw_master_device isn't a good place for quirks IMHO, it's a very
> shallow software-only layer without any existing ties to the hardware
> definition.

This one I would agree.

-- 
~Vinod

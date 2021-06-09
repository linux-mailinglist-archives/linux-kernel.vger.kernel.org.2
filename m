Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC24E3A1D67
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhFITE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 15:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhFITE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:04:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F60E613CA;
        Wed,  9 Jun 2021 19:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623265353;
        bh=01ekqEr7/oKQrK293xZwJEbpRjqwL9EMuSKoKq+9fCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANyQsTqW9jkL7tJ5o8WN2TFDaZ7uI8G/1l2wIG4s4Rtdnj0trnOX5+3wq/RyXoubu
         PU67pN2h+3F79jrO/G7ONF/u903jmIt1/EXgCghb6Wc/RLAynSieww3/Cu1j5JhVTs
         2ewQj6d5zLtBJpgDYQkWJxcQLGcLoEw1XBIb3Nic=
Date:   Wed, 9 Jun 2021 21:02:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        hui.wang@canonical.com, Jason Gunthorpe <jgg@nvidia.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH v4] soundwire: intel: move to auxiliary bus
Message-ID: <YMEQRlviWBJA0Rwd@kroah.com>
References: <20210511052132.28150-1-yung-chuan.liao@linux.intel.com>
 <21002781-0b78-3b36-952f-683482a925d7@linux.intel.com>
 <YLS4N2KgzfsMBD1c@vkoul-mobl.Dlink>
 <b316763b-d219-6ea3-401e-3eb9718aabf3@linux.intel.com>
 <YMBHj6PBzeHexXJb@vkoul-mobl>
 <07dbe0a2-0abb-810b-ef39-b83511d3f3e0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07dbe0a2-0abb-810b-ef39-b83511d3f3e0@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 09:44:08AM -0500, Pierre-Louis Bossart wrote:
> The model is exactly the same as what we have today with the platform
> devices. We did not add ANY new fields or information, what is passed in
> that structure is exactly the same as what we do upstream today with the
> platform devices.
> 
> To make my point, here is the structure in intel.h as of v5.13-rc1
> 
> struct sdw_intel_link_res {
> 	struct platform_device *pdev;
> 	void __iomem *mmio_base; /* not strictly needed, useful for debug */
> 	void __iomem *registers;
> 	void __iomem *shim;
> 	void __iomem *alh;
> 	int irq;
> 	const struct sdw_intel_ops *ops;
> 	struct device *dev;
> 	struct mutex *shim_lock; /* protect shared registers */
> 	u32 *shim_mask;
> 	u32 clock_stop_quirks;
> 	u32 link_mask;
> 	struct sdw_cdns *cdns;
> 	struct list_head list;
> };
> 
> and here's what we suggested in this patch:
> 
> struct sdw_intel_link_res {
> 	void __iomem *mmio_base; /* not strictly needed, useful for debug */
> 	void __iomem *registers;
> 	void __iomem *shim;
> 	void __iomem *alh;
> 	int irq;
> 	const struct sdw_intel_ops *ops;
> 	struct device *dev;
> 	struct mutex *shim_lock; /* protect shared registers */
> 	u32 *shim_mask;
> 	u32 clock_stop_quirks;
> 	u32 link_mask;
> 	struct sdw_cdns *cdns;
> 	struct list_head list;
> };
> 
> You will notice that we removed the platform_device *pdev, but embedded this
> structure into a larger one to make use of container_of()
> 
> struct sdw_intel_link_dev {
> 	struct auxiliary_device auxdev;
> 	struct sdw_intel_link_res link_res;
> };
> 
> That's it. We did not change anything else, all the other fields are
> identical. We are only changing the TYPE of device and the interfaces for
> probe/remove but using the same information and the same device hierarchy.

And this is the correct thing to do, you have done it properly here,
nice work.

greg k-h

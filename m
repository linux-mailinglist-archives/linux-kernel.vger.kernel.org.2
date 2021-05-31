Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EBE3958DA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhEaKVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbhEaKVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 06:21:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 315AB610E7;
        Mon, 31 May 2021 10:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622456379;
        bh=2E17MlRyF9jgcHRKGxx+DAw+cGznl+dPMZItWR6H9cU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hi18iMaiTtmfV15fMTFLamQcUewXekVls0ezWCip0YAjTJLadV9l4dkfuresXmB3m
         kXdPZRi4PXEl5DYSIb2JhuPUic5GnjMhxqyrWQoB/sYartinPy0JzkWsiv2P89LBl6
         jdxZNQBdunxmhxtZxVQZW/dNumGt7FHLQCEWgsEtzoFhHUTg8xzPBlmajJhxKaIvMu
         EIcUcBhxSj0LtU8PpXxKN3gyvctXo8bw5RbdMnG5c1Q1PWByBqYo/b2PzIVEm/0E0v
         mzrTfMFs6bZWA4gqxoaTycQ58ahtZDX4cZS6BzG2fbCjtFGwYXBrPaDap0yak6Jjmf
         t9wIvXfF8+dHA==
Date:   Mon, 31 May 2021 15:49:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, hui.wang@canonical.com,
        sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
        bard.liao@intel.com, Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH v4] soundwire: intel: move to auxiliary bus
Message-ID: <YLS4N2KgzfsMBD1c@vkoul-mobl.Dlink>
References: <20210511052132.28150-1-yung-chuan.liao@linux.intel.com>
 <21002781-0b78-3b36-952f-683482a925d7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21002781-0b78-3b36-952f-683482a925d7@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-21, 13:30, Pierre-Louis Bossart wrote:
> On 5/11/21 12:21 AM, Bard Liao wrote:
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
> > v2:
> >   - add link_dev_register for all kzalloc, device_init, and device_add.
> > v3:
> >   - Modify the function description of sdw_intel_probe() which was
> >     missing in previous version.
> > v4:
> >   - Move intel_link_dev_unregister(ldev) before pm_runtime_put_noidle(
> >     ldev->link_res.dev) to fix use-after-free reported by KASAN.
> 
> Two years ago, GregKH stated in
> https://lore.kernel.org/lkml/20190509181812.GA10776@kroah.com/
> 
> "So soundwire is creating platform devices?  Ick, no!  Don't do that"
> 
> Fast forward two years, this patch provides a solution to remove the use of
> the platform devices with the auxiliary bus. This move does not add any new
> functionality, it's just a replacement of one type of device by another.
> 
> The reviews have been rather limited since the first version shared on March
> 22.
> 
> a) I updated the code to follow the model of the Mellanox driver in
> 
> https://elixir.bootlin.com/linux/latest/source/include/linux/mlx5/driver.h#L545
> 
> I hope this addresses GregKH's feedback on the need for a 'register'
> function to combined the two init and add steps. I didn't see a path to add
> a generic register function in the auxiliary bus code since between init and
> add there is a need to setup domain-specific structures. Other contributors
> to the auxiliary bus (CC:ed) also didn't have a burning desire to add this
> capability.
> 
> b) Vinod commented:
> 
> "What I would like to see the end result is that sdw driver for Intel
> controller here is a simple auxdev device and no additional custom setup
> layer required... which implies that this handling should be moved into
> auxdev or Intel code setting up auxdev..."
> 
> I was unable to figure out what this comment hinted at: the auxbus is
> already handled in the intel_init.c and intel.c files and the auxbus is used
> to model a set of links/managers below the PCI device, not the controller
> itself. There is also no such thing as a simple auxdev device used in the
> kernel today, the base layer is meant to be extended with domain-specific
> structures. There is really no point in creating a simple auxbus device
> without extensions.

<back from vacations>

I would like to see that the init_init.c removed completely, that is my
ask here

This layer was created by me to aid in creating the platform devices.
Also the mistake was not to use platform resources and instead pass a
custom structure for resources (device iomem address, irq etc)

I would like to see is the PCI/SOF parent driver create the sdw aux
device and that should be all needed to be done. The aux device would be
probed by sdw driver. No custom resource structs for resources please.

If that is not possible, I would like to understand technical details of
why that would be that case. If required necessary changes should be
made to aux bus to handle and not have sequencing issue which you had
trouble with platform approach.

Thanks
-- 
~Vinod

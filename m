Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B445A3A5C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 06:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhFNEps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 00:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhFNEpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 00:45:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91C04613AD;
        Mon, 14 Jun 2021 04:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623645821;
        bh=IvmZ1b1TDZMBnSXVm8/fTN69Cd3Wq1w0/TEjzhTNHeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGHiC0c9pe1NmkciV35SzWPJ3Mah7tgis/rKoEwBFY8+d2CV8kChZGfa4K6vHe6N9
         lekO9YUMujZPLcNBS1Ijov4tnjHenblB992BITzbbmjj+vfC3YfOm/42WFu+w98eX0
         0UpgnrhGuRL3WICWPb9QhitNZJ/xxBKJ+OwlQMG3QQDYT0w7Sh96kHRBuegj0sHlej
         lRvahn+q7GC/TWOKOXt92qYfDeNjAYcXZXE0Sf3+M/P2sIq8vcDXGUymLXW8C2xyqB
         ocGckpjJOauk+4Hv6PAL+PRGIjZLK9x5KE9x6L6Z8cTvZ4y3fZAijXdub7/XguA1Nq
         KQZY8jweyVVpA==
Date:   Mon, 14 Jun 2021 10:13:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        hui.wang@canonical.com, Jason Gunthorpe <jgg@nvidia.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH v4] soundwire: intel: move to auxiliary bus
Message-ID: <YMbeefn6EHIqImQK@vkoul-mobl>
References: <20210511052132.28150-1-yung-chuan.liao@linux.intel.com>
 <21002781-0b78-3b36-952f-683482a925d7@linux.intel.com>
 <YLS4N2KgzfsMBD1c@vkoul-mobl.Dlink>
 <b316763b-d219-6ea3-401e-3eb9718aabf3@linux.intel.com>
 <YMBHj6PBzeHexXJb@vkoul-mobl>
 <07dbe0a2-0abb-810b-ef39-b83511d3f3e0@linux.intel.com>
 <YMNQBpFX9DXcoGAc@vkoul-mobl>
 <be440569-e18b-b079-2795-0af1e6812935@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be440569-e18b-b079-2795-0af1e6812935@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-21, 09:51, Pierre-Louis Bossart wrote:
> Thanks Vinod for your feedback,
> 
> > > If you look at the *existing* code, we don't handle any "resources" with the
> > > platform devices, we use the platform_device_info.data to pass the link
> > > information. It's a void pointer. We do not touch the resource field in the
> > > platform_device_into at all.
> > 
> > Yes that is true I dont disagree on that part. My ask here is to make it
> > better, it can be followed up after this but I would at least like to
> > agree on the direction.
> 
> [...]
> 
> > > That's it. We did not change anything else, all the other fields are
> > > identical. We are only changing the TYPE of device and the interfaces for
> > > probe/remove but using the same information and the same device hierarchy.
> > 
> > The move in itself is okay but I dont think that should be the end goal.
> 
> What we suggested in this patch is only an iso-functionality change. I
> believe from Greg's and your feedback that there is no objection on that
> small step.
> 
> This is not the end-goal indeed. The second step would be to remove the
> intel_init.c file. I fully agree with you Vinod that this can be moved into
> the SOF driver, and we could do this in a follow-up step. We can also
> improve the partition between 'context' used by the child driver and
> information passed by the parent on SHIM registers and bases.
> 
> I think we'd need to agree on the details of the second step, Bard and I can
> work on a proposal, but I don't see a disconnect on the direction to
> simplify the interface. That's the right thing to do.

That is agreeable to me. Looking forward to updates to clean these bits
up

Thanks
-- 
~Vinod

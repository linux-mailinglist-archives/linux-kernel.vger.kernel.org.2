Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019CE3A4135
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 13:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFKL2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 07:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhFKL2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 07:28:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 272D0610E9;
        Fri, 11 Jun 2021 11:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623410816;
        bh=QXbhpoKZRkqCV8d85AMb2D87wCsbusdzmNcunuEV1eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHNHZtdkpxh+sAIplb3d0tqtmW4gvz992iETR2j7p8QZBoUNBitsS2H7L1nbPOTIH
         +8CNq1F4ar3EFOsdILg8sQGmuYicMx0LKInecTpzYxnGkdPKMGEALsUWAiled/e5P0
         xYB4xE28l65g7gBJcouALiu9EJ/tOlnH95uYMzGOr+e5kquZjTuMhqJ4tJb7lqQqpr
         4A+LN/NVEFQSrt2zwQDxp2DiFPxozEdq6ZlAiTYe8RR7JYMF0P3t2bsnnGdRaCa6UE
         PPNqGgUXxC+KHKLIjc7/KR9uOA3rR5poXVAWQvc9oaijApy/1rBzt6c2vCwG6l7MHa
         TFsQwECdugKIA==
Date:   Fri, 11 Jun 2021 16:56:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        hui.wang@canonical.com, Dave Ertman <david.m.ertman@intel.com>,
        sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH v4] soundwire: intel: move to auxiliary bus
Message-ID: <YMNIfHPRcgKLXJ0v@vkoul-mobl>
References: <20210511052132.28150-1-yung-chuan.liao@linux.intel.com>
 <21002781-0b78-3b36-952f-683482a925d7@linux.intel.com>
 <YLS4N2KgzfsMBD1c@vkoul-mobl.Dlink>
 <b316763b-d219-6ea3-401e-3eb9718aabf3@linux.intel.com>
 <YMBHj6PBzeHexXJb@vkoul-mobl>
 <07dbe0a2-0abb-810b-ef39-b83511d3f3e0@linux.intel.com>
 <20210609151022.GF1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609151022.GF1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-06-21, 12:10, Jason Gunthorpe wrote:
> On Wed, Jun 09, 2021 at 09:44:08AM -0500, Pierre-Louis Bossart wrote:
> 
> > The consensus for the auxiliary_device model was hard to reach, and the
> > agreement was to align on a minimal model. If you disagree with the
> > directions, you will have to convince Nvidia/Mellanox and Intel networking
> > folks who contributed the solution to do something different.
> 
> The purpose of the aux devices was primarily to bind a *software*
> interface between two parts of the kernel.

Then I dont think this example is valid... This example has a PCI device,
which represents a DSP, HDA controller, DMICs, Soundwire
links... So at least here it is hardware.

> If there is a strong defined HW boundary and no software interface
> then the mfd subsytem may be a better choice.

More I think that might be better choice for this example, but then MFD
is a 'platform device' and Greg already nacked that

> For a software layer I expect to see some 'handle' and then a set of
> APIs to work within that. It is OK if that 'handle' refers to some HW
> resources that the API needs to work, the purpose of this is to
> control HW after all.
> 
> You might help Vinod by explaining what the SW API is here.
> 
> Jason

-- 
~Vinod

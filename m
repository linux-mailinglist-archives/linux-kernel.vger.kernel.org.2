Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146B03A4307
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFKNb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhFKNbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:31:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68D97613FA;
        Fri, 11 Jun 2021 13:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623418167;
        bh=5syIn+RCk4Eumnt8SPMfARRletWX4c3GwaWbmkOsZ0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ww7KB1r+D6dLROk8dlMYpi8iAR+fwNDQlEDSaCPbj5ILCyBZIVmxoxZuhCrKnpvKj
         8IDtkwQZd5W6UKgQfJmVQrV21q17wF8pVvEaTtvilYc+1BUFqEt3ecnEdzHqeQS4TL
         e4fCFA5MiVakh10bIUuEx1haWK3nCHSjqgUsbvn4=
Date:   Fri, 11 Jun 2021 15:29:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        hui.wang@canonical.com, Dave Ertman <david.m.ertman@intel.com>,
        sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH v4] soundwire: intel: move to auxiliary bus
Message-ID: <YMNlND32rR9aKWeW@kroah.com>
References: <20210511052132.28150-1-yung-chuan.liao@linux.intel.com>
 <21002781-0b78-3b36-952f-683482a925d7@linux.intel.com>
 <YLS4N2KgzfsMBD1c@vkoul-mobl.Dlink>
 <b316763b-d219-6ea3-401e-3eb9718aabf3@linux.intel.com>
 <YMBHj6PBzeHexXJb@vkoul-mobl>
 <07dbe0a2-0abb-810b-ef39-b83511d3f3e0@linux.intel.com>
 <20210609151022.GF1002214@nvidia.com>
 <YMNIfHPRcgKLXJ0v@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMNIfHPRcgKLXJ0v@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 04:56:52PM +0530, Vinod Koul wrote:
> On 09-06-21, 12:10, Jason Gunthorpe wrote:
> > On Wed, Jun 09, 2021 at 09:44:08AM -0500, Pierre-Louis Bossart wrote:
> > 
> > > The consensus for the auxiliary_device model was hard to reach, and the
> > > agreement was to align on a minimal model. If you disagree with the
> > > directions, you will have to convince Nvidia/Mellanox and Intel networking
> > > folks who contributed the solution to do something different.
> > 
> > The purpose of the aux devices was primarily to bind a *software*
> > interface between two parts of the kernel.
> 
> Then I dont think this example is valid... This example has a PCI device,
> which represents a DSP, HDA controller, DMICs, Soundwire
> links... So at least here it is hardware.

Yes, and that's fine, and exactly what aux devices were created for.

You divide up a single logically addressable device into differently
handled portions.

Not all hardware specs were as "smart" as USB was in allowing multiple
drivers to bind to the same physical USB device and talk to it at the
same time :)

Luckily the USB spec authors learned from the mistakes of PCI...

thanks,

greg k-h

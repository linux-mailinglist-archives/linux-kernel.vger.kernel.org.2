Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9750A3C1548
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhGHOkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 10:40:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:19419 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231858AbhGHOkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 10:40:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="189195795"
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="189195795"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 07:37:23 -0700
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="487629085"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 07:37:23 -0700
Date:   Thu, 8 Jul 2021 07:36:57 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Dey, Megha" <megha.dey@intel.com>, linux-kernel@vger.kernel.org,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: Programming PASID in IMS entries
Message-ID: <20210708143657.GA70042@otc-nc-03>
References: <bd509e3d-f59d-1200-44ce-93cf9132bd8c@intel.com>
 <87k0m2qzgz.ffs@nanos.tec.linutronix.de>
 <20210707221216.GA56594@otc-nc-03>
 <20210707235822.GB4459@nvidia.com>
 <20210708003335.GC56594@otc-nc-03>
 <20210708120846.GD4459@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708120846.GD4459@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason

On Thu, Jul 08, 2021 at 09:08:46AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 07, 2021 at 05:33:35PM -0700, Raj, Ashok wrote:
> > On Wed, Jul 07, 2021 at 08:58:22PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jul 07, 2021 at 03:12:16PM -0700, Raj, Ashok wrote:
> > > > Hi Thomas
> > > > 
> > > > On Wed, Jul 07, 2021 at 10:50:52AM +0200, Thomas Gleixner wrote:
> > > > > Megha,
> > > > > 
> > > > > On Wed, Jul 07 2021 at 09:49, Megha Dey wrote:
> > > > > > Per your suggestions during the last meeting, we wanted to confirm the 
> > > > > > sequence to program the PASID into the IMS entries:
> > > > > >
> > > > > > 1. Add a PASID member to struct msi_desc (Add as part of a union. Other 
> > > > > > source-id's such as Jason's vm-id can be added to it)
> > > > > 
> > > > > Yes. Though we also discussed storing the default PASID in struct device
> > > > > to begin with which is then copied to the msi_desc entries during
> > > > > allocation.
> > > > 
> > > > Using default PASID in struct device will work for sub-devices until the
> > > > guest needs to enable ENQCMD support. Since the guest kernel can ask for an
> > > > interrupt by specifying something in the descriptor submitted via ENQCMD.
> > > > Using the PASID in struct device won't be sufficient.
> > > 
> > > Could you could store a pasid table in the struct device and index it
> > > by vector?
> > 
> > Possibly... what ever Thomas things is clean. The device specific driver
> > would have this already. So providing some call to get this filled in vs
> > storing that in struct device. Someone close at heart to the driver model
> > is best to comment :-)
> > 
> > IMS core owns the format of the entries right now vs device specific driver. 
> > I suppose your use case requiring a vm_id might have a different format. 
> > So this is yet another one the core needs to learn and adapt?
> 
> All entry format stuff is device specific, it shouldn't be in "core"
> code.

Well, this is how it started way back last year. 

https://lore.kernel.org/lkml/158751209583.36773.15917761221672315662.stgit@djiang5-desk3.ch.intel.com/

Where the driver functions for mask/unmask/write_msg etc. So the core needs

So the format or layout is device specific, but core can dictate the exact
message that needs to be written.

> 
> It is is the same reason that the IRQ chip driver for IDXD should have
> IDXD in the name, it is not a generic "IMS core" thing.
> 
> The question mark is probably the locking model, but if IDXD
> guarentees the pasid table doesn't change while the irq is active then
> maybe it works out well enough.

I think this must be gauranteed at a min? changing things underneath when
the interrupts are unmasked would be bad usage.

> 
> Associating a void * with the irq is also possibly reasonable, I'm not
> sure which path makes the most sense.
> 

Seems like it.. 

Cheers,
Ashok

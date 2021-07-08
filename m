Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280503BF2E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 02:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhGHAg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 20:36:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:40961 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhGHAgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 20:36:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="196587808"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="196587808"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 17:34:02 -0700
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="498174309"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 17:34:01 -0700
Date:   Wed, 7 Jul 2021 17:33:35 -0700
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
Message-ID: <20210708003335.GC56594@otc-nc-03>
References: <bd509e3d-f59d-1200-44ce-93cf9132bd8c@intel.com>
 <87k0m2qzgz.ffs@nanos.tec.linutronix.de>
 <20210707221216.GA56594@otc-nc-03>
 <20210707235822.GB4459@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707235822.GB4459@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 08:58:22PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 07, 2021 at 03:12:16PM -0700, Raj, Ashok wrote:
> > Hi Thomas
> > 
> > On Wed, Jul 07, 2021 at 10:50:52AM +0200, Thomas Gleixner wrote:
> > > Megha,
> > > 
> > > On Wed, Jul 07 2021 at 09:49, Megha Dey wrote:
> > > > Per your suggestions during the last meeting, we wanted to confirm the 
> > > > sequence to program the PASID into the IMS entries:
> > > >
> > > > 1. Add a PASID member to struct msi_desc (Add as part of a union. Other 
> > > > source-id's such as Jason's vm-id can be added to it)
> > > 
> > > Yes. Though we also discussed storing the default PASID in struct device
> > > to begin with which is then copied to the msi_desc entries during
> > > allocation.
> > 
> > Using default PASID in struct device will work for sub-devices until the
> > guest needs to enable ENQCMD support. Since the guest kernel can ask for an
> > interrupt by specifying something in the descriptor submitted via ENQCMD.
> > Using the PASID in struct device won't be sufficient.
> 
> Could you could store a pasid table in the struct device and index it
> by vector?

Possibly... what ever Thomas things is clean. The device specific driver
would have this already. So providing some call to get this filled in vs
storing that in struct device. Someone close at heart to the driver model
is best to comment :-)

IMS core owns the format of the entries right now vs device specific driver. 
I suppose your use case requiring a vm_id might have a different format. 
So this is yet another one the core needs to learn and adapt?

It seems we have conceptually 3 types of IMS already brewing up.

1. IDXD has legacy MSIx + MSix permission table to hold PASID.
2. IMS in IDXD has PASID in the IMS entry itself.
3. Jason's vm_id instead of the PASID use case.

So we can keep IMS core about these types, another way is to allow device
specific implementations provide the write handlers with the index, and let
the driver handle the location of the write. IMS core will provide the
format and data.

Cheers,
Ashok


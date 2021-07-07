Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546E93BF1E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 00:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhGGWRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 18:17:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:49295 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230208AbhGGWRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 18:17:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="295036519"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="295036519"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 15:12:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="487142152"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 15:12:41 -0700
Date:   Wed, 7 Jul 2021 15:12:16 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Dey, Megha" <megha.dey@intel.com>, linux-kernel@vger.kernel.org,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, jgg@mellanox.com,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: Programming PASID in IMS entries
Message-ID: <20210707221216.GA56594@otc-nc-03>
References: <bd509e3d-f59d-1200-44ce-93cf9132bd8c@intel.com>
 <87k0m2qzgz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0m2qzgz.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas

On Wed, Jul 07, 2021 at 10:50:52AM +0200, Thomas Gleixner wrote:
> Megha,
> 
> On Wed, Jul 07 2021 at 09:49, Megha Dey wrote:
> > Per your suggestions during the last meeting, we wanted to confirm the 
> > sequence to program the PASID into the IMS entries:
> >
> > 1. Add a PASID member to struct msi_desc (Add as part of a union. Other 
> > source-id's such as Jason's vm-id can be added to it)
> 
> Yes. Though we also discussed storing the default PASID in struct device
> to begin with which is then copied to the msi_desc entries during
> allocation.

Using default PASID in struct device will work for sub-devices until the
guest needs to enable ENQCMD support. Since the guest kernel can ask for an
interrupt by specifying something in the descriptor submitted via ENQCMD.
Using the PASID in struct device won't be sufficient.

> 
> > 2. Create an API which device drivers can call, to program the PASID 
> > (PASID provided by the driver) on a per-irq basis. This API is to be 
> > called after msi_domain_alloc_irqs and will write to the corresponding 
> > msi_desc->pasid entry. (Assumption: For now, all devices will have the 
> > same IMS format). for e.g:
> >
> > msi_desc_set_pasid (irq, pasid) {
> >
> > struct msi_desc *desc = irq_get_msi_desc(irq);
> >
> > desc->pasid = pasid;
> >
> > }
> 
> That interface should be opaque probably with an u64 argument so it can
> be reused for Jason's VM-id. Jason?
> 
> > 3. In request_irq, add a irq_chip callback (in __setup_irq maybe??) to 
> > automatically write the pasid into the corresponding IMS entry:
> 
> Why? There is no need for yet another callback. The PASID or whatever ID
> is required can be written as part of e.g. irq_unmask().

Yes, that should work for the host side doing the irq_unmask() to program
the PASID in the ims entry.

> 
> > Is this the correct approach?
> 
> No.
> 
> > Also, from a previous discussion [1], we want to make IMS more dynamic:
> >
> > Given the QEMU behavior it doesn't ask for all IRQs upfront. It only 
> > allocates 1, and when it unmasks the 2nd, it wants to dynamically add a 
> > second. This will allow adding a second IRQ without having to free all 
> > the old irqs and reacquire the new number (as it is done today).
> >
> > This dynamic behavior is only for MSIx/IMS backed entries. For legacy
> > MSI, QEMU will allocate everything upfront. Since it has a
> > "num_vectors" enabled, nothing can be dynamically done for MSI. Kevin
> > is looking to have this fixed for legacy to stop the dynamic part for
> > MSI. We are pursuing this change just for IMS first, and once it
> > works, we can replicate the same for MSIx too.
> 
> No. Fix the existing stuff first and then IMS just works.
> 
> > In order to make IMS dynamic, we were thinking of the following 
> > enhancements to the IMS core:
> >
> > 1. Device Driver specifies maximum number of interrupts the sub device 
> > is allowed to request, while creating the dev-msi domain. E.g. in the 
> > case of DSA, Driver can specify that each mdev created can have upto X
> 
> Why would this be mdev specific? IIRC the sub devices can be used on
> bare metal as well.

I guess so. I thought for bare metal we don't need to play these games
since native abstraction is provided with things like uaccel for e.g. For
things like SRIOV its much different.

What the above limit accomplishes is telling the guest, you can request
upto the limit, but you aren't guaranteed to get them. This avoids the
static partitioning and becomes best effort by the host driver.

Ideally we want to tell the guest it can have upto say 1k interrupts, but
unlike MSIx where resources are commited in HW, we want to allow guest
allocations to fail. 

Cheers,
Ashok

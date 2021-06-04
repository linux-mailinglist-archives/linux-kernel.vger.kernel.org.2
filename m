Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93A439B6F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFDK0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhFDK0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:26:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F96EC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 03:24:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jt22so13708747ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vp5nodV8czU8XoGNBzmhcKT/5Cx+STD3G/uISCrpGY4=;
        b=Qy8oqCe9C3GIl3agw3bRS8rRWoOouva9dfQcVbDisTWeICLzPGNplyubb2CL7VqHSz
         orrVtrrbGENaTdVW1MigH2RXegdWfTY2nVGgSzKlZNPLj9HMmF+yMuOr8cjwDcDrgsHV
         n9JZnrXxv4zuJiNwb19p/di+oEb26GirvxUlLG9QExhKhz31Am5W/vNWLKNnN4KhjXaI
         HERJ2vRCBpAAFKDiFexTZLPh1iFOdMHNMJIT0IOLQkh/rQzHq3Z1BwZNLvh0RmLF484Z
         MQ0F1vbL/gc6DbMU664oR5/V/vcn77rw8gZSK3D9CkAccd92hj4183FzXwaOzw43K2/b
         R1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vp5nodV8czU8XoGNBzmhcKT/5Cx+STD3G/uISCrpGY4=;
        b=U4fETkSc/R+YTqBVEczO13+pM+KW3kPGeodNjotpdUsgWatFw7+UKjNuZyeqFtGH9v
         wyB6sesDz6H7B+IDAw/73KzWtZUR9Ym2+FnzLRJHokf2nSypNTDK3gDu14idcMgleqAa
         2/mQftgmULewr8L2/eYWC5t9qYNo4h1vJ/i4FxwHhpQVTMCzO++4DFCjKxrIuuK5ggjL
         k5JSp6a451nPVx0/8AKLvUDdqkg1V+Cx2TcTkLd1s/Dv5qfQKrXuGjblwIR87rKeWgIA
         W9AZzyoPUFuIIFkEteOVfrYrUiskw9GCs8N4fFeJoRPi7CmT0w+ap3mia3dltI3AgKRw
         KOVw==
X-Gm-Message-State: AOAM531mJk31Z+e86t94Esrt71ek6x//DKDZFGVuirNmcex+vI6x4x9P
        KKzBKkqeum9trjcnJHhJBpsz4J06TOJzFKSx
X-Google-Smtp-Source: ABdhPJyHncQfqj5pHRaAtZdltZJ3jUVuJI0Mj2xvK2vlD6pzD7aL91GaglI4VA6WW/8WtGakQzwRBA==
X-Received: by 2002:a17:906:fa13:: with SMTP id lo19mr3560274ejb.468.1622802268470;
        Fri, 04 Jun 2021 03:24:28 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id f6sm2586850eja.108.2021.06.04.03.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 03:24:27 -0700 (PDT)
Date:   Fri, 4 Jun 2021 12:24:08 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Alex Williamson (alex.williamson@redhat.com)" 
        <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLn/SJtzuJopSO2x@myrica>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com>
 <YLcpw5Kx61L7TVmR@yekko>
 <20210602165838.GA1002214@nvidia.com>
 <YLhsZRc72aIMZajz@yekko>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLhsZRc72aIMZajz@yekko>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 03:45:09PM +1000, David Gibson wrote:
> > > But it would certainly be possible for a system to have two
> > > different host bridges with two different IOMMUs with different
> > > pagetable formats.  Until you know which devices (and therefore
> > > which host bridge) you're talking about, you don't know what formats
> > > of pagetable to accept.  And if you have devices from *both* bridges
> > > you can't bind a page table at all - you could theoretically support
> > > a kernel managed pagetable by mirroring each MAP and UNMAP to tables
> > > in both formats, but it would be pretty reasonable not to support
> > > that.
> > 
> > The basic process for a user space owned pgtable mode would be:
> > 
> >  1) qemu has to figure out what format of pgtable to use
> > 
> >     Presumably it uses query functions using the device label.
> 
> No... in the qemu case it would always select the page table format
> that it needs to present to the guest.  That's part of the
> guest-visible platform that's selected by qemu's configuration.
> 
> There's no negotiation here: either the kernel can supply what qemu
> needs to pass to the guest, or it can't.  If it can't qemu, will have
> to either emulate in SW (if possible, probably using a kernel-managed
> IOASID to back it) or fail outright.
> 
> >     The
> >     kernel code should look at the entire device path through all the
> >     IOMMU HW to determine what is possible.
> > 
> >     Or it already knows because the VM's vIOMMU is running in some
> >     fixed page table format, or the VM's vIOMMU already told it, or
> >     something.
> 
> Again, I think you have the order a bit backwards.  The user selects
> the capabilities that the vIOMMU will present to the guest as part of
> the qemu configuration.  Qemu then requests that of the host kernel,
> and either the host kernel supplies it, qemu emulates it in SW, or
> qemu fails to start.

Hm, how fine a capability are we talking about?  If it's just "give me
VT-d capabilities" or "give me Arm capabilities" that would work, but
probably isn't useful. Anything finer will be awkward because userspace
will have to try combinations of capabilities to see what sticks, and
supporting new hardware will drop compatibility for older one.

For example depending whether the hardware IOMMU is SMMUv2 or SMMUv3, that
completely changes the capabilities offered to the guest (some v2
implementations support nesting page tables, but never PASID nor PRI
unlike v3.) The same vIOMMU could support either, presenting different
capabilities to the guest, even multiple page table formats if we wanted
to be exhaustive (SMMUv2 supports the older 32-bit descriptor), but it
needs to know early on what the hardware is precisely. Then some new page
table format shows up and, although the vIOMMU can support that in
addition to older ones, QEMU will have to pick a single one, that it
assumes the guest knows how to drive?

I think once it binds a device to an IOASID fd, QEMU will want to probe
what hardware features are available before going further with the vIOMMU
setup (is there PASID, PRI, which page table formats are supported,
address size, page granule, etc). Obtaining precise information about the
hardware would be less awkward than trying different configurations until
one succeeds. Binding an additional device would then fail if its pIOMMU
doesn't support exactly the features supported for the first device,
because we don't know which ones the guest will choose. QEMU will have to
open a new IOASID fd for that device.

Thanks,
Jean

> 
> Guest visible properties of the platform never (or *should* never)
> depend implicitly on host capabilities - it's impossible to sanely
> support migration in such an environment.
> 
> >  2) qemu creates an IOASID and based on #1 and says 'I want this format'
> 
> Right.
> 
> >  3) qemu binds the IOASID to the device. 
> > 
> >     If qmeu gets it wrong then it just fails.
> 
> Right, though it may be fall back to (partial) software emulation.  In
> practice that would mean using a kernel-managed IOASID and walking the
> guest IO pagetables itself to mirror them into the host kernel.
> 
> >  4) For the next device qemu would have to figure out if it can re-use
> >     an existing IOASID based on the required proeprties.
> 
> Nope.  Again, what devices share an IO address space is a guest
> visible part of the platform.  If the host kernel can't supply that,
> then qemu must not start (or fail the hotplug if the new device is
> being hotplugged).

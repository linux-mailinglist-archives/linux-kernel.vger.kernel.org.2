Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC56B399217
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhFBSDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230251AbhFBSDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622656876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOWP8as2a04gvaXr2BrNnViaTGVhZuXkKrD7YE2poSY=;
        b=fMvg5XQAoGGYgZbXWWGit90LBX9pU5xDrgfVN0QCW6542t7SI+cmkUGcP1hRWLPcYLhKCP
        E7hpeP10ZvAFea76WVkw7tKjRc76LsbraPg3+yg9W5JHVSo5r87HJjsKFJ07XuyYG3KgIx
        anEAr+zWYJ5R8dqsHRf4M1J12cT7Dsc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-Oe0OOuaLNSuxuMv6T5YGSg-1; Wed, 02 Jun 2021 14:01:15 -0400
X-MC-Unique: Oe0OOuaLNSuxuMv6T5YGSg-1
Received: by mail-ot1-f70.google.com with SMTP id r16-20020a0568301350b0290363e6a9392fso2011956otq.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 11:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GOWP8as2a04gvaXr2BrNnViaTGVhZuXkKrD7YE2poSY=;
        b=DfD9+akoQqewp7gXyMJ6f5O7yIlFOu17IjM2itHMrRqJDQHJ1WrVCrnYfyBA2POrON
         A1PNnRaHhVo9HjYF180acEr+8U9SVp46qB9oV7f/LbZ4BWeeDw14rRCHf/VO4RHLHpoF
         e3HOVOCP+OsFDoniMOl0/0Qf76DzOKjj8fz9/5s1L2PXo60XMSxeH92utPpHNPsCX/hU
         +Keyaiw7U6199oYiKOttFDgvpnLjI+nPwhrpThvWLX7OUKycjBZxRyXwWN9gFit5js6f
         aBDMeax9UuwuXlSgdECEiS5Z8hoSipXERiWNxvTTFAyZ8LQVZ9AK0RiCmMMAsh1N1TJE
         xcSA==
X-Gm-Message-State: AOAM530ugDVB81s0hQcgVX3tSnvUkE6TdNDFOhhV5m0zOs75yExEumGh
        oRKe7xiXh4TqVo8Q7DQ7SZetXAtNJ9OxzYv8uaafB2t72PkMTefAYcytoDBWZNXHq1EJARTJlSc
        cjY70adMMHV65yivZ6Q1puGgI
X-Received: by 2002:a4a:8111:: with SMTP id b17mr20369536oog.5.1622656874260;
        Wed, 02 Jun 2021 11:01:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrk3qRkou4FT+ap8Ib7IcLQ3KgCOffHmpgm57ql01tRBX5u1yu/4tSn54gl3AujN8OJ/KF+w==
X-Received: by 2002:a4a:8111:: with SMTP id b17mr20369498oog.5.1622656873779;
        Wed, 02 Jun 2021 11:01:13 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id u6sm133070otk.63.2021.06.02.11.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:01:13 -0700 (PDT)
Date:   Wed, 2 Jun 2021 12:01:11 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210602120111.5e5bcf93.alex.williamson@redhat.com>
In-Reply-To: <20210602173510.GE1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210528200311.GP1002214@nvidia.com>
        <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210601162225.259923bc.alex.williamson@redhat.com>
        <MWHPR11MB1886E8454A58661DC2CDBA678C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210602160140.GV1002214@nvidia.com>
        <20210602111117.026d4a26.alex.williamson@redhat.com>
        <20210602173510.GE1002214@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 14:35:10 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jun 02, 2021 at 11:11:17AM -0600, Alex Williamson wrote:
> 
> > > > > present and be able to test if DMA for that device is cache
> > > > > coherent.    
> > > 
> > > Why is this such a strong linkage to VFIO and not just a 'hey kvm
> > > emulate wbinvd' flag from qemu?  
> > 
> > IIRC, wbinvd has host implications, a malicious user could tell KVM to
> > emulate wbinvd then run the op in a loop and induce a disproportionate
> > load on the system.  We therefore wanted a way that it would only be
> > enabled when required.  
> 
> I think the non-coherentness is vfio_device specific? eg a specific
> device will decide if it is coherent or not?

No, this is specifically whether DMA is cache coherent to the
processor, ie. in the case of wbinvd whether the processor needs to
invalidate its cache in order to see data from DMA.

> If yes I'd recast this to call kvm_arch_register_noncoherent_dma()
> from the VFIO_GROUP_NOTIFY_SET_KVM in the struct vfio_device
> implementation and not link it through the IOMMU.

The IOMMU tells us if DMA is cache coherent, VFIO_DMA_CC_IOMMU maps to
IOMMU_CAP_CACHE_COHERENCY for all domains within a container.

> If userspace is telling the vfio_device to be non-coherent or not then
> it can call kvm_arch_register_noncoherent_dma() or not based on that
> signal.

Not non-coherent device memory, that would be a driver issue, cache
coherence of DMA is what we're after.

> > > It kind of looks like the other main point is to generate the
> > > VFIO_GROUP_NOTIFY_SET_KVM which is being used by two VFIO drivers to
> > > connect back to the kvm data
> > > 
> > > But that seems like it would have been better handled with some IOCTL
> > > on the vfio_device fd to import the KVM to the driver not this
> > > roundabout way?  
> > 
> > Then QEMU would need to know which drivers require KVM knowledge?  This
> > allowed transparent backwards compatibility with userspace.  Thanks,  
> 
> I'd just blindly fire a generic 'hey here is your KVM FD' into every
> VFIO device.

Yes, QEMU could do this, but the vfio-kvm device was already there with
this association and required no uAPI work.  This one is the least IOMMU
related of the use cases.  Thanks,

Alex


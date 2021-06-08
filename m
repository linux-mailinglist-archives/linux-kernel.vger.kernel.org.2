Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0E93A019C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbhFHSzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235459AbhFHSs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623178024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pggYjn7HE949Eh1AF224q4uHAjKMVRVQ+Yp3GK12w3I=;
        b=edKWUDwWFj2YSp0aVES1AheyWNX3eft6ZQjAIsMhYFbJEPoB0fAdRL2Rjuzh30XSfPzG8S
        ZkmaJOwjTFkpv48oLm4x2s3QmS+BMyRBRtp1JCJcOjid3dYCsQ2y1t3SJBzZG9ZSdDS8MH
        xJXZzNWa7J2BlRcp951lZAzLKxfWje8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-yBXqk7AJOfSaCcrbtjQu1g-1; Tue, 08 Jun 2021 14:47:03 -0400
X-MC-Unique: yBXqk7AJOfSaCcrbtjQu1g-1
Received: by mail-ot1-f71.google.com with SMTP id i25-20020a9d4a990000b0290304f00e3e3aso14543591otf.15
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 11:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=pggYjn7HE949Eh1AF224q4uHAjKMVRVQ+Yp3GK12w3I=;
        b=sxyfs4J7LT1NN1JfbSzDzM3IIRv8fP2NXxvItsM6A6Oq7UQ0MW8Zsy0wg59j1rh5kg
         UECi7GvI0WAB6rx6pixApc3wIKaf9qqs/OGzGhQzFajvjBQAf+ZOuE2+Ha1Uvnlrm5JM
         WgFuwRFN2k1GdTwA7WSQ2iXY5hM3NGYY/tJM/BYdYd6WrJCDcQQ7G19UtMrz5qg9xFpC
         R/kS4p9mIUFsSReNCUePdxSgMOAUVS2K/afj6/f2QW48/BMoJ0e45ohZxfwI6mDAvUXb
         yk8xJBtmOFT518LcpVov2ci2XO9cgUHJwjWFXbuIy/D39/rercLYhdBLgvcJhdq+g7oF
         jQhw==
X-Gm-Message-State: AOAM533bDiNg9ocUFjPDpX+SWrm4hs7ezIB6bVA+gyJqyDv20oFugZyp
        1mFe4V005kJWncpZM4BE4zuCbmjjlxnPNem3u067FxIENSBQbBVqXi/7lQR50e5yGdPyjxj+xJ0
        OHPS8zdMdlOjWjQUKyK7n9HMQ
X-Received: by 2002:aca:4cc3:: with SMTP id z186mr3803994oia.73.1623178022612;
        Tue, 08 Jun 2021 11:47:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZf1O0f0pw+40XtUuaOyogPurrGiPr1ylVHW3rYzYXfGQXFHlVRWz1CKnFUzJnCqpweUhXgA==
X-Received: by 2002:aca:4cc3:: with SMTP id z186mr3803972oia.73.1623178022326;
        Tue, 08 Jun 2021 11:47:02 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id 3sm336679oob.1.2021.06.08.11.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 11:47:02 -0700 (PDT)
Date:   Tue, 8 Jun 2021 12:47:00 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Message-ID: <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
In-Reply-To: <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
References: <20210604092620.16aaf5db.alex.williamson@redhat.com>
        <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
        <20210604155016.GR1002214@nvidia.com>
        <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
        <20210604160336.GA414156@nvidia.com>
        <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
        <20210604172207.GT1002214@nvidia.com>
        <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
        <20210607175926.GJ1002214@nvidia.com>
        <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
        <20210608131547.GE1002214@nvidia.com>
        <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 15:44:26 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 08/06/21 15:15, Jason Gunthorpe wrote:
> > On Tue, Jun 08, 2021 at 09:56:09AM +0200, Paolo Bonzini wrote:
> >   
> >>>> Alternatively you can add a KVM_DEV_IOASID_{ADD,DEL} pair of ioctls. But it
> >>>> seems useless complication compared to just using what we have now, at least
> >>>> while VMs only use IOASIDs via VFIO.  
> >>>
> >>> The simplest is KVM_ENABLE_WBINVD(<fd security proof>) and be done
> >>> with it.  

Even if we were to relax wbinvd access to any device (capable of
no-snoop or not) in any IOMMU configuration (blocking no-snoop or not),
I think as soon as we say "proof" is required to gain this access then
that proof should be ongoing for the life of the access.

That alone makes this more than a "I want this feature, here's my
proof", one-shot ioctl.  Like the groupfd enabling a path for KVM to
ask if that group is non-coherent and holding a group reference to
prevent the group from being used to authorize multiple KVM instances,
the ioasidfd proof would need to minimally validate that devices are
present and provide some reference to enforce that model as ongoing, or
notifier to indicate an end of that authorization.  I don't think we
can simplify that out of the equation or we've essentially invalidated
that the proof is really required.

> >>
> >> The simplest one is KVM_DEV_VFIO_GROUP_ADD/DEL, that already exists and also
> >> covers hot-unplug.  The second simplest one is KVM_DEV_IOASID_ADD/DEL.  
> > 
> > This isn't the same thing, this is back to trying to have the kernel
> > set policy for userspace.  
> 
> If you want a userspace policy then there would be three states:
> 
> * WBINVD enabled because a WBINVD-enabled VFIO device is attached.
> 
> * WBINVD potentially enabled but no WBINVD-enabled VFIO device attached
> 
> * WBINVD forcefully disabled
> 
> KVM_DEV_VFIO_GROUP_ADD/DEL can still be used to distinguish the first 
> two.  Due to backwards compatibility, those two describe the default 
> behavior; disabling wbinvd can be done easily with a new sub-ioctl of 
> KVM_ENABLE_CAP and doesn't require any security proof.

That seems like a good model, use the kvm-vfio device for the default
behavior and extend an existing KVM ioctl if QEMU still needs a way to
tell KVM to assume all DMA is coherent, regardless of what the kvm-vfio
device reports.

If feels like we should be able to support a backwards compatibility
mode using the vfio group, but I expect long term we'll want to
transition the kvm-vfio device from a groupfd to an ioasidfd.

> The meaning of WBINVD-enabled is "won't return -ENXIO for the wbinvd 
> ioctl", nothing more nothing less.  If all VFIO devices are going to be 
> WBINVD-enabled, then that will reflect on KVM as well, and I won't have 
> anything to object if there's consensus on the device assignment side of 
> things that the wbinvd ioctl won't ever fail.

If we create the IOMMU vs device coherency matrix:

            \ Device supports
IOMMU blocks \   no-snoop
  no-snoop    \  yes | no  |
---------------+-----+-----+
           yes |  1  |  2  |
---------------+-----+-----+
           no  |  3  |  4  |
---------------+-----+-----+

DMA is always coherent in boxes {1,2,4} (wbinvd emulation is not
needed).  VFIO will currently always configure the IOMMU for {1,2} when
the feature is supported.  Boxes {3,4} are where we'll currently
emulate wbinvd.  The best we could do, not knowing the guest or
insights into the guest driver would be to only emulate wbinvd for {3}.

The majority of devices appear to report no-snoop support {1,3}, but
the claim is that it's mostly unused outside of GPUs, effectively {2,4}.
I'll speculate that most IOMMUs support enforcing coherency (amd, arm,
fsl unconditionally, intel conditionally) {1,2}.

I think that means we're currently operating primarily in Box {1},
which does not seem to lean towards unconditional wbinvd access with
device ownership.

I think we have a desire with IOASID to allow user policy to operate
certain devices in {3} and I think the argument there is that a
specific software enforced coherence sync is more efficient on the bus
than the constant coherence enforcement by the IOMMU.

I think that the disable mode Jason proposed is essentially just a way
to move a device from {3} to {4}, ie. the IOASID support or
configuration does not block no-snoop and the device claims to support
no-snoop, but doesn't use it.  How we'd determine this to be true for
a device without a crystal ball of driver development or hardware
errata that no-snoop transactions are not possible regardless of the
behavior of the enable bit, I'm not sure.  If we're operating a device
in {3}, but the device does not generate no-snoop transactions, then
presumably the guest driver isn't generating wbinvd instructions for us
to emulate, so where are the wbinvd instructions that this feature
would prevent being emulated coming from?  Thanks,

Alex


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B67D3C7477
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhGMQ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhGMQ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626193572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUNFSZ0FEoShWeStx0gKzE+MBfhHSV0LmcBrnFbHTXY=;
        b=imYZ3nnr50zpDOZ363UQPIDY1+KD88gVR6aWNmF8CRaUzzIXpILEq+OdmRrMcPHpFU1rwP
        /OHAOxhMh1XmzmHo5QroNfqhqLgxGUiCDgdHNVLJ9v56+TDIKndkIyp3jbB4AuEt4IaBQy
        tlsOCPsle8EzLOMsaRsb6UCinn0BtAw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-hYg4s6djMwOy0jCucsL20g-1; Tue, 13 Jul 2021 12:26:11 -0400
X-MC-Unique: hYg4s6djMwOy0jCucsL20g-1
Received: by mail-oi1-f198.google.com with SMTP id u30-20020a056808151eb029025a08429ca1so5322676oiw.23
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUNFSZ0FEoShWeStx0gKzE+MBfhHSV0LmcBrnFbHTXY=;
        b=ZPMkDr8es8S6ltk22IQ/zusyE8q2ig8+r31iTirh6Gi5T1uUf1Rrkgs+qeLg4/TaRX
         3bdu3lasvPaCwPxOSpdeWxOTe7Co8MZtt4JE2Uq/3e/5hs2MoUJyRWcIS65zkf+2AWs1
         0aORXga0ePubmXabCDndYI7QSgymyTIfTEYsUWncwnbeGp5U1yp+mjnHDSt1q3+BfBY+
         IOOvaKu53VB06eH2jY596MvparI6YxfaIR4X3CjHVNlzl3WTbiooYw+uKlNj1AkALreq
         WMqWDuqdXgvzDu5P6lyaRFVax1qD11Y5fLpUERsGpQw5qcsSjMHu2dhZJrgMnMhSpeqn
         UK4g==
X-Gm-Message-State: AOAM532+CyUvKTGE6VNPXnojCQbUcL4B9L1jw6jmZVxHRm0Su0mFqcer
        kpFFMokIrxQLrHePKfNwpg9h+utQr7m4uYaPDVCLKtLB4hB6ykiOZK/yftbCRn96C/wukqfdbOe
        XpvEGuSzhpwZSqMtv+s3fXBrf
X-Received: by 2002:aca:1e04:: with SMTP id m4mr3818779oic.1.1626193570358;
        Tue, 13 Jul 2021 09:26:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl+u2c3Je1HN3GzIh0wo30xQVXEXR89UpoNOeKThRgzm1AgZvalAzbyfHug11B/NidaNjezQ==
X-Received: by 2002:aca:1e04:: with SMTP id m4mr3818748oic.1.1626193570154;
        Tue, 13 Jul 2021 09:26:10 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id l15sm1047355otk.56.2021.07.13.09.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 09:26:09 -0700 (PDT)
Date:   Tue, 13 Jul 2021 10:26:07 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Wang <jasowang@redhat.com>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shenming Lu <lushenming@huawei.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <20210713102607.3a886fee.alex.williamson@redhat.com>
In-Reply-To: <20210713125503.GC136586@nvidia.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
        <20210709155052.2881f561.alex.williamson@redhat.com>
        <BN9PR11MB54336FB9845649BB2D53022C8C159@BN9PR11MB5433.namprd11.prod.outlook.com>
        <20210712124150.2bf421d1.alex.williamson@redhat.com>
        <BL1PR11MB54299D9554D71F53D74E1E378C159@BL1PR11MB5429.namprd11.prod.outlook.com>
        <20210713125503.GC136586@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2021 09:55:03 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jul 12, 2021 at 11:56:24PM +0000, Tian, Kevin wrote:
> 
> > Maybe I misunderstood your question. Are you specifically worried
> > about establishing the security context for a mdev vs. for its
> > parent?  
> 
> The way to think about the cookie, and the device bind/attach in
> general, is as taking control of a portion of the IOMMU routing:
> 
>  - RID
>  - RID + PASID
>  - "software"
> 
> For the first two there can be only one device attachment per value so
> the cookie is unambiguous.
> 
> For "software" the iommu layer has little to do with this - everything
> is constructed outside by the mdev. If the mdev wishes to communicate
> on /dev/iommu using the cookie then it has to do so using some iommufd
> api and we can convay the proper device at that point.
> 
> Kevin didn't show it, but along side the PCI attaches:
> 
>         struct iommu_attach_data * iommu_pci_device_attach(
>                 struct iommu_dev *dev, struct pci_device *pdev,
>                 u32 ioasid);
> 
> There would also be a software attach for mdev:
> 
>         struct iommu_attach_data * iommu_sw_device_attach(
>                 struct iommu_dev *dev, struct device *pdev, u32 ioasid);
> 
> Which does not connect anything to the iommu layer.
> 
> It would have to return something that allows querying the IO page
> table, and the mdev would use that API instead of vfio_pin_pages().


Quoting this proposal again:

> 1)  A successful binding call for the first device in the group creates 
>     the security context for the entire group, by:
> 
>     * Verifying group viability in a similar way as VFIO does;
> 
>     * Calling IOMMU-API to move the group into a block-dma state,
>       which makes all devices in the group attached to an block-dma
>       domain with an empty I/O page table;
> 
>     VFIO should not allow the user to mmap the MMIO bar of the bound
>     device until the binding call succeeds.

The attach step is irrelevant to my question, the bind step is where
the device/group gets into a secure state for device access.

So for IGD we have two scenarios, direct assignment and software mdevs.

AIUI the operation of VFIO_DEVICE_BIND_IOMMU_FD looks like this:

	iommu_ctx = iommu_ctx_fdget(iommu_fd);

	mdev = mdev_from_dev(vdev->dev);
	dev = mdev ? mdev_parent_dev(mdev) : vdev->dev;

	iommu_dev = iommu_register_device(iommu_ctx, dev, cookie);

In either case, this last line is either registering the IGD itself
(ie. the struct device representing PCI device 0000:00:02.0) or the
parent of the GVT-g mdev (ie. the struct device representing PCI device
0000:00:02.0).  They're the same!  AIUI, the cookie is simply an
arbitrary user generated value which they'll use to refer to this
device via the iommu_fd uAPI.

So what magic is iommu_register_device() doing to infer my intentions
as to whether I'm asking for the IGD RID to be isolated or I'm only
creating a software context for an mdev?  Thanks,

Alex


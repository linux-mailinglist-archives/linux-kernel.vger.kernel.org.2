Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D8C413C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhIUVLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235296AbhIUVLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632258573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlpLbPlo4KBTm6av7Erxbr1sl480yKpqTzkq1T4fFto=;
        b=i3+Ts1UazGToaiU19md1QAeIb6XQu3crxJ7BdznORFJ8UMVR18VPCFT3O/MUWBrZ6vrovQ
        elXBQAKAE5Qwfz5yjyP+7xxLQZFX0xIR2QbGiZKMz2J2iUvg2Hcu7+4yXn9NksxB1M0EPG
        eiCy3cLy8Sl7axi9QLcqUgNnYdJ8GHY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-fEwmo4xfN6O1So43PYimXw-1; Tue, 21 Sep 2021 17:09:32 -0400
X-MC-Unique: fEwmo4xfN6O1So43PYimXw-1
Received: by mail-ot1-f71.google.com with SMTP id x23-20020a056830245700b00547388c3da3so137267otr.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 14:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlpLbPlo4KBTm6av7Erxbr1sl480yKpqTzkq1T4fFto=;
        b=ijuVt6axvg0RFZU614YvGBWXhiUJE/jcTLUNCxIo/DSwkgbCCOfK0IlVDuL3U68199
         LhnPMDFN99+XWlbsoRqEpqd/SD4Bx00dKJk484TWIEu49iwy/r0RjQqutSQcM1zbeSg7
         ktMtgMuN0impazevAgTm5anwhQdodt0UvLXRtSFTWc0LNJ4bmTg3OpKjz/Qc08wV5AX+
         ys0bQo6zn9a4bL02tTBilDBh7VlH3h+YHSZtOGPR/QYJ5tndvnyI51rp67eap5B9818N
         Exhm73QzN4LcqMRiw1mnTru16yn2gbybZ47bv0P8afEF6oKC61pSEv3ct2jHDz2HJMfv
         zzFw==
X-Gm-Message-State: AOAM533TGLemc64olDrLIL4sZMZXcKeoDI2KQXGOwilgPvbyT1asO+6s
        7mpCMOltg6F4H3f/i1No9QohyjAH9Y0hb/TV6rBtAk4BjStXrmAMd5D+/OEHPqfyRM9XGWh0zRe
        fVIg9qWASGrFxzAWGvF5oSM6h
X-Received: by 2002:aca:120f:: with SMTP id 15mr1525403ois.62.1632258571925;
        Tue, 21 Sep 2021 14:09:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhqVoP+OVs+kyF/lfOuiIjVaG7CDYwxfFsiO8jsmgxqmlxGTrRDnls5rys+4wGpfrkbujdyw==
X-Received: by 2002:aca:120f:: with SMTP id 15mr1525386ois.62.1632258571725;
        Tue, 21 Sep 2021 14:09:31 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id k23sm55513ood.12.2021.09.21.14.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:09:31 -0700 (PDT)
Date:   Tue, 21 Sep 2021 15:09:29 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Liu Yi L <yi.l.liu@intel.com>, hch@lst.de, jasowang@redhat.com,
        joro@8bytes.org, jean-philippe@linaro.org, kevin.tian@intel.com,
        parav@mellanox.com, lkml@metux.net, pbonzini@redhat.com,
        lushenming@huawei.com, eric.auger@redhat.com, corbet@lwn.net,
        ashok.raj@intel.com, yi.l.liu@linux.intel.com,
        jun.j.tian@intel.com, hao.wu@intel.com, dave.jiang@intel.com,
        jacob.jun.pan@linux.intel.com, kwankhede@nvidia.com,
        robin.murphy@arm.com, kvm@vger.kernel.org,
        iommu@lists.linux-foundation.org, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        david@gibson.dropbear.id.au, nicolinc@nvidia.com
Subject: Re: [RFC 05/20] vfio/pci: Register device to /dev/vfio/devices
Message-ID: <20210921150929.5977702c.alex.williamson@redhat.com>
In-Reply-To: <20210921164001.GR327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
        <20210919063848.1476776-6-yi.l.liu@intel.com>
        <20210921164001.GR327412@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021 13:40:01 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Sun, Sep 19, 2021 at 02:38:33PM +0800, Liu Yi L wrote:
> > This patch exposes the device-centric interface for vfio-pci devices. To
> > be compatiable with existing users, vfio-pci exposes both legacy group
> > interface and device-centric interface.
> > 
> > As explained in last patch, this change doesn't apply to devices which
> > cannot be forced to snoop cache by their upstream iommu. Such devices
> > are still expected to be opened via the legacy group interface.

This doesn't make much sense to me.  The previous patch indicates
there's work to be done in updating the kvm-vfio contract to understand
DMA coherency, so you're trying to limit use cases to those where the
IOMMU enforces coherency, but there's QEMU work to be done to support
the iommufd uAPI at all.  Isn't part of that work to understand how KVM
will be told about non-coherent devices rather than "meh, skip it in the
kernel"?  Also let's not forget that vfio is not only for KVM.
 
> > When the device is opened via /dev/vfio/devices, vfio-pci should prevent
> > the user from accessing the assigned device because the device is still
> > attached to the default domain which may allow user-initiated DMAs to
> > touch arbitrary place. The user access must be blocked until the device
> > is later bound to an iommufd (see patch 08). The binding acts as the
> > contract for putting the device in a security context which ensures user-
> > initiated DMAs via this device cannot harm the rest of the system.
> > 
> > This patch introduces a vdev->block_access flag for this purpose. It's set
> > when the device is opened via /dev/vfio/devices and cleared after binding
> > to iommufd succeeds. mmap and r/w handlers check this flag to decide whether
> > user access should be blocked or not.  
> 
> This should not be in vfio_pci.
> 
> AFAIK there is no condition where a vfio driver can work without being
> connected to some kind of iommu back end, so the core code should
> handle this interlock globally. A vfio driver's ops should not be
> callable until the iommu is connected.
> 
> The only vfio_pci patch in this series should be adding a new callback
> op to take in an iommufd and register the pci_device as a iommufd
> device.

Couldn't the same argument be made that registering a $bus device as an
iommufd device is a common interface that shouldn't be the
responsibility of the vfio device driver?  Is userspace opening the
non-group device anything more than a reservation of that device if
access is withheld until iommu isolation?  I also don't really want to
predict how ioctls might evolve to guess whether only blocking .read,
.write, and .mmap callbacks are sufficient.  Thanks,

Alex


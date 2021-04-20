Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F98536620B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 00:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhDTWKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 18:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234203AbhDTWKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618956615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYWPaibps44u4DG3im/OlXMp3Z2UvvRgt8JyqA221Lc=;
        b=YhihNFoTCZTL2wtGUASAOqG6YLsurgazayEF3mxgC9GIrYcYOofuiTvXsts8w2duSg+cNd
        7xUxxq8sFq0ej0xCoQdNBI5B9cZ7lKdrYmXdX1TWIzEJRWhqMsFy01eGrwpiKBj4tG7Nfv
        5aVx8K5rGaSE1ZQYziRCg/urWKDLD0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-f9V0_r9GNo-Bx64X37vOdQ-1; Tue, 20 Apr 2021 18:06:09 -0400
X-MC-Unique: f9V0_r9GNo-Bx64X37vOdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E3E2192CC50;
        Tue, 20 Apr 2021 22:04:59 +0000 (UTC)
Received: from x1.home.shazbot.org (ovpn-117-254.rdu2.redhat.com [10.10.117.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2614360CDE;
        Tue, 20 Apr 2021 22:04:58 +0000 (UTC)
Date:   Tue, 20 Apr 2021 16:04:57 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     liulongfang <liulongfang@huawei.com>, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
Message-ID: <20210420160457.6b91850a@x1.home.shazbot.org>
In-Reply-To: <20210420125957.GA1370958@nvidia.com>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
        <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
        <20210415220137.GA1672608@nvidia.com>
        <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
        <20210419123314.GT1370958@nvidia.com>
        <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
        <20210420125957.GA1370958@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 09:59:57 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Apr 20, 2021 at 08:50:12PM +0800, liulongfang wrote:
> > On 2021/4/19 20:33, Jason Gunthorpe wrote:  
> > > On Mon, Apr 19, 2021 at 08:24:40PM +0800, liulongfang wrote:
> > >   
> > >>> I'm also confused how this works securely at all, as a general rule a
> > >>> VFIO PCI driver cannot access the MMIO memory of the function it is
> > >>> planning to assign to the guest. There is a lot of danger that the
> > >>> guest could access that MMIO space one way or another.  
> > >>
> > >> VF's MMIO memory is divided into two parts, one is the guest part,
> > >> and the other is the live migration part. They do not affect each other,
> > >> so there is no security problem.  
> > > 
> > > AFAIK there are several scenarios where a guest can access this MMIO
> > > memory using DMA even if it is not mapped into the guest for CPU
> > > access.
> > >   
> > The hardware divides VF's MMIO memory into two parts. The live migration
> > driver in the host uses the live migration part, and the device driver in
> > the guest uses the guest part. They obtain the address of VF's MMIO memory
> > in their respective drivers, although these two parts The memory is
> > continuous on the hardware device, but due to the needs of the drive function,
> > they will not perform operations on another part of the memory, and the
> > device hardware also independently responds to the operation commands of
> > the two parts.  
> 
> It doesn't matter, the memory is still under the same PCI BDF and VFIO
> supports scenarios where devices in the same IOMMU group are not
> isolated from each other.
> 
> This is why the granual of isolation is a PCI BDF - VFIO directly
> blocks kernel drivers from attaching to PCI BDFs that are not
> completely isolated from VFIO BDF.
> 
> Bypassing this prevention and attaching a kernel driver directly to
> the same BDF being exposed to the guest breaks that isolation model.
> 
> > So, I still don't understand what the security risk you are talking about is,
> > and what do you think the security design should look like?
> > Can you elaborate on it?  
> 
> Each security domain must have its own PCI BDF.
> 
> The migration control registers must be on a different VF from the VF
> being plugged into a guest and the two VFs have to be in different
> IOMMU groups to ensure they are isolated from each other.

I think that's a solution, I don't know if it's the only solution.
AIUI, the issue here is that we have a device specific kernel driver
extending vfio-pci with migration support for this device by using an
MMIO region of the same device.  This is susceptible to DMA
manipulation by the user device.   Whether that's a security issue or
not depends on how the user can break the device.  If the scope is
limited to breaking their own device, they can do that any number of
ways and it's not very interesting.  If the user can manipulate device
state in order to trigger an exploit of the host-side kernel driver,
that's obviously more of a problem.

The other side of this is that if migration support can be implemented
entirely within the VF using this portion of the device MMIO space, why
do we need the host kernel to support this rather than implementing it
in userspace?  For example, QEMU could know about this device,
manipulate the BAR size to expose only the operational portion of MMIO
to the VM and use the remainder to support migration itself.  I'm
afraid that just like mdev, the vfio migration uAPI is going to be used
as an excuse to create kernel drivers simply to be able to make use of
that uAPI.  I haven't looked at this driver to know if it has some
other reason to exist beyond what could be done through vfio-pci and
userspace migration support.  Thanks,

Alex


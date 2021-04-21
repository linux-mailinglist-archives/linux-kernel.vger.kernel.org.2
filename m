Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8958B36724D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245136AbhDUSNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240314AbhDUSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619028748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8EfD7qwEqEHdrY5pzf6oTYJDg/yr8xn+BFbmxKK0ZwE=;
        b=VO/YaBSdrpYuguWFnNnomS4cXcOcAi8C3HoG6IfB+loX5XaBoLGNCi13nIBlN/BWdmBIn4
        eibNWsk+E74rgh65nt2NQJzTrU/pLal3gx0WZyQl1R80cQefG9pcYlUWqZSFlLxfFZ+tF+
        tM+7qDkP1KUY5IsIeVPZfGZMvwX/5bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131--lcLLR2jMzmT_DgVnWqM_g-1; Wed, 21 Apr 2021 14:12:27 -0400
X-MC-Unique: -lcLLR2jMzmT_DgVnWqM_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB5248030A0;
        Wed, 21 Apr 2021 18:12:25 +0000 (UTC)
Received: from redhat.com (ovpn-114-21.phx2.redhat.com [10.3.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73F8919726;
        Wed, 21 Apr 2021 18:12:25 +0000 (UTC)
Date:   Wed, 21 Apr 2021 12:12:24 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
Message-ID: <20210421121224.62382e5d@redhat.com>
In-Reply-To: <25d033e6-1cba-0da0-2ee7-03a14e75b8a5@huawei.com>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
        <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
        <20210415220137.GA1672608@nvidia.com>
        <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
        <20210419123314.GT1370958@nvidia.com>
        <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
        <20210420125957.GA1370958@nvidia.com>
        <20210420160457.6b91850a@x1.home.shazbot.org>
        <25d033e6-1cba-0da0-2ee7-03a14e75b8a5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 17:59:02 +0800
liulongfang <liulongfang@huawei.com> wrote:

> On 2021/4/21 6:04, Alex Williamson wrote:
> > On Tue, 20 Apr 2021 09:59:57 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >  =20
> >> On Tue, Apr 20, 2021 at 08:50:12PM +0800, liulongfang wrote: =20
> >>> On 2021/4/19 20:33, Jason Gunthorpe wrote:   =20
> >>>> On Mon, Apr 19, 2021 at 08:24:40PM +0800, liulongfang wrote:
> >>>>    =20
> >>>>>> I'm also confused how this works securely at all, as a general rul=
e a
> >>>>>> VFIO PCI driver cannot access the MMIO memory of the function it is
> >>>>>> planning to assign to the guest. There is a lot of danger that the
> >>>>>> guest could access that MMIO space one way or another.   =20
> >>>>>
> >>>>> VF's MMIO memory is divided into two parts, one is the guest part,
> >>>>> and the other is the live migration part. They do not affect each o=
ther,
> >>>>> so there is no security problem.   =20
> >>>>
> >>>> AFAIK there are several scenarios where a guest can access this MMIO
> >>>> memory using DMA even if it is not mapped into the guest for CPU
> >>>> access.
> >>>>    =20
> >>> The hardware divides VF's MMIO memory into two parts. The live migrat=
ion
> >>> driver in the host uses the live migration part, and the device drive=
r in
> >>> the guest uses the guest part. They obtain the address of VF's MMIO m=
emory
> >>> in their respective drivers, although these two parts The memory is
> >>> continuous on the hardware device, but due to the needs of the drive =
function,
> >>> they will not perform operations on another part of the memory, and t=
he
> >>> device hardware also independently responds to the operation commands=
 of
> >>> the two parts.   =20
> >>
> >> It doesn't matter, the memory is still under the same PCI BDF and VFIO
> >> supports scenarios where devices in the same IOMMU group are not
> >> isolated from each other.
> >>
> >> This is why the granual of isolation is a PCI BDF - VFIO directly
> >> blocks kernel drivers from attaching to PCI BDFs that are not
> >> completely isolated from VFIO BDF.
> >>
> >> Bypassing this prevention and attaching a kernel driver directly to
> >> the same BDF being exposed to the guest breaks that isolation model.
> >> =20
> >>> So, I still don't understand what the security risk you are talking a=
bout is,
> >>> and what do you think the security design should look like?
> >>> Can you elaborate on it?   =20
> >>
> >> Each security domain must have its own PCI BDF.
> >>
> >> The migration control registers must be on a different VF from the VF
> >> being plugged into a guest and the two VFs have to be in different
> >> IOMMU groups to ensure they are isolated from each other. =20
> >=20
> > I think that's a solution, I don't know if it's the only solution.
> > AIUI, the issue here is that we have a device specific kernel driver
> > extending vfio-pci with migration support for this device by using an =
=20
>=20
> If the two parts of the MMIO region are split into different BAR spaces on
> the device, the MMIO region of =E2=80=8B=E2=80=8Bthe business function is=
 still placed in BAR2,
> and the MMIO region of =E2=80=8B=E2=80=8Bthe live migration function is m=
oved to BAR4.
> Only BAR2 is mapped in the guest. only BAR4 is mapped in the host.
> This can solve this security issue.

The concern is really the "on the device" part rather than whether the
resources are within the same BAR or not.  We need to assume that a
user driver can generate a DMA targeting any address in the system,
including in this case the user driver could generate a DMA targeting
this migration BAR.  Ideally this would be routed upstream to the IOMMU
where it would be blocked for lack of a translation entry.  However,
because this range resides on the same PCIe requester ID, it's
logically more similar to a two-function device where the functions are
considered non-isolated and are therefore exposed within the same IOMMU
group.  We would not allow a kernel driver for one of those functions
and a userspace driver for the other.  In this case those drivers are
strongly related, but we still need to consider to what extent a
malicious user driver can interfere with or exploit the kernel side
driver.


> > MMIO region of the same device.  This is susceptible to DMA> manipulati=
on by the user device.   Whether that's a security issue or> not depends on=
 how the user can break the device.  If the scope is
> > limited to breaking their own device, they can do that any number of
> > ways and it's not very interesting.  If the user can manipulate device
> > state in order to trigger an exploit of the host-side kernel driver,
> > that's obviously more of a problem.
> >=20
> > The other side of this is that if migration support can be implemented
> > entirely within the VF using this portion of the device MMIO space, why
> > do we need the host kernel to support this rather than implementing it
> > in userspace?  For example, QEMU could know about this device,
> > manipulate the BAR size to expose only the operational portion of MMIO
> > to the VM and use the remainder to support migration itself.  I'm
> > afraid that just like mdev, the vfio migration uAPI is going to be used
> > as an excuse to create kernel drivers simply to be able to make use of
> > that uAPI.  I haven't looked at this driver to know if it has some =20
>=20
> When the accelerator device is designed to support the live migration
> function, it is based on the uAPI of the migration region to realize the
> live migration function, so the live migration function requires a driver
> that connects to this uAPI.
> Is this set of interfaces not open to us now?

In your model, if both BARs are exposed to userspace and a device
specific extension in QEMU claims the migration BAR rather than
exposing it to the VM, could that driver mimic the migration region
uAPI from userspace?  For example, you don't need page pinning to
interact with the IOMMU, you don't need resources beyond the scope
of the endpoint device itself, and the migration info BAR is safe for
userspace to manage?  If so, then a kernel-based driver to expose a
migration uAPI seems like it's only a risk for the kernel, ie. moving
what could be a userspace driver into the kernel for the convenience of
re-using a kernel uAPI.  Thanks,

Alex


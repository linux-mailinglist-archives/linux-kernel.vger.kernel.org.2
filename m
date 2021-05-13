Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B030537FD49
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhEMScy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 May 2021 14:32:54 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2367 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhEMScu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:32:50 -0400
Received: from dggeml702-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fh0XF02Hxz5wHf;
        Fri, 14 May 2021 02:28:13 +0800 (CST)
Received: from dggemi711-chm.china.huawei.com (10.3.20.110) by
 dggeml702-chm.china.huawei.com (10.3.17.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 14 May 2021 02:31:36 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggemi711-chm.china.huawei.com (10.3.20.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 14 May 2021 02:31:35 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Thu, 13 May 2021 19:31:33 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        liulongfang <liulongfang@huawei.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [Linuxarm]  Re: [RFC PATCH 2/3] vfio/hisilicon: register the
 driver to vfio
Thread-Topic: [Linuxarm]  Re: [RFC PATCH 2/3] vfio/hisilicon: register the
 driver to vfio
Thread-Index: AQHXMkL9mza0TJ8TfUm11z5ygPSvFqq7zAN3gAL2j3WAAIzL6IAgnBJYgAGsWYGAACE9wIAABZSAgAAb/VD///oBAIAAEwug
Date:   Thu, 13 May 2021 18:31:33 +0000
Message-ID: <34d73b078c894c66b535a25921b5a4e8@huawei.com>
References: <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
        <20210419123314.GT1370958@nvidia.com>
        <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
        <20210420125957.GA1370958@nvidia.com>
        <20210420160457.6b91850a@x1.home.shazbot.org>
        <25d033e6-1cba-0da0-2ee7-03a14e75b8a5@huawei.com>
        <20210421121224.62382e5d@redhat.com>
        <6ea89655-31c5-233b-ca2a-fcc166b5597c@huawei.com>
        <20210512121053.GT1002214@nvidia.com>
        <3eaa3114-81b6-1bd9-c7e6-cb1541389b58@huawei.com>
        <20210513134422.GD1002214@nvidia.com>
        <e3db0c328da6411ea2ae07595ed5f6c3@huawei.com>
        <20210513110349.68e3d59d@redhat.com>
        <1035a9a9b03b43dd9f859136ed84a7f8@huawei.com>
 <20210513122232.589d24d8@redhat.com>
In-Reply-To: <20210513122232.589d24d8@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.81.63]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: 13 May 2021 19:23
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>; liulongfang
> <liulongfang@huawei.com>; cohuck@redhat.com;
> linux-kernel@vger.kernel.org; linuxarm@openeuler.org
> Subject: Re: [Linuxarm] Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to
> vfio
> 
> On Thu, 13 May 2021 17:52:56 +0000
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> wrote:
> 
> > Hi Alex,
> >
> > > -----Original Message-----
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: 13 May 2021 18:04
> > > To: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
> > > Cc: Jason Gunthorpe <jgg@nvidia.com>; liulongfang
> > > <liulongfang@huawei.com>; cohuck@redhat.com;
> > > linux-kernel@vger.kernel.org; linuxarm@openeuler.org
> > > Subject: [Linuxarm] Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to
> > > vfio
> > >
> > > On Thu, 13 May 2021 15:49:25 +0000
> > > Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > > > > Sent: 13 May 2021 14:44
> > > > > To: liulongfang <liulongfang@huawei.com>
> > > > > Cc: Alex Williamson <alex.williamson@redhat.com>;
> cohuck@redhat.com;
> > > > > linux-kernel@vger.kernel.org; linuxarm@openeuler.org
> > > > > Subject: [Linuxarm] Re: [RFC PATCH 2/3] vfio/hisilicon: register the
> driver to
> > > > > vfio
> > > > >
> > > > > On Thu, May 13, 2021 at 10:08:28AM +0800, liulongfang wrote:
> > > > > > On 2021/5/12 20:10, Jason Gunthorpe wrote:
> > > > > > > On Wed, May 12, 2021 at 04:39:43PM +0800, liulongfang wrote:
> > > > > > >
> > > > > > >> Therefore, this method of limiting the length of the BAR
> > > > > > >> configuration space can prevent unsafe operations of the memory.
> > > > > > >
> > > > > > > The issue is DMA controlled by the guest accessing the secure BAR
> > > > > > > area, not the guest CPU.
> > > > > > >
> > > > > > > Jason
> > > > > > > .
> > > > > > >
> > > > > > This secure BAR area is not presented to the Guest,
> > > > > > which makes it impossible for the Guest to obtain the secure BAR area
> > > > > > when establishing the DMA mapping of the configuration space.
> > > > > > If the DMA controller accesses the secure BAR area, the access will
> > > > > > be blocked by the SMMU.
> > > > >
> > > > > There are scenarios where this is not true.
> > > > >
> > > > > At a minimum the mdev driver should refuse to work in those cases.
> > > > >
> > > >
> > > > Hi,
> > > >
> > > > I think the idea here is not a generic solution, but a quirk for this specific
> dev.
> > > >
> > > > Something like,
> > > >
> > > > --- a/drivers/vfio/pci/vfio_pci.c
> > > > +++ b/drivers/vfio/pci/vfio_pci.c
> > > > @@ -866,7 +866,12 @@ static long vfio_pci_ioctl(struct vfio_device
> > > *core_vdev,
> > > >                         break;
> > > >                 case VFIO_PCI_BAR0_REGION_INDEX ...
> > > VFIO_PCI_BAR5_REGION_INDEX:
> > > >                         info.offset =
> > > VFIO_PCI_INDEX_TO_OFFSET(info.index);
> > > > -                       info.size = pci_resource_len(pdev, info.index);
> > > > +
> > > > +                       if (check_hisi_acc_quirk(pdev, info))
> > > > +                               info.size = new_size;// BAR is
> limited
> > > without migration region.
> > > > +                       else
> > > > +                               info.size = pci_resource_len(pdev,
> > > info.index);
> > > > +
> > > >                         if (!info.size) {
> > > >                                 info.flags = 0;
> > > >                                 break;
> > > >
> > > > Is this an acceptable/workable solution here?
> > >
> > > As Jason says, this only restricts CPU access to the BAR, the issue is
> > > DMA access.  As the hardware vendor you may be able to guarantee that
> > > a DMA transaction generated by the device targeting the remainder of
> > > the BAR will always go upstream, but can you guarantee the routing
> > > between the device and the SMMU?  For instance if this device can be
> > > implemented as a plugin card, then it can be installed into a
> > > downstream port that may not support ACS.  That downstream port may
> > > implement request redirection allowing the transaction to reflect back
> > > to the device without IOMMU translation.  At that point the userspace
> > > driver can target the kernel driver half of the BAR and potentially
> > > expose a security risk.  Thanks,
> >
> > The ACC devices on this platform are not pluggable devices. They are
> exposed
> > as integrated endpoint devices. So I am not sure the above concern is valid in
> this
> > case.
> >
> > I had a look at the userspace driver approach you suggested. But
> unfortunately
> > the migration state change for the vf has to check some of the pf registers for
> > confirming the state. So even if we move the implementation to Qemu, we
> > still may have to use the migration uAPI to access the pf device registers.
> >
> > Since the devices we are concerned here are all integrated endpoints and if
> the
> > above quirk is an acceptable one, then we can use the uAPI as done in this
> > series without overly complicating things here.
> 
> If you expect this device to appear only as an integrated endpoint, then
> I think Jason's suggestion above is correct.  Your driver that supports
> migration can refuse to load for devices there the topology is other
> than expected and you're effectively guaranteeing DMA isolation of the
> user and in-kernel drivers by hardware DMA semantics and topology.

Ok. Will take a look at the recommendation.

> Requiring access to the PF to support the migration protocol also
> suggests that an in-kernel driver to support migration is our best
> option.  

Thanks,
Shameer

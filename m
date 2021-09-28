Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3840241B3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbhI1Q3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241768AbhI1Q3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632846470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vR8c6NsLOBOKtRR+igT5REdAQP6jWS9T8ZWr3CWbbOk=;
        b=TxIiqBc9wiH1ZVjHDTGXsIGuUn37WP6aCVmdNkOPJyyGt0r9/rPXpNaFe5qHDSLkLpUnaV
        2vLCDVyBoUowPLz0I/XRneL7xjiXlnQoUKoJ3eb/91wPglqG7Qb81XioDBS9cMsZPO2tXK
        iY0ULRcE5eYDsVXzUEo/5jqdN17Av0A=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-xmR5zoZQMSmXbVYb8LXeiQ-1; Tue, 28 Sep 2021 12:26:44 -0400
X-MC-Unique: xmR5zoZQMSmXbVYb8LXeiQ-1
Received: by mail-ot1-f70.google.com with SMTP id o12-20020a9d410c000000b00547056f6644so21507071ote.20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 09:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vR8c6NsLOBOKtRR+igT5REdAQP6jWS9T8ZWr3CWbbOk=;
        b=ILRbSZlUfQAo6YXmMJ0vMYZF1eW9SWP6OkRCghAF6o9AjAvIIEocBKbN1r98Mma5mP
         moV/r6D0LSiKGSmczUcbZ9HpgSOpaQhX3IUBOmS4+hatMFIDb33KjoJ/Hn85I4HyejYE
         CBPb0zByyAWTtXUp0y4UYDIBs7JnDX0NWXBM3UCbCkbnXERKBPC6ITxXXsWveSoACy9/
         5eyDR1WqOUkfigAd8ark92ORapyPHKMvHqPlajFFDUtwJAv8143363GKEtCkqh+NsETR
         U0IRouAKAHaG5QwVyR+cX35ysDGiffJs7Gp7n9nh+Uh80vZc+2O5uX+bLm+GooD77CmU
         /9FA==
X-Gm-Message-State: AOAM533VUzKpopLSYJAZLyCxYYp/AJXM5XXdSXLR29x6NRvN1LjNHS1+
        m7Yz0uEyE0krIcPuYiEbdjKHb7ek4fQsZKRU3vamArZL+SpSDvFSCxFpj4ETWwQCpcKONamRLvs
        0nIJ2EcLxeEIjumjtyAlmDKct
X-Received: by 2002:a9d:eac:: with SMTP id 41mr4740083otj.38.1632846403542;
        Tue, 28 Sep 2021 09:26:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1IG9jqGE9mq54HWFtwW0jt+nrscgPlPKb6PVqn3/v5AliJW96b01O572lk9obt2QieoW0Lg==
X-Received: by 2002:a9d:eac:: with SMTP id 41mr4740061otj.38.1632846403290;
        Tue, 28 Sep 2021 09:26:43 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id o126sm4579294oig.21.2021.09.28.09.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 09:26:42 -0700 (PDT)
Date:   Tue, 28 Sep 2021 10:26:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "hch@lst.de" <hch@lst.de>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "lkml@metux.net" <lkml@metux.net>,
        "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Tian, Jun J" <jun.j.tian@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lushenming@huawei.com" <lushenming@huawei.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: Re: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma
 interfaces
Message-ID: <20210928102640.4b115b09.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB54332256C5AAB9AECC88A7E38CA89@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
        <20210919063848.1476776-7-yi.l.liu@intel.com>
        <20210921170943.GS327412@nvidia.com>
        <BN9PR11MB5433DA330D4583387B59AA7F8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
        <20210922123931.GI327412@nvidia.com>
        <BN9PR11MB5433CE19425E85E7F52093278CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
        <20210927115342.GW964074@nvidia.com>
        <BN9PR11MB5433502FEF11940984774F278CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
        <20210927130935.GZ964074@nvidia.com>
        <BN9PR11MB543327D25DCE242919F7909A8CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
        <20210927131949.052d8481.alex.williamson@redhat.com>
        <BN9PR11MB54332256C5AAB9AECC88A7E38CA89@BN9PR11MB5433.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 07:43:36 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, September 28, 2021 3:20 AM
> >=20
> > On Mon, 27 Sep 2021 13:32:34 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >  =20
> > > > From: Jason Gunthorpe
> > > > Sent: Monday, September 27, 2021 9:10 PM
> > > >
> > > > On Mon, Sep 27, 2021 at 01:00:08PM +0000, Tian, Kevin wrote:
> > > > =20
> > > > > > I think for such a narrow usage you should not change the struct
> > > > > > device_driver. Just have pci_stub call a function to flip back =
to user
> > > > > > mode. =20
> > > > >
> > > > > Here we want to ensure that kernel dma should be blocked
> > > > > if the group is already marked for user-dma. If we just blindly
> > > > > do it for any driver at this point (as you commented earlier):
> > > > >
> > > > > +       ret =3D iommu_set_kernel_ownership(dev);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > >
> > > > > how would pci-stub reach its function to indicate that it doesn't
> > > > > do dma and flip back? =20
> > > > =20
> > > > > Do you envision a simpler policy that no driver can be bound
> > > > > to the group if it's already set for user-dma? what about vfio-pci
> > > > > itself? =20
> > > >
> > > > Yes.. I'm not sure there is a good use case to allow the stub drive=
rs
> > > > to load/unload while a VFIO is running. At least, not a strong enou=
gh
> > > > one to justify a global change to the driver core.. =20
> > >
> > > I'm fine with not loading pci-stub. From the very 1st commit msg
> > > looks pci-stub was introduced before vfio to prevent host driver
> > > loading when doing device assignment with KVM. I'm not sure
> > > whether other usages are built on pci-stub later, but in general it's
> > > not good to position devices in a same group into different usages. =
=20
> >=20
> > IIRC, pci-stub was invented for legacy KVM device assignment because
> > KVM was never an actual device driver, it just latched onto and started
> > using the device.  If there was an existing driver for the device then
> > KVM would fail to get device resources.  Therefore the device needed to
> > be unbound from its standard host driver, but that left it susceptible
> > to driver loads usurping the device.  Therefore pci-stub came along to
> > essentially claim the device on behalf of KVM.
> >=20
> > With vfio, there are a couple use cases of pci-stub that can be
> > interesting.  The first is that pci-stub is generally built into the
> > kernel, not as a module, which provides users the ability to specify a
> > list of ids for pci-stub to claim on the kernel command line with
> > higher priority than loadable modules.  This can prevent default driver
> > bindings to devices until tools like driverctl or boot time scripting
> > gets a shot to load the user designated driver for a device.
> >=20
> > The other use case, is that if a group is composed of multiple devices
> > and all those devices are bound to vfio drivers, then the user can gain
> > direct access to each of those devices.  If we wanted to insert a
> > barrier to restrict user access to certain devices within a group, we'd
> > suggest binding those devices to pci-stub.  Obviously within a group, it
> > may still be possible to manipulate the device via p2p DMA, but the
> > barrier is much higher and device, if not platform, specific to
> > manipulate such devices.  An example use case might be a chipset
> > Ethernet controller grouped among system management function in a
> > multi-function root complex integrated endpoint. =20
>=20
> Thanks for the background. It perfectly reflects how many tricky things
> that vfio has evolved to deal with and we'll dig them out again in this
> refactoring process with your help. =F0=9F=98=8A
>=20
> just a nit on the last example. If a system management function is=20
> in such group, isn't the right policy is to disallow assigning any device
> in this group? Even the barrier is high, any chance of allowing the guest
> to control a system management function is dangerous...

We can advise that it's a risk, but we generally refrain from making
such policy decisions.  Ideally the chipset vendor avoids
configurations that require their users to choose between functionality
and security ;)  Thanks,

Alex


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD67B3A86F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFOQ6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhFOQ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623776166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZvxaMeoVcMZyEFg7QVxXPrZUcScONdAV0vv4yiFQ3I=;
        b=QhSUVWA3Ao/GrAvtECBpz/ze/pVeI7s51bRVJ4DyXwEqMw8X2QlqWzOqCpmlEGqnsUghvu
        cxvdmXNAQJUhEZ5tDUk90jwqttR1wphiALJ+sdJZHxBq0sla99qjNdZhlA1Mi+Sjr9g8YX
        zJr1hBSSYK7hWk0siWUwad7/Oe3svoI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-hGttLU6oNkuRvOb8DJtB0g-1; Tue, 15 Jun 2021 12:56:05 -0400
X-MC-Unique: hGttLU6oNkuRvOb8DJtB0g-1
Received: by mail-ot1-f72.google.com with SMTP id n4-20020a9d6f040000b029041298cb18cdso7576286otq.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=tZvxaMeoVcMZyEFg7QVxXPrZUcScONdAV0vv4yiFQ3I=;
        b=GdoCSsR6l0iXAy6QFEsgUVeLM0pMrIm5c+vC2V0hfE+9sn+CxiFHMykX20e+xzwirN
         1fFY5myyE4gxoGM7DYbDPFthKyYZw17i7qGzOrtN0IFO3R5OnoTIJlNKhA4oAFd1fCYd
         KXg1WH4SZOyypLBpfDEaCaCaua8kaFQ58or4NSsW4ae1PVPQ3O/J6V5Ttlu5c8nYP2AY
         kqPmQ5abeNfLEZ+XxdTOm7ZCdMiA2f7Gp32LczDvAQqiv3goi45Xk4wVEbkRLu0m3i7t
         HDc+8H0rqNLwOLgmF+POvO1vjaWiqE9RocdR08tVuBZOnszW8TSZuSiRqwQh7OhJJBfm
         SVrA==
X-Gm-Message-State: AOAM532NLTxHuZLv1+T12HYIwrfWC3oBo1EtU2G3G5/cwwZZG75sDL5D
        jyPG9qTdmf5BndSAq4m7jEvy+WP3AK/WBRVm99E6uTV5SyxeKRl+kqZERBlbrfLTT0cmppLLT3K
        WcTRdvgj2R3eaEQmJRQ3hFx3/
X-Received: by 2002:a05:6830:1643:: with SMTP id h3mr226895otr.76.1623776164388;
        Tue, 15 Jun 2021 09:56:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySTCQEIkpHgxR7ihbT8TXIfNDOtXfaAzp/M9djykvPAQhJp1svTbBP66qBFBmasifCO52RQA==
X-Received: by 2002:a05:6830:1643:: with SMTP id h3mr226864otr.76.1623776164075;
        Tue, 15 Jun 2021 09:56:04 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id n21sm1462475oig.18.2021.06.15.09.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:56:03 -0700 (PDT)
Date:   Tue, 15 Jun 2021 10:56:01 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        David Gibson <david@gibson.dropbear.id.au>,
        Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shenming Lu <lushenming@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <20210615105601.4d7b8906.alex.williamson@redhat.com>
In-Reply-To: <MWHPR11MB1886A6B3AC4AD249405E5B178C309@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <YMDC8tOMvw4FtSek@8bytes.org>
        <20210609150009.GE1002214@nvidia.com>
        <YMDjfmJKUDSrbZbo@8bytes.org>
        <20210609101532.452851eb.alex.williamson@redhat.com>
        <20210609102722.5abf62e1.alex.williamson@redhat.com>
        <20210609184940.GH1002214@nvidia.com>
        <20210610093842.6b9a4e5b.alex.williamson@redhat.com>
        <BN6PR11MB187579A2F88C77ED2131CEF08C349@BN6PR11MB1875.namprd11.prod.outlook.com>
        <20210611153850.7c402f0b.alex.williamson@redhat.com>
        <MWHPR11MB1886C2A0A8AA3000EBD5F8E18C319@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210614133819.GH1002214@nvidia.com>
        <MWHPR11MB1886A6B3AC4AD249405E5B178C309@MWHPR11MB1886.namprd11.prod.outlook.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 01:21:35 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Monday, June 14, 2021 9:38 PM
> > 
> > On Mon, Jun 14, 2021 at 03:09:31AM +0000, Tian, Kevin wrote:
> >   
> > > If a device can be always blocked from accessing memory in the IOMMU
> > > before it's bound to a driver or more specifically before the driver
> > > moves it to a new security context, then there is no need for VFIO
> > > to track whether IOASIDfd has taken over ownership of the DMA
> > > context for all devices within a group.  
> > 
> > I've been assuming we'd do something like this, where when a device is
> > first turned into a VFIO it tells the IOMMU layer that this device
> > should be DMA blocked unless an IOASID is attached to
> > it. Disconnecting an IOASID returns it to blocked.  
> 
> Or just make sure a device is in block-DMA when it's unbound from a
> driver or a security context. Then no need to explicitly tell IOMMU layer 
> to do so when it's bound to a new driver.
> 
> Currently the default domain type applies even when a device is not
> bound. This implies that if iommu=passthrough a device is always 
> allowed to access arbitrary system memory with or without a driver.
> I feel the current domain type (identity, dma, unmanged) should apply
> only when a driver is loaded...

Note that vfio does not currently require all devices in the group to
be bound to drivers.  Other devices within the group, those bound to
vfio drivers, can be used in this configuration.  This is not
necessarily recommended though as a non-vfio, non-stub driver binding
to one of those devices can trigger a BUG_ON.

> > > If this works I didn't see the need for vfio to keep the sequence.
> > > VFIO still keeps group fd to claim ownership of all devices in a
> > > group.  
> > 
> > As Alex says you still have to deal with the problem that device A in
> > a group can gain control of device B in the same group.  
> 
> There is no isolation in the group then how could vfio prevent device
> A from gaining control of device B? for example when both are attached
> to the same GPA address space with device MMIO bar included, devA
> can do p2p to devB. It's all user's policy how to deal with devices within
> the group. 

The latter is user policy, yes, but it's a system security issue that
the user cannot use device A to control device B if the user doesn't
have access to both devices, ie. doesn't own the group.  vfio would
prevent this by not allowing access to device A while device B is
insecure and would require that all devices within the group remain in
a secure, user owned state for the extent of access to device A.

> > This means device A and B can not be used from to two different
> > security contexts.  
> 
> It depends on how the security context is defined. From iommu layer
> p.o.v, an IOASID is a security context which isolates a device from
> the rest of the system (but not the sibling in the same group). As you
> suggested earlier, it's completely sane if an user wants to attach
> devices in a group to different IOASIDs. Here I just talk about this fact.

This is sane, yes, but that doesn't give us license to allow the user
to access device A regardless of the state of device B.

> > 
> > If the /dev/iommu FD is the security context then the tracking is
> > needed there.
> >   
> 
> As I replied to Alex, my point is that VFIO doesn't need to know the
> attaching status of each device in a group before it can allow user to
> access a device. As long as a device in a group either in block DMA
> or switch to a new address space created via /dev/iommu FD, there's
> no problem to allow user accessing it. User cannot do harm to the
> world outside of the group. User knows there is no isolation within
> the group. that is it.

This is self contradictory, "vfio doesn't need to know the attachment
status"... "[a]s long as a device in a group either in block DMA or
switch to a new address space".  So vfio does need to know the latter.
How does it know that?  Thanks,

Alex


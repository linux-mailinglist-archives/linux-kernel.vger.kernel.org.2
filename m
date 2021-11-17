Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4D5454C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbhKQR4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:56:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239714AbhKQR4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637171606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZmS4a9DnCGExj2J+v0XrWscfy79HqauTSYXRBCa8T1g=;
        b=AenSlVOntoh4krIfGmgDy61ueCEwLG5QUcceBXDj4w4X4RV25PxZ5NQpobnLh87/x+lYSY
        uB+CezNkG51EYs69+Cy4MbxnjY4DW5PMfJ15+EqgxJ9hJzuZlHL7/rwdw1wZzQGPdoUjEF
        ehioMvOxSSxEkGI8GAtC24L97H86Gh4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-SveFyMDBNs-Lm97RLdXb_Q-1; Wed, 17 Nov 2021 12:53:25 -0500
X-MC-Unique: SveFyMDBNs-Lm97RLdXb_Q-1
Received: by mail-oo1-f69.google.com with SMTP id z48-20020a4a9873000000b002c29a99164cso813926ooi.20
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 09:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZmS4a9DnCGExj2J+v0XrWscfy79HqauTSYXRBCa8T1g=;
        b=0P3Ug9wYj1yID6dxpYsCYx4iFa6NMkqL9kqEO6MI7rEqOb6fiZ6OOlzeDHC79iA+nk
         RXCiKgggt89G1DINPIfbgaJf5MuIbl4aB/NGOqYNgFSMluwPIjpNG5Fnw6DsS98vo0GR
         qBA4yRgJLdmJuwXyZSQqE0cLbSjhFXxDklwIl4fhTIDAcVyfQZmIyMDaJK2NuhcDw+iH
         qAiqoj8uuazAP10nv3b+6NXfmtkivAuFYDlXm+HabKE2xya2ZrdC5M/u63f2WEJ2mMaX
         un9aFpDnVvV1Rn1wdkqouI52QStZZfgC5VknHzPUC1NESi7hUJUKfr/XKlsMIRT2Mafu
         vs5w==
X-Gm-Message-State: AOAM532VNIR12Cw3K658V1RQz7EWsyLxMlYc2OJB24csOsOMK6dNmnuY
        YxP0OFCicGu9aeG2jx16DoF8P6uoyON6w2V3vdRx7abba5U/wPqjVsuq5uMiKOBkQWYoDk96yX6
        JPvZi4lxh1OZy2KnMeyXDEAOk
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr15782754otn.299.1637171604713;
        Wed, 17 Nov 2021 09:53:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyw2vPkIqg6l0lVLyTbtslIT2ZyZA2oL+icLUZeXOnq6qKTbBpjK5IVYv6lHOU9sv5XYmecUw==
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr15782713otn.299.1637171604352;
        Wed, 17 Nov 2021 09:53:24 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id o2sm114156oiv.32.2021.11.17.09.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 09:53:24 -0800 (PST)
Date:   Wed, 17 Nov 2021 10:53:23 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     <abhsahu@nvidia.com>
Cc:     <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 3/3] vfio/pci: use runtime PM for vfio-device into low
 power state
Message-ID: <20211117105323.2866b739.alex.williamson@redhat.com>
In-Reply-To: <20211115133640.2231-4-abhsahu@nvidia.com>
References: <20211115133640.2231-1-abhsahu@nvidia.com>
        <20211115133640.2231-4-abhsahu@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 19:06:40 +0530
<abhsahu@nvidia.com> wrote:

> From: Abhishek Sahu <abhsahu@nvidia.com>
>=20
> Currently, if the runtime power management is enabled for vfio-pci
> device in guest OS, then guest OS will do the register write for
> PCI_PM_CTRL register. This write request will be handled in
> vfio_pm_config_write() where it will do the actual register write of
> PCI_PM_CTRL register. With this, the maximum D3hot state can be
> achieved for low power. If we can use the runtime PM framework, then
> we can achieve the D3cold state which will help in saving
> maximum power.
>=20
> This patch uses runtime PM framework whenever vfio-pci device will
> be put in the low power state.
>=20
> 1. If runtime PM is enabled, then instead of directly writing
>    PCI_PM_CTRL register, decrement the device usage counter whenever
>    the power state is non-D0. The kernel runtime PM framework will
>    itself put the PCI device in low power state when device usage
>    counter will become zero. Similarly, when the power state will be
>    again changed back to D0, then increment the device usage counter
>    and the kernel runtime PM framework will itself bring the PCI device
>    out of low power state.
>=20
> 2. The guest OS will read the PCI_PM_CTRL register back to
>    confirm the current power state so virtual register bits can be
>    used. For this, before decrementing the usage count, read the actual
>    PCI_PM_CTRL register, update the power state related bits, and then
>    update the vconfig bits corresponding to PCI_PM_CTRL offset. For
>    PCI_PM_CTRL register read, return the virtual value if runtime PM is
>    requested. This vconfig bits will be cleared when the power state
>    will be changed back to D0.
>=20
> 3. For the guest OS, the PCI power state will be still D3hot
>    even if put the actual PCI device into D3cold state. In the D3hot
>    state, the config space can still be read. So, if there is any request
>    from guest OS to read the config space, then we need to move the actual
>    PCI device again back to D0. For this, increment the device usage
>    count before reading/writing the config space and then decrement it
>    again after reading/writing the config space. There can be
>    back-to-back config register read/write request, but since the auto
>    suspend methods are being used here so only first access will
>    wake up the PCI device and for the remaining access, the device will
>    already be active.
>=20
> 4. This above-mentioned wake up is not needed if the register
>    read/write is done completely with virtual bits. For handling this
>    condition, the actual resume of device will only being done in
>    vfio_user_config_read()/vfio_user_config_write(). All the config
>    register access will come vfio_pci_config_rw(). So, in this
>    function, use the pm_runtime_get_noresume() so that only usage count
>    will be incremented without resuming the device. Inside,
>    vfio_user_config_read()/vfio_user_config_write(), use the routines
>    with pm_runtime_put_noidle() so that the PCI device won=E2=80=99t be
>    suspended in the lower level functions. Again in the top level
>    vfio_pci_config_rw(), use the pm_runtime_put_autosuspend(). Now the
>    auto suspend timer will be started and the device will be suspended
>    again. If the device is already runtime suspended, then this routine
>    will return early.
>=20
> 5. In the host side D3cold will only be used if the platform has
>    support for this, otherwise some other state will be used. The
>    config space can be read if the device is not in D3cold state. So in
>    this case, we can skip the resuming of PCI device. The wrapper
>    function vfio_pci_config_pm_runtime_get() takes care of this
>    condition and invoke the pm_runtime_resume() only if current power
>    state is D3cold.
>=20
> 6. For vfio_pci_config_pm_runtime_get()/vfio_
>    pci_config_pm_runtime_put(), the reference code is taken from
>    pci_config_pm_runtime_get()/pci_config_pm_runtime_put() and then it
>    is modified according to vfio-pci driver requirement.
>=20
> 7. vfio_pci_set_power_state() will be unused after moving to runtime
>    PM, so this function can be removed along with other related
>    functions and structure fields.


If we're transitioning a device to D3cold rather than D3hot as
requested by userspace, isn't that a user visible change?  For
instance, a device may report NoSoftRst- indicating that the device
does not do a soft reset on D3hot->D0 transition.  If we're instead
putting the device in D3cold, then a transition back to D0 has very
much undergone a reset.  On one hand we should at least virtualize the
NoSoftRst bit to allow the guest to restore the device, but I wonder if
that's really safe.  Is a better option to prevent entering D3cold if
the device isn't natively reporting NoSoftRst-?

We're also essentially making a policy decision on behalf of userspace
that favors power saving over latency.  Is that universally the correct
trade-off?  I can imagine this could be desirable for many use cases,
but if we're going to covertly replace D3hot with D3cold, it seems like
there should be an opt-in.  Is co-opting the PM capability for this
even really acceptable or should there be a device ioctl to request
D3cold and plumbing through QEMU such that a VM guest can make informed
choices regarding device power management?

Also if the device is not responsive to config space due to the user
placing it in D3 now, I'd expect there are other ioctl paths that need
to be blocked, maybe even MMIO paths that might be a gap for existing
D3hot support.  Thanks,

Alex


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5951A408535
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbhIMHTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237535AbhIMHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631517466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W/UgMoz82E5YjcGsc6k/qQwRZzRrj58b5T4UM7UHZKM=;
        b=GikMjgs04WDiTwwkFgWbLshKAmUwSYyw0mdW0b1lBBLstkSY5lCl/h0dod3l8l6E6qJvSr
        WLfCLCikjg2Wrfsx+P2PsJKTYbmQlv1GFf6ccwCuN1uT3Wm3g83xhba9UlsoG5jO85kHhe
        VlLWXxqbP5BzBqQrkAyse35mwRXPEL0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-SSxITBoVNdaZTLPXIgBN9A-1; Mon, 13 Sep 2021 03:17:44 -0400
X-MC-Unique: SSxITBoVNdaZTLPXIgBN9A-1
Received: by mail-lj1-f198.google.com with SMTP id e10-20020a05651c04ca00b001c99c74e564so3764216lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/UgMoz82E5YjcGsc6k/qQwRZzRrj58b5T4UM7UHZKM=;
        b=luFJ3IRCqzJvgCEgWt98AkHmksTtpEJMX5OU62bbMlANujzfVmoPQCMfAS0IP4O7Gt
         H9ycoruHM5wHtc/ZEZBzM0rFg3gh8IZecTMP8AWirIrcexmJ71W/5+YqkzbLwlUIQZ9v
         TFUEidzZYYfA2H6AtPG3lBAB2OSLgR+7x7835IQGCudLaMjrUwjSBRJIynXwFz5epnXD
         sXgQgrJfcc8J8GtnKQK/Qb3VnQ+DhOw6W2BqExclU1+i5GGjPqU51ol+ZZGEcBluTNzr
         bzA/jr4HPFdCEGEYya3ld0gcabbwqzSoZ9hRTZ8l0Udr2GTmDGQe6wz+enu5G9+itHqV
         sF3A==
X-Gm-Message-State: AOAM531Lx7nsNWWTvQ/q/k6wY58FWJKZyVAaqrhqidRJDZgQPVbiNhCE
        nV8DQ/WPB9f5uWRsDEK10fN9PY/+xJXaecjXtXOBlBK39X1/eNDck3/TonHH86CzFO7Vf7xEVcC
        4cdbG9n4npBHTbLfo5i/wAQXiqUoppY8QnRt8sRab
X-Received: by 2002:a2e:89c9:: with SMTP id c9mr9402809ljk.107.1631517463269;
        Mon, 13 Sep 2021 00:17:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT/V5PckfPGcvXXTm3FYDYDShi+9elBLuSke1ixt38qlK3JPy4gkcPD2/EZpeMxS4UPNz4xEuPi9C5JfC1x5w=
X-Received: by 2002:a2e:89c9:: with SMTP id c9mr9402793ljk.107.1631517463054;
 Mon, 13 Sep 2021 00:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com> <20210913055353.35219-8-jasowang@redhat.com>
 <20210913022824-mutt-send-email-mst@kernel.org> <CACGkMEtnmLzQDNVYnAYSsEmjjRJVDhuK6VNj56S__zU9+5-JQQ@mail.gmail.com>
 <20210913023757-mutt-send-email-mst@kernel.org> <CACGkMEskmq7azAP6QiNz=_nXaU6vbtr975wk3kr9H6pOGs-ZuQ@mail.gmail.com>
 <20210913030134-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210913030134-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 13 Sep 2021 15:17:32 +0800
Message-ID: <CACGkMEtcmGJhs=ft-0_rYQ7ctWsdxvd=BuHM_dR2MZXNxy9Tig@mail.gmail.com>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 3:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 13, 2021 at 02:45:38PM +0800, Jason Wang wrote:
> > On Mon, Sep 13, 2021 at 2:41 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 13, 2021 at 02:36:54PM +0800, Jason Wang wrote:
> > > > On Mon, Sep 13, 2021 at 2:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Sep 13, 2021 at 01:53:51PM +0800, Jason Wang wrote:
> > > > > > This patch tries to make sure the virtio interrupt handler for INTX
> > > > > > won't be called after a reset and before virtio_device_ready(). We
> > > > > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > > > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > > > > intx_soft_enabled variable and toggle it during in
> > > > > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > > > > intx_soft_enabled before processing the actual interrupt.
> > > > > >
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > >
> > > > >
> > > > > Not all that excited about all the memory barriers for something
> > > > > that should be an extremely rare event (for most kernels -
> > > > > literally once per boot). Can't we do better?
> > > >
> > > > I'm not sure, but do we need to care about the slow path (INTX)?
> > >
> > > Otherwise we won't try to support this, right?
> >
> > Sorry, what I meant is "do we need to care about the performance of
> > the slow path".
> >
> > >
> > > > (Or do you have a better approach?)
> > > >
> > > > Thanks
> > >
> > > Don't know really, maybe rcu or whatever?
> >
> > I am sure it's worth it to bother since it's the slow path.
> >
> > > But let's try to be much more specific - is there anything
> > > specific we are trying to protect against here?
> >
> > The unexpected calling of the vring or config interrupt handler. (The
> > same as MSI-X, e.g the untrusted device can send irq at any time).
> >
> > Thanks
>
> And so, does this do more than crash the guest?  Hypervisors
> already can do that ...

Yes, so for DOS and shutdown it should be fine, but for other kinds of
crash, it would be very hard to say what can happen (e.g manipulating
SWIOTLB or page table etc). So it's better to avoid non DOS crashes.

Thanks

>
>
> > >
> > >
> > >
> > > > >
> > > > > > ---
> > > > > >  drivers/virtio/virtio_pci_common.c | 18 ++++++++++++++++--
> > > > > >  drivers/virtio/virtio_pci_common.h |  1 +
> > > > > >  2 files changed, 17 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > > index 0b9523e6dd39..835197151dc1 100644
> > > > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > > > @@ -30,8 +30,12 @@ void vp_disable_vectors(struct virtio_device *vdev)
> > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > >       int i;
> > > > > >
> > > > > > -     if (vp_dev->intx_enabled)
> > > > > > +     if (vp_dev->intx_enabled) {
> > > > > > +             vp_dev->intx_soft_enabled = false;
> > > > > > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > > > > > +             smp_wmb();
> > > > > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > > > > +     }
> > > > > >
> > > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > @@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
> > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > >       int i;
> > > > > >
> > > > > > -     if (vp_dev->intx_enabled)
> > > > > > +     if (vp_dev->intx_enabled) {
> > > > > > +             vp_dev->intx_soft_enabled = true;
> > > > > > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > > > > > +             smp_wmb();
> > > > > >               return;
> > > > > > +     }
> > > > > >
> > > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > @@ -97,6 +105,12 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> > > > > >       struct virtio_pci_device *vp_dev = opaque;
> > > > > >       u8 isr;
> > > > > >
> > > > > > +     if (!vp_dev->intx_soft_enabled)
> > > > > > +             return IRQ_NONE;
> > > > > > +
> > > > > > +     /* read intx_soft_enabled before read others */
> > > > > > +     smp_rmb();
> > > > > > +
> > > > > >       /* reading the ISR has the effect of also clearing it so it's very
> > > > > >        * important to save off the value. */
> > > > > >       isr = ioread8(vp_dev->isr);
> > > > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > > > index a235ce9ff6a5..3c06e0f92ee4 100644
> > > > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > > > @@ -64,6 +64,7 @@ struct virtio_pci_device {
> > > > > >       /* MSI-X support */
> > > > > >       int msix_enabled;
> > > > > >       int intx_enabled;
> > > > > > +     bool intx_soft_enabled;
> > > > > >       cpumask_var_t *msix_affinity_masks;
> > > > > >       /* Name strings for interrupts. This size should be enough,
> > > > > >        * and I'm too lazy to allocate each name separately. */
> > > > > > --
> > > > > > 2.25.1
> > > > >
> > >
>


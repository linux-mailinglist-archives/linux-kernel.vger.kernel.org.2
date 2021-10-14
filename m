Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68C842D084
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhJNCiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhJNCiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634178964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fRcbe8WIYnw7cXDZRZpjRzCl36aRJMr9VWR6QW5LLsg=;
        b=YxP5P4t1FXacmS73RzOGPWlNdXCfDZdKUbp6kgHS0TG5f2qWVMz0987vQ4PPFieHtm0oJB
        KDKn39W0l0EuDYTY/g4Apve+OBTkJM/h0fCf/dOa5cslk0GOTuyjxDn0NVyo5m2PSKWfGP
        kvxz5gEXDddRp2ryUgxyl9hP4Yogs5w=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-csFY5av-OS6ta1nJ481nIw-1; Wed, 13 Oct 2021 22:36:03 -0400
X-MC-Unique: csFY5av-OS6ta1nJ481nIw-1
Received: by mail-lf1-f71.google.com with SMTP id k8-20020a0565123d8800b003fd6e160c77so3316574lfv.17
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRcbe8WIYnw7cXDZRZpjRzCl36aRJMr9VWR6QW5LLsg=;
        b=tr3ns4e94Um3nUMX7PA9hdr8p51q0tT8tCsde94OK8NFCYZRbCyA05ftnzIXJ+hXz4
         MB4PWkbqn8gN+rR0gdyH17io+lX8ckK+QagpGmgkRTlG0ETLQUqzhODu9rCDEDdTfcAT
         kWzS+ddO9oy6zSo3I1Tn1mHJBCmDXb9QU1d0NeSzVjRAN/YlpZNOCmVlT4Wv1IO+OBhx
         VSgagBO/X41Auk+mbTwKiFxLS2VFDoPc+0dVJQ86ruNC0QPsKprZXUYcmU96WQHVOqu3
         YTvQGvi0xxELcEAiM3NlcYTy3FTgP67d3XokKU/DsOPrS2dcw4vH24s+QtqJLx+YlTIx
         GyZA==
X-Gm-Message-State: AOAM531nUOVOYFlTkhGmPzDQva/0dNZaEAxUuiHI2FDGSjaU8p/ugRJM
        xDP+EMbfBc9YuVFMcWaq5waVglTa6Iux86vuF7TdT9SaJH6dLCXF1/A+RWH3NFtAeFtIz5YjBHI
        qySFUT4GES9d1ouwNcZcrj9aL29T/H2P0iTp9gUpT
X-Received: by 2002:a2e:8099:: with SMTP id i25mr3221899ljg.277.1634178961844;
        Wed, 13 Oct 2021 19:36:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBvr7aDWM7r6lk+wF33bxkLrS0BzM/vTPjwLcQmBvul9e4TVUkv+qhhNr0wI3WHaDebhczdB2HdDfeLmL4/FQ=
X-Received: by 2002:a2e:8099:: with SMTP id i25mr3221883ljg.277.1634178961702;
 Wed, 13 Oct 2021 19:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com> <20211012065227.9953-8-jasowang@redhat.com>
 <20211013053627-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211013053627-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 14 Oct 2021 10:35:48 +0800
Message-ID: <CACGkMEuRHKJv73oKFNetcBkPSFj034te7N_AJZdRbHe0ObU4Gw@mail.gmail.com>
Subject: Re: [PATCH V2 07/12] virtio-pci: harden INTX interrupts
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 5:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 02:52:22PM +0800, Jason Wang wrote:
> > This patch tries to make sure the virtio interrupt handler for INTX
> > won't be called after a reset and before virtio_device_ready(). We
> > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > intx_soft_enabled variable and toggle it during in
> > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > intx_soft_enabled before processing the actual interrupt.
> >
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++++++--
> >  drivers/virtio/virtio_pci_common.h |  1 +
> >  2 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index 0b9523e6dd39..5ae6a2a4eb77 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -30,8 +30,16 @@ void vp_disable_vectors(struct virtio_device *vdev)
> >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >       int i;
> >
> > -     if (vp_dev->intx_enabled)
> > +     if (vp_dev->intx_enabled) {
> > +             /*
> > +              * The below synchronize() guarantees that any
> > +              * interrupt for this line arriving after
> > +              * synchronize_irq() has completed is guaranteed to see
> > +              * intx_soft_enabled == false.
> > +              */
> > +             WRITE_ONCE(vp_dev->intx_soft_enabled, false);
> >               synchronize_irq(vp_dev->pci_dev->irq);
> > +     }
> >
> >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > @@ -43,8 +51,16 @@ void vp_enable_vectors(struct virtio_device *vdev)
> >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >       int i;
> >
> > -     if (vp_dev->intx_enabled)
> > +     if (vp_dev->intx_enabled) {
> > +             disable_irq(vp_dev->pci_dev->irq);
> > +             /*
> > +              * The above disable_irq() provides TSO ordering and
> > +              * as such promotes the below store to store-release.
> > +              */
> > +             WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> > +             enable_irq(vp_dev->pci_dev->irq);
> >               return;
> > +     }
> >
> >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > @@ -97,6 +113,10 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> >       struct virtio_pci_device *vp_dev = opaque;
> >       u8 isr;
> >
> > +     /* read intx_soft_enabled before read others */
> > +     if (!smp_load_acquire(&vp_dev->intx_soft_enabled))
> > +             return IRQ_NONE;
> > +
> >       /* reading the ISR has the effect of also clearing it so it's very
> >        * important to save off the value. */
> >       isr = ioread8(vp_dev->isr);
>
> I don't see why we need this ordering guarantee here.
>
> synchronize_irq above makes sure no interrupt handler
> is in progress.

Yes.

> the handler itself thus does not need
> any specific order, it is ok if intx_soft_enabled is read
> after, not before the rest of it.

But the interrupt could be raised after synchronize_irq() which may
see a false of the intx_soft_enabled. In this case we still need the
make sure intx_soft_enbled to be read first instead of allowing other
operations to be done first, otherwise the intx_soft_enabled is
meaningless.

Thanks

>
> Just READ_ONCE should be enough, and we can drop the comment.
>
>
> > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > index a235ce9ff6a5..3c06e0f92ee4 100644
> > --- a/drivers/virtio/virtio_pci_common.h
> > +++ b/drivers/virtio/virtio_pci_common.h
> > @@ -64,6 +64,7 @@ struct virtio_pci_device {
> >       /* MSI-X support */
> >       int msix_enabled;
> >       int intx_enabled;
> > +     bool intx_soft_enabled;
> >       cpumask_var_t *msix_affinity_masks;
> >       /* Name strings for interrupts. This size should be enough,
> >        * and I'm too lazy to allocate each name separately. */
> > --
> > 2.25.1
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2D542D5F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhJNJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhJNJ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634203509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xiLOxZ+5z33pX5MFO5if8n8kPjpaQMQgy6mlttqKZ3U=;
        b=eWgTz3v7HlnZDZ3dE6wa2aiX8yLnajwe2rS0aJYCPs7MP2nlHtLoeo6Rst5z2YaEoSJecz
        TDoxV2MceV1ZD7AQDi+ZAQKZlGmfoBYxgpGiHen6YHOQQrfVFdj1c8N+KiRfgSF8mCDUTS
        oP8b22x0Ros7XCQD6TxlzZpSG/kcPpI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-R5SScqKTPmOUH6oI-Mi9DA-1; Thu, 14 Oct 2021 05:25:08 -0400
X-MC-Unique: R5SScqKTPmOUH6oI-Mi9DA-1
Received: by mail-ed1-f70.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso4654621edf.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xiLOxZ+5z33pX5MFO5if8n8kPjpaQMQgy6mlttqKZ3U=;
        b=B7faNrqb3QFQ+MmZyPWzjksUyWgDVIvzdWFjhCvSHailwbU7Ft4p4zXsnseSRerM5q
         zHixiUOTU4EXBhd99zhrR6Z2WANVBHYDdyVxdi6evMzdQ41gNeNmzDW2AVjAU/tfIMlA
         pIr50Kh0KAeyH7Y0l1rf2jt3W1IV7E6hA7KGVYgC6G/np8RwZB305lwZaIlVzv9tUkAA
         WsqQqntQIA66X3A99NyDW+tPNRmknjiggx3m46cqj8z+9HpXX45fJw+uBronjEaGkC8j
         efC6++VVeW0oMP8EUTCbpdKexTJ+OZ5yOVbz8afQlrQFf33BeRy1mVcO4EQr67NLLr/1
         xOuA==
X-Gm-Message-State: AOAM530YyoMXyGIP0itbYg9ckMpgndtFfkmD5oYRARGLIDGF7qS4Y0c5
        RtsZP0IY0VnhbU3+c13vfvN7yK/vgzmty/YBiJcEWDIBhsia57W1m9P6XdxEhTBWVCa0d97QktJ
        GIaOrtuJPokL+SKtR5/tT2m3v
X-Received: by 2002:a17:907:77c8:: with SMTP id kz8mr2412062ejc.188.1634203507126;
        Thu, 14 Oct 2021 02:25:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxl+T8R/C3xSrlHcN9bOhMoODWG9RrhxIjg9UliIh4QUIfbiSvv/P7e/2iU8RPrHKrvdd6QVg==
X-Received: by 2002:a17:907:77c8:: with SMTP id kz8mr2412039ejc.188.1634203506877;
        Thu, 14 Oct 2021 02:25:06 -0700 (PDT)
Received: from redhat.com ([2.55.16.227])
        by smtp.gmail.com with ESMTPSA id 6sm1478664ejx.82.2021.10.14.02.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 02:25:06 -0700 (PDT)
Date:   Thu, 14 Oct 2021 05:25:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH V2 07/12] virtio-pci: harden INTX interrupts
Message-ID: <20211014052435-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-8-jasowang@redhat.com>
 <20211013053627-mutt-send-email-mst@kernel.org>
 <CACGkMEuRHKJv73oKFNetcBkPSFj034te7N_AJZdRbHe0ObU4Gw@mail.gmail.com>
 <20211014014551-mutt-send-email-mst@kernel.org>
 <CACGkMEvB4sMPmMmPQmHFasGLwktyXuCenQKGuoajmoFQYJJeBQ@mail.gmail.com>
 <20211014022438-mutt-send-email-mst@kernel.org>
 <CACGkMEsPiHee5A=JymA+RpaN+xqbpw=hU=or29hrHCDk=TK+Hw@mail.gmail.com>
 <20211014025815-mutt-send-email-mst@kernel.org>
 <CACGkMEtS1QWita4uKsR0bZOuSk5QnGkD47AwL5-cx=70=MQp-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtS1QWita4uKsR0bZOuSk5QnGkD47AwL5-cx=70=MQp-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 03:12:54PM +0800, Jason Wang wrote:
> On Thu, Oct 14, 2021 at 3:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Oct 14, 2021 at 02:32:19PM +0800, Jason Wang wrote:
> > > On Thu, Oct 14, 2021 at 2:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Oct 14, 2021 at 02:20:17PM +0800, Jason Wang wrote:
> > > > > On Thu, Oct 14, 2021 at 1:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 14, 2021 at 10:35:48AM +0800, Jason Wang wrote:
> > > > > > > On Wed, Oct 13, 2021 at 5:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Oct 12, 2021 at 02:52:22PM +0800, Jason Wang wrote:
> > > > > > > > > This patch tries to make sure the virtio interrupt handler for INTX
> > > > > > > > > won't be called after a reset and before virtio_device_ready(). We
> > > > > > > > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > > > > > > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > > > > > > > intx_soft_enabled variable and toggle it during in
> > > > > > > > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > > > > > > > intx_soft_enabled before processing the actual interrupt.
> > > > > > > > >
> > > > > > > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++++++--
> > > > > > > > >  drivers/virtio/virtio_pci_common.h |  1 +
> > > > > > > > >  2 files changed, 23 insertions(+), 2 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > > > > > index 0b9523e6dd39..5ae6a2a4eb77 100644
> > > > > > > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > > > > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > > > > > > @@ -30,8 +30,16 @@ void vp_disable_vectors(struct virtio_device *vdev)
> > > > > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > > >       int i;
> > > > > > > > >
> > > > > > > > > -     if (vp_dev->intx_enabled)
> > > > > > > > > +     if (vp_dev->intx_enabled) {
> > > > > > > > > +             /*
> > > > > > > > > +              * The below synchronize() guarantees that any
> > > > > > > > > +              * interrupt for this line arriving after
> > > > > > > > > +              * synchronize_irq() has completed is guaranteed to see
> > > > > > > > > +              * intx_soft_enabled == false.
> > > > > > > > > +              */
> > > > > > > > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, false);
> > > > > > > > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > > > > > > > +     }
> > > > > > > > >
> > > > > > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > > > > >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > > > > @@ -43,8 +51,16 @@ void vp_enable_vectors(struct virtio_device *vdev)
> > > > > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > > >       int i;
> > > > > > > > >
> > > > > > > > > -     if (vp_dev->intx_enabled)
> > > > > > > > > +     if (vp_dev->intx_enabled) {
> > > > > > > > > +             disable_irq(vp_dev->pci_dev->irq);
> > > > > > > > > +             /*
> > > > > > > > > +              * The above disable_irq() provides TSO ordering and
> > > > > > > > > +              * as such promotes the below store to store-release.
> > > > > > > > > +              */
> > > > > > > > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> > > > > > > > > +             enable_irq(vp_dev->pci_dev->irq);
> > > > > > > > >               return;
> > > > > > > > > +     }
> > > > > > > > >
> > > > > > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > > > > >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > > > > @@ -97,6 +113,10 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> > > > > > > > >       struct virtio_pci_device *vp_dev = opaque;
> > > > > > > > >       u8 isr;
> > > > > > > > >
> > > > > > > > > +     /* read intx_soft_enabled before read others */
> > > > > > > > > +     if (!smp_load_acquire(&vp_dev->intx_soft_enabled))
> > > > > > > > > +             return IRQ_NONE;
> > > > > > > > > +
> > > > > > > > >       /* reading the ISR has the effect of also clearing it so it's very
> > > > > > > > >        * important to save off the value. */
> > > > > > > > >       isr = ioread8(vp_dev->isr);
> > > > > > > >
> > > > > > > > I don't see why we need this ordering guarantee here.
> > > > > > > >
> > > > > > > > synchronize_irq above makes sure no interrupt handler
> > > > > > > > is in progress.
> > > > > > >
> > > > > > > Yes.
> > > > > > >
> > > > > > > > the handler itself thus does not need
> > > > > > > > any specific order, it is ok if intx_soft_enabled is read
> > > > > > > > after, not before the rest of it.
> > > > > > >
> > > > > > > But the interrupt could be raised after synchronize_irq() which may
> > > > > > > see a false of the intx_soft_enabled.
> > > > > >
> > > > > > You mean a "true" value right? false is what we are writing there.
> > > > >
> > > > > I meant that we want to not go for stuff like vq->callback after the
> > > > > synchronize_irq() after setting intx_soft_enabled to false. Otherwise
> > > > > we may get unexpected results like use after free. Host can craft ISR
> > > > > in this case.
> > > > > >
> > > > > > Are you sure it can happen? I think that synchronize_irq makes the value
> > > > > > visible on all CPUs running the irq.
> > > > >
> > > > > Yes, so the false is visible by vp_interrupt(), we can't do the other
> > > > > task before we check intx_soft_enabled.
> > > >
> > > > But the order does not matter. synchronize_irq will make sure
> > > > everything is visible.
> > >
> > > Not the thing that happens after synchronize_irq().
> > >
> > > E.g for remove_vq_common():
> > >
> > > static void remove_vq_common(struct virtnet_info *vi)
> > > {
> > >         vi->vdev->config->reset(vi->vdev);
> > >
> > >         /* Free unused buffers in both send and recv, if any. */
> > >         free_unused_bufs(vi);
> > >
> > >         free_receive_bufs(vi);
> > >
> > >         free_receive_page_frags(vi);
> > >
> > >         virtnet_del_vqs(vi);
> > > }
> > >
> > > The interrupt could be raised by the device after .reset().
> > >
> > > Thanks
> >
> > That's why your patches set intx_soft_enabled to false within reset.
> > Then you sync so all other CPUs see the false value.
> > Then it's ok to proceed with reset.
> > What does the interrupt handler *do* with the value
> > does not matter as long as it sees that it is false.
> 
> I'm not sure I get here, if we allow the interrupt handler to access
> the vq before checking intx_soft_enabled, won't there be a
> use-after-free?

It's a speculative access, not an architectural one.

> >
> > OTOH if you are really worried about spectre type speculative attacks,
> > that is a different matter, and would force us to stick expensive
> > barriers around hardware accessible buffers just like we have in
> > copy_XXX_user. I am not sure this is in scope for TDX, and
> > certainly out of scope for regular driver ardening.
> > If yes worth hiding that behind a kernel option.
> 
> Right.
> 
> Thanks
> 
> >
> >
> > > >
> > > > > >
> > > > > > > In this case we still need the
> > > > > > > make sure intx_soft_enbled to be read first instead of allowing other
> > > > > > > operations to be done first, otherwise the intx_soft_enabled is
> > > > > > > meaningless.
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > If intx_soft_enbled were not visible after synchronize_irq then
> > > > > > it does not matter in which order we read it wrt other values,
> > > > > > it still wouldn't work right.
> > > > >
> > > > > Yes.
> > > > >
> > > > > Thanks
> > > >
> > > >
> > > > We are agreed then? No need for a barrier here, READ_ONCE is enough?
> > > >
> > > > > >
> > > > > > > >
> > > > > > > > Just READ_ONCE should be enough, and we can drop the comment.
> > > > > > > >
> > > > > > > >
> > > > > > > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > > > > > > index a235ce9ff6a5..3c06e0f92ee4 100644
> > > > > > > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > > > > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > > > > > > @@ -64,6 +64,7 @@ struct virtio_pci_device {
> > > > > > > > >       /* MSI-X support */
> > > > > > > > >       int msix_enabled;
> > > > > > > > >       int intx_enabled;
> > > > > > > > > +     bool intx_soft_enabled;
> > > > > > > > >       cpumask_var_t *msix_affinity_masks;
> > > > > > > > >       /* Name strings for interrupts. This size should be enough,
> > > > > > > > >        * and I'm too lazy to allocate each name separately. */
> > > > > > > > > --
> > > > > > > > > 2.25.1
> > > > > > > >
> > > > > >
> > > >
> >


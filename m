Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC41C42D205
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 07:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhJNFwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 01:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhJNFwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 01:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634190602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVSsxXTqUF8SgEcg1VdRpaSfaT15nzOVvL9iycEb81M=;
        b=iT3SBOuftaj3ty0oyv73oOVdVGqnnrun3PMpIIHcAaQAGBSPQIaO40xuh0fns6BGTw9rMK
        xxVAypmsqC9R2YMryb0FJj60iy3QRlrsIJ34pHiWgJB/ykmCuwJ2T0t2nzMq+gyeOIUzrI
        F0EdG0Mh/0uKxEnxC8HEokt6uXMqFLM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-G_ZRtCtWOUqcc_mbHt2itg-1; Thu, 14 Oct 2021 01:50:01 -0400
X-MC-Unique: G_ZRtCtWOUqcc_mbHt2itg-1
Received: by mail-ed1-f70.google.com with SMTP id d3-20020a056402516300b003db863a248eso4205644ede.16
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 22:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kVSsxXTqUF8SgEcg1VdRpaSfaT15nzOVvL9iycEb81M=;
        b=Po/pdkHIwz804Y0y7JGApBoCZnrWgoTjZKXZGw6wM0aCyxhsJq0I6J884vdE01tqex
         xCW3yP7tV2lR2RaOzZkFR9O7mYFoKykD2EricUpiZIsd8/5kSz/9PB/B7rLi2cujTxXp
         oMy8M4tdvYlNKMevooLGjonRFILm61A4julPlVx7i6XiVp8Awf34ZOTWFmdoie0teIGH
         IPlcbMCrhKeWKHd11cdkbsC7J17v0a30TOkjtEDGwaApTvCdyAn/rCZIDnbT5qo7rRe/
         TegVllIIw8DE0p+HaPnPI5GjCbJGXP+NPZ5xhiqLfwbJG194BoJtXP97C78FuKgzrsYJ
         SMvg==
X-Gm-Message-State: AOAM531zYGOtAHfosH/v3X2UaFzjPsaIfpACvOQK65jgJe+cHf7Gwn2r
        DDdXULIcJb070jZpWNANemW1/2w/i/kTRHJnu8hqzGAKKobE6vkMCJblgGHCKq0mmoOr7mdhSJB
        23kYtoLtHEGNwoT/zAookQJaG
X-Received: by 2002:a17:906:1c03:: with SMTP id k3mr1384546ejg.562.1634190599747;
        Wed, 13 Oct 2021 22:49:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFOckRJp+uOn9m6c3TPfTw2gelsUrkP7Gyhoffoo3myEf1ta/SG7S3ClgjdMVibRoSVifWjg==
X-Received: by 2002:a17:906:1c03:: with SMTP id k3mr1384531ejg.562.1634190599603;
        Wed, 13 Oct 2021 22:49:59 -0700 (PDT)
Received: from redhat.com ([2.55.16.227])
        by smtp.gmail.com with ESMTPSA id ox9sm1064142ejb.66.2021.10.13.22.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 22:49:58 -0700 (PDT)
Date:   Thu, 14 Oct 2021 01:49:54 -0400
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
Message-ID: <20211014014551-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-8-jasowang@redhat.com>
 <20211013053627-mutt-send-email-mst@kernel.org>
 <CACGkMEuRHKJv73oKFNetcBkPSFj034te7N_AJZdRbHe0ObU4Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuRHKJv73oKFNetcBkPSFj034te7N_AJZdRbHe0ObU4Gw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 10:35:48AM +0800, Jason Wang wrote:
> On Wed, Oct 13, 2021 at 5:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 12, 2021 at 02:52:22PM +0800, Jason Wang wrote:
> > > This patch tries to make sure the virtio interrupt handler for INTX
> > > won't be called after a reset and before virtio_device_ready(). We
> > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > intx_soft_enabled variable and toggle it during in
> > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > intx_soft_enabled before processing the actual interrupt.
> > >
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++++++--
> > >  drivers/virtio/virtio_pci_common.h |  1 +
> > >  2 files changed, 23 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > index 0b9523e6dd39..5ae6a2a4eb77 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -30,8 +30,16 @@ void vp_disable_vectors(struct virtio_device *vdev)
> > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > >       int i;
> > >
> > > -     if (vp_dev->intx_enabled)
> > > +     if (vp_dev->intx_enabled) {
> > > +             /*
> > > +              * The below synchronize() guarantees that any
> > > +              * interrupt for this line arriving after
> > > +              * synchronize_irq() has completed is guaranteed to see
> > > +              * intx_soft_enabled == false.
> > > +              */
> > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, false);
> > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > +     }
> > >
> > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > @@ -43,8 +51,16 @@ void vp_enable_vectors(struct virtio_device *vdev)
> > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > >       int i;
> > >
> > > -     if (vp_dev->intx_enabled)
> > > +     if (vp_dev->intx_enabled) {
> > > +             disable_irq(vp_dev->pci_dev->irq);
> > > +             /*
> > > +              * The above disable_irq() provides TSO ordering and
> > > +              * as such promotes the below store to store-release.
> > > +              */
> > > +             WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> > > +             enable_irq(vp_dev->pci_dev->irq);
> > >               return;
> > > +     }
> > >
> > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > @@ -97,6 +113,10 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> > >       struct virtio_pci_device *vp_dev = opaque;
> > >       u8 isr;
> > >
> > > +     /* read intx_soft_enabled before read others */
> > > +     if (!smp_load_acquire(&vp_dev->intx_soft_enabled))
> > > +             return IRQ_NONE;
> > > +
> > >       /* reading the ISR has the effect of also clearing it so it's very
> > >        * important to save off the value. */
> > >       isr = ioread8(vp_dev->isr);
> >
> > I don't see why we need this ordering guarantee here.
> >
> > synchronize_irq above makes sure no interrupt handler
> > is in progress.
> 
> Yes.
> 
> > the handler itself thus does not need
> > any specific order, it is ok if intx_soft_enabled is read
> > after, not before the rest of it.
> 
> But the interrupt could be raised after synchronize_irq() which may
> see a false of the intx_soft_enabled.

You mean a "true" value right? false is what we are writing there.

Are you sure it can happen? I think that synchronize_irq makes the value
visible on all CPUs running the irq.

> In this case we still need the
> make sure intx_soft_enbled to be read first instead of allowing other
> operations to be done first, otherwise the intx_soft_enabled is
> meaningless.
> 
> Thanks

If intx_soft_enbled were not visible after synchronize_irq then
it does not matter in which order we read it wrt other values,
it still wouldn't work right.

> >
> > Just READ_ONCE should be enough, and we can drop the comment.
> >
> >
> > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > index a235ce9ff6a5..3c06e0f92ee4 100644
> > > --- a/drivers/virtio/virtio_pci_common.h
> > > +++ b/drivers/virtio/virtio_pci_common.h
> > > @@ -64,6 +64,7 @@ struct virtio_pci_device {
> > >       /* MSI-X support */
> > >       int msix_enabled;
> > >       int intx_enabled;
> > > +     bool intx_soft_enabled;
> > >       cpumask_var_t *msix_affinity_masks;
> > >       /* Name strings for interrupts. This size should be enough,
> > >        * and I'm too lazy to allocate each name separately. */
> > > --
> > > 2.25.1
> >


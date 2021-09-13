Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117984084DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhIMGm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237364AbhIMGm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631515301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A7ak6bO3ZbDQcmYe8pOAt6ZN28nqsiJpqhbYVS/xAd8=;
        b=Bi/FrQ+oSW56U5+7pve/eXIb/NYx8LSX+aUvrpNS/lSzRZ0eT0xC8N6Hj+gUHCKqhjI73H
        M1r9lKWyVlsl2k3k/Dl7nkAqFQBGVylXhxHOZ+YF3G2qAHAfnRDHY3IAz6pDz4s3fi/WRb
        7Acyzlt+0z1VFjqfQPRzvPy6IuO+J6c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-Mx9AFVS6OMykHt3iXSrWMg-1; Mon, 13 Sep 2021 02:41:39 -0400
X-MC-Unique: Mx9AFVS6OMykHt3iXSrWMg-1
Received: by mail-wm1-f69.google.com with SMTP id f17-20020a05600c155100b002f05f30ff03so3600959wmg.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7ak6bO3ZbDQcmYe8pOAt6ZN28nqsiJpqhbYVS/xAd8=;
        b=F+bEnfordyW/EO/H1t5DsPBioMqiNpLUl/rpKsXSg72RuH0cZgbJEBWM8ZFsTqAVGe
         pn0Z6cmRVBEh5h1s/0iyRBGkv/uLn9ZPFSO+pmZ+I7vf4k3KfyMfBttgmyEpNXXlgrtt
         cZwGbLxU1z8IFwkK1JhE4x88ZLUXCuPepOQ8M4XPzu6Iofvros8K0Vhy9elJbkdcZjO9
         4/gVItAn2PeNlQotYWn/42kwENkLkChkfQs5ZjFW1hsgNMdXGHcLmMqQ9EfhUscw4pea
         b+JGLWkDdBJwLcUey5m0aRuwCqOQdO4yrPTWEyKWIabLmuvpxt9VHbQZq6YxDSYObp97
         HFfA==
X-Gm-Message-State: AOAM532xmqHted5h6T392KD5xKodsnim++2mfobJsDT+/FN/vK5XVENw
        hezHXY5TzZpvkRZnAtuGFBDCEc+8ujG47nFhvFd53d/3ewJXBPLuRl32ULjrMK29MH+UqC+YQqp
        l++RuC20xYGWCgTpLsqX8k9a/
X-Received: by 2002:adf:cf05:: with SMTP id o5mr10577223wrj.270.1631515298310;
        Sun, 12 Sep 2021 23:41:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsD+bT8UWlKmgvA78K+/pI1lMXq4Gz36uYronKSczbZYhYO104bBjXmMrJqzweRJ9POQwkcg==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr10577212wrj.270.1631515298130;
        Sun, 12 Sep 2021 23:41:38 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
        by smtp.gmail.com with ESMTPSA id z7sm8061280wre.72.2021.09.12.23.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 23:41:37 -0700 (PDT)
Date:   Mon, 13 Sep 2021 02:41:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
Message-ID: <20210913023757-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com>
 <20210913022824-mutt-send-email-mst@kernel.org>
 <CACGkMEtnmLzQDNVYnAYSsEmjjRJVDhuK6VNj56S__zU9+5-JQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtnmLzQDNVYnAYSsEmjjRJVDhuK6VNj56S__zU9+5-JQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 02:36:54PM +0800, Jason Wang wrote:
> On Mon, Sep 13, 2021 at 2:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 01:53:51PM +0800, Jason Wang wrote:
> > > This patch tries to make sure the virtio interrupt handler for INTX
> > > won't be called after a reset and before virtio_device_ready(). We
> > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > intx_soft_enabled variable and toggle it during in
> > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > intx_soft_enabled before processing the actual interrupt.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> >
> > Not all that excited about all the memory barriers for something
> > that should be an extremely rare event (for most kernels -
> > literally once per boot). Can't we do better?
> 
> I'm not sure, but do we need to care about the slow path (INTX)?

Otherwise we won't try to support this, right?

> (Or do you have a better approach?)
> 
> Thanks

Don't know really, maybe rcu or whatever?
But let's try to be much more specific - is there anything
specific we are trying to protect against here?



> >
> > > ---
> > >  drivers/virtio/virtio_pci_common.c | 18 ++++++++++++++++--
> > >  drivers/virtio/virtio_pci_common.h |  1 +
> > >  2 files changed, 17 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > index 0b9523e6dd39..835197151dc1 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -30,8 +30,12 @@ void vp_disable_vectors(struct virtio_device *vdev)
> > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > >       int i;
> > >
> > > -     if (vp_dev->intx_enabled)
> > > +     if (vp_dev->intx_enabled) {
> > > +             vp_dev->intx_soft_enabled = false;
> > > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > > +             smp_wmb();
> > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > +     }
> > >
> > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > @@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
> > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > >       int i;
> > >
> > > -     if (vp_dev->intx_enabled)
> > > +     if (vp_dev->intx_enabled) {
> > > +             vp_dev->intx_soft_enabled = true;
> > > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > > +             smp_wmb();
> > >               return;
> > > +     }
> > >
> > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > @@ -97,6 +105,12 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> > >       struct virtio_pci_device *vp_dev = opaque;
> > >       u8 isr;
> > >
> > > +     if (!vp_dev->intx_soft_enabled)
> > > +             return IRQ_NONE;
> > > +
> > > +     /* read intx_soft_enabled before read others */
> > > +     smp_rmb();
> > > +
> > >       /* reading the ISR has the effect of also clearing it so it's very
> > >        * important to save off the value. */
> > >       isr = ioread8(vp_dev->isr);
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


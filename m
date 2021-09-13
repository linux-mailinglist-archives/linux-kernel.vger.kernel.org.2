Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5474084E9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbhIMGrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237368AbhIMGrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631515554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0ej8XTbwKPpyyCRf+V2wNAvPGgbx3EpHXxZ8UETyS0=;
        b=IDMjYOzQ37M148vlaNxHcd1i8P6vIpITCGZkdCs+veodutv/iP0pdWlkI212n2O6LgU93R
        a6g5khsQUuJ3NUxzDAiENr6GBpkkrelHaEuoUC8nzA2gbEefKNBJpCG7BO00UGrDDUSQhd
        gkJm56GX4kb3pw2FLer8wi24znzB8CM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-Pa6NVxAFNF2RkZXXUvSXxg-1; Mon, 13 Sep 2021 02:45:51 -0400
X-MC-Unique: Pa6NVxAFNF2RkZXXUvSXxg-1
Received: by mail-lj1-f198.google.com with SMTP id e10-20020a05651c04ca00b001c99c74e564so3729552lji.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0ej8XTbwKPpyyCRf+V2wNAvPGgbx3EpHXxZ8UETyS0=;
        b=3d5RD4kRXwjcYdFWqn4T4qqqlk+/2M2pzLa1l1Fr8XGcrnD0jXexIhOv+D5Zw7ZznJ
         jjcOk969m5eG+IjD2x0WgMoRP7lyiBXWkOOpGK6sDARk7bT0hUI/qeWIcS+TXVuTW1Jd
         tjyjXYvk4G3lDwNrOGQ4y7r9gKp+hhxmWBNs6GFJojdNMuabaijWThLKHaobGhlmCcrm
         ud5zYLEPshi2PNCZ7AwmHMA00J15RfJyE5E8DdlCG2IoVbEFkeEbZRcMe4+uCsp1JbTK
         NrsnJ5D0sjD0WG5q8xO/XmQPypMWHzpuMbL34B+eUsYqAH27DyFtq8mkO57hm+edTYbr
         vZRQ==
X-Gm-Message-State: AOAM5300OigiYOUCIfQMWpf3Liteq0Bs0bC/AHbOgT0nm6DisP8ypzZ/
        Lw0uuwrtcX0ThA3XxQ1SRdH6AVW43BSuWxGTUFPU9HG8n7BUqb8+Y+GbysV2jRlpX7zJrJ20/qv
        pv2v3XXIbaqOBC6HPaDrWTugN3Os4XB0iNkMf4rZb
X-Received: by 2002:a05:651c:b09:: with SMTP id b9mr9062303ljr.307.1631515549986;
        Sun, 12 Sep 2021 23:45:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAlp5VhrDfNq1QxtijJNOsG+u1lm/8be7YTCgCLWeFFvN/SZ849iaepzcduKsQXhYHlrCgcJ/4danq9R0lTiQ=
X-Received: by 2002:a05:651c:b09:: with SMTP id b9mr9062284ljr.307.1631515549705;
 Sun, 12 Sep 2021 23:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com> <20210913055353.35219-8-jasowang@redhat.com>
 <20210913022824-mutt-send-email-mst@kernel.org> <CACGkMEtnmLzQDNVYnAYSsEmjjRJVDhuK6VNj56S__zU9+5-JQQ@mail.gmail.com>
 <20210913023757-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210913023757-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 13 Sep 2021 14:45:38 +0800
Message-ID: <CACGkMEskmq7azAP6QiNz=_nXaU6vbtr975wk3kr9H6pOGs-ZuQ@mail.gmail.com>
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

On Mon, Sep 13, 2021 at 2:41 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 13, 2021 at 02:36:54PM +0800, Jason Wang wrote:
> > On Mon, Sep 13, 2021 at 2:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 13, 2021 at 01:53:51PM +0800, Jason Wang wrote:
> > > > This patch tries to make sure the virtio interrupt handler for INTX
> > > > won't be called after a reset and before virtio_device_ready(). We
> > > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > > intx_soft_enabled variable and toggle it during in
> > > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > > intx_soft_enabled before processing the actual interrupt.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > >
> > > Not all that excited about all the memory barriers for something
> > > that should be an extremely rare event (for most kernels -
> > > literally once per boot). Can't we do better?
> >
> > I'm not sure, but do we need to care about the slow path (INTX)?
>
> Otherwise we won't try to support this, right?

Sorry, what I meant is "do we need to care about the performance of
the slow path".

>
> > (Or do you have a better approach?)
> >
> > Thanks
>
> Don't know really, maybe rcu or whatever?

I am sure it's worth it to bother since it's the slow path.

> But let's try to be much more specific - is there anything
> specific we are trying to protect against here?

The unexpected calling of the vring or config interrupt handler. (The
same as MSI-X, e.g the untrusted device can send irq at any time).

Thanks

>
>
>
> > >
> > > > ---
> > > >  drivers/virtio/virtio_pci_common.c | 18 ++++++++++++++++--
> > > >  drivers/virtio/virtio_pci_common.h |  1 +
> > > >  2 files changed, 17 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > index 0b9523e6dd39..835197151dc1 100644
> > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > @@ -30,8 +30,12 @@ void vp_disable_vectors(struct virtio_device *vdev)
> > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >       int i;
> > > >
> > > > -     if (vp_dev->intx_enabled)
> > > > +     if (vp_dev->intx_enabled) {
> > > > +             vp_dev->intx_soft_enabled = false;
> > > > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > > > +             smp_wmb();
> > > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > > +     }
> > > >
> > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > @@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
> > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >       int i;
> > > >
> > > > -     if (vp_dev->intx_enabled)
> > > > +     if (vp_dev->intx_enabled) {
> > > > +             vp_dev->intx_soft_enabled = true;
> > > > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > > > +             smp_wmb();
> > > >               return;
> > > > +     }
> > > >
> > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > @@ -97,6 +105,12 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> > > >       struct virtio_pci_device *vp_dev = opaque;
> > > >       u8 isr;
> > > >
> > > > +     if (!vp_dev->intx_soft_enabled)
> > > > +             return IRQ_NONE;
> > > > +
> > > > +     /* read intx_soft_enabled before read others */
> > > > +     smp_rmb();
> > > > +
> > > >       /* reading the ISR has the effect of also clearing it so it's very
> > > >        * important to save off the value. */
> > > >       isr = ioread8(vp_dev->isr);
> > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > index a235ce9ff6a5..3c06e0f92ee4 100644
> > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > @@ -64,6 +64,7 @@ struct virtio_pci_device {
> > > >       /* MSI-X support */
> > > >       int msix_enabled;
> > > >       int intx_enabled;
> > > > +     bool intx_soft_enabled;
> > > >       cpumask_var_t *msix_affinity_masks;
> > > >       /* Name strings for interrupts. This size should be enough,
> > > >        * and I'm too lazy to allocate each name separately. */
> > > > --
> > > > 2.25.1
> > >
>


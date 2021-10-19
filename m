Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FB4432B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 03:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhJSBgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 21:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhJSBgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 21:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634607247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9zJ/UlJQ6UbjTHaSUXp9FcbIfyNp0zrJpCvZSAEQ+pw=;
        b=J8BqxLZii7AjW6EDFw+0wvqpYTtybOP3ZOMbJT+s/S9XyZx57gsWSp4Z/omUUqx3ek5w2e
        +OlrosUgWQM5GkKRr+N16jjBzCAibRSTHNvZeuSZN38RZmxUah2nKHAHdA4+k8KCcD4o2Y
        7K9XotDyqBmITVjGieXKhXhbxSDcaCU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-lsnqE0pBNseyJZaGnXrR3Q-1; Mon, 18 Oct 2021 21:34:06 -0400
X-MC-Unique: lsnqE0pBNseyJZaGnXrR3Q-1
Received: by mail-lf1-f72.google.com with SMTP id i19-20020a0565123e1300b003fdc4e26333so764004lfv.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 18:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zJ/UlJQ6UbjTHaSUXp9FcbIfyNp0zrJpCvZSAEQ+pw=;
        b=msmd0NwIgnw2j+1cLsYX2FfmpzqKCuSIbS67skm+pJOZZbQW/ajcCz31joiKrDNCWZ
         ANUCyVpctFs1JnaPOTVzEGS266kqgzh00pE9lnW8O4kqRX1rq24k1uALfJQtBA4NifdP
         BUuaZ7r5x0vmJsOKt0T3L2jQKDNBbgZSxLumblMiPMH/pirzirKgFF6XH9bRQsP31pFr
         ZzxyvodT+Y4YdB3uednWo2OoNa7Qv/JDjyOpGSX/KXTtKOi08vEEe+mSXM+kUifIpaV1
         KTjHfp9XdhKkCmD3zna4v4vDs79efLevpk3J2SNTtBzz8HT1e1PLufY6YhJ1vy4afWqQ
         m18Q==
X-Gm-Message-State: AOAM532wWkBcsoA84Ec3DFZl9ByGMOtQ8hO+13JpNMwe+0qFHYobiz7T
        ET2ivLsvraUvIYT+wjoQPRaxPlKzU05locZhUv1MZ+7L5cnSdnLLJzQQMCFzeuQ6VyJJcpjpGc9
        Eze+LPfmVqdCLVlM28MJmD3fTQ6cpVH0L4/LW77f4
X-Received: by 2002:a05:6512:3b22:: with SMTP id f34mr3198705lfv.629.1634607244650;
        Mon, 18 Oct 2021 18:34:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2ghcjzJ36vyLgOMwKEoUc+7RKm3bxf7XmnLzT/+p97sw+QbledQVMw4UavMkbN6RxfFmbGs3JJwaaQOaBTRc=
X-Received: by 2002:a05:6512:3b22:: with SMTP id f34mr3198693lfv.629.1634607244412;
 Mon, 18 Oct 2021 18:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com> <20211012065227.9953-7-jasowang@redhat.com>
 <c6641b6a-6204-2b41-e775-ad329314711c@oracle.com> <20211015132639-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211015132639-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 19 Oct 2021 09:33:52 +0800
Message-ID: <CACGkMEujcgMTtLiJWx5ZazVgM5qopB0ZVDkvg6cEuyRGAL31AA@mail.gmail.com>
Subject: Re: [PATCH V2 06/12] virtio_pci: harden MSI-X interrupts
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 1:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Oct 15, 2021 at 05:09:38AM -0700, Dongli Zhang wrote:
> > Hi Jason,
> >
> > On 10/11/21 11:52 PM, Jason Wang wrote:
> > > We used to synchronize pending MSI-X irq handlers via
> > > synchronize_irq(), this may not work for the untrusted device which
> > > may keep sending interrupts after reset which may lead unexpected
> > > results. Similarly, we should not enable MSI-X interrupt until the
> >
> > About "unexpected results", while you mentioned below in v1 ...
> >
> > "My understanding is that e.g in the case of SEV/TDX we don't trust the
> > hypervisor. So the hypervisor can keep sending interrupts even if the
> > device is reset. The guest can only trust its own software interrupt
> > management logic to avoid call virtio callback in this case."
> >
> > .. and you also mentioned to avoid the panic (due to untrusted device) in as
> > many scenarios as possible.
> >
> >
> > Here is my understanding.
> >
> > The reason we do not trust hypervisor is to protect (1) data/code privacy for
> > most of times and sometimes (2) program execution integrity.
> >
> > The bad thing is: the hypervisor is able to panic/destroy the VM in the worst case.
> >
> > It is reasonable to re-configure/recover if we assume there is BUG at
> > hypervisor/device side. That is, the hypervisor/device is buggy, but not malicious.
> >
> > However, how about to just detect and report the hypervisor/device is malicious
> > and shutdown/panic the VM immediately? If we have detected the malicious
> > hypervisor, we should avoid running VMs on the malicious hypervisor further. At
> > least how about to print error message to reminder users that the hypervisor is
> > malicious?

I understand your point, but several questions needs to be answered:

1) how can we easily differentiate "malicious" from "buggy"?
2) If we want to detect malicious hypervisor, virtio is not the only
place that we want to do this
3) Is there a way that "malicious" hypervisor can prevent guest from
shutting down itself?

> >
> >
> > About "unexpected results", it should not be hang/panic. I suggest ...
> >

It's just the phenomenon not the logic behind that. It could be e.g
OOB which may lead the unexpected kernel codes to be executed in
unexpected ways (e.g mark the page as shared or go with IOTLB etc).
Sometimes we can see panic finally but it's not always.

> > Assuming SEV/TDX is involved, the hypervisor should never be able to derive the
> > VM privacy (at least secure memory data) by providing malicious configuration,
> > e.g., num_queues=0.

Yes.

> > If we detect hypervisor is malicious, the VM is
> > panic/shutdown immediately.

This seems to enforce the policy into the kernel, we need to leave
this to userspace to decide.

> > At least how about to print error message to
> > reminder users.

This is fine.

> >
> >
> > BTW, while I always do care about the loss of interrupt issue, the malicious
> > device is able to hang a VM by dropping a single interrupt on purpose for
> > virtio-scsi :)
> >

Right.

> >
> > Thank you very much!
>
>
> Can't say I understand what it's about. TDX does not protect against
> hypervisor DoS attacks.

Yes, I think what Dongli wants to discuss is how to behave if we
detect a malicious hypervisor. He suggested a shutdown instead of
failing the probe.

Thanks

>
> > Dongli Zhang
> >
> > > device is ready. So this patch fixes those two issues by:
> > >
> > > 1) switching to use disable_irq() to prevent the virtio interrupt
> > >    handlers to be called after the device is reset.
> > > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> > >
> > > This can make sure the virtio interrupt handler won't be called before
> > > virtio_device_ready() and after reset.
> > >
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
> > >  drivers/virtio/virtio_pci_common.h |  6 ++++--
> > >  drivers/virtio/virtio_pci_legacy.c |  5 +++--
> > >  drivers/virtio/virtio_pci_modern.c |  6 ++++--
> > >  4 files changed, 32 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > index b35bb2d57f62..0b9523e6dd39 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
> > >              "Force legacy mode for transitional virtio 1 devices");
> > >  #endif
> > >
> > > -/* wait for pending irq handlers */
> > > -void vp_synchronize_vectors(struct virtio_device *vdev)
> > > +/* disable irq handlers */
> > > +void vp_disable_vectors(struct virtio_device *vdev)
> > >  {
> > >     struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > >     int i;
> > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > >             synchronize_irq(vp_dev->pci_dev->irq);
> > >
> > >     for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > -           synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > +           disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > +}
> > > +
> > > +/* enable irq handlers */
> > > +void vp_enable_vectors(struct virtio_device *vdev)
> > > +{
> > > +   struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > +   int i;
> > > +
> > > +   if (vp_dev->intx_enabled)
> > > +           return;
> > > +
> > > +   for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > +           enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > >  }
> > >
> > >  /* the notify function used when creating a virt queue */
> > > @@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> > >     snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> > >              "%s-config", name);
> > >     err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > > -                     vp_config_changed, 0, vp_dev->msix_names[v],
> > > +                     vp_config_changed, IRQF_NO_AUTOEN,
> > > +                     vp_dev->msix_names[v],
> > >                       vp_dev);
> > >     if (err)
> > >             goto error;
> > > @@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> > >             snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> > >                      "%s-virtqueues", name);
> > >             err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > > -                             vp_vring_interrupt, 0, vp_dev->msix_names[v],
> > > +                             vp_vring_interrupt, IRQF_NO_AUTOEN,
> > > +                             vp_dev->msix_names[v],
> > >                               vp_dev);
> > >             if (err)
> > >                     goto error;
> > > @@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> > >                      "%s-%s",
> > >                      dev_name(&vp_dev->vdev.dev), names[i]);
> > >             err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> > > -                             vring_interrupt, 0,
> > > +                             vring_interrupt, IRQF_NO_AUTOEN,
> > >                               vp_dev->msix_names[msix_vec],
> > >                               vqs[i]);
> > >             if (err)
> > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > index beec047a8f8d..a235ce9ff6a5 100644
> > > --- a/drivers/virtio/virtio_pci_common.h
> > > +++ b/drivers/virtio/virtio_pci_common.h
> > > @@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
> > >     return container_of(vdev, struct virtio_pci_device, vdev);
> > >  }
> > >
> > > -/* wait for pending irq handlers */
> > > -void vp_synchronize_vectors(struct virtio_device *vdev);
> > > +/* disable irq handlers */
> > > +void vp_disable_vectors(struct virtio_device *vdev);
> > > +/* enable irq handlers */
> > > +void vp_enable_vectors(struct virtio_device *vdev);
> > >  /* the notify function used when creating a virt queue */
> > >  bool vp_notify(struct virtqueue *vq);
> > >  /* the config->del_vqs() implementation */
> > > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> > > index d62e9835aeec..bdf6bc667ab5 100644
> > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > @@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
> > >     /* Flush out the status write, and flush in device writes,
> > >      * including MSi-X interrupts, if any. */
> > >     ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> > > -   /* Flush pending VQ/configuration callbacks. */
> > > -   vp_synchronize_vectors(vdev);
> > > +   /* Disable VQ/configuration callbacks. */
> > > +   vp_disable_vectors(vdev);
> > >  }
> > >
> > >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > > @@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
> > >  }
> > >
> > >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > > +   .ready          = vp_enable_vectors,
> > >     .get            = vp_get,
> > >     .set            = vp_set,
> > >     .get_status     = vp_get_status,
> > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > index 30654d3a0b41..acf0f6b6381d 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
> > >      */
> > >     while (vp_modern_get_status(mdev))
> > >             msleep(1);
> > > -   /* Flush pending VQ/configuration callbacks. */
> > > -   vp_synchronize_vectors(vdev);
> > > +   /* Disable VQ/configuration callbacks. */
> > > +   vp_disable_vectors(vdev);
> > >  }
> > >
> > >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > > @@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
> > >  }
> > >
> > >  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > > +   .ready          = vp_enable_vectors,
> > >     .get            = NULL,
> > >     .set            = NULL,
> > >     .generation     = vp_generation,
> > > @@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > >  };
> > >
> > >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > > +   .ready          = vp_enable_vectors,
> > >     .get            = vp_get,
> > >     .set            = vp_set,
> > >     .generation     = vp_generation,
> > >
>


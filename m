Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A652408528
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhIMHRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234423AbhIMHRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631517351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8zrjQ6IIpS0SJcwnTDNdtjS5JFyVJjD1vEjBqvQo7YE=;
        b=YT/YSoynvW7BKnoAGxUDIfDWW52g+Ij0tDt+OyCVu3ja3lfFbUYmlKq/rK/7M5jE0WL7Ni
        V/gLrRTpEYjq848LwKdHh+MgDZnbh99K4F4Ft3xdXmuY+0u0gDqNNA+gz5ewrUU7Q9MHFd
        qBhYX1KnB8BYDm1kxV6cflAlkefs3Mc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-7qxLK9FYMdab9ulhK5mw2A-1; Mon, 13 Sep 2021 03:15:49 -0400
X-MC-Unique: 7qxLK9FYMdab9ulhK5mw2A-1
Received: by mail-lf1-f70.google.com with SMTP id c15-20020a056512238f00b003f1de3c67e2so2261184lfv.22
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8zrjQ6IIpS0SJcwnTDNdtjS5JFyVJjD1vEjBqvQo7YE=;
        b=jq/IGCpBHKbVhanT2ukmWYlgQZu2lPJG3iUNJr7zQHOHoN1G3QgvzcBo8ulF1ogBW1
         Gp493knaeqYGSwOomupXucW2i7cmIasscrHfbsmimGF3cSPORcfHdmfJ36CWrmjUR3nd
         98CqjnxO4OKpnLh6uVzLgWYoDfgfB2m0/1Yu9IdAkW0tKzrzUZPd3a+mLCDsQpDPk+l7
         uINzjStD1Nr2qc8Scn/Gv4enV2H9qfcg5rx8XxzjxB/g4vxJYNPsBc7OsEiqzsfmM0th
         /7vSq6ebqsXTjr/5o1BkMF9Ekq9zgL/XyG+jiZIghlL7bAxj5AjOnDKjmOdf2WgCzVsH
         ozHg==
X-Gm-Message-State: AOAM530A1KklN592PipUy9VkcvkEgxu8jISbaEAiqfeGJiFj5UimHDnR
        bWSMId6yOa6DHEOBLdrkfZgTJpuGhraXLBPKJUMuuhM8TTSd3kP+5jBLdJNh6xXfyfWIolfUWmm
        5v40lb6Jrd6y8httHrB9lfYQKCXtWw05YruM2m2uN
X-Received: by 2002:a05:651c:54c:: with SMTP id q12mr9608615ljp.369.1631517347655;
        Mon, 13 Sep 2021 00:15:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMpOgXkiak1oB+/DBlDqXjFcdlgx98ninwMWWS67k9PpQx34JiOsMPjDxRa3iJ6hUJiL9wFu5P8po7OGC3ySk=
X-Received: by 2002:a05:651c:54c:: with SMTP id q12mr9608584ljp.369.1631517347405;
 Mon, 13 Sep 2021 00:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com> <20210913055353.35219-7-jasowang@redhat.com>
 <20210913015711-mutt-send-email-mst@kernel.org> <CACGkMEva2j57tG=-QYG7NdgEV28i-gpBReRR+UX7YwrHzRWydw@mail.gmail.com>
 <20210913022257-mutt-send-email-mst@kernel.org> <CACGkMEsWJq0SMMfTBdoOxVa1_=k9nZkrRu2wYZo7WO-01p_sgQ@mail.gmail.com>
 <20210913023626-mutt-send-email-mst@kernel.org> <CACGkMEuP=uHXrpeUa4Fku3ZoHm12y2R4_htA=_0nr-0HYBiB0A@mail.gmail.com>
 <20210913025729-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210913025729-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 13 Sep 2021 15:15:36 +0800
Message-ID: <CACGkMEtVYSDekdaM9cXOLNizr2_oAboxTA3FYyLKxQUgpRht2Q@mail.gmail.com>
Subject: Re: [PATCH 6/9] virtio_pci: harden MSI-X interrupts
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        pbonzini <pbonzini@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 3:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 13, 2021 at 02:43:08PM +0800, Jason Wang wrote:
> > On Mon, Sep 13, 2021 at 2:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 13, 2021 at 02:34:01PM +0800, Jason Wang wrote:
> > > > On Mon, Sep 13, 2021 at 2:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Sep 13, 2021 at 02:08:02PM +0800, Jason Wang wrote:
> > > > > > On Mon, Sep 13, 2021 at 2:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 13, 2021 at 01:53:50PM +0800, Jason Wang wrote:
> > > > > > > > We used to synchronize pending MSI-X irq handlers via
> > > > > > > > synchronize_irq(), this may not work for the untrusted device which
> > > > > > > > may keep sending interrupts after reset which may lead unexpected
> > > > > > > > results. Similarly, we should not enable MSI-X interrupt until the
> > > > > > > > device is ready. So this patch fixes those two issues by:
> > > > > > > >
> > > > > > > > 1) switching to use disable_irq() to prevent the virtio interrupt
> > > > > > > >    handlers to be called after the device is reset.
> > > > > > > > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> > > > > > > >
> > > > > > > > This can make sure the virtio interrupt handler won't be called before
> > > > > > > > virtio_device_ready() and after reset.
> > > > > > > >
> > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > >
> > > > > > > I don't get the threat model here. Isn't disabling irqs done by the
> > > > > > > hypervisor anyway? Is there a reason to trust disable_irq but not
> > > > > > > device reset?
> > > > > >
> > > > > > My understanding is that e.g in the case of SEV/TDX we don't trust the
> > > > > > hypervisor. So the hypervisor can keep sending interrupts even if the
> > > > > > device is reset. The guest can only trust its own software interrupt
> > > > > > management logic to avoid call virtio callback in this case.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Hmm but I don't see how do these patches do this.
> > > > > They call disable_irq but can't the hypervisor keep
> > > > > sending interrupts after disable_irq, too?
> > > >
> > > > Yes, but since the irq is disabled, the vring or config callback won't
> > > > be called in this case.
> > > >
> > > > Thanks
> > >
> > > But doen't "irq is disabled" basically mean "we told the hypervisor
> > > to disable the irq"?  What extractly prevents hypervisor from
> > > sending the irq even if guest thinks it disabled it?
> >
> > It can't prevent the hypersior from sending irq. But it can make sure
> > the irq descriptor is disabled (e.g IRQD_IRQ_DISABLED). Is this
> > sufficient?
> >
> > Thanks
>
> Maybe, maybe not ... there's not a lot in the way of
> memory barriers around code using that bit, that's for sure.

Ok, I think the irq core should be robust enough for such unexpected
irq for many years but maybe I was wrong.

But anyhow, the virtio core should be prepared for this, since the irq
core doesn't know when the irq should be raised.

Thanks

> Did anyone look at it from point of view of what
> can a bad interrupt do?
>
>
> > >
> > > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > > Cc a bunch more people ...
> > > > > > >
> > > > > > >
> > > > > > > > ---
> > > > > > > >  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
> > > > > > > >  drivers/virtio/virtio_pci_common.h |  6 ++++--
> > > > > > > >  drivers/virtio/virtio_pci_legacy.c |  5 +++--
> > > > > > > >  drivers/virtio/virtio_pci_modern.c |  6 ++++--
> > > > > > > >  4 files changed, 32 insertions(+), 12 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > > > > index b35bb2d57f62..0b9523e6dd39 100644
> > > > > > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > > > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > > > > > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
> > > > > > > >                "Force legacy mode for transitional virtio 1 devices");
> > > > > > > >  #endif
> > > > > > > >
> > > > > > > > -/* wait for pending irq handlers */
> > > > > > > > -void vp_synchronize_vectors(struct virtio_device *vdev)
> > > > > > > > +/* disable irq handlers */
> > > > > > > > +void vp_disable_vectors(struct virtio_device *vdev)
> > > > > > > >  {
> > > > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > >       int i;
> > > > > > > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > > > > > > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > > > > > >
> > > > > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > > > > -             synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > > > +             disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +/* enable irq handlers */
> > > > > > > > +void vp_enable_vectors(struct virtio_device *vdev)
> > > > > > > > +{
> > > > > > > > +     struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > > +     int i;
> > > > > > > > +
> > > > > > > > +     if (vp_dev->intx_enabled)
> > > > > > > > +             return;
> > > > > > > > +
> > > > > > > > +     for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > > > > +             enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  /* the notify function used when creating a virt queue */
> > > > > > > > @@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> > > > > > > >       snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> > > > > > > >                "%s-config", name);
> > > > > > > >       err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > > > > > > > -                       vp_config_changed, 0, vp_dev->msix_names[v],
> > > > > > > > +                       vp_config_changed, IRQF_NO_AUTOEN,
> > > > > > > > +                       vp_dev->msix_names[v],
> > > > > > > >                         vp_dev);
> > > > > > > >       if (err)
> > > > > > > >               goto error;
> > > > > > > > @@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> > > > > > > >               snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> > > > > > > >                        "%s-virtqueues", name);
> > > > > > > >               err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > > > > > > > -                               vp_vring_interrupt, 0, vp_dev->msix_names[v],
> > > > > > > > +                               vp_vring_interrupt, IRQF_NO_AUTOEN,
> > > > > > > > +                               vp_dev->msix_names[v],
> > > > > > > >                                 vp_dev);
> > > > > > > >               if (err)
> > > > > > > >                       goto error;
> > > > > > > > @@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> > > > > > > >                        "%s-%s",
> > > > > > > >                        dev_name(&vp_dev->vdev.dev), names[i]);
> > > > > > > >               err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> > > > > > > > -                               vring_interrupt, 0,
> > > > > > > > +                               vring_interrupt, IRQF_NO_AUTOEN,
> > > > > > > >                                 vp_dev->msix_names[msix_vec],
> > > > > > > >                                 vqs[i]);
> > > > > > > >               if (err)
> > > > > > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > > > > > index beec047a8f8d..a235ce9ff6a5 100644
> > > > > > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > > > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > > > > > @@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
> > > > > > > >       return container_of(vdev, struct virtio_pci_device, vdev);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -/* wait for pending irq handlers */
> > > > > > > > -void vp_synchronize_vectors(struct virtio_device *vdev);
> > > > > > > > +/* disable irq handlers */
> > > > > > > > +void vp_disable_vectors(struct virtio_device *vdev);
> > > > > > > > +/* enable irq handlers */
> > > > > > > > +void vp_enable_vectors(struct virtio_device *vdev);
> > > > > > > >  /* the notify function used when creating a virt queue */
> > > > > > > >  bool vp_notify(struct virtqueue *vq);
> > > > > > > >  /* the config->del_vqs() implementation */
> > > > > > > > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> > > > > > > > index d62e9835aeec..bdf6bc667ab5 100644
> > > > > > > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > > > > > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > > > > > > @@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
> > > > > > > >       /* Flush out the status write, and flush in device writes,
> > > > > > > >        * including MSi-X interrupts, if any. */
> > > > > > > >       ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> > > > > > > > -     /* Flush pending VQ/configuration callbacks. */
> > > > > > > > -     vp_synchronize_vectors(vdev);
> > > > > > > > +     /* Disable VQ/configuration callbacks. */
> > > > > > > > +     vp_disable_vectors(vdev);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > > > > > > > @@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > > > > > > > +     .ready          = vp_enable_vectors,
> > > > > > > >       .get            = vp_get,
> > > > > > > >       .set            = vp_set,
> > > > > > > >       .get_status     = vp_get_status,
> > > > > > > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > > > > > > index 30654d3a0b41..acf0f6b6381d 100644
> > > > > > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > > > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > > > > > @@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
> > > > > > > >        */
> > > > > > > >       while (vp_modern_get_status(mdev))
> > > > > > > >               msleep(1);
> > > > > > > > -     /* Flush pending VQ/configuration callbacks. */
> > > > > > > > -     vp_synchronize_vectors(vdev);
> > > > > > > > +     /* Disable VQ/configuration callbacks. */
> > > > > > > > +     vp_disable_vectors(vdev);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > > > > > > > @@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > > > > > > > +     .ready          = vp_enable_vectors,
> > > > > > > >       .get            = NULL,
> > > > > > > >       .set            = NULL,
> > > > > > > >       .generation     = vp_generation,
> > > > > > > > @@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > > > > > > > +     .ready          = vp_enable_vectors,
> > > > > > > >       .get            = vp_get,
> > > > > > > >       .set            = vp_set,
> > > > > > > >       .generation     = vp_generation,
> > > > > > > > --
> > > > > > > > 2.25.1
> > > > > > >
> > > > >
> > >
>


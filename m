Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7AF4084EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbhIMGvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229634AbhIMGvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631515818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MyDTqnCM7+1l/i+LYvpu8caLxbFrAy8F0rFuYAKYUbQ=;
        b=ewLaVgqkCsmxnpNhraBISUYDsz31gofyO4lA86WPrIP7pmfp7J5H3AwwM7eG+b8MqCQIvu
        7gd/35KMdYRVGkzf2KjSVYylS58WZmszROFYJ+9XhxzVqwRunDawadcKj+FjKyc1LQWuz/
        DwlNUgHr6YjehUIDGzE3LPBg6b+iNcc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-38rNJAy3NkOrbK_qBlv_Bg-1; Mon, 13 Sep 2021 02:50:17 -0400
X-MC-Unique: 38rNJAy3NkOrbK_qBlv_Bg-1
Received: by mail-wm1-f72.google.com with SMTP id v2-20020a7bcb420000b02902e6b108fcf1so3603658wmj.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MyDTqnCM7+1l/i+LYvpu8caLxbFrAy8F0rFuYAKYUbQ=;
        b=EjvEgcYd9/ej1nw7hAZb9QnPFFcppZAx2qQyZIcG357y1XjH1MHdUvbhNDWfq4pkaG
         sk8QOhKPOVzEblXnTD1zdccUaL/MIBvr+5cWPATYfl/0G/CyNZi91XScKS9n6fBPkA0B
         2by/NXuI5yx/VPp4Nq5083bc5On8klI8Ktl9wjIfUOoW9mZmtyhqrlqp76W92Kz5vPcS
         gvuqFCrMqJw0icFUOxnBDIjlFuiDpEA6EZ0qHwTStXFZvGPR5kAZ/VxfGJUjBWBww16u
         cplrcuhUEdYMA8VyN1qYDVRgERECs4p7TQcqbtPnXUnJ5cojNrye2kWQxlrUxsjt100Z
         2QoQ==
X-Gm-Message-State: AOAM530Pi8ir+WTBWGOlz3S64xBq0S/FtvQZ6K73VA+cUoOZdCfHbOXw
        sVA1tIcDhRqoFZ9FMz/7UE8AhWn+m1sAYcGlusv/W1ZtwD8d/MkFPBh8SGYm4pTpvxMWFzOK1Qj
        N42MWckHos7l8Mg/lb1jwXhv3
X-Received: by 2002:adf:fe82:: with SMTP id l2mr5774803wrr.268.1631515816388;
        Sun, 12 Sep 2021 23:50:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcfkgu3ConcE2PukWR2cAEy3AU4MhrJ9eakHtv6dPbV1CFh1HXDoihq8fVIZUBqRBUMAYQfw==
X-Received: by 2002:adf:fe82:: with SMTP id l2mr5774770wrr.268.1631515816044;
        Sun, 12 Sep 2021 23:50:16 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
        by smtp.gmail.com with ESMTPSA id h8sm5857613wmb.35.2021.09.12.23.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 23:50:15 -0700 (PDT)
Date:   Mon, 13 Sep 2021 02:50:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
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
Subject: Re: [PATCH 6/9] virtio_pci: harden MSI-X interrupts
Message-ID: <20210913024153-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-7-jasowang@redhat.com>
 <20210913015711-mutt-send-email-mst@kernel.org>
 <CACGkMEva2j57tG=-QYG7NdgEV28i-gpBReRR+UX7YwrHzRWydw@mail.gmail.com>
 <20210913022257-mutt-send-email-mst@kernel.org>
 <CACGkMEsWJq0SMMfTBdoOxVa1_=k9nZkrRu2wYZo7WO-01p_sgQ@mail.gmail.com>
 <20210913023626-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913023626-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 02:37:42AM -0400, Michael S. Tsirkin wrote:
> On Mon, Sep 13, 2021 at 02:34:01PM +0800, Jason Wang wrote:
> > On Mon, Sep 13, 2021 at 2:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 13, 2021 at 02:08:02PM +0800, Jason Wang wrote:
> > > > On Mon, Sep 13, 2021 at 2:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Sep 13, 2021 at 01:53:50PM +0800, Jason Wang wrote:
> > > > > > We used to synchronize pending MSI-X irq handlers via
> > > > > > synchronize_irq(), this may not work for the untrusted device which
> > > > > > may keep sending interrupts after reset which may lead unexpected
> > > > > > results. Similarly, we should not enable MSI-X interrupt until the
> > > > > > device is ready. So this patch fixes those two issues by:
> > > > > >
> > > > > > 1) switching to use disable_irq() to prevent the virtio interrupt
> > > > > >    handlers to be called after the device is reset.
> > > > > > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> > > > > >
> > > > > > This can make sure the virtio interrupt handler won't be called before
> > > > > > virtio_device_ready() and after reset.
> > > > > >
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > >
> > > > > I don't get the threat model here. Isn't disabling irqs done by the
> > > > > hypervisor anyway? Is there a reason to trust disable_irq but not
> > > > > device reset?
> > > >
> > > > My understanding is that e.g in the case of SEV/TDX we don't trust the
> > > > hypervisor. So the hypervisor can keep sending interrupts even if the
> > > > device is reset. The guest can only trust its own software interrupt
> > > > management logic to avoid call virtio callback in this case.
> > > >
> > > > Thanks
> > >
> > > Hmm but I don't see how do these patches do this.
> > > They call disable_irq but can't the hypervisor keep
> > > sending interrupts after disable_irq, too?
> > 
> > Yes, but since the irq is disabled, the vring or config callback won't
> > be called in this case.
> > 
> > Thanks
> 
> But doen't "irq is disabled" basically mean "we told the hypervisor
> to disable the irq"?  What extractly prevents hypervisor from
> sending the irq even if guest thinks it disabled it?

More generally, can't we for example blow away the
indir_desc array that we use to keep the ctx pointers?
Won't that be enough?


And looking at all this closely, I suspect it is wise to just completely
disable hotplug/unplug for encrypted guests. Or maybe it's already
the case?


> > >
> > >
> > >
> > > > >
> > > > > Cc a bunch more people ...
> > > > >
> > > > >
> > > > > > ---
> > > > > >  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
> > > > > >  drivers/virtio/virtio_pci_common.h |  6 ++++--
> > > > > >  drivers/virtio/virtio_pci_legacy.c |  5 +++--
> > > > > >  drivers/virtio/virtio_pci_modern.c |  6 ++++--
> > > > > >  4 files changed, 32 insertions(+), 12 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > > index b35bb2d57f62..0b9523e6dd39 100644
> > > > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > > > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
> > > > > >                "Force legacy mode for transitional virtio 1 devices");
> > > > > >  #endif
> > > > > >
> > > > > > -/* wait for pending irq handlers */
> > > > > > -void vp_synchronize_vectors(struct virtio_device *vdev)
> > > > > > +/* disable irq handlers */
> > > > > > +void vp_disable_vectors(struct virtio_device *vdev)
> > > > > >  {
> > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > >       int i;
> > > > > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > > > > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > > > >
> > > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > > -             synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > +             disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > +}
> > > > > > +
> > > > > > +/* enable irq handlers */
> > > > > > +void vp_enable_vectors(struct virtio_device *vdev)
> > > > > > +{
> > > > > > +     struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > +     int i;
> > > > > > +
> > > > > > +     if (vp_dev->intx_enabled)
> > > > > > +             return;
> > > > > > +
> > > > > > +     for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > > +             enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > >  }
> > > > > >
> > > > > >  /* the notify function used when creating a virt queue */
> > > > > > @@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> > > > > >       snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> > > > > >                "%s-config", name);
> > > > > >       err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > > > > > -                       vp_config_changed, 0, vp_dev->msix_names[v],
> > > > > > +                       vp_config_changed, IRQF_NO_AUTOEN,
> > > > > > +                       vp_dev->msix_names[v],
> > > > > >                         vp_dev);
> > > > > >       if (err)
> > > > > >               goto error;
> > > > > > @@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> > > > > >               snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> > > > > >                        "%s-virtqueues", name);
> > > > > >               err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > > > > > -                               vp_vring_interrupt, 0, vp_dev->msix_names[v],
> > > > > > +                               vp_vring_interrupt, IRQF_NO_AUTOEN,
> > > > > > +                               vp_dev->msix_names[v],
> > > > > >                                 vp_dev);
> > > > > >               if (err)
> > > > > >                       goto error;
> > > > > > @@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> > > > > >                        "%s-%s",
> > > > > >                        dev_name(&vp_dev->vdev.dev), names[i]);
> > > > > >               err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> > > > > > -                               vring_interrupt, 0,
> > > > > > +                               vring_interrupt, IRQF_NO_AUTOEN,
> > > > > >                                 vp_dev->msix_names[msix_vec],
> > > > > >                                 vqs[i]);
> > > > > >               if (err)
> > > > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > > > index beec047a8f8d..a235ce9ff6a5 100644
> > > > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > > > @@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
> > > > > >       return container_of(vdev, struct virtio_pci_device, vdev);
> > > > > >  }
> > > > > >
> > > > > > -/* wait for pending irq handlers */
> > > > > > -void vp_synchronize_vectors(struct virtio_device *vdev);
> > > > > > +/* disable irq handlers */
> > > > > > +void vp_disable_vectors(struct virtio_device *vdev);
> > > > > > +/* enable irq handlers */
> > > > > > +void vp_enable_vectors(struct virtio_device *vdev);
> > > > > >  /* the notify function used when creating a virt queue */
> > > > > >  bool vp_notify(struct virtqueue *vq);
> > > > > >  /* the config->del_vqs() implementation */
> > > > > > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> > > > > > index d62e9835aeec..bdf6bc667ab5 100644
> > > > > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > > > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > > > > @@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
> > > > > >       /* Flush out the status write, and flush in device writes,
> > > > > >        * including MSi-X interrupts, if any. */
> > > > > >       ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> > > > > > -     /* Flush pending VQ/configuration callbacks. */
> > > > > > -     vp_synchronize_vectors(vdev);
> > > > > > +     /* Disable VQ/configuration callbacks. */
> > > > > > +     vp_disable_vectors(vdev);
> > > > > >  }
> > > > > >
> > > > > >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > > > > > @@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
> > > > > >  }
> > > > > >
> > > > > >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > > > > > +     .ready          = vp_enable_vectors,
> > > > > >       .get            = vp_get,
> > > > > >       .set            = vp_set,
> > > > > >       .get_status     = vp_get_status,
> > > > > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > > > > index 30654d3a0b41..acf0f6b6381d 100644
> > > > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > > > @@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
> > > > > >        */
> > > > > >       while (vp_modern_get_status(mdev))
> > > > > >               msleep(1);
> > > > > > -     /* Flush pending VQ/configuration callbacks. */
> > > > > > -     vp_synchronize_vectors(vdev);
> > > > > > +     /* Disable VQ/configuration callbacks. */
> > > > > > +     vp_disable_vectors(vdev);
> > > > > >  }
> > > > > >
> > > > > >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > > > > > @@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
> > > > > >  }
> > > > > >
> > > > > >  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > > > > > +     .ready          = vp_enable_vectors,
> > > > > >       .get            = NULL,
> > > > > >       .set            = NULL,
> > > > > >       .generation     = vp_generation,
> > > > > > @@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > > > > >  };
> > > > > >
> > > > > >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > > > > > +     .ready          = vp_enable_vectors,
> > > > > >       .get            = vp_get,
> > > > > >       .set            = vp_set,
> > > > > >       .generation     = vp_generation,
> > > > > > --
> > > > > > 2.25.1
> > > > >
> > >


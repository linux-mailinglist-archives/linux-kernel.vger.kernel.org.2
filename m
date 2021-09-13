Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D3A4084C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbhIMGiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237377AbhIMGiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631515028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqkyzUI1dnGPwIvrGQ+g2Xfc1wH8fcvMTQo++GQRrBM=;
        b=MqDdKUvDYfbmSXPGfRexT26s4gjtoWUgUR/04S8FPxXoYzbm5s19+9cSGloJl9bZ5rOoDU
        j45mKljZdcKix9BqQAKsCJHto8k5cpUyAp/fUQwa/s7zVj+6hBZBYOl0gP/DrYtgenOqRe
        e4QZknOnXox906f/ofrFRGW/0N5rqF0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-Qxd_XxYiNCq-1mP582XcxA-1; Mon, 13 Sep 2021 02:37:07 -0400
X-MC-Unique: Qxd_XxYiNCq-1mP582XcxA-1
Received: by mail-lj1-f198.google.com with SMTP id e10-20020a05651c04ca00b001c99c74e564so3720976lji.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqkyzUI1dnGPwIvrGQ+g2Xfc1wH8fcvMTQo++GQRrBM=;
        b=ePIED84H7DyBAPTSMf6C7489Wn1hW+s9a5taXYatHLbE1ZcFRcZ1nuVpcBIMIB9WCW
         +FG9aWrcCnfplqchfbYzaAqr55dkpKFpeY68k7oV774IU8IV3kQE6nrcsxyK0GiXfN5v
         3uXt+xVbJ6gtxaZauk0Bk+30rONbKXlLdrmDdWhnJH4T5UroryfhTgnk6yXbauzyG+cl
         AbsTz5nba7eGxTX93xExa+bup0FJpMh2YX7kPDUWGZt9UL/bLtaRAl3oKFz7XEhYq9H0
         AugslGYgcO5FrD2lE2Fuog2C9mMqpiB/f5Uf0shGB8W/fVkRA2wB6Gf2F976CdqZu5C4
         B3SA==
X-Gm-Message-State: AOAM533MqZcCCEW9r4zLzWALscYUJRhKTxwsdF+7SMhzrMeWPXSGV5nu
        jiCzfcopt8EgBSGZfQi1tuQms+WjuQT1iNour7D5iczK52ki4Qkgf5uVCh1+xFMfpbf5npDzBTi
        KOD6O8WiG6dPqzFLLaqUIX1uWgtqBeQPOvphmFhrS
X-Received: by 2002:a2e:5353:: with SMTP id t19mr259576ljd.420.1631515025416;
        Sun, 12 Sep 2021 23:37:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbn7iuunCofdqVJY1OJWnNhI+lYxdwaHwFNiEIVLQCDg/YbWIC45Gj6fnmMR5J32oFhSBKyFcX6loiH4oMsqE=
X-Received: by 2002:a2e:5353:: with SMTP id t19mr259567ljd.420.1631515025176;
 Sun, 12 Sep 2021 23:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com> <20210913055353.35219-8-jasowang@redhat.com>
 <20210913022824-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210913022824-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 13 Sep 2021 14:36:54 +0800
Message-ID: <CACGkMEtnmLzQDNVYnAYSsEmjjRJVDhuK6VNj56S__zU9+5-JQQ@mail.gmail.com>
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

On Mon, Sep 13, 2021 at 2:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 13, 2021 at 01:53:51PM +0800, Jason Wang wrote:
> > This patch tries to make sure the virtio interrupt handler for INTX
> > won't be called after a reset and before virtio_device_ready(). We
> > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > intx_soft_enabled variable and toggle it during in
> > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > intx_soft_enabled before processing the actual interrupt.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> Not all that excited about all the memory barriers for something
> that should be an extremely rare event (for most kernels -
> literally once per boot). Can't we do better?

I'm not sure, but do we need to care about the slow path (INTX)?

(Or do you have a better approach?)

Thanks

>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 18 ++++++++++++++++--
> >  drivers/virtio/virtio_pci_common.h |  1 +
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index 0b9523e6dd39..835197151dc1 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -30,8 +30,12 @@ void vp_disable_vectors(struct virtio_device *vdev)
> >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >       int i;
> >
> > -     if (vp_dev->intx_enabled)
> > +     if (vp_dev->intx_enabled) {
> > +             vp_dev->intx_soft_enabled = false;
> > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > +             smp_wmb();
> >               synchronize_irq(vp_dev->pci_dev->irq);
> > +     }
> >
> >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > @@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
> >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >       int i;
> >
> > -     if (vp_dev->intx_enabled)
> > +     if (vp_dev->intx_enabled) {
> > +             vp_dev->intx_soft_enabled = true;
> > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > +             smp_wmb();
> >               return;
> > +     }
> >
> >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > @@ -97,6 +105,12 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> >       struct virtio_pci_device *vp_dev = opaque;
> >       u8 isr;
> >
> > +     if (!vp_dev->intx_soft_enabled)
> > +             return IRQ_NONE;
> > +
> > +     /* read intx_soft_enabled before read others */
> > +     smp_rmb();
> > +
> >       /* reading the ISR has the effect of also clearing it so it's very
> >        * important to save off the value. */
> >       isr = ioread8(vp_dev->isr);
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16004408510
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhIMHDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237454AbhIMHDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631516547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B3xga+XtM9D0cLew21idW0fKhvufHgnjYqMJYJQKJQA=;
        b=Ap/SQD2qgzd4RNCeK/Tan/YMup51mBHXgZrFVIolbvWXj+40X0rrlQxewC5Qugr24FcdLN
        cTk3DwyFmSIy+AtJBQEsxCLlOWzXMz8J+UOaAt8LUkqoiFiHCd7BaOrXwGUVgdxKB16qcx
        1C8NnYbT4khwEEiVXk7HGEw104xFWCA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-OyVxqedSNyuzExXjvFxEJA-1; Mon, 13 Sep 2021 03:02:26 -0400
X-MC-Unique: OyVxqedSNyuzExXjvFxEJA-1
Received: by mail-wr1-f71.google.com with SMTP id r9-20020a5d4989000000b0015d0fbb8823so2111440wrq.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B3xga+XtM9D0cLew21idW0fKhvufHgnjYqMJYJQKJQA=;
        b=pqrdn2zDD2hL5fOvvW0dOiv+8ppL7+l9lRb9Ji9z7qnxK2o4ckLKdXItNxvOykxMyI
         dinVAiYoX5zcvpqJFGMtiVppLeJ71zXMQurU7384lwzoJR+LQY/+0TbhGNepSnkRS6Mo
         mLL8ypzJT2xftVNapEuIUZO1YcSyEWeAYTOJfSKRtMbenQf7cO44+RXeZm/3lpKU9hXy
         mOi6tV8bqWdtMt+wOwviHsDizuz6TKRzceWct6r10mvGLJZGnB6PnU81QeW6Lq9FtZNG
         SUPBL2nhpHqj1NGtpEuxlPWzZq1T7BG0Bqcb+1SxFgIFXV5Ifj6b6DqBL/g9yspmDBTP
         LjmA==
X-Gm-Message-State: AOAM5303EYXLEOzwTNpUcNrA+ldugwDin82CVTop+aBni7V/2g6TKa7q
        71E3juDWEwf+Ra2CFkmoO5loR+MA8KMhhRz2rBDmwfDgv9snEVuncMoN9n8+3BnKRITHlBFS/tK
        6WmwvehOrfkGFf8eeZ8QzUemN
X-Received: by 2002:a1c:2547:: with SMTP id l68mr9485136wml.23.1631516545539;
        Mon, 13 Sep 2021 00:02:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD55TVvlDtRtqgJCBRla+/PTUug5ntfDs6eJ/eUl/ouRdkIPoitUu0G630NOp5JJrqUko78w==
X-Received: by 2002:a1c:2547:: with SMTP id l68mr9485113wml.23.1631516545307;
        Mon, 13 Sep 2021 00:02:25 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
        by smtp.gmail.com with ESMTPSA id v20sm6613465wra.73.2021.09.13.00.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:02:24 -0700 (PDT)
Date:   Mon, 13 Sep 2021 03:02:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
Message-ID: <20210913030134-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com>
 <20210913022824-mutt-send-email-mst@kernel.org>
 <CACGkMEtnmLzQDNVYnAYSsEmjjRJVDhuK6VNj56S__zU9+5-JQQ@mail.gmail.com>
 <20210913023757-mutt-send-email-mst@kernel.org>
 <CACGkMEskmq7azAP6QiNz=_nXaU6vbtr975wk3kr9H6pOGs-ZuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEskmq7azAP6QiNz=_nXaU6vbtr975wk3kr9H6pOGs-ZuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 02:45:38PM +0800, Jason Wang wrote:
> On Mon, Sep 13, 2021 at 2:41 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 02:36:54PM +0800, Jason Wang wrote:
> > > On Mon, Sep 13, 2021 at 2:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Sep 13, 2021 at 01:53:51PM +0800, Jason Wang wrote:
> > > > > This patch tries to make sure the virtio interrupt handler for INTX
> > > > > won't be called after a reset and before virtio_device_ready(). We
> > > > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > > > intx_soft_enabled variable and toggle it during in
> > > > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > > > intx_soft_enabled before processing the actual interrupt.
> > > > >
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > >
> > > >
> > > > Not all that excited about all the memory barriers for something
> > > > that should be an extremely rare event (for most kernels -
> > > > literally once per boot). Can't we do better?
> > >
> > > I'm not sure, but do we need to care about the slow path (INTX)?
> >
> > Otherwise we won't try to support this, right?
> 
> Sorry, what I meant is "do we need to care about the performance of
> the slow path".
> 
> >
> > > (Or do you have a better approach?)
> > >
> > > Thanks
> >
> > Don't know really, maybe rcu or whatever?
> 
> I am sure it's worth it to bother since it's the slow path.
> 
> > But let's try to be much more specific - is there anything
> > specific we are trying to protect against here?
> 
> The unexpected calling of the vring or config interrupt handler. (The
> same as MSI-X, e.g the untrusted device can send irq at any time).
> 
> Thanks

And so, does this do more than crash the guest?  Hypervisors
already can do that ...


> >
> >
> >
> > > >
> > > > > ---
> > > > >  drivers/virtio/virtio_pci_common.c | 18 ++++++++++++++++--
> > > > >  drivers/virtio/virtio_pci_common.h |  1 +
> > > > >  2 files changed, 17 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > index 0b9523e6dd39..835197151dc1 100644
> > > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > > @@ -30,8 +30,12 @@ void vp_disable_vectors(struct virtio_device *vdev)
> > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > >       int i;
> > > > >
> > > > > -     if (vp_dev->intx_enabled)
> > > > > +     if (vp_dev->intx_enabled) {
> > > > > +             vp_dev->intx_soft_enabled = false;
> > > > > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > > > > +             smp_wmb();
> > > > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > > > +     }
> > > > >
> > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > @@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
> > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > >       int i;
> > > > >
> > > > > -     if (vp_dev->intx_enabled)
> > > > > +     if (vp_dev->intx_enabled) {
> > > > > +             vp_dev->intx_soft_enabled = true;
> > > > > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > > > > +             smp_wmb();
> > > > >               return;
> > > > > +     }
> > > > >
> > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > @@ -97,6 +105,12 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> > > > >       struct virtio_pci_device *vp_dev = opaque;
> > > > >       u8 isr;
> > > > >
> > > > > +     if (!vp_dev->intx_soft_enabled)
> > > > > +             return IRQ_NONE;
> > > > > +
> > > > > +     /* read intx_soft_enabled before read others */
> > > > > +     smp_rmb();
> > > > > +
> > > > >       /* reading the ISR has the effect of also clearing it so it's very
> > > > >        * important to save off the value. */
> > > > >       isr = ioread8(vp_dev->isr);
> > > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > > index a235ce9ff6a5..3c06e0f92ee4 100644
> > > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > > @@ -64,6 +64,7 @@ struct virtio_pci_device {
> > > > >       /* MSI-X support */
> > > > >       int msix_enabled;
> > > > >       int intx_enabled;
> > > > > +     bool intx_soft_enabled;
> > > > >       cpumask_var_t *msix_affinity_masks;
> > > > >       /* Name strings for interrupts. This size should be enough,
> > > > >        * and I'm too lazy to allocate each name separately. */
> > > > > --
> > > > > 2.25.1
> > > >
> >


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41A73209EE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 12:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBUL2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 06:28:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229540AbhBUL2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 06:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613906802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Ig11Pa9JeTNL+845eeMHRWH78YC6z1GjViCXAPXliA=;
        b=TpnUya5N1LHc0C6uCBBs7hLeUP7VT9mmOH7pWCb+bMEJ0h7B93KZvV6cmWhJwvE3WUukG8
        0WFLYTlGRnIfsO/dkL+qw7lEC1FU6Ns1LADAZtTNn1+PtTWK7PUz0eo2yaZl9xFNR27OBO
        N/10lBwcfm4X8gdn9WiApDjSRjcY4Ls=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-NdGx_aCcOnu8kb4ezjpkWA-1; Sun, 21 Feb 2021 06:26:40 -0500
X-MC-Unique: NdGx_aCcOnu8kb4ezjpkWA-1
Received: by mail-ed1-f72.google.com with SMTP id g20so2851842edy.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 03:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8Ig11Pa9JeTNL+845eeMHRWH78YC6z1GjViCXAPXliA=;
        b=YE3aRgmz1qOLFwHcC8rFix/MqsvK4/RKP58WnNR8uK5T+SPnaYECgAA7i+UD6TW8ME
         Z3tkmkC/ynxYG/jPeh4SKo4t7/E337Vegsh1za0lXzcIQ1lR1NNolAxumPodZc2S1Vnh
         pKFgoX1DJiRjAzIbEAk0dF+vmY4d6mtiGI5RptIYwZUshqIUiszz4kH6homaAU3kPARH
         UpfZpwDLJf8u3glW5OpZYlupV2mDtmoF8Jr6h1uwBomuTX4j/2XIA6CJIwcpswNt5h4V
         k0hYE9N+jnZlzHKjmtlPmig/z9NqgU/f+HNvtadPkA/lB64PWl7vp5vym/hrGYjrGJ5c
         Q9Rw==
X-Gm-Message-State: AOAM530EGcsXEPEf3uVjnxc9wqi2UPDmDz0X1CIQ+JnA5q2uEeTurDRn
        MtKRArUzEibfQeTVI6oMQgI5X7cu8RRCqeCqGgR49g2Oqi8GNYl9GqrYANgM4RRhDev1AsU0DOs
        NmVD5Hh22XN7KpPvX1qVj2Iqq
X-Received: by 2002:a17:906:4e19:: with SMTP id z25mr16557668eju.205.1613906799394;
        Sun, 21 Feb 2021 03:26:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJym3ziM+C3oMmyNcWorCks/womKKudglaEVoLH6vh9AKa0j8BznTKu7kNGodpjIodbGSXj1HA==
X-Received: by 2002:a17:906:4e19:: with SMTP id z25mr16557658eju.205.1613906799243;
        Sun, 21 Feb 2021 03:26:39 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id gt7sm5268170ejc.121.2021.02.21.03.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 03:26:38 -0800 (PST)
Date:   Sun, 21 Feb 2021 06:26:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-mmio: Use to_virtio_mmio_device() to simply code
Message-ID: <20210221062628-mutt-send-email-mst@kernel.org>
References: <20210210030401.5532-1-tangbin@cmss.chinamobile.com>
 <b7043be4-46cf-e72c-b3aa-4a8d487e82ad@redhat.com>
 <740b0c1f-24d4-de31-8753-4c5ec07b92f9@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <740b0c1f-24d4-de31-8753-4c5ec07b92f9@cmss.chinamobile.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 09:34:08AM +0800, Tang Bin wrote:
> Dear Jason：
> 
>       Sorry for the late reply this email.
> 
> 在 2021/2/10 16:09, Jason Wang 写道:
> > 
> > On 2021/2/10 上午11:04, Tang Bin wrote:
> > > The file virtio_mmio.c has defined the function to_virtio_mmio_device,
> > > so use it instead of container_of() to simply code. And remove
> > > superfluous blank lines in this file.
> > > 
> > > Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> > > ---
> > >   drivers/virtio/virtio_mmio.c | 16 +---------------
> > >   1 file changed, 1 insertion(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > > index 627ac0487..449d0f209 100644
> > > --- a/drivers/virtio/virtio_mmio.c
> > > +++ b/drivers/virtio/virtio_mmio.c
> > > @@ -69,14 +69,10 @@
> > >   #include <uapi/linux/virtio_mmio.h>
> > >   #include <linux/virtio_ring.h>
> > >   -
> > > -
> > 
> > 
> > It's better not mix the patch with style changes.
> > 
> > Other looks good.
> > 
> > Thanks
> 
> Whether should I send patch V2？
> 
> Thanks


Please do.

> > 
> > 
> > >   /* The alignment to use between consumer and producer parts of vring.
> > >    * Currently hardcoded to the page size. */
> > >   #define VIRTIO_MMIO_VRING_ALIGN        PAGE_SIZE
> > >   -
> > > -
> > >   #define to_virtio_mmio_device(_plat_dev) \
> > >       container_of(_plat_dev, struct virtio_mmio_device, vdev)
> > >   @@ -100,8 +96,6 @@ struct virtio_mmio_vq_info {
> > >       struct list_head node;
> > >   };
> > >   -
> > > -
> > >   /* Configuration interface */
> > >     static u64 vm_get_features(struct virtio_device *vdev)
> > > @@ -264,8 +258,6 @@ static void vm_reset(struct virtio_device *vdev)
> > >       writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> > >   }
> > >   -
> > > -
> > >   /* Transport interface */
> > >     /* the notify function used when creating a virt queue */
> > > @@ -307,8 +299,6 @@ static irqreturn_t vm_interrupt(int irq, void
> > > *opaque)
> > >       return ret;
> > >   }
> > >   -
> > > -
> > >   static void vm_del_vq(struct virtqueue *vq)
> > >   {
> > >       struct virtio_mmio_device *vm_dev =
> > > to_virtio_mmio_device(vq->vdev);
> > > @@ -512,13 +502,11 @@ static const struct virtio_config_ops
> > > virtio_mmio_config_ops = {
> > >       .bus_name    = vm_bus_name,
> > >   };
> > >   -
> > >   static void virtio_mmio_release_dev(struct device *_d)
> > >   {
> > >       struct virtio_device *vdev =
> > >               container_of(_d, struct virtio_device, dev);
> > > -    struct virtio_mmio_device *vm_dev =
> > > -            container_of(vdev, struct virtio_mmio_device, vdev);
> > > +    struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> > >       struct platform_device *pdev = vm_dev->pdev;
> > >         devm_kfree(&pdev->dev, vm_dev);
> > > @@ -608,8 +596,6 @@ static int virtio_mmio_remove(struct
> > > platform_device *pdev)
> > >       return 0;
> > >   }
> > >   -
> > > -
> > >   /* Devices list parameter */
> > >     #if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)
> > 
> 


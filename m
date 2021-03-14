Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C6933A388
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 09:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhCNI1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 04:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234944AbhCNI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 04:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615710424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GFza66MGjkmqcb+P+WR/8xxm8S5ZeuJzJsDH9rg8ne8=;
        b=ifEwcLL2q/el+NHJEC6eI7TX3Qzt0iBKVzNC0lEXvs1F9LXe1PJ+UfRYujqEgrAv8uGb7o
        8gMsmWMWSrbyLUGCm6uwlpWpP09Y1EcrUGxpBzuzpyBOFYN5+ZWX5UiUyq9sPebriEoWa+
        y5BfEYFEdGoHZtrwCCDude0MCg/JVcw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-uQrXAEeNP8SGRqX37r4nJQ-1; Sun, 14 Mar 2021 04:27:02 -0400
X-MC-Unique: uQrXAEeNP8SGRqX37r4nJQ-1
Received: by mail-wr1-f70.google.com with SMTP id h21so13379069wrc.19
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 00:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GFza66MGjkmqcb+P+WR/8xxm8S5ZeuJzJsDH9rg8ne8=;
        b=BQKFiP9XHwcXpqRHStkdsLFFdQaEygmmkAXKK9ac1k428xRPT3K8YYSU9CMr1zu50Q
         FdPt7J0/jHjOt3mOx+Ol1J9rxuiVAQwchR/RfBawVYzFaf4M2a+TlHlQZlEihWI5YLuk
         QV+vm4c4HGWFmnNJZppgnagWI+KVWeb+pC/rfoiIOXLtFqq4cOQW0vZiBiphbePP6T2E
         zvKvqNksCEAP3/Ji1cBF79zRvc7uxqu3TtBVj+0iRUep3kEEK/KuZ8KoYtGoi2S+7+Px
         exwet0fWze7YSU7c98KBxXf0S6/kEvwpAQWxehTH+q4uAyLn+7TYqU0C9sdaHM3zh9L3
         I97g==
X-Gm-Message-State: AOAM530TOxCEA+ZsgqyVXq8mnhzxTWBTR4svnEkIcs96JA+bDnntxJ9m
        deohqZY3DaZUSXlsC0KsRmwARU3OkCEE8i1a5HYq69+hq5bTuY80/W1AyAwa8d8hxreDqe+AVID
        z9c3RTNuATYr3thCPbfu91Aoa
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr22029675wrw.351.1615710421274;
        Sun, 14 Mar 2021 00:27:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKnWuLs8sfVuJDUXO5TPsB2edZfCWoKeglFZEVvuQNi26qHIwmjHiiKDOZdYcyfL+oBUHyaw==
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr22029667wrw.351.1615710421144;
        Sun, 14 Mar 2021 00:27:01 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id c9sm14807528wrr.78.2021.03.14.00.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 00:27:00 -0800 (PST)
Date:   Sun, 14 Mar 2021 04:26:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-mmio: read[wl]()/write[wl] are already
 little-endian
Message-ID: <20210314041749-mutt-send-email-mst@kernel.org>
References: <20210309224313.956065-1-laurent@vivier.eu>
 <20210311104414-mutt-send-email-mst@kernel.org>
 <a8a0b68c-d36d-c675-3c6d-d4fca996fdfd@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8a0b68c-d36d-c675-3c6d-d4fca996fdfd@vivier.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 06:10:29PM +0100, Laurent Vivier wrote:
> Le 11/03/2021 à 16:44, Michael S. Tsirkin a écrit :
> > On Tue, Mar 09, 2021 at 11:43:13PM +0100, Laurent Vivier wrote:
> >> read[wl]()/write[wl] already access memory in little-endian mode.
> > 
> > But then they convert it to CPU right? We just convert it back ...
> 
> In fact the problem is in QEMU.
> 
> On a big-endian guest, the readw() returns a byte-swapped value, This means QEMU doesn't provide a
> little-endian value.
> 
> I found in QEMU virtio_mmio_read() provides a value with byte-swapped bytes.
> 
> The problem comes from virtio_config_readX() functions that read the value using ldX_p accessors.
> 
> Is it normal not to use the modern variant here if we are not in legacy mode?
> 
> I think we should have something like this in virtio_mmio_read (and write):
> 
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -112,15 +112,28 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
> 
>      if (offset >= VIRTIO_MMIO_CONFIG) {
>          offset -= VIRTIO_MMIO_CONFIG;
> -        switch (size) {
> -        case 1:
> -            return virtio_config_readb(vdev, offset);
> -        case 2:
> -            return virtio_config_readw(vdev, offset);
> -        case 4:
> -            return virtio_config_readl(vdev, offset);
> -        default:
> -            abort();
> +        if (proxy->legacy) {
> +            switch (size) {
> +            case 1:
> +                return virtio_config_readb(vdev, offset);
> +            case 2:
> +                return virtio_config_readw(vdev, offset);
> +            case 4:
> +                return virtio_config_readl(vdev, offset);
> +            default:
> +                abort();
> +            }
> +        } else {
> +            switch (size) {
> +            case 1:
> +                return virtio_config_modern_readb(vdev, offset);
> +            case 2:
> +                return virtio_config_modern_readw(vdev, offset);
> +            case 4:
> +                return virtio_config_modern_readl(vdev, offset);
> +            default:
> +                abort();
> +            }
>          }
>      }
>      if (size != 4) {

Sounds reasonable ...


> And we need the same thing in virtio_pci_config_read() (and write).

We already have it, see below.

> And this could explain why it works with virtio-pci and not with virtio-mmio with the big-endian guest:
> 
> with virtio-pci the bytes are swapped twice (once in virtio-mmio and then in virtio-pci), so they
> are restored to the initial value, whereas with direct virtio-mmio they are swapped only once.
> 
> Thanks,
> Laurent

virtio pci does this: modern accesses use:

	virtio_pci_device_read

static uint64_t virtio_pci_device_read(void *opaque, hwaddr addr,
                                       unsigned size)
{
    VirtIOPCIProxy *proxy = opaque;
    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
    uint64_t val = 0;

    if (vdev == NULL) {
        return val;
    }

    switch (size) {
    case 1:
        val = virtio_config_modern_readb(vdev, addr);
        break;
    case 2:
        val = virtio_config_modern_readw(vdev, addr);
        break;
    case 4:
        val = virtio_config_modern_readl(vdev, addr);
        break;
    }
    return val;
}


while legacy accesses use:

	virtio_pci_config_read

static uint64_t virtio_pci_config_read(void *opaque, hwaddr addr,
                                       unsigned size)
{
    VirtIOPCIProxy *proxy = opaque;
    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
    uint32_t config = VIRTIO_PCI_CONFIG_SIZE(&proxy->pci_dev);
    uint64_t val = 0;
    if (addr < config) {
        return virtio_ioport_read(proxy, addr);
    }
    addr -= config;

    switch (size) {
    case 1:
        val = virtio_config_readb(vdev, addr);
        break;
    case 2:
        val = virtio_config_readw(vdev, addr);
        if (virtio_is_big_endian(vdev)) {
            val = bswap16(val);
        }
        break;
    case 4:
        val = virtio_config_readl(vdev, addr);
        if (virtio_is_big_endian(vdev)) {
            val = bswap32(val);
        }
        break;
    }
    return val;
}


the naming is configing but there you are.

virtio_pci_config_read is also calling virtio_is_big_endian.

        
static inline bool virtio_is_big_endian(VirtIODevice *vdev)
{       
    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
        assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
        return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
    }   
    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
    return false;
}       
            

I note that
virtio_is_big_endian is kind of wrong for modern config accesses since it
checks guest feature bits - config accesses are done before features are
acknowledged.
Luckily this function is never called for a modern guest ...
It would be nice to add virtio_legacy_is_big_endian and call that
when we know it's a legacy interface.


-- 
MST


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD6843AFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhJZKY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229687AbhJZKYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635243721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fwG+pbc/RX0UtcP7zmAqWBtlccSZoVrnTVcmaM/OGoo=;
        b=PJm/YYiMu/vo/Ir0hLt6Ia0d+iusiWxXytz/UQYE9V7NhCacfxkRsocWiUGpVB/1mKeKGe
        03DNu7ijHUtG6XkMvO+6XVKHE6speGzh9ZNJ/IBAR5mCztqGAzJDFRf087RPNzp6HOQEMm
        QXoFIGBcXAVCDWiU5Mp/va6k7uJQZ2Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-np6SfI2NNA6kNs-h0cR3Cg-1; Tue, 26 Oct 2021 06:21:59 -0400
X-MC-Unique: np6SfI2NNA6kNs-h0cR3Cg-1
Received: by mail-lf1-f71.google.com with SMTP id z7-20020a0565120c0700b003ffb3da4283so488393lfu.23
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwG+pbc/RX0UtcP7zmAqWBtlccSZoVrnTVcmaM/OGoo=;
        b=SwMMZc/4sghYQd8KZSjOt3Zr6tfTVkZzhf+RHTMQ2tsobj52qzkr2C8sd0qza5jKze
         lUmnI+8RfmuyU3s4WhmYIGQ+MO4Sg6s3aOIY7tzXphfKobsI9AHs3/QW4LTu5OQEre0U
         3zS1MeBerPfKOt+uwqajZ88bRiD8AGRxAbcIQxwuj29tp3kM8YPFYCvreTI0FVNbaSzj
         Dro6sXCjICXELwbbbp04W0KOX9TDrZ5ReZWka0uq95010xHndyBI4irwplSdgCD3m2j+
         iwoGolNBGAHL7aR9DPZrc16Wv4wnTQxNfpbLLIi+zhzqAfyzwmt2vt4xlz/MMfyBUV3W
         eBLA==
X-Gm-Message-State: AOAM530hL4Enr6D5fwUCmU6eJkKTdA0Dc+JqRJAhRbsNND7ohakxSaut
        eVLmJ3fZhCr1usz0B3txLZtZAJrhr/fOzQM/L3ZnmOM8ZRagOYC0CCQFjsUu6sX1B3NPD5VnVq3
        zviRX23q1p4c3KKi3yKgTAaWxtUeHeyTWn3Tqvu6x
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr22929108lfg.498.1635243717958;
        Tue, 26 Oct 2021 03:21:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRi7eDA7VNK2NZZvjOTAi7iKncvVwBcSyj0I/WsPXPEK8+uGW2NAe1yK0dNgSsnT1GGqJ206I8AuI2ZWl/F7w=
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr22929089lfg.498.1635243717653;
 Tue, 26 Oct 2021 03:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211026072000.8699-1-jasowang@redhat.com> <20211026072000.8699-2-jasowang@redhat.com>
 <20211026053741-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211026053741-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Oct 2021 18:21:46 +0800
Message-ID: <CACGkMEv64WkTB22CTy_Y_0VPLjT+YLCx6Ea8+Lg2ZDCKOid8UQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/4] virtio_ring: validate used buffer length
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

On Tue, Oct 26, 2021 at 5:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 26, 2021 at 03:19:57PM +0800, Jason Wang wrote:
> > This patch validate the used buffer length provided by the device
> > before trying to use it. This is done by record the in buffer length
> > in a new field in desc_state structure during virtqueue_add(), then we
> > can fail the virtqueue_get_buf() when we find the device is trying to
> > give us a used buffer length which is greater than the in buffer
> > length.
> >
> > Since some drivers have already done the validation by themselves,
> > this patch tries to makes the core validation optional. For the driver
> > that doesn't want the validation, it can set the validate_used to be
> > true (which could be overridden by force_used_validation). To be more
>
> This description is now out of date. it's suppress_used_validation.

Yes, do you want me to post a new version or do you want to fix it for me?

Thanks

>
> > efficient, a dedicate array is used for storing the validate used
> > length, this helps to eliminate the cache stress if validation is done
> > by the driver.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 60 ++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  2 ++
> >  2 files changed, 62 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 4c0ec82cef56..a6e5a3b94337 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -14,6 +14,9 @@
> >  #include <linux/spinlock.h>
> >  #include <xen/xen.h>
> >
> > +static bool force_used_validation = false;
> > +module_param(force_used_validation, bool, 0444);
> > +
> >  #ifdef DEBUG
> >  /* For development, we want to crash whenever the ring is screwed. */
> >  #define BAD_RING(_vq, fmt, args...)                          \
> > @@ -182,6 +185,9 @@ struct vring_virtqueue {
> >               } packed;
> >       };
> >
> > +     /* Per-descriptor in buffer length */
> > +     u32 *buflen;
> > +
> >       /* How to notify other side. FIXME: commonalize hcalls! */
> >       bool (*notify)(struct virtqueue *vq);
> >
> > @@ -490,6 +496,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >       unsigned int i, n, avail, descs_used, prev, err_idx;
> >       int head;
> >       bool indirect;
> > +     u32 buflen = 0;
> >
> >       START_USE(vq);
> >
> > @@ -571,6 +578,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >                                                    VRING_DESC_F_NEXT |
> >                                                    VRING_DESC_F_WRITE,
> >                                                    indirect);
> > +                     buflen += sg->length;
> >               }
> >       }
> >       /* Last one doesn't continue. */
> > @@ -610,6 +618,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >       else
> >               vq->split.desc_state[head].indir_desc = ctx;
> >
> > +     /* Store in buffer length if necessary */
> > +     if (vq->buflen)
> > +             vq->buflen[head] = buflen;
> > +
> >       /* Put entry in available array (but don't update avail->idx until they
> >        * do sync). */
> >       avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > @@ -784,6 +796,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >               BAD_RING(vq, "id %u is not a head!\n", i);
> >               return NULL;
> >       }
> > +     if (vq->buflen && unlikely(*len > vq->buflen[i])) {
> > +             BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> > +                     *len, vq->buflen[i]);
> > +             return NULL;
> > +     }
> >
> >       /* detach_buf_split clears data, so grab it now. */
> >       ret = vq->split.desc_state[i].data;
> > @@ -1062,6 +1079,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> >       unsigned int i, n, err_idx;
> >       u16 head, id;
> >       dma_addr_t addr;
> > +     u32 buflen = 0;
> >
> >       head = vq->packed.next_avail_idx;
> >       desc = alloc_indirect_packed(total_sg, gfp);
> > @@ -1091,6 +1109,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> >                       desc[i].addr = cpu_to_le64(addr);
> >                       desc[i].len = cpu_to_le32(sg->length);
> >                       i++;
> > +                     if (n >= out_sgs)
> > +                             buflen += sg->length;
> >               }
> >       }
> >
> > @@ -1144,6 +1164,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> >       vq->packed.desc_state[id].indir_desc = desc;
> >       vq->packed.desc_state[id].last = id;
> >
> > +     /* Store in buffer length if necessary */
> > +     if (vq->buflen)
> > +             vq->buflen[id] = buflen;
> > +
> >       vq->num_added += 1;
> >
> >       pr_debug("Added buffer head %i to %p\n", head, vq);
> > @@ -1179,6 +1203,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >       __le16 head_flags, flags;
> >       u16 head, id, prev, curr, avail_used_flags;
> >       int err;
> > +     u32 buflen = 0;
> >
> >       START_USE(vq);
> >
> > @@ -1258,6 +1283,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >                                       1 << VRING_PACKED_DESC_F_AVAIL |
> >                                       1 << VRING_PACKED_DESC_F_USED;
> >                       }
> > +                     if (n >= out_sgs)
> > +                             buflen += sg->length;
> >               }
> >       }
> >
> > @@ -1277,6 +1304,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >       vq->packed.desc_state[id].indir_desc = ctx;
> >       vq->packed.desc_state[id].last = prev;
> >
> > +     /* Store in buffer length if necessary */
> > +     if (vq->buflen)
> > +             vq->buflen[id] = buflen;
> > +
> >       /*
> >        * A driver MUST NOT make the first descriptor in the list
> >        * available before all subsequent descriptors comprising
> > @@ -1463,6 +1494,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >               BAD_RING(vq, "id %u is not a head!\n", id);
> >               return NULL;
> >       }
> > +     if (vq->buflen && unlikely(*len > vq->buflen[id])) {
> > +             BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> > +                     *len, vq->buflen[id]);
> > +             return NULL;
> > +     }
> >
> >       /* detach_buf_packed clears data, so grab it now. */
> >       ret = vq->packed.desc_state[id].data;
> > @@ -1668,6 +1704,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >       struct vring_virtqueue *vq;
> >       struct vring_packed_desc *ring;
> >       struct vring_packed_desc_event *driver, *device;
> > +     struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
> >       dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
> >       size_t ring_size_in_bytes, event_size_in_bytes;
> >
> > @@ -1757,6 +1794,15 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >       if (!vq->packed.desc_extra)
> >               goto err_desc_extra;
> >
> > +     if (!drv->suppress_used_validation || force_used_validation) {
> > +             vq->buflen = kmalloc_array(num, sizeof(*vq->buflen),
> > +                                        GFP_KERNEL);
> > +             if (!vq->buflen)
> > +                     goto err_buflen;
> > +     } else {
> > +             vq->buflen = NULL;
> > +     }
> > +
> >       /* No callback?  Tell other side not to bother us. */
> >       if (!callback) {
> >               vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
> > @@ -1769,6 +1815,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >       spin_unlock(&vdev->vqs_list_lock);
> >       return &vq->vq;
> >
> > +err_buflen:
> > +     kfree(vq->packed.desc_extra);
> >  err_desc_extra:
> >       kfree(vq->packed.desc_state);
> >  err_desc_state:
> > @@ -2176,6 +2224,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >                                       void (*callback)(struct virtqueue *),
> >                                       const char *name)
> >  {
> > +     struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
> >       struct vring_virtqueue *vq;
> >
> >       if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> > @@ -2235,6 +2284,15 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >       if (!vq->split.desc_extra)
> >               goto err_extra;
> >
> > +     if (!drv->suppress_used_validation || force_used_validation) {
> > +             vq->buflen = kmalloc_array(vring.num, sizeof(*vq->buflen),
> > +                                        GFP_KERNEL);
> > +             if (!vq->buflen)
> > +                     goto err_buflen;
> > +     } else {
> > +             vq->buflen = NULL;
> > +     }
> > +
> >       /* Put everything in free lists. */
> >       vq->free_head = 0;
> >       memset(vq->split.desc_state, 0, vring.num *
> > @@ -2245,6 +2303,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >       spin_unlock(&vdev->vqs_list_lock);
> >       return &vq->vq;
> >
> > +err_buflen:
> > +     kfree(vq->split.desc_extra);
> >  err_extra:
> >       kfree(vq->split.desc_state);
> >  err_state:
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 41edbc01ffa4..44d0e09da2d9 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -152,6 +152,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
> >   * @feature_table_size: number of entries in the feature table array.
> >   * @feature_table_legacy: same as feature_table but when working in legacy mode.
> >   * @feature_table_size_legacy: number of entries in feature table legacy array.
> > + * @suppress_used_validation: set to not have core validate used length
> >   * @probe: the function to call when a device is found.  Returns 0 or -errno.
> >   * @scan: optional function to call after successful probe; intended
> >   *    for virtio-scsi to invoke a scan.
> > @@ -168,6 +169,7 @@ struct virtio_driver {
> >       unsigned int feature_table_size;
> >       const unsigned int *feature_table_legacy;
> >       unsigned int feature_table_size_legacy;
> > +     bool suppress_used_validation;
> >       int (*validate)(struct virtio_device *dev);
> >       int (*probe)(struct virtio_device *dev);
> >       void (*scan)(struct virtio_device *dev);
> > --
> > 2.25.1
>


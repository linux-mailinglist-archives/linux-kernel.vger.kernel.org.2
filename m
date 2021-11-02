Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78AF44263B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 04:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhKBD5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 23:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232129AbhKBD45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635825263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZyyl0TVW5IjSjKmk16FYhpmpNrCsjekrv5/NqsRPmo=;
        b=MKwGIS4xB5AbsQANkagde5c9EvlQXr2Kp3NsIUa0Q3WHsM+9NGfsMmH5LSbJ0Vy8TyDJ2/
        eTdMkvjBOjjWbzejBeLl2VbJXb2qIfn83fNAvYKNv5lsMt+PUknlgXwQH5p7ZoHVi1M6Pr
        U2T6wQBo1atOlHT3dU6t0VJzP7+GbUQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-vdC7O_wLMNuw4WkeotA06g-1; Mon, 01 Nov 2021 23:54:22 -0400
X-MC-Unique: vdC7O_wLMNuw4WkeotA06g-1
Received: by mail-lj1-f198.google.com with SMTP id b8-20020a05651c028800b00211cc108922so6937662ljo.15
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 20:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZyyl0TVW5IjSjKmk16FYhpmpNrCsjekrv5/NqsRPmo=;
        b=MLjQ7gXuDCZaI/Yymoc+fsSIcKw+aHrRXCmtMEdnO08mwObHmtN2t3su0KxxHZnhBs
         SuZTw+c7hpkhW3lB3TkgXcZ987bb0qy2xIuatcE2FY9c/0xbOmCz7FsEXCWpDGF2fJRB
         uSmuxV3ljU2li+9nWL3N9AhClMXVzL3beWCREUcesb77K2X1wfkMqYvGqsR0LMHlnhgf
         aBbVPm+pqAy6UeOnoDxMa1BhjH0REOlb9Db0ML+/BNSBtifJiYuy3GVYrXwrvhX/j7CF
         DO0DrtP+d/Nui3HPwvGGsdogzLqAYM481NevSNp/61mpPYjeLIjlIClZ+emaC/reG3Kd
         1uHA==
X-Gm-Message-State: AOAM5308n275MR4rdI8V/wJTSigPg20m/qRKEZrmTLSNBmOZEqIgSkFl
        dwJ3f6ItBCT+SuZz7qrkw1BU2CIcW/OBQLFBMlSTHHg+S9v8CcQ07j2RnNxs/9mXMEWzd+vv5XZ
        zKZXZ7KxZmHngLB83NDfdTcsG7hhCdWUP4UY4C+Hy
X-Received: by 2002:a05:6512:1291:: with SMTP id u17mr32958874lfs.84.1635825260570;
        Mon, 01 Nov 2021 20:54:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRIQ+z5bRRGv9yeZAuxUIB+7vDq/QSTl9mFm+K4uBUJvyEW3Z26FBIzcgAayLu+2xhJTS/5htZMl4mL7Lcvfw=
X-Received: by 2002:a05:6512:1291:: with SMTP id u17mr32958849lfs.84.1635825260308;
 Mon, 01 Nov 2021 20:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211027022107.14357-2-jasowang@redhat.com> <1635823138.4631283-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1635823138.4631283-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 2 Nov 2021 11:54:09 +0800
Message-ID: <CACGkMEuTkbgWJKLb+McZRUbvu+BD+-S0HdqabyxjTrX2T5=CJA@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 11:22 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Wed, 27 Oct 2021 10:21:04 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > This patch validate the used buffer length provided by the device
> > before trying to use it. This is done by record the in buffer length
> > in a new field in desc_state structure during virtqueue_add(), then we
> > can fail the virtqueue_get_buf() when we find the device is trying to
> > give us a used buffer length which is greater than the in buffer
> > length.
> >
> > Since some drivers have already done the validation by themselves,
> > this patch tries to makes the core validation optional. For the driver
> > that doesn't want the validation, it can set the
> > suppress_used_validation to be true (which could be overridden by
> > force_used_validation module parameter). To be more efficient, a
> > dedicate array is used for storing the validate used length, this
> > helps to eliminate the cache stress if validation is done by the
> > driver.
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
>
> The reason for not using "struct vring_desc_state_split/ struct vring_desc_state_split"
> is to occupy less memory when turning off this function?

Less memory and less cache pressure.

Thanks

>
> Thanks.
>
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
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>


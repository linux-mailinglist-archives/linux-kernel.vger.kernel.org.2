Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68957408527
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhIMHQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237577AbhIMHPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631517232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jh0KU3Sv6x8sFcS0pPhFPEvAjOPvPT5qvBoko3QxumI=;
        b=CVowJMJUHkWsl/C/2QB729XAcqqWch5VTfqewHHHR9PCgEzKQyJMmarVj8xZ8ETbRQWupS
        5Z1QRqoBJZRbYBhNczu4SHbbIrc0PzF83G0tJRaecwm6B6ixyrGCpJzEI1diboGMPawpqO
        16wcjy/K88fxM/B82BX4z03GH2DjoxA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-_teRu90bNaaj4iafeg4CHg-1; Mon, 13 Sep 2021 03:13:51 -0400
X-MC-Unique: _teRu90bNaaj4iafeg4CHg-1
Received: by mail-lj1-f199.google.com with SMTP id b29-20020a2ebc1d000000b001ba014dfa94so3754432ljf.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jh0KU3Sv6x8sFcS0pPhFPEvAjOPvPT5qvBoko3QxumI=;
        b=bethpxb46KfsfOiIwI0eXrHQaVhXLI2f13OoTaKpQMgzbiY/lQnZl+DPeJufnWAWWY
         LDWv1Ibxdu5LxScMw+yAa1RmuitZ763tla6dzGNy7ENsgp/4f0giVyzrZ3rE3sUgjjZK
         aybYHBLBJ0oNWqSdKQqDOBQ74F0WLBUnWIIMuHeHy9M8Um9kS5C6CHpUwc27oZk4a1Gk
         VxNHAEM8paoc0CKoxem7+z1GHoV1V8gqS9hk3oMW+I9tRELTdhUtrJ+bJRPnO9RCwj3d
         YuJdhUGJsbSpOxzbOY6FBjSPViYkVd0wYmo+lCZMaPvOKpC7Tp+sYT9MxjFxdoTrKJx7
         sFFg==
X-Gm-Message-State: AOAM5312cx9VjbjToPUboro3sEBo54PqULw7hqKH/G2rINqohimDYsNU
        SCpNjcOCgDIYFixEE9DiRRtzxayaGVOnUYBqVkmBMTQ3A30wLybkRYaMdN9Quj8Zl8XXPiRZoqh
        KvA+1W24hd+TuJrlvVTAwjSGggtyBl8cm9rHLCji+
X-Received: by 2002:a05:651c:54c:: with SMTP id q12mr9602410ljp.369.1631517229590;
        Mon, 13 Sep 2021 00:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycPxBgCQO1gE8i+MvVdUGtkEMPUfn03lKIoegv1ZwDbOj48JN0k6JDpy6CnZ0f/tV6+r520UFOx8xcJ2azRaw=
X-Received: by 2002:a05:651c:54c:: with SMTP id q12mr9602400ljp.369.1631517229343;
 Mon, 13 Sep 2021 00:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com> <20210913055353.35219-10-jasowang@redhat.com>
 <20210913023428-mutt-send-email-mst@kernel.org> <CACGkMEsqFbnog3jktR0Ms-u75yHfo8zKO-SC66iN2fLZ185XWQ@mail.gmail.com>
 <20210913025145-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210913025145-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 13 Sep 2021 15:13:38 +0800
Message-ID: <CACGkMEvPcRwHFxAsjsDxaAVOQkDUONSKgeyP6ZS9SM6RAw81uA@mail.gmail.com>
Subject: Re: [PATCH 9/9] virtio_ring: validate used buffer length
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

On Mon, Sep 13, 2021 at 2:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 13, 2021 at 02:40:09PM +0800, Jason Wang wrote:
> > On Mon, Sep 13, 2021 at 2:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 13, 2021 at 01:53:53PM +0800, Jason Wang wrote:
> > > > This patch validate the used buffer length provided by the device
> > > > before trying to use it. This is done by record the in buffer length
> > > > in a new field in desc_state structure during virtqueue_add(), then we
> > > > can fail the virtqueue_get_buf() when we find the device is trying to
> > > > give us a used buffer length which is greater than the in buffer
> > > > length.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Hmm this was proposed in the past. The overhead here is
> > > not negligeable, so I'd like to know more -
> > > when is it a problem if the used len is too big?
> >
> > One example is: https://github.com/fuzzsa/fuzzsa-bugs/blob/master/virtio_rng.md
> >
> > And there would be more I guess.
>
> That seems to suggest hwrng validation is better, and
> I think it makes sense: will fix all rng drivers in one go.
>
> > > Don't the affected drivers already track the length somewhere
> > > and so can validated it without the extra cost in
> > > virtio core?
> >
> > Probably, but this requires the changes in each device driver. And it
> > would be easily forgotten if new drivers are introduced?
> >
> > Thanks
>
> My thinking is one just has to be aware that before enabling
> any drivers they have to be audited. We can validate
> used length but e.g. for virtio net the length is inside
> the buffer anyway.

Yes, maybe we can introduce a boolean to tell the virtio core that the
driver can do the validation by itself.

>
> If we really have to, maybe use extra->len?

The extra->len has already been used for per descriptor length.

> And maybe have a mod param so the check can be turned off e.g.
> for benchmarking purposes.

Right. And I will benchmark the differences.

Thanks

>
>
>
> > >
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index d2ca0a7365f8..b8374a6144f3 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -69,6 +69,7 @@
> > > >  struct vring_desc_state_split {
> > > >       void *data;                     /* Data for callback. */
> > > >       struct vring_desc *indir_desc;  /* Indirect descriptor, if any. */
> > > > +     u64 buflen;                     /* In buffer length */
> > > >  };
> > > >
> > > >  struct vring_desc_state_packed {
> > > > @@ -76,6 +77,7 @@ struct vring_desc_state_packed {
> > > >       struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> > > >       u16 num;                        /* Descriptor list length. */
> > > >       u16 last;                       /* The last desc state in a list. */
> > > > +     u64 buflen;                     /* In buffer length */
> > > >  };
> > > >
> > > >  struct vring_desc_extra {
> > > > @@ -490,6 +492,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > >       unsigned int i, n, avail, descs_used, prev, err_idx;
> > > >       int head;
> > > >       bool indirect;
> > > > +     u64 buflen = 0;
> > > >
> > > >       START_USE(vq);
> > > >
> > > > @@ -571,6 +574,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > >                                                    VRING_DESC_F_NEXT |
> > > >                                                    VRING_DESC_F_WRITE,
> > > >                                                    indirect);
> > > > +                     buflen += sg->length;
> > > >               }
> > > >       }
> > > >       /* Last one doesn't continue. */
> > > > @@ -605,6 +609,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > >
> > > >       /* Store token and indirect buffer state. */
> > > >       vq->split.desc_state[head].data = data;
> > > > +     vq->split.desc_state[head].buflen = buflen;
> > > >       if (indirect)
> > > >               vq->split.desc_state[head].indir_desc = desc;
> > > >       else
> > > > @@ -784,6 +789,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > > >               BAD_RING(vq, "id %u is not a head!\n", i);
> > > >               return NULL;
> > > >       }
> > > > +     if (unlikely(*len > vq->split.desc_state[i].buflen)) {
> > > > +             BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
> > > > +                     *len, vq->split.desc_state[i].buflen);
> > > > +             return NULL;
> > > > +     }
> > > >
> > > >       /* detach_buf_split clears data, so grab it now. */
> > > >       ret = vq->split.desc_state[i].data;
> > > > @@ -1062,6 +1072,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > > >       unsigned int i, n, err_idx;
> > > >       u16 head, id;
> > > >       dma_addr_t addr;
> > > > +     u64 buflen = 0;
> > > >
> > > >       head = vq->packed.next_avail_idx;
> > > >       desc = alloc_indirect_packed(total_sg, gfp);
> > > > @@ -1089,6 +1100,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > > >                       desc[i].addr = cpu_to_le64(addr);
> > > >                       desc[i].len = cpu_to_le32(sg->length);
> > > >                       i++;
> > > > +                     if (n >= out_sgs)
> > > > +                             buflen += sg->length;
> > > >               }
> > > >       }
> > > >
> > > > @@ -1141,6 +1154,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > > >       vq->packed.desc_state[id].data = data;
> > > >       vq->packed.desc_state[id].indir_desc = desc;
> > > >       vq->packed.desc_state[id].last = id;
> > > > +     vq->packed.desc_state[id].buflen = buflen;
> > > >
> > > >       vq->num_added += 1;
> > > >
> > > > @@ -1176,6 +1190,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > > >       unsigned int i, n, c, descs_used, err_idx;
> > > >       __le16 head_flags, flags;
> > > >       u16 head, id, prev, curr, avail_used_flags;
> > > > +     u64 buflen = 0;
> > > >
> > > >       START_USE(vq);
> > > >
> > > > @@ -1250,6 +1265,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > > >                                       1 << VRING_PACKED_DESC_F_AVAIL |
> > > >                                       1 << VRING_PACKED_DESC_F_USED;
> > > >                       }
> > > > +                     if (n >= out_sgs)
> > > > +                             buflen += sg->length;
> > > >               }
> > > >       }
> > > >
> > > > @@ -1268,6 +1285,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > > >       vq->packed.desc_state[id].data = data;
> > > >       vq->packed.desc_state[id].indir_desc = ctx;
> > > >       vq->packed.desc_state[id].last = prev;
> > > > +     vq->packed.desc_state[id].buflen = buflen;
> > > >
> > > >       /*
> > > >        * A driver MUST NOT make the first descriptor in the list
> > > > @@ -1455,6 +1473,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > >               BAD_RING(vq, "id %u is not a head!\n", id);
> > > >               return NULL;
> > > >       }
> > > > +     if (unlikely(*len > vq->packed.desc_state[id].buflen)) {
> > > > +             BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
> > > > +                     *len, vq->packed.desc_state[id].buflen);
> > > > +             return NULL;
> > > > +     }
> > > >
> > > >       /* detach_buf_packed clears data, so grab it now. */
> > > >       ret = vq->packed.desc_state[id].data;
> > > > --
> > > > 2.25.1
> > >
>


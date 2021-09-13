Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06401408505
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbhIMG6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237429AbhIMG6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631516242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uq9tbu3TDqgOAJs2JRYdBCy2+stYK+Aour5wYZ0uUGA=;
        b=CYzAFp8Arz1xilEWN36TRZmhHpbFLet3O/CT1EvmXYAiRAH0SkBMWEIuZq9W96K0hUiWFm
        Z1VtP7YLP7dxAWSRgDhLEtkNRiTU5GEeOTGvgzFyUjrA9MGhMpwQnzx6BH+sTGgKNhUw6I
        ghzafzpEnY/ifZ+YUZIGMZyb9xBuwE8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-t7UF_ycFO1iT1Fu2aDQvOQ-1; Mon, 13 Sep 2021 02:57:18 -0400
X-MC-Unique: t7UF_ycFO1iT1Fu2aDQvOQ-1
Received: by mail-ej1-f72.google.com with SMTP id v12-20020a170906858c00b005f03d2ccaf5so845740ejx.14
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uq9tbu3TDqgOAJs2JRYdBCy2+stYK+Aour5wYZ0uUGA=;
        b=s4MhcR/82LCA41Cpuv7ymKysiITQCVkTfZ1T3szrzW94rujVs0N4FX3fahAZA3MHpr
         HCKSk2RZIbNlrXashQGSmb/OlltlvVzy0Zw51DjSk0E9A+iMC0q+IRgRATcdiNGpxSmX
         pdUSx6sVNLq38G87YFfENuhMLC3YzL6d0c8sfTG7ewCtixVwKDrskRoyff/tqLos5d6g
         yGZd4erMwZeOtWN73tSkUkeChJTMzwOCBOnvedqbeBn3jiZCKvqNSDiPRGW2zdjdmy8v
         MnMNzy60MWPQ/KUdOyiuUXgWG88hkGLatcYUV76D6QvLrwqUXUinCjCD3ZrdO2TP3akn
         8kGg==
X-Gm-Message-State: AOAM532njHxaN8vNufCwLArA6JhVjTu3yvj9SL3+PGgtV8DVwpyzqzSk
        CoKAd1J2ydtkMJBmFr2hmEa/BTcrblkE1ZqPh3iYz7np2dsb6tG6hzkGSngauxPL4pa0755fqkl
        oGgVBZ1Aesjqs7+sT6ZuwOdlQ
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr11298286ejy.201.1631516237578;
        Sun, 12 Sep 2021 23:57:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf5/Gf8m1Q3nQCm+wPmq4d0HVpTy/1yuqlo2Uj3Zc2BLzZUv7WljJ+w+6qn7kZUCSD+LF40w==
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr11298276ejy.201.1631516237402;
        Sun, 12 Sep 2021 23:57:17 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
        by smtp.gmail.com with ESMTPSA id lz19sm3027248ejb.40.2021.09.12.23.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 23:57:16 -0700 (PDT)
Date:   Mon, 13 Sep 2021 02:57:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 9/9] virtio_ring: validate used buffer length
Message-ID: <20210913025145-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-10-jasowang@redhat.com>
 <20210913023428-mutt-send-email-mst@kernel.org>
 <CACGkMEsqFbnog3jktR0Ms-u75yHfo8zKO-SC66iN2fLZ185XWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsqFbnog3jktR0Ms-u75yHfo8zKO-SC66iN2fLZ185XWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 02:40:09PM +0800, Jason Wang wrote:
> On Mon, Sep 13, 2021 at 2:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 01:53:53PM +0800, Jason Wang wrote:
> > > This patch validate the used buffer length provided by the device
> > > before trying to use it. This is done by record the in buffer length
> > > in a new field in desc_state structure during virtqueue_add(), then we
> > > can fail the virtqueue_get_buf() when we find the device is trying to
> > > give us a used buffer length which is greater than the in buffer
> > > length.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Hmm this was proposed in the past. The overhead here is
> > not negligeable, so I'd like to know more -
> > when is it a problem if the used len is too big?
> 
> One example is: https://github.com/fuzzsa/fuzzsa-bugs/blob/master/virtio_rng.md
> 
> And there would be more I guess.

That seems to suggest hwrng validation is better, and
I think it makes sense: will fix all rng drivers in one go.

> > Don't the affected drivers already track the length somewhere
> > and so can validated it without the extra cost in
> > virtio core?
> 
> Probably, but this requires the changes in each device driver. And it
> would be easily forgotten if new drivers are introduced?
> 
> Thanks

My thinking is one just has to be aware that before enabling
any drivers they have to be audited. We can validate
used length but e.g. for virtio net the length is inside
the buffer anyway.

If we really have to, maybe use extra->len?
And maybe have a mod param so the check can be turned off e.g.
for benchmarking purposes.



> >
> > > ---
> > >  drivers/virtio/virtio_ring.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index d2ca0a7365f8..b8374a6144f3 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -69,6 +69,7 @@
> > >  struct vring_desc_state_split {
> > >       void *data;                     /* Data for callback. */
> > >       struct vring_desc *indir_desc;  /* Indirect descriptor, if any. */
> > > +     u64 buflen;                     /* In buffer length */
> > >  };
> > >
> > >  struct vring_desc_state_packed {
> > > @@ -76,6 +77,7 @@ struct vring_desc_state_packed {
> > >       struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> > >       u16 num;                        /* Descriptor list length. */
> > >       u16 last;                       /* The last desc state in a list. */
> > > +     u64 buflen;                     /* In buffer length */
> > >  };
> > >
> > >  struct vring_desc_extra {
> > > @@ -490,6 +492,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >       unsigned int i, n, avail, descs_used, prev, err_idx;
> > >       int head;
> > >       bool indirect;
> > > +     u64 buflen = 0;
> > >
> > >       START_USE(vq);
> > >
> > > @@ -571,6 +574,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >                                                    VRING_DESC_F_NEXT |
> > >                                                    VRING_DESC_F_WRITE,
> > >                                                    indirect);
> > > +                     buflen += sg->length;
> > >               }
> > >       }
> > >       /* Last one doesn't continue. */
> > > @@ -605,6 +609,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >
> > >       /* Store token and indirect buffer state. */
> > >       vq->split.desc_state[head].data = data;
> > > +     vq->split.desc_state[head].buflen = buflen;
> > >       if (indirect)
> > >               vq->split.desc_state[head].indir_desc = desc;
> > >       else
> > > @@ -784,6 +789,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > >               BAD_RING(vq, "id %u is not a head!\n", i);
> > >               return NULL;
> > >       }
> > > +     if (unlikely(*len > vq->split.desc_state[i].buflen)) {
> > > +             BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
> > > +                     *len, vq->split.desc_state[i].buflen);
> > > +             return NULL;
> > > +     }
> > >
> > >       /* detach_buf_split clears data, so grab it now. */
> > >       ret = vq->split.desc_state[i].data;
> > > @@ -1062,6 +1072,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >       unsigned int i, n, err_idx;
> > >       u16 head, id;
> > >       dma_addr_t addr;
> > > +     u64 buflen = 0;
> > >
> > >       head = vq->packed.next_avail_idx;
> > >       desc = alloc_indirect_packed(total_sg, gfp);
> > > @@ -1089,6 +1100,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >                       desc[i].addr = cpu_to_le64(addr);
> > >                       desc[i].len = cpu_to_le32(sg->length);
> > >                       i++;
> > > +                     if (n >= out_sgs)
> > > +                             buflen += sg->length;
> > >               }
> > >       }
> > >
> > > @@ -1141,6 +1154,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >       vq->packed.desc_state[id].data = data;
> > >       vq->packed.desc_state[id].indir_desc = desc;
> > >       vq->packed.desc_state[id].last = id;
> > > +     vq->packed.desc_state[id].buflen = buflen;
> > >
> > >       vq->num_added += 1;
> > >
> > > @@ -1176,6 +1190,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >       unsigned int i, n, c, descs_used, err_idx;
> > >       __le16 head_flags, flags;
> > >       u16 head, id, prev, curr, avail_used_flags;
> > > +     u64 buflen = 0;
> > >
> > >       START_USE(vq);
> > >
> > > @@ -1250,6 +1265,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >                                       1 << VRING_PACKED_DESC_F_AVAIL |
> > >                                       1 << VRING_PACKED_DESC_F_USED;
> > >                       }
> > > +                     if (n >= out_sgs)
> > > +                             buflen += sg->length;
> > >               }
> > >       }
> > >
> > > @@ -1268,6 +1285,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >       vq->packed.desc_state[id].data = data;
> > >       vq->packed.desc_state[id].indir_desc = ctx;
> > >       vq->packed.desc_state[id].last = prev;
> > > +     vq->packed.desc_state[id].buflen = buflen;
> > >
> > >       /*
> > >        * A driver MUST NOT make the first descriptor in the list
> > > @@ -1455,6 +1473,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > >               BAD_RING(vq, "id %u is not a head!\n", id);
> > >               return NULL;
> > >       }
> > > +     if (unlikely(*len > vq->packed.desc_state[id].buflen)) {
> > > +             BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
> > > +                     *len, vq->packed.desc_state[id].buflen);
> > > +             return NULL;
> > > +     }
> > >
> > >       /* detach_buf_packed clears data, so grab it now. */
> > >       ret = vq->packed.desc_state[id].data;
> > > --
> > > 2.25.1
> >


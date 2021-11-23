Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15848459A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhKWCeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:34:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229672AbhKWCe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637634681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wCkvV/uQ/l+5VmuSujGW2K1ZJaWeBNqARPUi89XiOro=;
        b=ezIljCRBCgckGv78IXevtwVtnhYkf5UeNor0S1WcnRiKWidiBfbmwc1ygNPDfpFU4oNJxP
        7RYWw6QTJZuOqvfqephnavOdbnVpHZNAHqeTgmxHehBE6JAkknbkhoDb6YpB2j7Pi7UWz6
        FbJ7ZO8xyT33l5B2hqhmfJfiSO57PsI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-525-t1qeIxAOMzmhuOhp1Ziyaw-1; Mon, 22 Nov 2021 21:30:55 -0500
X-MC-Unique: t1qeIxAOMzmhuOhp1Ziyaw-1
Received: by mail-lj1-f200.google.com with SMTP id w16-20020a05651c103000b00218c9d46faeso773282ljm.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCkvV/uQ/l+5VmuSujGW2K1ZJaWeBNqARPUi89XiOro=;
        b=ZQ2f+iamw8D90975Ox9vp98QOayjgBzGqMGljN6sSi0L5J4RP78f0xG6ILB/zi8m02
         niSDrr1d3bsp3Iw5UsF4742+J6WlHqAcvY6lA6sJBTR/X54fpzGmOlnkHMHt2fT7BUjZ
         QMbdMFKeYbgmuoJtf6ndfdQZz0GGyekScH6pkYpWLfDI1M+7TEPNlZljAfHABCPTrAE8
         /a7aHj+OcvePNaDIG4SCZD9y8/qRbAXQvOor6fNNbhRVIL1CllIyiWc/9wFSkInmHfeQ
         ZABBxdi5fvIpWVGBWmHzhnENgFkzMRNSNEoP+Ng8/uzuapVAhmKHXnvmvCLx1SHHRV6J
         OClg==
X-Gm-Message-State: AOAM531mRBQqahE9b2Popo6bNHH0eWC0oFLDeOiMFloTPfZaMqhlwpl9
        ftXJAxNRbxPcoDUTfTt4jBQyJdfM9efaCb2WnHlJwKaYoOpZyJNFWFOJrCYH2nTnbnR/MBtSTtT
        FxRpAknF/lQ6VvoL9NDE+mJzgdxqRhnTCdGxXHBiy
X-Received: by 2002:a2e:2ac1:: with SMTP id q184mr1242445ljq.420.1637634653898;
        Mon, 22 Nov 2021 18:30:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRAo64DnpXGi056uwL0AGCZ115VkubYU56IC6Uae253U4UUTM6u6QJOOsgeBLEqc1CbnUQlDBIu1AlEAYCjos=
X-Received: by 2002:a2e:2ac1:: with SMTP id q184mr1242418ljq.420.1637634653620;
 Mon, 22 Nov 2021 18:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20211027022107.14357-1-jasowang@redhat.com> <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com> <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com> <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com> <20211122145003.3e127a03.pasic@linux.ibm.com>
In-Reply-To: <20211122145003.3e127a03.pasic@linux.ibm.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 23 Nov 2021 10:30:42 +0800
Message-ID: <CACGkMEsdUfxrSsF30QNhs=41FxQN9uMW0cOb1E-HWF3yChU_Gw@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 9:50 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Mon, 22 Nov 2021 14:25:26 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > On Mon, Nov 22, 2021 at 1:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
> > >
> > > On Mon, 22 Nov 2021 06:35:18 +0100
> > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > >
> > > > > I think it should be a common issue, looking at
> > > > > vhost_vsock_handle_tx_kick(), it did:
> > > > >
> > > > > len += sizeof(pkt->hdr);
> > > > > vhost_add_used(vq, head, len);
> > > > >
> > > > > which looks like a violation of the spec since it's TX.
> > > >
> > > > I'm not sure the lines above look like a violation of the spec. If you
> > > > examine vhost_vsock_alloc_pkt() I believe that you will agree that:
> > > > len == pkt->len == pkt->hdr.len
> > > > which makes sense since according to the spec both tx and rx messages
> > > > are hdr+payload. And I believe hdr.len is the size of the payload,
> > > > although that does not seem to be properly documented by the spec.
> >
> > Sorry for being unclear, what I meant is that we probably should use
> > zero here. TX doesn't use in buffer actually.
> >
> > According to the spec, 0 should be the used length:
> >
> > "and len the total of bytes written into the buffer."
>
> Right, I was wrong. I somehow assumed this is the total length and not
> just the number of bytes written.
>
> >
> > > >
> > > > On the other hand tx messages are stated to be device read-only (in the
> > > > spec) so if the device writes stuff, that is certainly wrong.
> > > >
> >
> > Yes.
> >
> > > > If that is what happens.
> > > >
> > > > Looking at virtqueue_get_buf_ctx_split() I'm not sure that is what
> > > > happens. My hypothesis is that we just a last descriptor is an 'in'
> > > > type descriptor (i.e. a device writable one). For tx that assumption
> > > > would be wrong.
> > > >
> > > > I will have another look at this today and send a fix patch if my
> > > > suspicion is confirmed.
>
> Yeah, I didn't remember the semantic of
> vq->split.vring.used->ring[last_used].len
> correctly, and in fact also how exactly the rings work. So your objection
> is correct.
>
> Maybe updating some stuff would make it easier to not make this mistake.
>
> For example the spec and also the linux header says:
>
> /* le32 is used here for ids for padding reasons. */
> struct virtq_used_elem {
>         /* Index of start of used descriptor chain. */
>         le32 id;
>         /* Total length of the descriptor chain which was used (written to) */
>         le32 len;
> };
>
> I think that comment isn't as clear as it could be. I would prefer:
> /* The number of bytes written into the device writable portion of the
> buffer described by the descriptor chain. */
>
> I believe "the descriptor chain which was used" includes both the
> descriptors that map the device read only and the device write
> only portions of the buffer described by the descriptor chain. And the
> total length of that descriptor chain may be defined either as a number
> of the descriptors that form the chain, or the length of the buffer.
>
> One has to use the descriptor chain even if the whole buffer is device
> read only. So "used" == "written to" does not make any sense to me.

Not a native speaker but if others are fine I'm ok with this tweak on
the comment.

>
> Also something like
> int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int bytes_written)
> instead of
> int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int len)
> would make it easier to read the code correctly.

Or maybe a comment to explain the len.

Thanks

>
> > >
> > > If my suspicion is right something like:
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 00f64f2f8b72..efb57898920b 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -764,6 +764,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > >         struct vring_virtqueue *vq = to_vvq(_vq);
> > >         void *ret;
> > >         unsigned int i;
> > > +       bool has_in;
> > >         u16 last_used;
> > >
> > >         START_USE(vq);
> > > @@ -787,6 +788,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > >                         vq->split.vring.used->ring[last_used].id);
> > >         *len = virtio32_to_cpu(_vq->vdev,
> > >                         vq->split.vring.used->ring[last_used].len);
> > > +       has_in = virtio16_to_cpu(_vq->vdev,
> > > +                       vq->split.vring.used->ring[last_used].flags)
> > > +                               & VRING_DESC_F_WRITE;
> >
> > Did you mean vring.desc actually? If yes, it's better not depend on
> > the descriptor ring which can be modified by the device. We've stored
> > the flags in desc_extra[].
> >
> > >
> > >         if (unlikely(i >= vq->split.vring.num)) {
> > >                 BAD_RING(vq, "id %u out of range\n", i);
> > > @@ -796,7 +800,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > >                 BAD_RING(vq, "id %u is not a head!\n", i);
> > >                 return NULL;
> > >         }
> > > -       if (vq->buflen && unlikely(*len > vq->buflen[i])) {
> > > +       if (has_in && q->buflen && unlikely(*len > vq->buflen[i])) {
> > >                 BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> > >                         *len, vq->buflen[i]);
> > >                 return NULL;
> > >
> > > would fix the problem for split. I will try that out and let you know
> > > later.
> >
> > I'm not sure I get this, in virtqueue_add_split, the buflen[i] only
> > contains the in buffer length.
>
> Sorry my diff is indeed silly.
>
> >
> > I think the fixes are:
> >
> > 1) fixing the vhost vsock
> > 2) use suppress_used_validation=true to let vsock driver to validate
> > the in buffer length
> > 3) probably a new feature so the driver can only enable the validation
> > when the feature is enabled.
> >
>
> Makes sense!
>
> Regards,
> Halil
>


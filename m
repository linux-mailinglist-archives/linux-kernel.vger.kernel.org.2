Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D2D43AB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 06:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhJZEtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 00:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231801AbhJZEtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635223604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywFf8Nt0Po4A+AsAVSGAY5OyaS8B6ezXbsiAVAuI/M8=;
        b=WQrenAprwuxX5LSQFfrExmCHiTsTN9Xsa69Rk5d0wEgRz03hg/XDLAubCp+l8prh5crJDX
        hdqnmGCdNH2la9qEHtldDBrTZ8ZuRpzbogyNN+lWIw1VnUrEuav6dpgDLAG5lPFeVywBXx
        L951W4spANHLyp1KX1ffXt8ZM6V0TyA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-wfoBy_-_PSibvh2p02ecuw-1; Tue, 26 Oct 2021 00:46:43 -0400
X-MC-Unique: wfoBy_-_PSibvh2p02ecuw-1
Received: by mail-lf1-f72.google.com with SMTP id t11-20020a056512068b00b003ffb571164dso705105lfe.14
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 21:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ywFf8Nt0Po4A+AsAVSGAY5OyaS8B6ezXbsiAVAuI/M8=;
        b=DbsgKGt0zlYnNb+8rm3lKaNPGPhOpJhscEzSTllve9PEVJoiSGxiI7FGGN96H8xi8n
         f7rsWDw9/qXSXmyvhyAcQLcNmWTIra9MDqOIcjL9WZUdHNq1qkWnv9JzbxcbSWzpGE9W
         y6E5ahoS0FL2k/dNTXTXLXnehlnaUE+6nDQma9rIQTZ+4Pzaz8rzEhvQr1NOusuWxrEH
         m3bI67up4xsgNdn/vbNiCeXDBEReC+TJSauz0viIgMi8Ypqfdd38NswgPoaWG6BqiTnx
         u4ZYzcWJxeK9tWjVazwtmhq3mvsxScylcGZNeFIklPHTUKCuM3GL2dSukSQMjxjHLG59
         ge4g==
X-Gm-Message-State: AOAM532NtK3y0O+yGtG3fsTYHd2bvHdzH9qFraEFP+qvLSmVr+zkFy/h
        iBfBATcy57vCteoKZQeClJszOy02rTOwx/kEtdIBOSUK9OOkh3dyh9ey4jPj0hvOOYHm8Lp78+B
        r94lZdbiyI/twslf6dHhX+8T/VqB5YFnAEGHN4Bnp
X-Received: by 2002:a05:6512:3d11:: with SMTP id d17mr16086970lfv.481.1635223601669;
        Mon, 25 Oct 2021 21:46:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcLiJzIwVWhMCDF8Td4cRTk/ol0gv9lySImO+vOnYnXqjy15iLtfVFK+Rp3mNhOD4BkEZ4r0ZV/jCqDb/6UC4=
X-Received: by 2002:a05:6512:3d11:: with SMTP id d17mr16086951lfv.481.1635223601462;
 Mon, 25 Oct 2021 21:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com> <c75b4499f7ead922daa19bf67b32eed6f185d260.1634870456.git.wuzongyong@linux.alibaba.com>
 <CACGkMEtNECAUtpEvLvEpTFKfbYRC7YQKnHDnjxR3k9Hap1tmig@mail.gmail.com>
 <20211025024403.GA3684@L-PF27918B-1352.localdomain> <bfb2875b-0da1-27e8-829b-f6b61ea6e326@redhat.com>
 <20211025062454.GA4832@L-PF27918B-1352.localdomain>
In-Reply-To: <20211025062454.GA4832@L-PF27918B-1352.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Oct 2021 12:46:30 +0800
Message-ID: <CACGkMEvhRqWY=HXEqJHJUMupmEx+GZRvrzA3bZVoVgf=-r2U1A@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] virtio_vdpa: setup correct vq size with callbacks get_vq_num_{max,min}
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 2:25 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> On Mon, Oct 25, 2021 at 12:45:44PM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2021/10/25 =E4=B8=8A=E5=8D=8810:44, Wu Zongyong =E5=86=99=E9=
=81=93:
> > > On Mon, Oct 25, 2021 at 10:22:30AM +0800, Jason Wang wrote:
> > > > On Fri, Oct 22, 2021 at 10:45 AM Wu Zongyong
> > > > <wuzongyong@linux.alibaba.com> wrote:
> > > > > For the devices which implement the get_vq_num_min callback, the =
driver
> > > > > should not negotiate with virtqueue size with the backend vdpa de=
vice if
> > > > > the value returned by get_vq_num_min equals to the value returned=
 by
> > > > > get_vq_num_max.
> > > > > This is useful for vdpa devices based on legacy virtio specficati=
on.
> > > > >
> > > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > > > ---
> > > > >   drivers/virtio/virtio_vdpa.c | 21 ++++++++++++++++-----
> > > > >   1 file changed, 16 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio=
_vdpa.c
> > > > > index 72eaef2caeb1..e42ace29daa1 100644
> > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > @@ -145,7 +145,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vd=
ev, unsigned int index,
> > > > >          /* Assume split virtqueue, switch to packed if necessary=
 */
> > > > >          struct vdpa_vq_state state =3D {0};
> > > > >          unsigned long flags;
> > > > > -       u32 align, num;
> > > > > +       u32 align, max_num, min_num =3D 0;
> > > > > +       bool may_reduce_num =3D true;
> > > > >          int err;
> > > > >
> > > > >          if (!name)
> > > > > @@ -163,22 +164,32 @@ virtio_vdpa_setup_vq(struct virtio_device *=
vdev, unsigned int index,
> > > > >          if (!info)
> > > > >                  return ERR_PTR(-ENOMEM);
> > > > >
> > > > > -       num =3D ops->get_vq_num_max(vdpa);
> > > > > -       if (num =3D=3D 0) {
> > > > > +       max_num =3D ops->get_vq_num_max(vdpa);
> > > > > +       if (max_num =3D=3D 0) {
> > > > >                  err =3D -ENOENT;
> > > > >                  goto error_new_virtqueue;
> > > > >          }
> > > > >
> > > > > +       if (ops->get_vq_num_min)
> > > > > +               min_num =3D ops->get_vq_num_min(vdpa);
> > > > > +
> > > > > +       may_reduce_num =3D (max_num =3D=3D min_num) ? false : tru=
e;
> > > > > +
> > > > >          /* Create the vring */
> > > > >          align =3D ops->get_vq_align(vdpa);
> > > > > -       vq =3D vring_create_virtqueue(index, num, align, vdev,
> > > > > -                                   true, true, ctx,
> > > > > +       vq =3D vring_create_virtqueue(index, max_num, align, vdev=
,
> > > > > +                                   true, may_reduce_num, ctx,
> > > > >                                      virtio_vdpa_notify, callback=
, name);
> > > > >          if (!vq) {
> > > > >                  err =3D -ENOMEM;
> > > > >                  goto error_new_virtqueue;
> > > > >          }
> > > > >
> > > > > +       if (virtqueue_get_vring_size(vq) < min_num) {
> > > > > +               err =3D -EINVAL;
> > > > > +               goto err_vq;
> > > > > +       }
> > > > I wonder under which case can we hit this?
> > > >
> > > > Thanks
> > > If min_vq_num < max_vq_num, may_reduce_num should be true, then it is
> > > possible to allocate a virtqueue with a small size which value is les=
s
> > > than the min_vq_num since we only set the upper bound for virtqueue s=
ize
> > > when creating virtqueue.
> > >
> > > Refers to vring_create_virtqueue_split in driver/virtio/virtio_vring.=
c:
> > >
> > >     for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /=3D =
2) {
> > >             queue =3D vring_alloc_queue(vdev, vring_size(num, vring_a=
lign),
> > >                                       &dma_addr,
> > >                                       GFP_KERNEL|__GFP_NOWARN|__GFP_Z=
ERO);
> > >             if (queue)
> > >                     break;
> > >             if (!may_reduce_num)
> > >                     return NULL;
> > >     }
> >
> >
> > It looks to me it's better to fix this function instead of checking it =
in
> > the caller?
>
> Or we can simply remove that code since this case only exists in theory, =
and
> there is no real usecase for now.

(Adding list back)

Somehow, it can't happen if you stick to a 256 as both min and max.

Another question, can ENI support vring size which is less than 256?

Thanks

>
> >
> >
> > >
> > > BTW, I have replied this mail on Nov.18, have you ever received it?
> >
> >
> > For some reason I dont' get that.
> >
> > Thanks
> >
> >
> > > > > +
> > > > >          /* Setup virtqueue callback */
> > > > >          cb.callback =3D virtio_vdpa_virtqueue_cb;
> > > > >          cb.private =3D info;
> > > > > --
> > > > > 2.31.1
> > > > >
>


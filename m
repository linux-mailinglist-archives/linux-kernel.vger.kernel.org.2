Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3730B401D88
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 17:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242710AbhIFPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 11:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhIFPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 11:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630941550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kgdlut4j5hhuAHnNJHiggZ2QyP4suVpRdgQkI8pg7R0=;
        b=Q0t0CR9RLMw9R0UUwcFO1xKcMBmqPhDyDSnsqjU45zeULaEuOvt9875BK66nR8/CCMWJ7R
        POSNDJ3VKCtYZJIPQWwVY5vLIa6c5jzMuxADlHntzgQ0po/7NYNdgXetR/kWX/wE6e3F0S
        xDFPx3cZ+6o5RLlgvmzqnjCo1j/ixr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-V4udaKiDNheFJQaw9DUDSA-1; Mon, 06 Sep 2021 11:19:07 -0400
X-MC-Unique: V4udaKiDNheFJQaw9DUDSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C51518766D0;
        Mon,  6 Sep 2021 15:19:06 +0000 (UTC)
Received: from localhost (unknown [10.39.194.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5D4C19711;
        Mon,  6 Sep 2021 15:18:57 +0000 (UTC)
Date:   Mon, 6 Sep 2021 16:18:56 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        vgoyal@redhat.com, jasowang@redhat.com
Subject: Re: [RFC PATCH 0/1] virtio: false unhandled irqs from
 vring_interrupt()
Message-ID: <YTYxYJ6UbaRAwOFQ@stefanha-x1.localdomain>
References: <20210824105944.172659-1-stefanha@redhat.com>
 <20210824072622-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lPM85ySJm1oUCXyU"
Content-Disposition: inline
In-Reply-To: <20210824072622-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lPM85ySJm1oUCXyU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 24, 2021 at 07:31:29AM -0400, Michael S. Tsirkin wrote:
> On Tue, Aug 24, 2021 at 11:59:43AM +0100, Stefan Hajnoczi wrote:
> > While investigating an unhandled irq from vring_interrupt() with virtio=
fs I
> > stumbled onto a possible race that also affects virtio_gpu. This theory=
 is
> > based on code inspection and hopefully you can point out something that=
 makes
> > this a non-issue in practice :).
> >=20
> > The vring_interrupt() function returns IRQ_NONE when an MSI-X interrupt=
 is
> > taken with no used (completed) buffers in the virtqueue. The kernel dis=
ables
> > the irq and the driver is no longer receives irqs when this happens:
> >=20
> >   irq 77: nobody cared (try booting with the "irqpoll" option)
> >   ...
> >   handlers:
> >   [<00000000a40a49bb>] vring_interrupt
> >   Disabling IRQ #77
> >=20
> > Consider the following:
> >=20
> > 1. An virtiofs irq is handled and the virtio_fs_requests_done_work() wo=
rk
> >    function is scheduled to dequeue used buffers:
> >    vring_interrupt() -> virtio_fs_vq_done() -> schedule_work()
> >=20
> > 2. The device adds more used requests and just before...
> >=20
> > 3. ...virtio_fs_requests_done_work() empties the virtqueue with
> >    virtqueue_get_buf().
> >=20
> > 4. The device raises the irq and vring_interrupt() is called after
> >    virtio_fs_requests_done_work emptied the virtqueue:
> >=20
> >    irqreturn_t vring_interrupt(int irq, void *_vq)
> >    {
> >        struct vring_virtqueue *vq =3D to_vvq(_vq);
> >=20
> >        if (!more_used(vq)) {
> >            pr_debug("virtqueue interrupt with no work for %p\n", vq);
> >            return IRQ_NONE;
> >            ^^^^^^^^^^^^^^^^
> >=20
> > I have included a patch that switches virtiofs from spin_lock() to
> > spin_lock_irqsave() to prevent vring_interrupt() from running while the
> > virtqueue is processed from a work function.
> >=20
> > virtio_gpu has a similar case where virtio_gpu_dequeue_ctrl_func() and
> > virtio_gpu_dequeue_cursor_func() work functions only use spin_lock().
> > I think this can result in the same false unhandled irq problem as virt=
iofs.
> >=20
> > This race condition could in theory affect all drivers. The VIRTIO
> > specification says:
> >=20
> >   Neither of these notification suppression methods are reliable, as th=
ey are
> >   not synchronized with the device, but they serve as useful optimizati=
ons.
> >=20
> > If virtqueue_disable_cb() is just a hint and might not disable virtqueu=
e irqs
> > then virtio_net and other drivers have a problem because because an irq=
 could
> > be raised while the driver is dequeuing used buffers. I think we haven'=
t seen
> > this because software VIRTIO devices honor virtqueue_disable_cb(). Hard=
ware
> > devices might cache the value and not disable notifications for some ti=
me...
> >=20
> > Have I missed something?
> >=20
> > The virtiofs patch I attached is being stress tested to see if the unha=
ndled
> > irqs still occur.
> >=20
> > Stefan Hajnoczi (1):
> >   fuse: disable local irqs when processing vq completions
> >=20
> >  fs/fuse/virtio_fs.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> Fundamentally it is not a problem to have an unhandled IRQ
> once in a while. It's only a problem if this happens time
> after time.
>=20
>=20
> Does the kernel you are testing include
> commit 8d622d21d24803408b256d96463eac4574dcf067
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Tue Apr 13 01:19:16 2021 -0400
>=20
>     virtio: fix up virtio_disable_cb
>=20
> ?
>=20
> If not it's worth checking whether the latest kernel still
> has the issue.

A new kernel with your patch doesn't have this issue.

Please disregard the patch I posted, your patch seems to be enough.

Stefan

--lPM85ySJm1oUCXyU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmE2MWAACgkQnKSrs4Gr
c8h9vwf/TvphpnVlEkCnWdWs0t0kMgy5CKuVPH3KAkkGI8l4P/GCoSU2DelelBvF
w17DEUCANUwpUq9ztmwj3L0iXWm+xoloiKsrVhhy0QygYuJ7T8Rot2O/j3+43DXV
JBVTOHnTD1rZoPVLiARBGe0PpPvBp01vWOe2wsPvpVzwTCdd0SI/Jll/2HjcaT3q
mEJCFJ0/6DXRhDIxkg5XoVn/b0Rqh7dBYXBTqxgGOy0nmTug/9ViGHzQB3W/d47i
TsL727I7jYgmfhqlMt64jpHC0I/lu7prYWAzV3jo3meRlAUUHnxu1faO5UA+Gjn3
ZwjFVWt2eidR327qaotQ4wK470gZNA==
=zSYe
-----END PGP SIGNATURE-----

--lPM85ySJm1oUCXyU--


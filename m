Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774DE38FD22
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhEYIty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231436AbhEYItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621932503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fZSzTn3XdBziNvP1nroqncrsKcB81lwHm3zNNNJefNA=;
        b=S9NKqKOVNFNjb9oF77zTJEF8Mwi9JIVL9b59Duti2jGuxKDYw1RzSbjv7crS+abZ5CtRE2
        4MSnMyvrKvuvhB1sCy7/Az53RetGOfwKDgyNlAl7XYdFMSFedqYRChxtxE22+KvkhIeoXd
        Wu2VuJ66sGnrpMbAwAVq9f5vquMVL48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-gGEvty48NiiNtehDZRzyRA-1; Tue, 25 May 2021 04:48:21 -0400
X-MC-Unique: gGEvty48NiiNtehDZRzyRA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69665100747D;
        Tue, 25 May 2021 08:48:20 +0000 (UTC)
Received: from localhost (ovpn-115-80.ams2.redhat.com [10.36.115.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 255FC5D767;
        Tue, 25 May 2021 08:48:12 +0000 (UTC)
Date:   Tue, 25 May 2021 09:48:12 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] virtio: add virtioqueue_more_used()
Message-ID: <YKy5zCoPpp8CDAOI@stefanha-x1.localdomain>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-2-stefanha@redhat.com>
 <dc4a4d96-53b1-5358-cfdd-61795283fd88@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q2pAw8oRrgVElFHr"
Content-Disposition: inline
In-Reply-To: <dc4a4d96-53b1-5358-cfdd-61795283fd88@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q2pAw8oRrgVElFHr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 10:23:39AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/5/20 =E4=B8=8B=E5=8D=8810:13, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > Add an API to check whether there are pending used buffers. There is
> > already a similar API called virtqueue_poll() but it only works together
> > with virtqueue_enable_cb_prepare(). The patches that follow add blk-mq
> > ->poll() support to virtio_blk and they need to check for used buffers
> > without re-enabling virtqueue callbacks, so introduce an API for it.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
>=20
> Typo in the subject.

Thanks, will fix.

> > +/**
> > + * virtqueue_more_used - check if there are used buffers pending
> > + * @_vq: the struct virtqueue we're talking about.
> > + *
> > + * Returns true if there are used buffers, false otherwise. May be cal=
led at
> > + * the same time as other virtqueue operations, but actually calling
> > + * virtqueue_get_buf() requires serialization so be mindful of the rac=
e between
> > + * calling virtqueue_more_used() and virtqueue_get_buf().
> > + */
> > +bool virtqueue_more_used(const struct virtqueue *_vq)
> > +{
> > +	struct vring_virtqueue *vq =3D to_vvq(_vq);
> > +
> > +	return more_used(vq);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_more_used);
>=20
>=20
> It's worth to mention that the function is not serialized (no barriers).

Thanks, will fix.

Stefan

--Q2pAw8oRrgVElFHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCsucwACgkQnKSrs4Gr
c8j8Uwf+MTP06r8XJ+YE0VYRGBqCmA19ycJ516IRi9lTxBr0gX3dq0DN42/Edsw6
9WxemdajF0LTpoZHZnvxgVGYXg1q0oid5Yv9VDC8kfCgae4LG0N+NCZWQqH/g/O+
i/Ef9kbvgGRUevQjXRkc+CT8ABJn+AMyi7GLQU8UK7SaukNUL53JyQ4BFUAYduhv
Hh04GLhl5kJJe5Y6R/e8T8IlsGo2zreSYAhjVdf0/NEe9VmRqDRpnhsQOVi/sDCB
yLeedUgTK0judEjzzQTCs2umD+ph7wREEL62RJMtfkVKihjtiFGflZWNIoIWF5Xm
Ty37GqRB8akwZ3qV9aQ7HE61DePm7A==
=lNmw
-----END PGP SIGNATURE-----

--Q2pAw8oRrgVElFHr--


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8DA434650
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhJTH6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhJTH6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634716551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5VjR3bPcCHRdUMlUAg5b7vcZhP6CummMCmSSquwYdA4=;
        b=em3IYoNPgCPLjzFNo7Jwvi7/a3lIqFYLarjRV3Eax7vmvayN6X7TnozgGdMFmgrKOE+Pln
        e/H1niMYFjaYDp5w1I/SdYBa7R8e5uuWzRCy2kXoJ8jy+ai6W1sfdnMSOEwIsWf/spXcZG
        tbS7Rd7CGjEXspbK1hzNdp76xwdVUig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215--WD9zA1vOEa6X7zTFMIzhw-1; Wed, 20 Oct 2021 03:55:47 -0400
X-MC-Unique: -WD9zA1vOEa6X7zTFMIzhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C76218125C0;
        Wed, 20 Oct 2021 07:55:46 +0000 (UTC)
Received: from localhost (unknown [10.39.192.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1A5E5DF21;
        Wed, 20 Oct 2021 07:55:34 +0000 (UTC)
Date:   Wed, 20 Oct 2021 08:55:33 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V3 01/10] virtio-blk: validate num_queues during probe
Message-ID: <YW/LdQibVvEP06hI@stefanha-x1.localdomain>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NwFJ7yLypb5u6Psm"
Content-Disposition: inline
In-Reply-To: <20211019070152.8236-2-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NwFJ7yLypb5u6Psm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 19, 2021 at 03:01:43PM +0800, Jason Wang wrote:
> If an untrusted device neogitates BLK_F_MQ but advertises a zero
> num_queues, the driver may end up trying to allocating zero size
> buffers where ZERO_SIZE_PTR is returned which may pass the checking
> against the NULL. This will lead unexpected results.
>=20
> Fixing this by failing the probe in this case.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NwFJ7yLypb5u6Psm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFvy3UACgkQnKSrs4Gr
c8hxVQf/SVTtkJjObwCF2iGUpkXg+NjbhBRMuYPz6vpdcE8hkM6QcPTjunwbWU4S
fUv03sI3pv4rshtc32bxBRajdsyMh5KXoeRJzva80Fh+u83CoFA56lOZ0rnXbFo+
LWexYoYjN0Z4F/SZq/M4IowJJFPYtIuti6E3djl9b+jYWcpEySdE4Lz2fmhgVaSQ
xinnT8BP7Xz41dkp6tbM6lI/hR3ItUYQjQMZV8yeMm7FhL2q9RzbQvMR2WYE5xLx
pz2m/87axMgvuwRJyU/5Hr4mMmjwFqXGjPWd237D08GGz5Q/yd+2r6wy7GOS7ccg
da+Vy3aFkpi+kl6DpMBNhIaPrCBnfA==
=GJbH
-----END PGP SIGNATURE-----

--NwFJ7yLypb5u6Psm--


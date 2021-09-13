Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC07408AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbhIMMGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235453AbhIMMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631534711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y2V1xD45BymJlhmyK56YaoVflozzkNCaUFnnSN8deNA=;
        b=DtqZsI9koHwhwaUy1H8Iw7+qd4XksLZFqW2KeNS2dFh+FMfkWm4GG1/j7mZgHjyE0MjQox
        DZT6KOTfUjPyTtC0ENxNSvD0pJFVxcxpNNJJlCme4vwwx4dPutXtLbKiKDOyUYTAvTp6bV
        G87V+zHy5D3KD5ImCCc1gpIoARvXkJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-r0iJ8p1lPY20wHocXZejiA-1; Mon, 13 Sep 2021 08:05:09 -0400
X-MC-Unique: r0iJ8p1lPY20wHocXZejiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 910A380006E;
        Mon, 13 Sep 2021 12:05:08 +0000 (UTC)
Received: from localhost (unknown [10.39.195.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51A4C4180;
        Mon, 13 Sep 2021 12:05:03 +0000 (UTC)
Date:   Mon, 13 Sep 2021 13:05:02 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/9] virtio-blk: validate num_queues during probe
Message-ID: <YT8+bhzt5uy3PBzD@stefanha-x1.localdomain>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TYQ9xRefSpUSapXV"
Content-Disposition: inline
In-Reply-To: <20210913055353.35219-2-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TYQ9xRefSpUSapXV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2021 at 01:53:45PM +0800, Jason Wang wrote:
> If an untrusted device neogitates BLK_F_MQ but advertises a zero
> num_queues, the driver may end up trying to allocating zero size
> buffers where ZERO_SIZE_PTR is returned which may pass the checking
> against the NULL. This will lead unexpected results.
>=20
> Fixing this by using single queue if num_queues is zero.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TYQ9xRefSpUSapXV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmE/Pm4ACgkQnKSrs4Gr
c8iH2AgAu2/zVPkm3h8QB33TiU7b3MgZx1rNvvDlWVmPXVNk5z/ibtU893Zqbz5k
5b/ir6SryiQCzsNHJ6dWLWZkpeEb5/puRlX3TrkOIKCvRXwW99C3v+F5H7PSmsHK
suAQ3qOXr8d0wKP3abOEbuA6Kc1/IOESqt8R46x5WY/ivrSO0+Hv3T9Q8qARJDof
bS/1hEea6dVAYGCtqENC0qQn/utltrIlReSohiKgQcKWwdq+M8iSiOc4BjLHZLnm
/vBvQbyGF9bhgHavnJ4UdHHG+3rV/rIxpL/JvAtk2EldNxyWqFinm+hKTlXVt814
4YMu8qCcYN4fZrklAyED5F5xFl1wJw==
=47Nn
-----END PGP SIGNATURE-----

--TYQ9xRefSpUSapXV--


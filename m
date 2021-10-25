Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9611439115
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhJYIZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229928AbhJYIZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635150161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pib8ma/BQeVkVseqwE+TRzGP17V6G6u5cRT95wmBcbA=;
        b=VvB+0DfqYMyMR782cP9Co57TzYkK641OGHYN0FoeaxsyYmWUGRwevTCCDKWXqnafvRsmm0
        itsoeYXp3wXnZUjGX2hH1OUvZUW/L0qkLzrk3JdtdjIeo/mF04C1LmH+dai/SDvHL70b2n
        An6xtunkiz1o4Vu6STg4+wQBOhc+/2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-HUQAky8lNRCByC_gVNhl5w-1; Mon, 25 Oct 2021 04:22:39 -0400
X-MC-Unique: HUQAky8lNRCByC_gVNhl5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C17680A5E1;
        Mon, 25 Oct 2021 08:22:38 +0000 (UTC)
Received: from localhost (unknown [10.39.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11DC07092D;
        Mon, 25 Oct 2021 08:22:09 +0000 (UTC)
Date:   Mon, 25 Oct 2021 09:22:08 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Feng Li <lifeng1519@gmail.com>,
        Israel Rukshin <israelr@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: corrent types for status handling
Message-ID: <YXZpMEKn8S/4nGbx@stefanha-x1.localdomain>
References: <20211025075825.1603118-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C9wt3Sbjl43MgXq9"
Content-Disposition: inline
In-Reply-To: <20211025075825.1603118-1-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C9wt3Sbjl43MgXq9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 25, 2021 at 03:58:54AM -0400, Michael S. Tsirkin wrote:
> virtblk_setup_cmd returns blk_status_t in an int, callers then assign it
> back to a blk_status_t variable. blk_status_t is either u32 or (more
> typically) u8 so it works, but is inelegant and causes sparse warnings.
>=20
> Pass the status in blk_status_t in a consistent way.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
> Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--C9wt3Sbjl43MgXq9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmF2aS0ACgkQnKSrs4Gr
c8jQdwf/fzLqhl0442aIH8ivsv8J4yZzxYSvpzk2tEZCVN58tNxxTWg+5X0uRwzc
oD7cQ7LWeJVVDzUmLwTyfV4pdscQYq0JHNaWzQSlOqcW3ITAzklnFlbFml+U4Voq
K8xatotWSjF4A7osZPAaQJlXZQMj3BGwgjPrCfFTSfFQAxB2H4hZ/qipvFV1GSzv
wZl+qKZ63bOe9dZPrveJGG7T5AYJ0yeKkb3cYC7vQZyrXDIq1ebMTJviljtn/EQh
GvYN5hDiSm/fW/hFhzppVM1IvRlXjjS0lVIWtliFLCGNcBc90b8DYaDmhZ4SmYnL
XD4KCvqtap4utaH5KGhbmT2Y5cBxZw==
=201H
-----END PGP SIGNATURE-----

--C9wt3Sbjl43MgXq9--


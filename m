Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34480390204
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhEYNVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233127AbhEYNVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621948774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zZxaIXMKBL2xYZBd8FBb6gCvi6cm3iqOYV73SsLQBnI=;
        b=UH6r/UVeRPsTBXNnwvsW7V3CwelN0e46jmtDKXNRdVTzWWiJOfJ2qYtnevh+5xweMEJ2Z9
        cYZqbkWS86fSKb4/58/HtpV076pkRv9l8f6peCFAtLRx3ZDSqBVRZ1ItfCTKo5NcZwJdVz
        7JyIgzaiSf48FHqS8D+4AZfKIG5bPnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-4G8AXiD4MC6vQu30vdl2ng-1; Tue, 25 May 2021 09:19:32 -0400
X-MC-Unique: 4G8AXiD4MC6vQu30vdl2ng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D733100945E;
        Tue, 25 May 2021 13:19:31 +0000 (UTC)
Received: from localhost (ovpn-115-80.ams2.redhat.com [10.36.115.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15982100760F;
        Tue, 25 May 2021 13:19:23 +0000 (UTC)
Date:   Tue, 25 May 2021 14:19:22 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Message-ID: <YKz5WqaeU0R0jQMu@stefanha-x1.localdomain>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com>
 <20210524145928.GA3873@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FcfGVErKD3SlOPsb"
Content-Disposition: inline
In-Reply-To: <20210524145928.GA3873@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FcfGVErKD3SlOPsb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 24, 2021 at 04:59:28PM +0200, Christoph Hellwig wrote:
> On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
> > Possible drawbacks of this approach:
> >=20
> > - Hardware virtio_blk implementations may find virtqueue_disable_cb()
> >   expensive since it requires DMA. If such devices become popular then
> >   the virtio_blk driver could use a similar approach to NVMe when
> >   VIRTIO_F_ACCESS_PLATFORM is detected in the future.
> >=20
> > - If a blk_poll() thread is descheduled it not only hurts polling
> >   performance but also delays completion of non-REQ_HIPRI requests on
> >   that virtqueue since vq notifications are disabled.
>=20
> Yes, I think this is a dangerous configuration.  What argument exists
> again just using dedicated poll queues?

Aside from what Paolo described (the lack of a hardware interface to
designate polling queues), the poll_queues=3DN parameter needs to be added
to the full guest and host software stack. Users also need to learn
about this so they can enable it in all the places. This is much more
hassle for users to configure. The dynamic polling mode approach
requires no configuration.

Paolo's suggestion is to notify the driver when irqs need to be
re-enabled if the polling thread is descheduled. I actually have a
prototype that achieves something similar here:
https://gitlab.com/stefanha/linux/-/commits/cpuidle-haltpoll-virtqueue

It's a different approach from the current patch series: the cpuidle
driver provides poll_start/stop() callbacks and virtio_blk participates
in cpuidle-haltpoll. That means all virtio-blk devices temporarily use
polling mode while the vCPU is doing cpuidle-haltpoll polling. The neat
thing about the cpuidle approach is:
1. Applications don't need to set the RWF_HIPRI flag!
2. Other drivers besides virtio_blk can participate in polling too.

Maybe we should go with cpuidle polling instead?

Stefan

--FcfGVErKD3SlOPsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCs+VoACgkQnKSrs4Gr
c8iQxwgAmR9W7hmYqTRjXDc7N6m7WlEUvC5lJOdzS6z9lyWow8E4NbsDC3bWMGRA
FqBeqV/uXR7quNHf2SlUJRYU8vCiHklVo2GuEVi28frjrI+a1jNIAYqgreDPruWp
raBsSoXtEiYp7hbNFxTbRV78h/NiM/YB5SaVLSW5X+0JTbIDvQ3Too7VZeDfvdki
ia88AtFEQ19hFnvIMnnEPu/Lh6J71U2opqacHvBqJMfFJGIQotpBlnHc/uwW+GQ6
Uys7SGQ073N8tZStszYefcPI0QRiptiIAE08DO40KlLjKtBHt1hc5QAd3y89y5el
ZSupk+mYJLpzLXQUB+VvLAINMtu2Og==
=PIq+
-----END PGP SIGNATURE-----

--FcfGVErKD3SlOPsb--


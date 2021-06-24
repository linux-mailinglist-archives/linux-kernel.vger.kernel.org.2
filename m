Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC67F3B5E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhF1NEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232598AbhF1NEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624885307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yN2gKWfYSS2BvZ25yeJRmT/Gg0ySnY/1p9C8SnCeINA=;
        b=OA4wX64iYjbdmkNautWRTk0RzLM5vE0kIi6uDrVajqw906sY9o3oCEcFH42vTqVY5CzdKM
        9XQK7zHpU6zrzse0arU4c8vnqsVeYFOoYjC1Wa/2Rc+1jJk1ntQEOik+7ErfDiQ63TXEGl
        ZPQlvlgJq+L7o5wGLut12twwFrWLo80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-6udnZiKlNlmnouAkGCPhCg-1; Mon, 28 Jun 2021 09:01:45 -0400
X-MC-Unique: 6udnZiKlNlmnouAkGCPhCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7FA3804308;
        Mon, 28 Jun 2021 13:01:43 +0000 (UTC)
Received: from localhost (ovpn-112-170.ams2.redhat.com [10.36.112.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30B7B5C1CF;
        Mon, 28 Jun 2021 13:01:40 +0000 (UTC)
Date:   Thu, 24 Jun 2021 10:40:52 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, christian@brauner.io,
        akpm@linux-foundation.org, peterz@infradead.org,
        christian.brauner@ubuntu.com
Subject: Re: [PATCH 0/3] kthread: pass in user and check RLIMIT_NPROC
Message-ID: <YNRTJFHxSlUSEqL5@stefanha-x1.localdomain>
References: <20210624030804.4932-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tAINK5wpSU1Wy0aE"
Content-Disposition: inline
In-Reply-To: <20210624030804.4932-1-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tAINK5wpSU1Wy0aE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 23, 2021 at 10:08:01PM -0500, Mike Christie wrote:
> The vhost driver will create a kthread when userspace does a
> VHOST_SET_OWNER ioctl, but the thread is charged to the kthreadd thread.
> We can then end up violating the userspace process's RLIMIT_NPROC. This
> patchset allows drivers to pass in the user to charge/check.
>=20
> The patches were made over Linus's current tree.

Makes sense from a vhost perspective and for future users, but I'm not
familiar with the kthread internals:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--tAINK5wpSU1Wy0aE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDUUyQACgkQnKSrs4Gr
c8h3ugf/SnO91w5rQo5ExA9DoePrMOZqkuNg6cgYqUlV25038PRp49kMp9I9fUXD
JuoebkNTOpavvl1JtW8auitS2pQkvkdLb4VkmzqgGBgQROmpik5sH7H9QACCh0oh
huSYZVkw9PTEyo6fMnKr97+RoGncP/hORtADOuS8VfoMjhADfl0d/QIwBIilOmEA
72x1CQQzVhzmgOp7wK7uBgWGDzA7RoesQHpQhtOidvmwnpSIIa3GZJwn58jM/NJK
+SScwhri8pg/zUGI0wboBpX7HCbkp3U5qF84WiOksuYSFZ3ojnqao9WTdXOVSbdK
3DO/IaTA19tStIHHvcBdAiUuRohZXg==
=dvls
-----END PGP SIGNATURE-----

--tAINK5wpSU1Wy0aE--


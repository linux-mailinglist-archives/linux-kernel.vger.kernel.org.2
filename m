Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB2D36F0E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbhD2UIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:08:53 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52426 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbhD2UIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:08:51 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 42B0C1C0B9F; Thu, 29 Apr 2021 22:08:04 +0200 (CEST)
Date:   Thu, 29 Apr 2021 22:08:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 052/190] Revert "media: media/saa7146: fix incorrect
 assertion in saa7146_buffer_finish"
Message-ID: <20210429200803.GE31692@amd>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-53-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-53-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/common/saa7146/saa7146_fops.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/media/common/saa7146/saa7146_fops.c b/drivers/media/=
common/saa7146/saa7146_fops.c
> index baf5772c52a9..c256146fd3b6 100644
> --- a/drivers/media/common/saa7146/saa7146_fops.c
> +++ b/drivers/media/common/saa7146/saa7146_fops.c
> @@ -95,6 +95,8 @@ void saa7146_buffer_finish(struct saa7146_dev *dev,
>  	DEB_EE("dev:%p, dmaq:%p, state:%d\n", dev, q, state);
>  	DEB_EE("q->curr:%p\n", q->curr);
> =20
> +	BUG_ON(!q->curr);
> +
>  	/* finish current buffer */
>  	if (NULL =3D=3D q->curr) {
>  		DEB_D("aiii. no current buffer\n");

The code is obviously crazy _after_ the revert, so I'd suggest not
reverting it.

But whether this code has any security problems is quite hard to
decide, it was not written with readability in mind :-(.

								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCLEiMACgkQMOfwapXb+vK0LACfRU8bbKn5RV33JmLZN/XFrwd6
gncAnRzMwEp0sgJ8gAmH5DJ1H6bbDwic
=Rsza
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--

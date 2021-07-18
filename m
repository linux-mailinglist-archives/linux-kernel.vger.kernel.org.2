Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9B3CC907
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 14:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhGRMXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 08:23:10 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60786 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhGRMXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 08:23:09 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 418491C0B82; Sun, 18 Jul 2021 14:20:11 +0200 (CEST)
Date:   Sun, 18 Jul 2021 14:20:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.14-rc1
Message-ID: <20210718122011.GA22167@duo.ucw.cz>
References: <20210714143239.2529044-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20210714143239.2529044-1-geert@linux-m68k.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Below is the list of build error/warning regressions/improvements in
> v5.14-rc1[1] compared to v5.13+[2].
>=20
> Summarized:
>   - build errors: +24/-4
>   - build warnings: +71/-65
>=20
> Happy fixing! ;-)
>=20
> Thanks to the linux-next team for providing the build service.

I have onemore:

https://lkml.org/lkml/2021/7/11/50

Best regards,
									Pavel
--=20
http://www.livejournal.com/~pavelmachek

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYPQcewAKCRAw5/Bqldv6
8vZ+AJ4+4H3wWdRpR5hYBITXMJY/tv8GdACeLmZgKW6iAALtrzqvrIFtfHrFZNU=
=sf4K
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225903B0A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFVQup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhFVQuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:50:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2C8D60724;
        Tue, 22 Jun 2021 16:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624380508;
        bh=q3Qb7oVFJdLdwtoqMte+CVN+jKnb6D5a8vxBsBnEsuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2YvzeteFpRMsS1VBKoKkGEw2Np0qVkXZiM+rAjrPFozTIEtGYuFEjii8wRzMjTPn
         O/SZ9XGACQgznk5en4iB/Y9lebpBuBuUkpEUMxz10jvnNAp4GiDMrqb8LLCRYYrJrm
         K+fud6C1mMqBmW20HrX+wUsWoSMb32ayUYskG4yVcJLS7YR1w0Pkj49PBK0E9LOXjZ
         53UFFOmq+n1TmFDLujdhpSvW+F4A/FYkYwTPIsd1j2Lq/ZwYIUWqJelJhpgUX5pbwR
         NXLFCaS0YcLM10qh7HDdQq2JYwUoMq+MZPbImgBB7z1ST2UnRaLI0Wa7Dr4QL2lf97
         7zESWTHRgS92A==
Date:   Tue, 22 Jun 2021 17:48:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/nolibc: Implement msleep()
Message-ID: <20210622164804.GG4574@sirena.org.uk>
References: <20210512123215.42321-1-broonie@kernel.org>
 <20210512132102.GD20883@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Content-Disposition: inline
In-Reply-To: <20210512132102.GD20883@1wt.eu>
X-Cookie: fortune: not found
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 12, 2021 at 03:21:02PM +0200, Willy Tarreau wrote:
> On Wed, May 12, 2021 at 01:32:15PM +0100, Mark Brown wrote:
> > Allow users to implement shorter delays than a full second by implement=
ing
> > msleep().
> >=20
> > Signed-off-by: Mark Brown <broonie@kernel.org>

> Great, now queued, thank you Mark!

This doesn't seem to be showing up in -next, did it get missed or is the
queue it's in not in -next?

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDSFEQACgkQJNaLcl1U
h9CZZAf/ad9XgtaS+NaS95dcHq+3NE3DyNtIb5A5UXEiQ8bS8u+l0lEzuXdkkyLa
PyTBNOfJzfz0BFtshkw9ZPkFjIQpO1D2yV3YN2Vd+o71o/xtFanNeKsrGPlYr7q2
uJ6Xjb1oXvEiRojT0n1df9hJwGqfJFwdMGjagP9N8MRoG760TE9SpYgzilMPRpVz
HzdmnM2peSboLXpt2CHL6+Q3da8WhaZNGr8bK9KVRslyuVqRNU9pQ+CuBZpbKw2H
sfij7mXm2vdxPccYS8NKs2NeUYTYVmEbXniFBjlUZHSYgGw7jLNsfIIDf36SRLxT
+3iLx1RHksuEc8MxBmMWf+Nsgu/eUQ==
=zbmr
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--

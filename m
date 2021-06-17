Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4FA3AB345
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhFQMKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231299AbhFQMKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:10:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B2FC610EA;
        Thu, 17 Jun 2021 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623931688;
        bh=i6kJUpBxHxG+QzGCDo+Do5icLvOgpxju9jJwwtE9c60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/MF8VS5eLhlJg7fqU/4oVwicWtdYZrsBUlhtr0IshhwqQr/yWHEbmL8gV6+k/4Ma
         HCNySERsghT73XoINOrMFjd85j9xERAS/2UL6pyZAM+eV3z8t5aWkhNCepKtKcxrBg
         yKPstJrlTl6T6Xedpb5AR9zwZl+MMpxKlRA9Gj1soZttmwEvwDlT3q56Im7yAFcm7Y
         2E8aRmsggzinAf9XrDXPhZoZXC+v+LfJvYVfQ3TII6YdQPUtf+1ZV6Nj1Kfw93tFat
         lwUfksBlcWAEdmcYLRyDLyg2/YZ19zyBkBbEdrj+ujMc5tTf6NhN57b9QvM//bTiWF
         YGy8ozgXe9l0g==
Date:   Thu, 17 Jun 2021 13:07:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?54+t5rab?= <fengzheng923@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        p.zabel@pengutronix.de, Samuel Holland <samuel@sholland.org>,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
Message-ID: <20210617120747.GB5067@sirena.org.uk>
References: <20210615130326.2044-1-fengzheng923@gmail.com>
 <20210615132207.GG5149@sirena.org.uk>
 <CAE=m61-kHPeKNvEEc08w8DeUwssGPWNf5UaYojRPNZRJ0v=arw@mail.gmail.com>
 <20210617104828.GA5067@sirena.org.uk>
 <CAE=m618Gtx_RQ4+h=8+TFvbcuSTpNWVcx1bry+8OggL6uDCzfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <CAE=m618Gtx_RQ4+h=8+TFvbcuSTpNWVcx1bry+8OggL6uDCzfw@mail.gmail.com>
X-Cookie: But it does move!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 17, 2021 at 07:50:42PM +0800, =E7=8F=AD=E6=B6=9B wrote:
> Mark Brown <broonie@kernel.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=8817=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:48=E5=86=99=E9=81=93=EF=BC=9A
> > On Thu, Jun 17, 2021 at 03:42:43PM +0800, =E7=8F=AD=E6=B6=9B wrote:
> > > Mark Brown <broonie@kernel.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:22=E5=86=99=E9=81=93=EF=BC=9A

> > No, that's what you have already make the entire thing a C++ comment
> > with //s.

> I don=E2=80=99t understand. For example, sun4i-codec.c sun4i-i2s.c
> sun8i-codec.c and sun4i-spdif.c files are the same as mine.

Other people doing a bad job is no excuse for doing a bad job yourself.

> Which file can I refer to? what should I do......

Make every line of the comment start with //.  See soc-core.c

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDLOxIACgkQJNaLcl1U
h9B0Zwf9F77pXhY9/b+1fLkmyUPL4p+njHaVTXcpjPLK+YIOfmiX/pNhREBXmMnc
LdIdlGNvIBKzJ0VDd8SBzL8ARlpaQe7tKqzaxBOHMU5dwnN8q0QueQcYWsO3CeJt
5r6781yl1ugFsKrzC3BIhebjleMk6a+qng15JFRX+cHj04xhbEtBDfcsLwJ1nZMz
+THnsoZRSTCF85GXriv8+fJsXHrTGUEFnveSSXhuAuWAMZJzqIrHdyBo0xhzWpRh
69xN583U++MDxvV5evOlyGJ9OC7KSqRqSIZOsADHlgEhWaHhZt9sz1nbNRmquXY3
9U/3IhGf/VSvyYqELpfU4Ka8wL672Q==
=JYR3
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0787F3EFD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbhHRGrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:47:45 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45772 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbhHRGro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:47:44 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 210661C0B77; Wed, 18 Aug 2021 08:47:09 +0200 (CEST)
Date:   Wed, 18 Aug 2021 08:47:08 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        kernel list <linux-kernel@vger.kernel.org>,
        rodrigo.vivi@intel.com
Subject: Re: 5.13-rc6 on thinkpad X220: graphics hangs with recent mainline
Message-ID: <20210818064708.GB22282@amd>
References: <20210624095359.GA29649@duo.ucw.cz>
 <162487567602.6944.6736788493261786550@jlahtine-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <162487567602.6944.6736788493261786550@jlahtine-mobl.ger.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> > I'm getting graphics problems with 5.13-rc:
> >=20
> > Debian 10.9, X, chromium and flightgear is in use. Things were more
> > stable than this with previous kernels.
> >=20
> > Any ideas?
>=20
> The error you are seeing:
>=20
> > [185300.784992] i915 0000:00:02.0: [drm] Resetting chip for stopped hea=
rtbeat on rcs0
> > [185300.888694] i915 0000:00:02.0: [drm] fgfs[27370] context reset due =
to GPU hang
>=20
> That just indicates that the rendering took too long. It could be caused
> by a change in how the application renders, userspace driver or i915. So
> a previously on-the-edge-of-timeout operation may have got pushed beyond
> the timeout, or the rendering genuinely got completely stuck.
>=20
> If you only updated the kernel, not the application or userspace, could
> you bisect the commit that introduced the behavior and report:
>=20
> https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs
>=20
> We have changes around this area, so would be helpful if you can bisect
> the commit that started the behavior.

So with more recent kernels, problem went away. Is it possible it was
one of those "aborted fence aborts both application and X" problems?

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmEcrOwACgkQMOfwapXb+vIC3QCeJirTC9Cf5I7TcizH8NrCvzRG
W34AnR3UwIkupopApaBERV9hTCObwWH6
=3y6B
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--

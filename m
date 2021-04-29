Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6A036F0FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbhD2UXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:23:50 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53286 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhD2UXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:23:49 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1702C1C0B9F; Thu, 29 Apr 2021 22:23:02 +0200 (CEST)
Date:   Thu, 29 Apr 2021 22:23:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 075/190] Revert "gma/gma500: fix a memory disclosure bug
 due to uninitialized bytes"
Message-ID: <20210429202301.GI31692@amd>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-76-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="STPqjqpCrtky8aYs"
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-76-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--STPqjqpCrtky8aYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>  drivers/gpu/drm/gma500/cdv_intel_display.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_display.c b/drivers/gpu/drm=
/gma500/cdv_intel_display.c
> index 5d3302249779..f89c2088dc2d 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_display.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_display.c
> @@ -405,8 +405,6 @@ static bool cdv_intel_find_dp_pll(const struct gma_li=
mit_t *limit,
>  	struct gma_crtc *gma_crtc =3D to_gma_crtc(crtc);
>  	struct gma_clock_t clock;
> =20
> -	memset(&clock, 0, sizeof(clock));
> -
>  	switch (refclk) {
>  	case 27000:
>  		if (target < 200000) {

Original description is correct, we are returning with .vco and .dot
unitialized which is at least very very ugly, so we should keep the
memset and not revert this.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--STPqjqpCrtky8aYs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCLFaUACgkQMOfwapXb+vIY8wCglHWfV91ODxkJrVxpHNYGcHBp
dUkAoJV/6kLn1j/p0l4KlyXYFMdBIrEK
=V7Ne
-----END PGP SIGNATURE-----

--STPqjqpCrtky8aYs--

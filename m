Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF234548F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhKQOit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:38:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231747AbhKQOis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:38:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC879613AD;
        Wed, 17 Nov 2021 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637159750;
        bh=ypN75feuluVV6CkzUNd9qT/2Ps0eqEvsXElsx7kHfnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXE4O+6Xgyewk4chPr27uwZC/N0l0RxDuR87w4JGWSaNNUKPbF36/z08a9IB96Zcy
         OrSpiONae6hQRgq5bRWsh90RsGFoJM1GSy0Qf0gidami87tHNEioaNqbg58gtvTiR+
         y8BA+03Yh9yE9NW8/Qa9vshwRJWN8Zdr0qSprXoLl+4lDFpxr7LzpUcjCZxtKJKzsQ
         D4PZyAbf4vujw6EJ/kjTWRXPEBfj2HPN+TYZw5AW+B2RzdB67Q5P18OOaTcQrOMFwd
         3Nc1OukD7iX8Se8JzVDsg8oRCvOGn0e/I48u3qXt/txrqmBs4LCM/CqUtoduDSJeVi
         q20TIVqfIelZw==
Date:   Wed, 17 Nov 2021 14:35:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mighty M <mightymb17@gmail.com>
Cc:     linux-kernel@vger.kernel.org, krzk@kernel.org,
        Tony Lindgren <tony@atomide.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com
Subject: Re: Adding support for audio (WM1811)
Message-ID: <YZUTQdK6qWZadoz2@sirena.org.uk>
References: <CACLAQJEjPg4swtLKVj1OdO_h6Js1CtfFJnL9+8WDEtT9AANaeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="An86/UMqTj2Q3cfh"
Content-Disposition: inline
In-Reply-To: <CACLAQJEjPg4swtLKVj1OdO_h6Js1CtfFJnL9+8WDEtT9AANaeg@mail.gmail.com>
X-Cookie: One Bell System - it sometimes works.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--An86/UMqTj2Q3cfh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 01, 2021 at 02:18:45PM +0530, Mighty M wrote:
>  I've been trying to add audio support to my device,
> samsung-espresso3g, but cannot seem to wrap my head around it. Other
> devices in mainline are other exynos samsung's (aries/midas/arndale) all of
> which have some drivers in mainline, while mine is an omap. I would like to
> know how would I start adding the support. Here's the downstream driver
> https://github.com/Unlegacy-Android/android_kernel_ti_omap4/blob/3.0/common/sound/soc/omap/espresso.c
> Any help would be appreciated. Audio is very confusing

The downstream driver looks fairly clean to be honest - I'd think you
could get a long way to getting something upstreamable by just fixing it
so it builds and adding basic DT bindings.  There's quite a lot of
drivers in tree you could take as examples there, the way devices fit
into the system isn't really device specific so they don't need to be
WM1811 specific bindings so much.  Is there any specific thing you were
having difficulty with or was it just general pointers about getting
going?

If you've got questions about WM1811 in particular I'd loop i the Cirrus
people (Cirrus bought Wolfson a while back), hopefully they can provide
some help though that part is very old by now.  You should also copy the
ALSA list alsa-devel@alsa-project.org, that'll get more visibility from
audio people.

--An86/UMqTj2Q3cfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGVE0AACgkQJNaLcl1U
h9CH0Qf+NDUcQGpNKmM4ejDtd+cqjQPpqUsgFlsN7xspCJPpHxIeN366MoNd4kJC
JyUg7Yn1J4YJTxdU2/8KB4p0KoI33nsegNY8g1TMu70JLudvFidjRyCqjk9i2/NZ
Ci0PJFQ4N5mEwNew1BbxfuEqnBlhSgld5aPfmin70sDTOkD0ainhX9d6Hew8uoDN
7TTOFgioQ1egcamKwMR513DIo3CBcYC5Y8SApO+PtFBg7JB5zSSb597JeZ4rdOfF
WilMD/Z3aqnRN4G2dLjO7v5sTjA6dccrYft3zwvmZ/lbeUWGZ0d/pf9NLpFS8/N6
aOdr4vyVl3FOy/gQqh2njvMlLIhe1w==
=5A21
-----END PGP SIGNATURE-----

--An86/UMqTj2Q3cfh--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3537305B72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhA0Mdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237968AbhA0M25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:28:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA53220739;
        Wed, 27 Jan 2021 12:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611750496;
        bh=bTDQADTlQR0Lg50LOKeztokhxttN3WR4/PCnuUuWkcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZ419NUnIc43rQ00dvslDeW85NhY+6E09Vwpj05XQVOufdcZYq3wpUG15XiBFpQO9
         8qmU9gK1ArRUP3EyWPhUMxg3rlz/4v6CjRx/ehxeAZmfFwEftBgjbvD2Ydkp0HLDMU
         G9bEjWAT8HT7Jqvlp+z+8FRfjRXMFAvyLNG5uvn25R79od7qsJwHJsen/7FQ8zXahO
         rxyUNBCGdgYhOM6HaUdOaVt0KPf9i8NSbIjpdOnI1Io9XCdRvJp/0+II9HRaKEKVrJ
         rSIqd50O0Jgflqudi3zt4Wnbs2os/5Rr7agfiulh1omb+1RrgY75gB7fekmDao7C6e
         XobwLn9zwDVhQ==
Date:   Wed, 27 Jan 2021 12:27:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "angelogioacchino.delregno@somainline.org" 
        <angelogioacchino.delregno@somainline.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: short-circuit and over-current IRQs
Message-ID: <20210127122733.GC4387@sirena.org.uk>
References: <6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com>
X-Cookie: La-dee-dee, la-dee-dah.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 27, 2021 at 12:01:55PM +0000, Vaittinen, Matti wrote:

> Anyways - I was wondering if this is common thing amongst many PMICs?
> If yes - then, perhaps some generally useful regulator helper could be
> added to help implementing the IRQ disabling + scheduling worker to
> check status and re-enable IRQs? I think it *might* save some time in
> the future - and help making same mistakes many times :]

If we've got two that's enough for a helper.  TBH I'm a bit surprised
that people are implementing hardware that leaves the outputs enabled
when it detects this sort of error, it's something that's usually an
emergency that needs shutting off quickly to prevent hardware damage.

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmARXDQACgkQJNaLcl1U
h9AFEwf4xLwACd6nS44w7jG5H10iqcrks+9j8HV08yzdET7oaIGpxL2z83Z/7BBJ
WMVZLg2pLZ/eAnwFX1dm/S9t4Lp7TL+acTflL998RxwjeMUa8xqkSGPzy6oe4I+m
1oXXhFbZO9wKTUg7YuZgVGF2rW1XYLxCEkzXP/zq8Cq0amWz1zMQ/NoXV50gam7/
rVB3N0k6mUrPNbvbX2rfNbmZMEy4rxH4qGtULC6gu54Ob4yF0IibKOlbF9fiT2IF
wW20fXH4UJun1d7LpZ30c2BGgg2yAEncVRqwPY9Qx8tVPcujUJVbMI4n3aQOYsob
HCQCMbMdfei7Xllc0cpDU+v+o2qH
=9Mti
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--

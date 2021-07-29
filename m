Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD8B3DAC31
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 21:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhG2Txq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 15:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhG2Txp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 15:53:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06BC160F01;
        Thu, 29 Jul 2021 19:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627588421;
        bh=the9VPxFqD+9/ugS0c9sVUvODmc6n6lJDaNBo6wHI0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0X1x7n4+MMSGyGkCzZST5UV0ajYMP3qdfsRY0kR8cazyT3LPkUcgq8laARi4DqxK
         naQGkx44vZ0m+vVk+zKHzpH4V6DOy6iG8qT+haMbi6OaX/bUu2hthUDVS8V2H31puJ
         XF+KcYJME/eg6lbc+e8jL0j2EJCz44VRXf4uGex3+vaIWe38XcXIEpdKK50qR2jYNt
         YOq1CTFSy5T4QbgJfvR4zXie/3kkyqqsNvAfcFirbds8g0izxTTQb3/zh2d8+Yn9ie
         +FiYTzugizii6qsuXJ8tXrtjvfXnay5ro23oFWpjUSfeLPg1B1xwFC1Qzk1ZD3U9y8
         gzqlf2+kk+5vQ==
Date:   Thu, 29 Jul 2021 20:53:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/3] ASoC: cs42l42: Correct definition of ADC Volume
 control
Message-ID: <20210729195330.GW4670@sirena.org.uk>
References: <20210729170929.6589-1-rf@opensource.cirrus.com>
 <162758812271.3952.13208728919315614383.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H23uHpCUqgUcHMpK"
Content-Disposition: inline
In-Reply-To: <162758812271.3952.13208728919315614383.b4-ty@kernel.org>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H23uHpCUqgUcHMpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 29, 2021 at 08:49:21PM +0100, Mark Brown wrote:
> On Thu, 29 Jul 2021 18:09:27 +0100, Richard Fitzgerald wrote:
> > The ADC volume is a signed 8-bit number with range -97 to +12,
> > with -97 being mute. Use a SOC_SINGLE_S8_TLV() to define this
> > and fix the DECLARE_TLV_DB_SCALE() to have the correct start and
> > mute flag.
>=20
> Applied to
>=20
>    torvalds/linux.git master
>=20
> Thanks!

Ugh, sorry - the script is confused.  This is applied to the ASoC tree.

--H23uHpCUqgUcHMpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEDBzkACgkQJNaLcl1U
h9BrGAf+PY+yTDXgKEFsmCiaafH3h5AnC9tHm6iKn/8k2xAVmzlWXJ1BbFhRTI1G
MmuZC1AgDaTMb8YOPWfxfH1Wfmw3AuvU9oavT4ZQgRIF1Y792pLw7Xu0RFgmFYGK
r4W6b9U6yLXwt9Fkky9q90TGTqWRTryoY4ed4lMlAz26L62nl1aPm1h1KIFPfpq9
SwixS0xaUrmBHiY0I4fhCqVnbIJyjsGYjTjDiD4T6wD+vTpUCkU6g8xdrLaWUSey
u1tTBZrybaji/jZavDOs3jIbj6x/3Y9ngLa5bQtnDIYAyy0/3oiAv9iglQOvjv9q
M2jkPjxACZgea9gh3fwhrZWasxme/w==
=saqM
-----END PGP SIGNATURE-----

--H23uHpCUqgUcHMpK--

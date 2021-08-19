Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22953F1854
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbhHSLim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236881AbhHSLil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:38:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A57B260FDC;
        Thu, 19 Aug 2021 11:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629373085;
        bh=1pXGnQNvDxeuXqt+aYCclGcI86QRezmijIATUR1/REw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QqT6CLFs67pYkpgPeNz4zVRQBqXfGQcS4JnKF7tFS0hntfEonz1xjEyISu4mv8U7u
         /6mPUDRaMMcky5+/TQBJ952SMwXp8xds9+1awwXfV8aNuJLIQuj5CuMB2fm6PPbN/N
         TlKpyjxXPQrV1x9jp2yEJXMn81AgQnUFTSa8tXMJKOkuMmfsH1ijHA2zQmH688Bkjd
         xSdcrgyT+ST40HD8YtnZWzqDOP1bXFZ860PJDw6CtikB/MNlZFzpuarv4uJOixfTk1
         TJYZXvlfuixzttiutaE2ozT+S5KUrvR4XbMv9o/mYBJoIFG3egpD7aEhWTqPJRqDvb
         Xmo9xAByQ/a5w==
Date:   Thu, 19 Aug 2021 12:37:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     kernel test robot <yujie.liu@intel.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild] drivers/regulator/bd718x7-regulator.c:531:8: warning:
 Excessive padding in 'struct bd718xx_regulator_data' (8 padding bytes, where
 0 is optimal).
Message-ID: <20210819113741.GK4177@sirena.org.uk>
References: <202108172206.9cbgvI53-lkp@intel.com>
 <4dabc78a-f9ee-4e7d-8bf3-ea1c6cef8530@intel.com>
 <CANhJrGOh+9PoMmsv-Q9petTV-hv9rv9nOitg0NCQHqXVXzJvvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W2ydbIOJmkm74tJ2"
Content-Disposition: inline
In-Reply-To: <CANhJrGOh+9PoMmsv-Q9petTV-hv9rv9nOitg0NCQHqXVXzJvvw@mail.gmail.com>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W2ydbIOJmkm74tJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 19, 2021 at 08:34:22AM +0300, Matti Vaittinen wrote:

> something changes would cause quite a churn of changes... What is
> expected to be done as a result from these mails?

It's probably fine to ignore them for something like this which is going
to get very few uses in the kernel - it gets a lot more interesting for
something that gets lots of copies allocated since that causes the bloat
to really add up.

--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEeQoQACgkQJNaLcl1U
h9AWKAf+IrW5qcHIee0p98YTKEhTs8gSVTcipARBWcgS6DI8bTIyj/m0sCiimwIE
pEGDwcUXwm4S2RYDHK+LwSLnhfIQ3D3IpwiQCv8xKGan56imaoS/IZ0mzWbGl3Ed
JnkVLfvdA+PIglG136FXd6NNwWysl2mqlk8ONCPHXWoNqEhUwCRJz0sQgcBZEch9
9vvKI3gPcy/0WtGPiL4iZyTCCRphrdFKqMPnf+UmPjydbwdIcVSPwEaHwNk6DPxs
fPab0vjz5cwBNrfAPyJj2pkdx8sfxCoQVaI2vouR0kZIYsaCQbsDKRyXCgrECskZ
o/ExAOOfOWsHZ4DDXg3jusHY6tge5w==
=vI3c
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--

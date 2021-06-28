Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7563B5DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhF1MVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232802AbhF1MVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:21:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B6E861C3D;
        Mon, 28 Jun 2021 12:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624882760;
        bh=fxbPAIWX+3dJHV0y6YubtoXYy441Gu3XR5brw+dJJgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QhFh3CpL/X6QInfC94fq4p5I9vh3fQ8KoDvVkA549Wj/2fb42WS62gKSAoKLY8g5k
         aD+JVuTcaxiH6S5DZIZTnrdyQGTae5beILLwgXW4NwtjT/rHNETqNUSZnrScvXEqHp
         TsCW1vU0cOezoqVgNOfUUVWdhyciLylObMPA5UzLviPcwxn+45hH8QxHMwJbG2rnHl
         ThpgUn1LiU5GGOB5Cf3RbonmR7LiXxd575lnWjhBcILqQXplEGPVXw9N0NXBMLa4fZ
         os4TyRve+/ypC7Kp753p902VZREIpmCL2BIJ1gwaTDL4iBdfCBV7Zpay9LLswSAw4F
         b9LFy3mWZbDHg==
Date:   Mon, 28 Jun 2021 13:18:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jinchao Wang <wjc@cdjrlc.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: base: Prefer unsigned int to bare use of unsigned
Message-ID: <20210628121853.GA4492@sirena.org.uk>
References: <20210626073408.12448-1-wjc@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20210626073408.12448-1-wjc@cdjrlc.com>
X-Cookie: Someone is speaking well of you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 26, 2021 at 03:34:08PM +0800, Jinchao Wang wrote:
> Fix checkpatch warnings:
>     WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>=20
> Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
> ---
>  drivers/base/cpu.c                   |  4 ++--
>  drivers/base/map.c                   | 12 ++++++------
>  drivers/base/node.c                  |  8 ++++----
>  drivers/base/regmap/regmap-debugfs.c |  2 +-
>  drivers/base/regmap/regmap-mmio.c    |  2 +-
>  drivers/base/regmap/regmap.c         |  6 +++---

Please don't mix changes for multiple subsystems into single patches,
send at least one patch per subsystem.

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDZvioACgkQJNaLcl1U
h9C+egf/Vogc+cKUu9SRD7cn8PEFWQZntY+mBn5eRPohU+psTD50Yn/NqtrBjFP+
CK+TCW1NM6QLNjDtfP9Z29BBPS9+xxdIZNdaD4oj7ntOerrbCYW5qkumt2w2OaAb
zRIeWpXkia9luM4RxOg0FnrE7WMzEF4J6sZ7n+SM+AKgtyRKtbmJPTxyXs4/PMDX
0PyERKLx/s27ucnhS5GZXrdWHhh41AT/MBRbclDi2BgKb/eqokZPSrN2vkMaHY+q
yMDp22BRb9KDaRCFTzvz8vst5mJq10PvRGqI+vjKZVAmajSenpUHL5Tg0oSIayUT
OdXWOiXbZcGKAcowajzdBaqyNv7tSg==
=D7Xu
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

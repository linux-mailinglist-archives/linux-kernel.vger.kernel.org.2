Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0144D6B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 13:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhKKMmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 07:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231951AbhKKMmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 07:42:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC63461038;
        Thu, 11 Nov 2021 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636634367;
        bh=pqY6pWBKqFqLPVwFfney88YGZd/ZDQ6qptq/TVEJbvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hjpu2CRgGBlIneSzKuDdGaY3RUxTiY0iD3zoR7UyDvcrJj/yDOdxP9+nd+L6T8DEA
         XZckxBsa/DUYJyLdyNAJc2d/V6rt+2eR+gu/5QG9iDJqOgawOXkmDoDrj3GojErAEp
         3K5M/qq6eYWUx5isn/XKOAmogtbdnt3WfPVtfcpG3lJCUqw+O3l2RkSyAZqHUbevbw
         4dpZ20KXXm1v1DK/5e2mXvoS9LvOvaZodvTZ+9DFD/X3NCgkZPFyK6Ch/XsAwNR2DA
         EPzn8n/APLDl8CMI0fTIQKAhzevWSQyjQUWUFp4vvOydSqVauykTT2noM+v4TmCS+2
         HI4TOsi5osuWQ==
Date:   Thu, 11 Nov 2021 12:39:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] regmap: allow to define reg_update_bits for no
 bus configuration
Message-ID: <YY0O+yHo9ZSYgj83@sirena.org.uk>
References: <20211111014138.15645-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oLGvg2jcuDI+EZmV"
Content-Disposition: inline
In-Reply-To: <20211111014138.15645-1-ansuelsmth@gmail.com>
X-Cookie: Teutonic:
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oLGvg2jcuDI+EZmV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 11, 2021 at 02:41:38AM +0100, Ansuel Smith wrote:
> Some device requires a special handling for reg_update_bits and can't use
> the normal regmap read write logic. An example is when locking is
> handled by the device and rmw operations requires to do atomic operations.

Please allow a reasonable time for review and remember that it's the
merge window right now so no new patches are being applied.

--oLGvg2jcuDI+EZmV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGNDvoACgkQJNaLcl1U
h9AvRAf+MV+w+VUWXuLCUVCPFqEeTrrynCCx8rKKsi2BlPjNw4H/KOCz/ZsiuKse
TuYYg9T3PDTC+lUFY+jTmi3LNR/ls7760RNFBELMNfxNK+7k1X7O05WX0HV3v58x
3RF9d4bKwM3J1mHho/ZxPlLQHxz3rPIsMvRISP8B3uwWzQ6zJETKBhpxviP7wCeY
5JoGJWYLwl6RF5rG4hCuXjY7XAiB0zuTE+9hbynLYMlqbeJB/HvoYwvvqeDoTQfd
JhZPOz9V8t7YIzXLaslDrzeKfotz0i63YmsWjuEtC/MGf5NDKTmbgP5Fk0aHvSs6
l8XIjywwQ+4UdPpbP2TmDbMY38FW1g==
=b79x
-----END PGP SIGNATURE-----

--oLGvg2jcuDI+EZmV--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C02737BC5F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhELMUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:20:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231510AbhELMUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:20:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AE68613E6;
        Wed, 12 May 2021 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620821978;
        bh=1+sZNdPQyC0Lr1d9yheQ8APvdsf4aKIojbmqetdGbiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lO+tctgQ8ZTNkI/rcrC/R/CqlUttfWCyMltILr5vGPN3k5cTwnSXUV1KXE/k5MOPX
         iTmgCzwbEIGynZ3EwweTAbREmwgtItZSNi+YuZWGsko7TnCKorUYwQl+qsQDRinqvr
         FyGsAfej46XHbi9FCVRwKrnHQqm8z8CkjRGgOBygwmm+VZ6ugkPsK1BBcsHNHv+O7X
         px7rZUipNZY5Uz6bKuQnOQHNyIHD6Lecvyx8Cfi1TRbAwlIaIEF5dyEuea9xDuCdQd
         QdIFwRWbvs3Ix9kEaCNe/ON6PgsmfiCLcn6Wy4EEW3vLsZsDS+X48MaG4WhNraUDyt
         T6vB5jCwPmZ5A==
Date:   Wed, 12 May 2021 13:18:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: Implement msleep()
Message-ID: <20210512121858.GA6343@sirena.org.uk>
References: <20210512114728.19015-1-broonie@kernel.org>
 <20210512115949.GA20883@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20210512115949.GA20883@1wt.eu>
X-Cookie: When your memory goes, forget it!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 12, 2021 at 01:59:49PM +0200, Willy Tarreau wrote:
> On Wed, May 12, 2021 at 12:47:28PM +0100, Mark Brown wrote:

> >  - Return the number of seconds remaining if the delay does not
> >    complete.

> But why returning the number of seconds instead of milliseconds ?
> The common use case is this:

>      delay = delay_before_next_event();
>      while ((ret = msleep(delay)) > 0)
>             delay -= ret;

It seemed to be what you were asking for and I didn't have strong enough
opinions for it to be worth pushing back.

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCbx7EACgkQJNaLcl1U
h9D/iAf/enP1RBlCnYO1xqhCt+nTxMyu954O58KeziUKwfhi08PGhi4/lf1sJO8l
EU0oXuPdgI5juEmz0OsRoFQzAipG8EcPNADXWl+26ApFehnFkpooczdvDg7il5L7
asbQQebVuUfpOl8eURPhIbYGohWXwsO7hN79BUqLLfzWP+Cb7yVdyoWS05s+exyK
LQv2e6aJHjjXRxAnADjehjg3izC0aYziXbkXKxrvIzlHYntWjBxWjEIcfpb+GcmQ
1IFHwO4+8eg1nZMy/JEKwNj5ztPTC6AaP2r9MCP7RGWnnwBjISa7o4eQQyFSsQuO
cZUwCxoYiy0Ac9fpnLgvVItHMiZ+iw==
=OEPI
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

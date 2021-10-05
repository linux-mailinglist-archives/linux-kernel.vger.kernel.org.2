Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCB04225C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhJEL5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233784AbhJEL5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:57:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC2A561401;
        Tue,  5 Oct 2021 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633434942;
        bh=mQqnmuQSyf8niJjlZoCYMQofmwAr4tO5WYz2lCvfp70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WniXSwBd/nuLj1LLI5zbipu2OaTk9UFxdYY+G5FAZk1CA1D2vGkbr6193t7XxFM/R
         eC4zj2iB4lnaEiFKLA9t3wks058AQwm1XtfnTps+x8wIOPypSQrGO3T7sz/bNw3KRc
         b+tAzgc75D80Ef24Dwq9D0MAtdD+6ach59/DvZ0ao948ScG0LhVyS/yXm8JbYCKTrl
         t4cbkZWHTiGXP/QnxXVXwFbBaU1TwcG3CFbAV6pknal6buaTm+4pKYt35wXXbxdvnE
         Ael5SO+HsKxp9yxEL2QffiIt3x10BVy6lJmV0xmSWYeGOniNQ74XWh6J5j9Mt/9cCu
         lcCtuLgMgMc/Q==
Date:   Tue, 5 Oct 2021 12:55:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        allen_lin@richtek.com
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: rt9120: Add initial bindings
Message-ID: <YVw9PKpyC8h/FRaG@sirena.org.uk>
References: <1633398092-19953-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nPNcSppYshgchqQ2"
Content-Disposition: inline
In-Reply-To: <1633398092-19953-1-git-send-email-u0084500@gmail.com>
X-Cookie: A is for Apple.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nPNcSppYshgchqQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 05, 2021 at 09:41:31AM +0800, cy_huang wrote:

> Very appoligized. I forget to migrate this line from my test 5.10 kernel.
> Without this line will cause sound card codec link fail.
> Please use the patch v2 to review the bindings and source code.

Sorry, saw v1 before I saw this but I guess the issues still apply - a
quick check seems like it.

--nPNcSppYshgchqQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFcPTsACgkQJNaLcl1U
h9DRxAgAgJlACpiNaOHNgYf+86uBmvoGsBHO/ZqK7aZ+QGzzVpgWiLTwZSxpPEGg
6muweRc/slScEbZ7u23O3jBS7+TjC725G+E+KrvcivKUl/GEIMfzfOK/hxSfLjxp
g3vtlVTo4REqoJLHFM/Yc+oYj81ByU+yg8WOP4/bbB0bcx4EitrJzAvesyV9kTFi
C0Ya0ORNjISZJvUhSBTKEMJnuNm2OTkR3hbTUQWeKlNFNJft3G3neZkm3UjuyDWE
JjbAkTFxGAyLFq7eJJ5JyXT9k2EVtdinLv4xpgs9ayHT6ahv91Ru4PIUc9H5zgYh
tDJlCNZo2EPW/fDwJ3XLxoMjstlmqA==
=7Jak
-----END PGP SIGNATURE-----

--nPNcSppYshgchqQ2--

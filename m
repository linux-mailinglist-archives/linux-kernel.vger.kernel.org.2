Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A8D388ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbhESNSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235765AbhESNSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:18:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B090F610CC;
        Wed, 19 May 2021 13:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621430232;
        bh=/N7tAx3OswxBYez0nhficTmxmEYvhAU1su9MYCvCXTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NjjKjJjL4Em7Hhtmap0lFl1YHgkrNbVtYY1yOGV0fqvDp3dhZW0SFiELHqrcwxqYg
         dT0ETnHwzvzlDthA6eaVgrSBEKv8T7sq19PnQ2KnJ5awms0jyDKicTI23M8kOX91mH
         0J0he9ODrBkR+EJgQ44kRj0JDFOwpncUwiYZdCtV3XqgvfOeaLPbyIXhE3w5Xzx+dy
         1RaO5Sw4hOq7EnTSOdUTxxcwY1SrZrWJwgf4fAcF7/kbEfgeX7JagLAJsOObnMoIwH
         3aTIlZhgT7GJ42F1oPtL+znH/y8WnnOQ7zZ+0EPiqHNjFBUbJ2HDsd43S1O9K2bPI5
         e8Xq773qHejiA==
Date:   Wed, 19 May 2021 14:16:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: Check ramp_delay_table for
 regulator_set_ramp_delay_regmap
Message-ID: <20210519131626.GE4224@sirena.org.uk>
References: <20210519075024.1644990-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <20210519075024.1644990-1-axel.lin@ingics.com>
X-Cookie: There's no time like the pleasant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 19, 2021 at 03:50:24PM +0800, Axel Lin wrote:

> +	if (!rdev->desc->n_ramp_values || !rdev->desc->ramp_delay_table) {
> +		WARN_ON(!rdev->desc->n_ramp_values || !rdev->desc->ramp_delay_table);

You can write "if (WARN_ON(..." there and it'll DTRT, though I'm never
sure it's great for readability.

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmClD6oACgkQJNaLcl1U
h9C0bgf9Gjdn+dx9h/0a5itgBfbXwSWxqmKIBJz29U8zhmWt/sUtM21Rat05VG/u
r12bcVn/IIsBZRKL6iyDRopHUQIFh5jfS04TL1nfJIhd78il7bWziIU7YZ5jykKx
95zI9L7EXEIB8zXvPLNCXGNgpq0STPpmYSvvrsX3V5zYTmbCRWMMIRy9XEwWRKxC
hj6uWpyaRAxmOdtazvgP2vqknFOHjulbaNZVnS+ubDyRk+JzQSRU45Pf1e0l89n/
0wYVd4hxRg/QFOSpzq1hDDWPxpEhqu12F8f3uWQEVcJoZ57lpE8vVEtoChRILsto
cGDWixK2xQU3NDvehZ1z4fz7iLi+rQ==
=Aswp
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--

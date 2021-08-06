Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF53A3E29FE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245689AbhHFLqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241873AbhHFLqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:46:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A62F60EBC;
        Fri,  6 Aug 2021 11:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628250358;
        bh=lc7TjjkywpgZUl0uKJvryhmrqgXPv4TdZTjYg6zyHyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hm183JOENzsjSiX628aQnr1XsYwuCzVRLy9DTh7ni9/LUnxWIHFKwi4IRB7T8LNFy
         ms2tvAQlatOLOm+QP9KKtPLAFC64lPOT8eqdsfiymOW9yyXNGdUbma+TMKzJ2hSKLX
         0UI1m6JFr1D5iAtViAQmXoDNUlzuqoY7SnCACcorr1Cz/2xOZ0BW98ZYmOZJr6O1qk
         HM3KCT4LNk8IggmlnhAC+P9IpZG11VhdKuzwVeipNyLR8eZlY8MOxnY/ymxJdBPgZt
         jNJhZRYuHpMixPJAKCnCN1XZs6Ll/i9BzxkLFfnSom8WIFrPj2dUtooEUyCm7e9z1k
         5CTyOD1TWOQAA==
Date:   Fri, 6 Aug 2021 12:45:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alistair Francis <alistair@alistair23.me>, robh+dt@kernel.org,
        lgirdwood@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v9 03/12] mfd: simple-mfd-i2c: Save the register client
 data
Message-ID: <20210806114541.GY26252@sirena.org.uk>
References: <20210806091058.141-1-alistair@alistair23.me>
 <20210806091058.141-4-alistair@alistair23.me>
 <YQ0fPEeZGYe7f1cC@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pDtNmxPr5KTxcQ6Z"
Content-Disposition: inline
In-Reply-To: <YQ0fPEeZGYe7f1cC@google.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pDtNmxPr5KTxcQ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 06, 2021 at 12:38:36PM +0100, Lee Jones wrote:
> On Fri, 06 Aug 2021, Alistair Francis wrote:

> > +	i2c_set_clientdata(i2c, regmap);
> > +

> No need to store this here.

> Just do this in the child device:

>      dev_get_regmap(pdev->dev.parent, NULL);

Note that dev_get_regmap() is relatively expensive compared to a simple
driver data reference since it needs to go search for the device to find
the regmap, it's not the end of the world especially in the context of
doing I2C I/O but storing it isn't a terrible idea.

--pDtNmxPr5KTxcQ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmENIOQACgkQJNaLcl1U
h9DxJQf/TuyP2y3UfrP+x/Wbj5TUX4a0xU78jS7hhKqNUubUfUVUt+3e2HWDFn0S
7L/kD0+2R2LgseDvTaEesgsh2pG3zoFdmLUESXJ2jXjNFMEs5ghnl2f6UFN0Xhbq
WhwTOq7czFXuPrsGn/ENBhS4CMZtEy9VyBGADad+9ywJ9mSVrk+G1C3kVL9noefx
TFIMsSOYOyeoFy3SQSGpOuSzvEfc3QT84QLdO0iF3EHyR4pyTaRSbDhMrvCuiQ1v
y4icrwxHH3yH28LcErkBRzsDrwoRrVW5E/a0R3L6cK9niAl5cMxIkvu7w/rg/WqZ
bwM487Xppc5FK6NmjakYEKnrOsmPQA==
=v6hN
-----END PGP SIGNATURE-----

--pDtNmxPr5KTxcQ6Z--

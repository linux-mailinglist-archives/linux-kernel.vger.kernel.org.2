Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE9940C5B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhIOMxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233269AbhIOMxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:53:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60C4D611C1;
        Wed, 15 Sep 2021 12:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631710341;
        bh=eO7LROAkbQL8kyyGq2LBHt7EiYSoyaJfMG4S72prsuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d42rcmdn1LBFQo4L1D61IRI0LrbM2wIKoBLpypE1r/iuafTzVQqj7KWSvJtWB8nEO
         57ZDy9H796nOL/ZIN1l3xQsuIvNfWJ2kZ32FPNBJCGAQaT6j06qn/l6TCt0sGVzSXY
         K0jp8/ts8T90IzLuvASb5GcxT2F4XxCOTv+DRot1J3vkh9pWbgZvevTLCZgI3S/y1l
         axLpdf5ld0M29ZB/72SRxn2Pj9VsbTARznl9dvLaxvOxxlMRfNno6VA5Lhu1N/r69d
         jH4re+jIGyteV1kgnKrhBlPjxS5cX6rQBJCQV209pXbMAAKi88bVLFwteiSvfjJiZh
         P4UvxhmvQOlng==
Date:   Wed, 15 Sep 2021 13:51:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v3 2/2] regmap: spi: Check raw_[read|write] against max
 message size
Message-ID: <20210915125140.GE5389@sirena.org.uk>
References: <20210915120951.29907-1-tanureal@opensource.cirrus.com>
 <20210915120951.29907-2-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Content-Disposition: inline
In-Reply-To: <20210915120951.29907-2-tanureal@opensource.cirrus.com>
X-Cookie: Absence makes the heart grow frantic.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 15, 2021 at 01:09:51PM +0100, Lucas Tanure wrote:
> regmap-spi will split data and address between two transfers
> in the same message, so max_[read|write] must include space
> for the address and padding
>=20
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
>=20
> Changes v3:
> New series

The changelog in patch 1 claimed that v2 was the first version of a new
series.  Which is it?  If you're going to include an inter-version
changelog it should be meaningful, just writing something for the sake
of providing a changelog tends to only cause confusion.

> +		if (spi_max_message_size(spi) !=3D SIZE_MAX)
> +			bus->max_combined_rw =3D spi_max_message_size(spi);
> +

Why is this conditional?  The whole point in returning SIZE_MAX is that
users don't need to care if there's a limit or not, any client logic
checking sizes will always work.

> +			if (map->max_raw_read  < map->format.buf_size ||
> +			    map->max_raw_write < map->format.buf_size) {
> +				ret =3D -EINVAL;
> +				goto err_hwlock;
> +			}
> +		}

This is at best an assert that the logic in _init() is self-consistent
so just silently returning an error doesn't seem like the right thing to
do, it's going to be super obscure for users.

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFB7FwACgkQJNaLcl1U
h9Dt7gf/XlEhf5FUSoGuccLAcieIplRgz2zkt4w3YWo8myCkOrEq/BoSfXmqOmXN
40BQwG95M8RXz/AUg9kA5iM2y3kaIn1iNrOjzWUCofJOfP8LJMcIc7q8Xr3Oygv/
Aeb955CnlbWC51cN5/XvCzK5WpSRkuUHtEN8Nl/G/gFWehU/V2ZfsmyBwkgkDuvJ
3YOhXwq9d3Dq+7NlMw/Ej7NBZXE4V9SDn8fWVL9IyDBQCw7ao0R9ClKPK16UdGWe
MADbdjQFFUshlbGdCovokcwFlWEYA7s+RR/2uCr8TBBa1uUQbvMV+ShlXMasaqsK
Vj1dxZhJpwYGYs7dOo/S6XMsxE43ww==
=Yo+T
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--

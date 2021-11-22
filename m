Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA04459021
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 15:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbhKVOZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 09:25:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239182AbhKVOZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 09:25:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A50446023E;
        Mon, 22 Nov 2021 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637590944;
        bh=WKzltYKcWxxR0C3ceu4znEwrAGhBPzs0S1yq2paT+UY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pa42aqNDzulWRQi9OYypU8lYqnWjd/AgYdW+TB0RC1H/0owbOKtTb1kdVXY/obGu7
         zrNYvnC4z8kzKxth5diPD3kB7M5ir1Ctl6rlm2GeUUQb0P661lXvdQM808bBjNpXab
         SFbtDdSbLc7QjBAz9UaYKD4JOz9jjgkyaktulzKOOwU5Or5D2jRmHUFWFaWKyBphFv
         7ex/YGqtlVnGaILx/InZXt0AECbfrg+FAfTjeyBWvfHrPNLC9wNqoJsfInwEfYzUkT
         7Mq4rZVxQ/0Iphwozy55MUwJJ9mJ7q2r7OTLOANgZfjOl+G8si4bpByY7mA4GzXLd9
         EjL8PJCqM8yrA==
Date:   Mon, 22 Nov 2021 14:22:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
        bkylerussell@gmail.com, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com
Subject: Re: [RFC patch 2/5] ASoC: tlv320aic31xx: Add support for pll_r
 coefficient
Message-ID: <YZunmnHqemZRJ6JK@sirena.org.uk>
References: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
 <20211119153248.419802-3-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PmgQRVULIqfojczT"
Content-Disposition: inline
In-Reply-To: <20211119153248.419802-3-ariel.dalessandro@collabora.com>
X-Cookie: Lake Erie died for your sins.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PmgQRVULIqfojczT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 19, 2021 at 12:32:45PM -0300, Ariel D'Alessandro wrote:
> When the clock used by the codec is BCLK, the operation parameters need
> to be calculated from input sample rate and format. Low frequency rates
> required different r multipliers, in order to achieve a higher PLL
> output frequency.
>=20
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

Did Michael write this code (in which case there should be a From: from
him) or did he work on the code with you?  The signoffs are a little
confusing.

--PmgQRVULIqfojczT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGbp5oACgkQJNaLcl1U
h9CvBAf9GOA835hDgBLet04zGnfaBKpUlrl7hmECxdRr48Sa7/Px2zGXfjVQuTMm
DUlgYzbqInQKwYzyZc6fJZuckQ6rH1XE0I5abjYX2u1lmzxI+cZxFqXn36DIuzdh
vQ42B3TA6qTsYiXsu/gPqiOiXvnN/WQdTHY7tEI7EoOOBTZLJGqtMogLPC017BLL
nHeSmAeEnyWb3dPXEcgDGf5skYaKT9wTLIordEI801/mUn9a1vJO7eqFDSDcWoMe
U4uXqWun43CWTkzOa0TPQHx2/F3WGO5tOmnumCO+KYspRDmfGn2oh6dPsuF56IV1
kn4ax3imRAqnWphauh3/dilfO1kRsA==
=ZDS5
-----END PGP SIGNATURE-----

--PmgQRVULIqfojczT--

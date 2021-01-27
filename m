Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CFC306232
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbhA0Rhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343847AbhA0ReO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:34:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F02D60187;
        Wed, 27 Jan 2021 17:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611768807;
        bh=DdKngb2YIcQrgemBY4ma9VuV+K3VnS5RUHlaX7aNcEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bezFeLkNWpbSOOiyGS1wKapfKLSrkt6sfzxYcgqh536qfPQfssRPOhHnoyqu8Nyy+
         WmSO1/c6LU8Fcjysog3DCObQJLf/3zmBou/r7/50T5m0AWcmiQtn/S5c10KtErn/VB
         OmLzdvJo/zULxbxaX6v56jE5Jg8/RR8cECzY2Gcmco1lejG/7+l0Qta91NUJTXMw+o
         wTBTjUYW7NJn4TNlnpYXP+xbxHW+wAAO/KLnT6pNN/xejrwgnbraSZdboZzvn9+gqt
         j6Q1EiZN1T3OpAJst5E/DC6cJvbe9bLN0u6PqFiwkYBsRTdmacF68oFvJJAWq3+N5H
         Y3Ci8wnk6laBQ==
Date:   Wed, 27 Jan 2021 17:32:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: avoid error messages for deferred
 probing
Message-ID: <20210127173244.GG4387@sirena.org.uk>
References: <20210125192736.17657-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7uYPyRQQ5N0D02nI"
Content-Disposition: inline
In-Reply-To: <20210125192736.17657-1-andreas@kemnade.info>
X-Cookie: La-dee-dee, la-dee-dah.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7uYPyRQQ5N0D02nI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 25, 2021 at 08:27:36PM +0100, Andreas Kemnade wrote:

> Noise like this happens on boot with regulators which can be bypassed
> when the supply is not probed. That looks too alarming and confusing.

...

> Handle such issues silently.

This means that if something is failing to probe due to deferral the
user has no diagnostics of any kind which would allow them to figure out
why that's happening.  Reducing the severity of the diagnostics might
make sense but completely removing them is going to frustrate people.

--7uYPyRQQ5N0D02nI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmARo7sACgkQJNaLcl1U
h9C/zgf+M23E2uLySMQpf+A6iMEsNiTgpP7a/viNGD5sYniZQUKnaIAK5DxA9Wxg
IxeLQmVrNJ/y9+2meCuGWt9OQZSTkxB79jJjHfvO35SNFtGF9aQx/2o4GS2Qs9Dy
GBLOUOv4GJvkJjFcMEtaZ0GpknvWUE9c6O3lX5a+RYyl7r4ADF6xI1oCfoqeaYxC
iqWjcuM0R0EY9V54WfY9pplpSdQ0vhpviMaS/TwZkg8+ReoIBUeBvZh4A5gEdUGk
gy/nAa/nbm50quO60GmuDzvpEk5KzjW8dkKR24YYK1ksd/gTxwCMpSAzYMp8HCal
4Fu3pD3sBZkMffb71pMFVgO1Wyv5zw==
=8ALC
-----END PGP SIGNATURE-----

--7uYPyRQQ5N0D02nI--

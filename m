Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A8D352E9A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbhDBRmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234652AbhDBRma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:42:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F26136113E;
        Fri,  2 Apr 2021 17:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617385349;
        bh=YYpr5IaWCQsD7N7ywU8mjtGkvi9LGdVG8pQe6xdHBFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwGuZK+OavfMWRuZiKZKmvPq2vXhAZe7xsezIJP2dPOV8L67dJ0mVS1AIEvVXGJkZ
         rQW+OwlBtd/qFsNFVdAhyBhplyQFsy+Loz2BBNs99SHFJD/qBcCen5YDbJ7ey4nBtf
         T/TdIw8Q0JNaHOWFIlGfx0ajzLEGJ60cHQtEDzkhruLKHH+Z5lku5swAwrrfE1b0pP
         kUoT8ggDq+casdOsXEiz8WW0+wARFq037ftfyvkyOsEbrvQ2HgNQbES2ViYalaiydo
         91TXJy6p5gEVCKPodfQ9djdW7O4/S9z8a6qMFwBVs5SKW0kcHaXVEscqbc6cknLHxb
         +ixPPZVKRE2gw==
Date:   Fri, 2 Apr 2021 18:42:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: Re: [PATCH v5 15/19] regulator: Support ROHM BD71815 regulators
Message-ID: <20210402174215.GI5402@sirena.org.uk>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
 <eb20a8f466a9ccbc26d261f0102d203718a32fa0.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6lCXDTVICvIQMz0h"
Content-Disposition: inline
In-Reply-To: <eb20a8f466a9ccbc26d261f0102d203718a32fa0.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6lCXDTVICvIQMz0h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 29, 2021 at 03:59:51PM +0300, Matti Vaittinen wrote:

Acked-by: Mark Brown <broonie@kernel.org>

but...

> @@ -0,0 +1,676 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2014 Embest Technology Co. Ltd. Inc.

Please make the entire comment a C++ one so things look more
intentional.

> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>

A regulator driver generally shouldn't need machine interfaces...

> +				ret = regulator_enable_regmap(rdev);
> +			else
> +				ret = regulator_disable_regmap(rdev);
> +
> +			if (ret)
> +				dev_err(rdev_get_dev(rdev),
> +					"LED status error\n");

Better to print the error code, and that error message could be a bit
more descriptive.

--6lCXDTVICvIQMz0h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBnV3YACgkQJNaLcl1U
h9CG4wf+Ld2glQBnwDCew6b6vrM1TQ2QiVAzZAJ6it/rr9KPdem694P58K+TjiPQ
+xrTwHNQzxClt543Ojcnz/GgVNkzAX9EB+rryi4vd5dgIrflVFmVHIAcFRwdMm4G
seyKLrNZMKjXrZYnsOWq8FBp9IQY8XHS3VTT+xZZ9bL9u7nwQLPRiTOw8pnO/Rm5
bK+Z3nUUMjn1q/9qb7RxcJIoDdz4ZXHPBVeiXJHlH+Qte7uCX5DBwjCUUmYAd2js
Aag6x5mNQQr1pu+c9EFgFHvpHwU7pf7tdHHlY6SDktsVUAgj3N8SKwJI5NAfSj7W
lprOxHbcePNWLWGV/945wTEnsyFpJA==
=KPCY
-----END PGP SIGNATURE-----

--6lCXDTVICvIQMz0h--

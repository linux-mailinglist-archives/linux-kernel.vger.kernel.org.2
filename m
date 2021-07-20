Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864213D032F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 22:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhGTUDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 16:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237057AbhGTTqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 15:46:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F1146100C;
        Tue, 20 Jul 2021 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626812803;
        bh=498ZV+kTA8luIgnKHXiUEOs3RG1lku/aWIWKkBlOfmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSSekSsUNrxEp+zjoWf0x0j4JXl/SqH3jIkZ7K4IKmNvHWf5E87BLzwqFwrgQWlmY
         ATbTZCwiqX/YlGkAfeo9notUych+JyiYoRvq7uR+4aiszQo+ORTWuj+/KHJh5MtnXj
         c0Vcgqwi9/S0ENcxPsNCEegn8ETUqzTot5CaI7BLxZr0mtsNX3zVoSGIlV2/7Q7dTR
         ZYCjzI7yUEV5Suhi6bZlkuxq1r3e8ArAsDbX1X+d5Dgn4eFptXnLl/DnvKbs+Z7VCK
         DmulWyXVih1wB3VGmka2JxgyvKOIw6UafzXtRdPJLCTkGzGVh0wOc1JUq43ND9eOty
         elx0xRRT+Vhhw==
Date:   Tue, 20 Jul 2021 21:26:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alistair Francis <alistair@alistair23.me>, robh+dt@kernel.org,
        lgirdwood@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v7 1/6] mfd: sy7636a: Initial commit
Message-ID: <20210720202639.GE5042@sirena.org.uk>
References: <20210708115804.212-1-alistair@alistair23.me>
 <YPbjZdu7T9wFcvNz@google.com>
 <20210720152351.GC5042@sirena.org.uk>
 <YPb1Hs0EoZ1MikuX@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline
In-Reply-To: <YPb1Hs0EoZ1MikuX@google.com>
X-Cookie: Revenge is a meal best served cold.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 20, 2021 at 05:09:02PM +0100, Lee Jones wrote:
> On Tue, 20 Jul 2021, Mark Brown wrote:

> > At least the regulator probably shouldn't be - this is just a Linux
> > specific grouping of devices, it's not really directly a block in the
> > hardware in a way that's platform independent.

> I've seen (and authored) regulator support in DT before.

> What's changed?  They're controlled by registers, right?

Nothing's changed, I routinely push back on regulator drivers that have
a compatible string for a MFD subfunction like this.  I do miss them
sometimes but try not to.

> Is the problem that the registers are usually split?

It's just not really describing the hardware, it's encoding the way
Linux splits things up into the DT that adds no descriptive information.
We're not getting any information about where the IPs are in the device
or anything from the compatible, and typically it's describing a set of
disjoint IPs with minimal overlap in their configuration.  If it's a
binding for something like an individual LDO or DCDC and we've got
multiple instances of that within a single chip then it starts to get
more useful but that's not what something like this is doing.  We're not
gaining anything by putting a compatible string in there, all it does is
make the DT bigger and add some ABI.

Similar issues exist with CODEC subfunctions - those are usually
describing huge piles of different IPs but we happen to want to pull
them together for Linux, typically including some clocking which if we
were going down to the level of describing components of the MFD in the
DT should be being described using their own bindings.

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD3MX4ACgkQJNaLcl1U
h9BumAf9Gv7JxuM4KnEtvd75CvzJ6Q1mpDe/o2nSUZ28ZpkUWzFjSPKcuZVP4QMr
6pfKO7WafBbuYEsF5Cqm8foXG3mf657HcvH7Gh8S5YAt2edtHFEyf1NI/CxpV0pd
oCT1KyHMfVCmPtU5Y1c1qpD1FrAQqP7LBlQCSbsbLgKNmNXCwT81p4Byn+FzGK0Y
GGoETC8N9/5X26ypFwmCFRgtwYv5YUHJNp3fgfg5AfPc/Ylq1I0FkUweVWWBaZtm
9BBe9iiGzTgQvHwYUT8YVfsgBh2fVuTGoBMHLB6hkQURTPGTPU9t906w1YIu/HU4
Q15zJ/pjolZ+BE6CO4hDx1Z0s9qPgQ==
=Ul11
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--

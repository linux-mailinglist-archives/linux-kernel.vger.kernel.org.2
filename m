Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4923CFDC0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242119AbhGTO7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240986AbhGTOxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:53:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1251F610CC;
        Tue, 20 Jul 2021 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626794635;
        bh=stC0BzA+DYwcXTiLCi+t5d7+76Ta1ZpDociH/Lgci/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlMP31/TRk2qMDaVki+1wjeieqAMpB5eSZ2KSre2/ooBHAEjHoGx6MbWGTYaZudTC
         cgNP8utSKmpyOlQVSPFGjujijBk8U6m9JpJlTsRCIyXdfYCRj+7YC6ZVk7pd6xPKsh
         WH1PTU4R+uJ26RA4XF4HQwpfRHDoYG/f+JZfoHGL1rWj+cezhxXQBgj65VGlb8l1cY
         e4VL9fI7CG7NIDW4x+h5erkNPHkzZlsDn3lfrK53XuOJ5tqckZ2W+DdKly+5lsJtjh
         sr9CAASEX4v+5nuJGqBw6zKopEbBMCKwWwcpeD98Un33lOVRldVRxDN+S5TBIVucYn
         EzIdOpQ9jShbg==
Date:   Tue, 20 Jul 2021 16:23:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alistair Francis <alistair@alistair23.me>, robh+dt@kernel.org,
        lgirdwood@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v7 1/6] mfd: sy7636a: Initial commit
Message-ID: <20210720152351.GC5042@sirena.org.uk>
References: <20210708115804.212-1-alistair@alistair23.me>
 <YPbjZdu7T9wFcvNz@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <YPbjZdu7T9wFcvNz@google.com>
X-Cookie: Revenge is a meal best served cold.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 20, 2021 at 03:53:25PM +0100, Lee Jones wrote:
> On Thu, 08 Jul 2021, Alistair Francis wrote:

> > +static const struct mfd_cell sy7636a_cells[] = {
> > +	{ .name = "sy7636a-regulator", },
> > +	{ .name = "sy7636a-temperature", },
> > +	{ .name = "sy7636a-thermal", },
> > +};

> If you put these in the Device Tree, you can use "simple-mfd-i2c"

At least the regulator probably shouldn't be - this is just a Linux
specific grouping of devices, it's not really directly a block in the
hardware in a way that's platform independent.

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD26oYACgkQJNaLcl1U
h9CyzAf/afWZvdO1BI74mZ+EtbyLufn+rfykBtoUCaBT4mi7ryweoZTiZaL4UM4/
X1RVHOveN2kQvVLZD56iknuPgbaK6e8nAkjJ34tcH3Js/VfW00sEbq3ZVoajXCdj
m1mApf1Yc5RLluqMBJKAVL6Jvb3JgAhObWeoy6G4nrymlCMcfOI2FqeKVweZ3+K4
Ir2n6cHuvVOtJiM9CylMHhwul5idLZgQRy7ICNnsRZuKu6snRFG4t17PouSdhQd4
/n1VFL+NnxWDLZSIRoG3l6RmVUdGf6+QQlIbN5WkNsWD5NLf+FnqhVh/iVo3hCt3
LWLUD78Xz0aFHtLFa56+s6scFjAw2A==
=oEMs
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--

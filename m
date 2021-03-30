Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DC934F170
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 21:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhC3TIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 15:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232839AbhC3TIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:08:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A91036187E;
        Tue, 30 Mar 2021 19:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617131315;
        bh=hdpJfzOnIKrzYxlAvJAQY3p7qJScz2PMUWeiFD16dFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKQ31vgweZmVGLndNG7Ov4/goepC+tWgRr1PHvac/tKFw2sGgXdWv6zdNhItdHI54
         gACzNcefpb3sTql0tGvhvqmE78A/mRMe8JHmOC6kZ2DkeUy9tzbbkPxUB3kG/pdq/g
         WbwWwMW7L1vKPaT7k5vfmAeczimZoeYYWn6/IMwfse1gHWVRAfcPyK2SJqB1W1m32k
         mDgH3dcorGkZ4voHCcogHmoTt6s+RscnBmbu0KM11bXrfdTNz23t3UWW/aHKjitRir
         TFMjwdi51rbNeuAo76ClqHoCu5kZ1nbjHkKrS/NnBr1q8WKxkZ60N8jKFiGRHctE9R
         vLLLoD+w3kP2Q==
Date:   Tue, 30 Mar 2021 20:08:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v4 2/5] mfd: sy7636a: Initial commit
Message-ID: <20210330190823.GM4976@sirena.org.uk>
References: <20210326015511.218-1-alistair@alistair23.me>
 <20210326015511.218-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eWmFpGZayiNrn4FL"
Content-Disposition: inline
In-Reply-To: <20210326015511.218-2-alistair@alistair23.me>
X-Cookie: Memory fault - where am I?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eWmFpGZayiNrn4FL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 25, 2021 at 09:55:08PM -0400, Alistair Francis wrote:

> +config MFD_SY7636A
> +	tristate "Silergy SY7636A Power Management chip"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ

This selects but does not use regmap-irq.

--eWmFpGZayiNrn4FL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBjdyYACgkQJNaLcl1U
h9DJMwf/ViSnJH6/mEB6Mpb8rIBM23yravTP5hIb1zawk+hdgfHUSr912s285xOu
3w01yMYhMAYVZBZzR+rB7tc+VJAd4JHpQMlfywEO0VxrdqRTnL+HrsqeX5XJvMOO
26gBacFOTEnJ15PrOqaSsGvUQFUmf6isxncMDKroOdUScfs8DrLYQxGh8FtdJEL8
sC3XlwTrzMuvKsIoVMJb1rxvgD10gXmFcp6QP9wdxIri9zNz3BwkdVnKVB3Q+NR6
K7QTmw3dQD7HrrBZEeRw911HrTBj67oP0RUKTOTKzGcoHGJuqbBtkZSuV4OI/ES6
zUgqbODGILh1qLXheQvyu3sVzCZq2Q==
=c5NS
-----END PGP SIGNATURE-----

--eWmFpGZayiNrn4FL--

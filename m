Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499903B74F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhF2POF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234613AbhF2PN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:13:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EED1061D5E;
        Tue, 29 Jun 2021 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624979489;
        bh=IA+oZ5ip9u2qXhn0bknb8s4FMiQeh1admHHae8tV4hU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gnda8MieoA+S6RMhAezYCmSZqS7Dwga+uXQ5LFs4ZpxKANs7BzP+iMNsUIumocg3J
         Y/j3nBhK84TbcKeXGbH3XMwBDncOpPdxmZlrlptfoyicFjRPk86uq5Rod0V4I1azU/
         TUDhtIdLWulVJLJHb7wFlwi6WM9Qvn3Eei7cxw8aooPBfMuzJoahEwytVKmgEM3sYz
         pmMBZLdKphkfFGKUSmsl6JRVayJS5VeIJ/O9l7vZF/NR3dxkvGHLDQA4BofuhJx3HK
         2da7U9r/jjMRBsS9rAq3XT6brc9ux+PrqQrFwIbNA+BdbuQRbBN/FyH61r928x72PS
         E5JvjC6oWkjwg==
Date:   Tue, 29 Jun 2021 16:11:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Axel Lin <axel.lin@ingics.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v10 2/5] regulator: hi6421v600-regulator: fix platform
 drvdata
Message-ID: <20210629151101.GB4613@sirena.org.uk>
References: <cover.1624962269.git.mchehab+huawei@kernel.org>
 <eed34e8897c79a2ab13573d3da12c86569bca0f6.1624962269.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <eed34e8897c79a2ab13573d3da12c86569bca0f6.1624962269.git.mchehab+huawei@kernel.org>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 29, 2021 at 12:31:28PM +0200, Mauro Carvalho Chehab wrote:

> platform drvdata can't be used inside the regulator driver,
> as this is already used by the MFD and SPMI drivers.

Can you clarify what exactly is using which platform drvdata already?
This all feels very confused and I can't tell what the problem that's
being fixed is, if it's a real issue or how this fixes it.

>  drivers/misc/hi6421v600-irq.c               |  9 ++--
>  drivers/regulator/hi6421v600-regulator.c    | 49 +++++++++++----------
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 18 +++-----
>  include/linux/mfd/hi6421-spmi-pmic.h        | 25 -----------

I'm especially nervous about the core driver still being in staging
perhaps meaning there's some issue with it doing odd and confusing
things.

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDbOAQACgkQJNaLcl1U
h9DAlwf/Xk/1GHAewsVo2OnlmvHfyZaTMpC/v9OxRXYKvzdLpnnrSfPKRPhSb8vE
Bzx2cl0Ii8/DQFux0Mw+f3HawsIT9hD2NEM0IWwEJuvNm3c3x22fQgv2KoMaKOpx
GCC0xOL3gM73xGAA7zcYAqcmTnLyfI/+vZzSQISJX5LX0A4nHs3yWl1Wsf/oBfaW
ZmetZNAcqZcUFLAX51xAV4OG7XJZHH3bdjGl97rUngohEhqJaabboU6F8HTnMR4P
tzVqDsk9TqWYOmE+xr47/hV3XDih9mrAXikqmG66e+hvLdYTXD54qHeGVVDUzzOn
ZIELYdxaUl9DMR45NrfyqHE5Th7rlg==
=GCra
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

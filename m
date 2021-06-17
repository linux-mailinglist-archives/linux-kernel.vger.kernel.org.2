Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2E53AB19F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhFQKu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhFQKuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:50:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1324613CA;
        Thu, 17 Jun 2021 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623926928;
        bh=bau1sJVrqnmwLJCK9iqruNzCaMLSnzjtAbht3vISZY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmB6qMM6hnJ3qujtDIuNjXRiogFQVOXytKHJaMONAwWjH7Eb+5eEAi/0D6ao6z+qo
         Oabdq0uDOfCkdedqnvgi4Gzt4ufvOzq9d1DDwwNmT+n3qAadam39jOqbpzSlCCanOa
         5K0BKCdKUxQZdsbM3MCuEIqhnBrpX+oOiDBmiRHrq45tSh/l2hOioysuj+sF1zKjPm
         zysDstTL8hxC/Q5qxdfo/ZCpM8ssKTiWHPbcZUs3KYM/Pb6kbkKCae0fwX2JgkZ+Ca
         Pu8lgM6XfUwGnssBQUzl6rzbscDcu6S0Db+UYHXut1aY7GdgSxe3AdPoaHlvHqXq3m
         DySuTZuSqcH7A==
Date:   Thu, 17 Jun 2021 11:48:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?54+t5rab?= <fengzheng923@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        p.zabel@pengutronix.de, Samuel Holland <samuel@sholland.org>,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
Message-ID: <20210617104828.GA5067@sirena.org.uk>
References: <20210615130326.2044-1-fengzheng923@gmail.com>
 <20210615132207.GG5149@sirena.org.uk>
 <CAE=m61-kHPeKNvEEc08w8DeUwssGPWNf5UaYojRPNZRJ0v=arw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <CAE=m61-kHPeKNvEEc08w8DeUwssGPWNf5UaYojRPNZRJ0v=arw@mail.gmail.com>
X-Cookie: But it does move!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 17, 2021 at 03:42:43PM +0800, =E7=8F=AD=E6=B6=9B wrote:
> Mark Brown <broonie@kernel.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:22=E5=86=99=E9=81=93=EF=BC=9A

> > > @@ -0,0 +1,408 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * ALSA SoC DMIC Audio Layer
> > > + *
> > > + * Copyright 2021 Ban Tao <fengzheng923@gmail.com>
> > > + *

> > Please make the entire comment a C++ one so things look more
> > intentional.

> For example;
> // SPDX-License-Identifier: GPL-2.0-or-later
> /*
>  * This driver supports the DMIC in Allwinner's H6 SoCs.
>  *
>  * Copyright 2021 Ban Tao <fengzheng923@gmail.com>
>  *
>  */
> is this OK?

No, that's what you have already make the entire thing a C++ comment
with //s.

> > > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +     base =3D devm_ioremap_resource(&pdev->dev, res);
> >
> > devm_platform_ioremap_resource()
>=20
> But I need to get the register base address of DMIC. E.g res->start.
> host->dma_params_rx.addr =3D res->start + SUN50I_DMIC_DATA;

OK.

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDLKHgACgkQJNaLcl1U
h9A0pwf+LW1ZtYwHr81ahK+pl3EiV/POTOJ7FJbWi3WW2Qp5f2dwCe2pzuL6cYZj
OvpcHO7/2R6alg5gmV+ZoNL1jpCwEN/GtDAhGV7vTZbiYqPlWRJATQ6i/OfezRM3
vAarjgq/zSPSsoclgfTxW34Ximb2mWroAO7+mwXnO6NnqD9fQizE1Nvwuvmmb+5W
VmUj4twfmrb7NiBq9rCORvHysgh743068QBgZ8TSSJqlE+x1b+q6DGJu2eej93df
KyiBggovrE62m9q+YTiL0a73OGLLqzVlgqBMRn8STtj5FKbLWq5CmdDNjVROF0Po
BX0ItM++Ki1iiTCmdDRtYp6lEjSFiA==
=u7Z8
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

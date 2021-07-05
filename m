Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F0F3BC1D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 18:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhGEQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 12:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhGEQ4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 12:56:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F34AB61278;
        Mon,  5 Jul 2021 16:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625504006;
        bh=OQoRiE6FpxfI2/SIV4tbnVrTGtf9MzYZtaCIiysd5jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWXh0H6ilfMGghLa2xY4692pc1OH6xTKse5tUxs2e7Q6afddB0TQHyu3EaDuEcz8n
         pBoCC5MHieN3Y6YjLxffBh/EvAB1wS20vtdq6eQf0+/RmhlCHoGHz1XAXoqXOKNNEU
         SgcgBXFFTZWak/dq4DbAjOvBjtwjNar5WWEQ6fK+c5oZU9MVyAZdVI05CuKCdtj45X
         cHu0KLriFFHdLFhv0EqS+17ohFAMcK1DbzvsLPA7v0UEUUIDKPgq/6kbwUoKJB+mO1
         YQRD0lQVk8aeTB7AS5IVzDSlUZzzGZnNKc+QXQZYFiBtOHP/9ky0wvCC7AT4Gq8/n9
         fISoHQ+KleSEw==
Date:   Mon, 5 Jul 2021 17:52:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Axel Lin <axel.lin@ingics.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH] regulator: rt5033: Use linear ranges to map all voltage
 selection
Message-ID: <20210705165255.GD4574@sirena.org.uk>
References: <1625111646-3955-1-git-send-email-u0084500@gmail.com>
 <CAFRkauCNf6fP8zAz+0gY_Vzb_wCtVyYqLjw8s1T+t2s=bR0RQw@mail.gmail.com>
 <CADiBU3_dCNvZRwewiztB0UGFvDz3g5sw-q+95sg9akqte1YJsA@mail.gmail.com>
 <CADiBU3-i2tg33iCjX83NEYAhYYabnHjL129+tOm9_h=MrPhraw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline
In-Reply-To: <CADiBU3-i2tg33iCjX83NEYAhYYabnHjL129+tOm9_h=MrPhraw@mail.gmail.com>
X-Cookie: Star Trek Lives!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 02, 2021 at 11:47:50PM +0800, ChiYuan Huang wrote:
> ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=881=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:53=E5=AF=AB=E9=81=93=EF=BC=9A
> > Axel Lin <axel.lin@ingics.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=881=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8812:41=E5=AF=AB=E9=81=93=EF=BC=9A

> > From the regulator register in probe, it will get the current voltage
> > from the IC.
> > If the vout sel is not is over N_VOLTAGES, it will return the error num=
ber.

> > But as I think it's the side effect to change the vout step num.
> > To use the linear range is just to guarantee all vout sel range are inc=
luded.

> > That's my initial thoughts.

>    Like as you said,  the first revision is from 2014.
> It is almost EOL for this product.
> To fix this seems redundant.

Even if something is old it's still posible that people can use it, and
if someone's done the work to fix it then why not?

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDjOOYACgkQJNaLcl1U
h9B+Mgf+MWapEDWuJZ3hOsHSCMCCr9jtCwoIiZCIBNIK7H+LjFLnbfw1n/6nwrJp
LQ0AAvjuoSklB7AhLj4TEQ8v3kGOgglOxwltjCb6idxYbfOpaxc2qtjv91eC1XeB
x8d7EwWTE6z1tM/IN/e3C0yWKenlE+Dm9SIbhZBviy5/rpCa0UB9Akqq/+HDL6x/
pw3Y27D9l4QL4WxgGzKLEyN5sMkzI3Uvvc1tDsBoAXjcRh+tYjbbvqhF19N8obyL
f6h1XgQ13iFaYJdDHiccewq9NjDPWlq26O9mGn0JN50XK62TXjr5ClBK6pjv2Y58
iBnvR298V8NqJTbYmtOrm1dx6N9q0A==
=AXjd
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--

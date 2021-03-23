Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238C33466AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhCWRtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230378AbhCWRss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:48:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3B5A61585;
        Tue, 23 Mar 2021 17:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616521728;
        bh=DT7S4ANP/ZZuhKQtMce/aXHnvlXtr9OnxskEhH4djlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1x4uled6bRtRcVetmBH/l2bRYlraEGJe7UjUD0WmTDX4ajHIripgIMoSk+YUcTUn
         ftxUshYg6/bAmBNfPpTqEXFXXjgaymqfew7euiLU57QrERWSqofcRMrQkp3RV5keyI
         bOqH851sblS8JiQl38haGgEA1UB2YFIKK8u3U28ZDqZ4/5zOtDE/ARK+b53F8s3JcJ
         3VnEPdR9FbQGPMlYO3b33rAnqg28aECe6LJQhRlM+7Ul7gjM4MEK42+Kn55B9zstvt
         EoCLhD6EI6jjEJQsCbHoAYVym00wx6pobXzurxbtEQt1PjDFqUDNFUTCg6xcCDMbas
         qjVH83p0H3/IQ==
Date:   Tue, 23 Mar 2021 17:48:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210323174841.GD5490@sirena.org.uk>
References: <20210308212952.20774-1-andreas@kemnade.info>
 <20210310094821.GB701493@dell>
 <20210311184033.GJ4962@sirena.org.uk>
 <20210322145925.GY2916463@dell>
 <20210323171143.GA5490@sirena.org.uk>
 <20210323172002.GY2916463@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <20210323172002.GY2916463@dell>
X-Cookie: Formatted to fit your screen.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 23, 2021 at 05:20:02PM +0000, Lee Jones wrote:
> On Tue, 23 Mar 2021, Mark Brown wrote:
>=20
> > On Mon, Mar 22, 2021 at 02:59:25PM +0000, Lee Jones wrote:
> > > On Thu, 11 Mar 2021, Mark Brown wrote:

> > > > If there were more users it'd be better to have this in the core so=
 that
> > > > problems we can detect like cache stuff if that's used but if it's =
just
> > > > one broken device it's probably not worth it, this seems like somet=
hing
> > > > you'd have to try to end up with and which is going to cause timeout
> > > > problems with a lot of I2C controllers which would tank performance
> > > > enough that people would notice.

> > > So Yoda, is this to go into the core, or stay where it is?

> > Well, nobody's sent me any patches.

> Code is still in the driver in v4.

> My question is; should these functions really live in the SS?

Perhaps we could avoid using that particular abbreviation.

Like I say it depends on how common this is - are we seeing other
devices with the same problem?

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBaKfgACgkQJNaLcl1U
h9CLWgf+N0kLQl/2ZQ2baUjBK0WRJO/GmByHzzTEeVPzmUxA5JJ1U4jmQqnMTRo6
Apnb5Ofwzv/voAVBCKYfixNb8IYTXBbToOlybeWeuwgoy/TiBPCQmulTI0XVajmC
4bTo6ME3aRoNeR5FPkXVrNHLKZlb00NFmN2PxgCeeW2BH3ymbYJ0P+eQ8siL4jBA
0cb7NqryhfXsc5yXWZupQaauvgx9S5i8gq/YwfCwzKCqcvU/VPsV38i/HXb9A5tV
TS9ps8z/2BziU8E7rr4r4vLHI9iRtq1K88t+RuR9gOPIsgp3vyYgaJBWTKserAix
RBJbKvE3D5MbNeRHWdwt7zkCiLQFyQ==
=BHaw
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8CA366A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbhDUMCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234132AbhDUMCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:02:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE9D461448;
        Wed, 21 Apr 2021 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619006530;
        bh=sq5loJMS1RgMRKqx3y/IFNVGnUaCXhwVbTBzTxi9LHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDTRSgkwkp56nhZSfDzll+5h9ZI3oj1PWgFfbG29RvTnsNxC3GR+1aQxmO2NDlu1O
         69EuBhSN/YiNLx2bU6RI0kgmTnggmRlM0FK+gIjOCtjp7wSYTDOIi8ICxV0sUrYqdq
         XCa5ag2gG8wkhndIMxfbvr2Na4OAjWAZPCdJyBmgNKKilaY8+aFsT1HOUflvavYApm
         kF87+PIY6vGrXYYPmM8RhEEoXlPPGX5r3YoCDB+xYVLra/ejNhyNwifU0QwAn18btm
         SySKqUs7HY9YdguiJXGF68Spmtv967nCj6Vu4BUpyzXUgGI3Eaq2L8JZVbWEB0fNFK
         pljdATVXVySaQ==
Date:   Wed, 21 Apr 2021 13:01:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V2] regulator: da9121: automotive variants identity fix
Message-ID: <20210421120143.GB4617@sirena.org.uk>
References: <20210421115216.9C1BC80007F@slsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <20210421115216.9C1BC80007F@slsrvapps-01.diasemi.com>
X-Cookie: RELATIVES!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 21, 2021 at 11:52:16AM +0000, Adam Ward wrote:
> be exclusively using automotive or consumer grade parts.
>=20
> V2: Fix for TYPE/SUBTYPE error I forgot to commit before generating patch
>     (Thanks to Raviteja Narayanam for originally spotting this)
>=20
> Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
> ---

As covered in submitting-patches.rst inter version changelogs should go
after the ---.

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCAFCYACgkQJNaLcl1U
h9CmNwf9E5JLhw1NMeVaiNhBASVUDF1+VkcIG28y8uTptNaOXhoYMfEsVYEmm2RP
X4H9Pv8t0OknpFSKwoVwm8PYPB7QoMXwok4giaVDkY4qT65aeAM1thxTN9BpIxra
KOzB285vJN/FSj6EQJOeYcE/s6vAGrSTbMgokEwsiM2l7dMCtGkRNokyyxWYoaFa
ukB8Xe3Enq+Wk9uz2W60UP3i6V6pcmo5N8PADt4kWS1l2/t0OuJPNDAix8Y3BGTg
HHqJWG/ZqX3hlo3BhOiaWMcv6CFHBIwHNoBsKWOBLP/ovCuoWGRHUt5oZJLZiMpw
xQe4QhoPKPIsstONioQWxVTWG5Ynvg==
=vVsj
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

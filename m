Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD070444682
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhKCREA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233022AbhKCRD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:03:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8003F61108;
        Wed,  3 Nov 2021 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635958880;
        bh=ctHs4cYJ4MVL59XgQwiliRdAEGQU0iYYEgGiBFXjHew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y91pIA4eOn4EvbomZQhZcknl7XmH2WF8NJarBVW5n8E1TWR+srMaoricFWqXlyzg0
         ywbpWG5TnAPurdaA6RZ69xerT08i4/LNTB2w/0zYJclHO9KAHWVszXFP50MqanVvYV
         7Z6Xlvy4jE6+kvAjHS37qRqI6vqY2jyPJMIKkX/e45GG4GIbf08WRNR2ELwf7Ebhbu
         TifRIVJVghxkPGLITo1RPxe7eaR+XcmxorlJIAa/hhnTr29E6aK+WLCFUwHyqd6jWc
         8XsJFq6tJr79AO7fvhhEG5midws2PBJH8CeJm3bxr7OVD1wh4EiJqBY+E45qCgcCMc
         Wn9akcRWBlRvg==
Date:   Wed, 3 Nov 2021 17:01:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: allow to define reg_update_bits for no bus
 configuration
Message-ID: <YYLAXL4HjgBGuF91@sirena.org.uk>
References: <20211102214138.28873-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a/xCltgFY3niSviz"
Content-Disposition: inline
In-Reply-To: <20211102214138.28873-1-ansuelsmth@gmail.com>
X-Cookie: Thank God I'm an atheist.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a/xCltgFY3niSviz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 02, 2021 at 10:41:38PM +0100, Ansuel Smith wrote:

> @@ -3064,7 +3065,7 @@ static int _regmap_update_bits(struct regmap *map, =
unsigned int reg,
>  	if (change)
>  		*change =3D false;
> =20
> -	if (regmap_volatile(map, reg) && map->reg_update_bits) {
> +	if ((regmap_volatile(map, reg) || !map->bus) && map->reg_update_bits) {
>  		ret =3D map->reg_update_bits(map->bus_context, reg, mask, val);
>  		if (ret =3D=3D 0 && change)
>  			*change =3D true;

I don't understand this change.  The point of the check for volatile
there is that if the register isn't volatile then we need to ensure that
the cache gets updated with any change that happens so we need to go
through paths that include cache updates.  The presence or otherwise of
a bus does not seem at all relevant here.

--a/xCltgFY3niSviz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGCwFsACgkQJNaLcl1U
h9Cr9gf/Rt2GQTK3uvJpL+ueiJcYhKUD4eskBUMhuQLL4Qg7FQ9CelORo1PeFzjL
zNfAeeFv2+1dT+sT6BLGshAfbwwAqlIawcA+S5xoxePdjviYnZd04dSEthB5kUMG
9ha3i6VFyivSIdrD3e0nWw8alM0Ntc4wUyoyPaje5teyZ93YOfyXy48ulmkTKT8q
jUQRUJtIhZZfpop7bd8K8m65nrBc6HZhqUF6/ZtiNMpb9FBROgHx7SYQ4LauGYIr
gD/UjYryp/tX8GVi50UKpdMJPs5RCIcFBGun6hStg+73owAVBlJx2orEZM7HY3ds
XXEUl106BrjiL63+kYTc587QQa2sUQ==
=clcK
-----END PGP SIGNATURE-----

--a/xCltgFY3niSviz--

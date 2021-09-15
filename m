Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CFD40C61B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhIONR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233645AbhIONRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:17:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0366B6121F;
        Wed, 15 Sep 2021 13:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631711766;
        bh=NocgklKFuC+0qjgr5yBXLHKbKyk8N7CsQWs0TBOnvf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RthnlBkNAHcfebtgzBf3/JYryXUGUmfkXay9+gd2RSLG97b/4WnSgZCsl5l8FcM9u
         BZIpYbvO++/+VnyxJiBNI0m/OwKUwDHoMFTSmfvKgcywPAmiCcb45+z5edTsA9W3F6
         4Rf75VGu7Ngk5KHqbUM4DPZNF6Cqvao86fibefZhiGko6yIDZqrEiBONXI46H5vMCT
         y/i/0lWFIouKAbdee20LET5/KMAYqtCjitw5og/kI9w8S62LREnh62ShHcyLsRLq7t
         X2JHtXDW7WkADZ5cUf813w903XIs02kuLJX/0tj3PJNA+cBExTBcTHgZgXZ7u1OZOD
         jrspJlI5Pmpuw==
Date:   Wed, 15 Sep 2021 14:15:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH] regulators: fix typo in Kconfig and max8973-regulator
Message-ID: <20210915131525.GA12513@sirena.org.uk>
References: <20210915110627.17525-1-ramona.nechita@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20210915110627.17525-1-ramona.nechita@analog.com>
X-Cookie: The more the merrier.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 15, 2021 at 02:06:27PM +0300, Ramona Alexandra Nechita wrote:
> MAX8973 is supposed to be MAX8973A. Kconfig and the
> initial comment of max8973-regulator.c were modified
> accordingly.

It is?

>  config REGULATOR_MAX8973

Why not update the Kconfig symbol as well?  If there's a danger of
collisions that's probably the main thing people will be using.

> -	tristate "Maxim MAX8973 voltage regulator "
> +	tristate "Maxim MAX8973A voltage regulator "

There's an extra space there while you're fixing stuff up.

> @@ -1,7 +1,7 @@
>  /*
>   * max8973-regulator.c -- Maxim max8973
>   *
> - * Regulator driver for MAXIM 8973 DC-DC step-down switching regulator.
> + * Regulator driver for MAXIM 8973A DC-DC step-down switching regulator.

What about the first line?

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFB8ewACgkQJNaLcl1U
h9A7+gf/XRVSzwdHPxFOVpDG/56uGOlk7sGl/JjgLmCXUSCs27HxJz1P2jbSUtmE
ZioXU+bzl5+xrtuQK97osDxTHz3UuNvgty/xFNWc350w8CpfgeRjb45WUeVMkTzH
dqahnBdgfk/TLzFYAScK2GrUGW0W0cbaC1QyvtV9G7Z91jZh2xZPMu5qz84gPYu+
9Mf/wlXPXq9yqsvIU49xi36gLylqZLstE2kpCjGC3w6Mu614A8isLA/I2MeV0Tm1
gvA+d/ATw1V0GmT5eS9yby6LukEaFu8ugH6OZDa/Fw4ImuuurpdisuLYgGAOXn5h
CdVhKjUJAfXPwH8SdLOnMXgmKqx9pw==
=g8Ug
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0BC3FDE41
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbhIAPKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245176AbhIAPKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:10:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79B5F6108B;
        Wed,  1 Sep 2021 15:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630508954;
        bh=7XRaczfrw+2P43Gf4nm/2FTf+SxW1WWEUqmmQ3hnIcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K83KonJXxAu/WFqFrM+8B+Ge5k6gPHHXbGdy/NEX38ouJtHVlenY/vDAWwAGTD6OH
         1WOl7qnVbHhNh+3WJOTX7aF6Kgchqub8foo2kp2zGMe7aL0AngRmtLh7ChAnLoZ84m
         Mhr4aSHVL2y5Du65zNxEPlg0SFCZU2aTzLJIOXkkwz0gfphScpXZjT1Ajnf+dDTTGu
         Oe3537lqhUA907jIdJRog+byClKhsjDt7FfG0LZ0DB9X69zfZAl4bNLcwSOiV4ZJ6M
         Ed0+PU0vFQzmnwsM9TVE9QUOHGKeBrWJIqlzgFUf1RtJrSKlOYpE+v3ZuuH36sVVQN
         Qf2tT0jK466Vw==
Date:   Wed, 1 Sep 2021 16:08:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: resolve supply voltage deferral silently
Message-ID: <20210901150840.GF5976@sirena.org.uk>
References: <20210826124015.1.Iab79c6dd374ec48beac44be2fcddd165dd26476b@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <20210826124015.1.Iab79c6dd374ec48beac44be2fcddd165dd26476b@changeid>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 26, 2021 at 12:40:17PM -0700, Brian Norris wrote:

>  		if (current_uV < 0) {
> -			rdev_err(rdev,
> -				 "failed to get the current voltage: %pe\n",
> -				 ERR_PTR(current_uV));
> +			if (current_uV != -EPROBE_DEFER)
> +				rdev_err(rdev,
> +					 "failed to get the current voltage: %pe\n",
> +					 ERR_PTR(current_uV));

This doesn't make sense to me.  Why are we getting as far as trying to
read the voltage if we've been told to defer probe?  This suggests that
we ought to be doing this earlier on.  I see that the logic is already
there to handle a deferral being generated here but it looks off.

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEvl3gACgkQJNaLcl1U
h9DlTAf9Hpq9UaFzbGme83M83BU1yqWkKPMs4UsUkdDs+GiapH/I2YE1ScWvh34e
TmcfIKEVlvjiXLyjJ0g1XhmyYoiC4YI7S2IE7PdR2UamBYmkro92rcBLkhZ5+SwP
5SJiLjEbEpxJ+nYsJUFX4CPTJHdjF/3Rkg/NnCIQjZjw/5FGcawuM7+Pi8f+FFsS
EZGtCwRKr10FcrEGEQQ0LAM/uBipz14DTFF/3znMqTldwksbNRnex/Fgsa4jA24B
s5njTK0+MqTbpUwrQPraGdtQJHWA/dBNbQlsorJAaOxLDtjWKQXAHzoPIG5BTuyU
vqYaB5TrEGWAGjAdvBFBrcu3MiZPLw==
=4MoL
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--

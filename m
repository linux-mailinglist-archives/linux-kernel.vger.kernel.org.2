Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D353232F32C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhCESvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:51:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhCESu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:50:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFC8C65090;
        Fri,  5 Mar 2021 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614970255;
        bh=3idx5+kPjlauvjxP2U80NOvMnVC9vfiBCM+ajkpdqN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQ6ZPsGMWQO+dcXCO/wPT9G0aO0mTGrViOwMqqZehxl1+nXYf/mV8qznCA/bYj3Az
         WuTVE1uQNVTVSK732zyC57UVpOZi2ShpDtJtfVXcl0J2TZOvXxFkLV4blxrU2p/lxX
         aTAbK0lmorAgGkCCe6d0J4Cn1sCaB0Y0jpVvZ4rpT1X94tNes9p9h5EHCiUL83o1rx
         1JsHvpv/3GtOOqCxHCetLKwO/M/PdJ5M7QSZiTCQJvm8NWSQ6rVQwGU7lo/IObm7FK
         HhNPrJ8ST3nVJwKU84fIKLX1lZzOBroY5Dz77fzESluNEDMgpexg0Vq1wIEiMpM4jX
         Ut1EvIUQwx+Bg==
Date:   Fri, 5 Mar 2021 18:49:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/15] ASoC: cs42l42: Remove power if the driver is
 being removed
Message-ID: <20210305184944.GC4552@sirena.org.uk>
References: <20210305173442.195740-1-tanureal@opensource.cirrus.com>
 <20210305173442.195740-7-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <20210305173442.195740-7-tanureal@opensource.cirrus.com>
X-Cookie: Shipping not included.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 05, 2021 at 05:34:33PM +0000, Lucas Tanure wrote:

> -	/* Hold down reset */
> -	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
> +	disable_irq(i2c_client->irq);
> +	pm_runtime_suspend(&i2c_client->dev);
> +	pm_runtime_disable(&i2c_client->dev);

You should be unregistering the interrupt, not disabling it - this will
better support any shared IRQ usage that appears and is much, much more
idiomatic.

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBCfUgACgkQJNaLcl1U
h9Ah/gf/V/Gxmbl9IRaNIRZvhenD73EaKj04ZmN5d2YMKVFoGYwvAiPcogZdH7P5
E9pI47Xib3JE2LlSe8/aJKC72tDatgYSDU2bj1zRgx07NEzA5wKyt16j/yD43+kx
IVH3q6ZQKxAQ8poAs/n5FFOrJ05Ii7Sdxzl0l3ns18KiyY4XEetlD9GHcrzn6wrr
wvDdfjOVd0wOAgwC8H3231OEGqrALq/RTSb4zwPdbs/pgEyBj8qB6sSBhKHuq4uE
JDeUa2Ia0KyiRnZGOBy8xpbS5PEKZioZMaLYKsPB0BweuvO0hfaVVY2VpSPKP7ZU
SY+zekeFJ699pBSVx1FmtBbyYjJTDw==
=48aq
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--

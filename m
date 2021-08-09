Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5F3E4582
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhHIMWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233161AbhHIMWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:22:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF5A160C3F;
        Mon,  9 Aug 2021 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628511702;
        bh=3kFnfS+Dy7NmGU+ijvdxfcEyE+vtAAyO0mFOkgwcuAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=slYnTMLrUeFRH40v30luW0Xn3tP+312crZgqGDDJJkKtEKuYugRnRDJ5V7FPBJH5Q
         3mGJ6fHdx5RcRcEJme/bcsnoQU0EbUoP6dZt1i6iii4qADSTezskMwDsngRzKysrG0
         jE3fgZGg3lY7+vzZhKVd3IIpCRJ4nnVVkkraNBC2HtOpJcL+7kSvH3TE/1slRif837
         YeRr8h0GkOudZ1frXTmhHf9SnVAJ6VCWODGrdcbd3RRWQhRhU8VOUPI3bHg5scT9X2
         NNBXLFG73AMqeE7FR7mywn25t9kmyaqtf4RYla/CZ7Yo6bZmHzuJpUkHJS0F7iiuwS
         YLNkbvjLs2TOg==
Date:   Mon, 9 Aug 2021 13:21:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Lee <SteveS.Lee@maximintegrated.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "jack.yu@realtek.com" <jack.yu@realtek.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>,
        "steves.lee.maxim@gmail.com" <steves.lee.maxim@gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] ASoC: max98390: Add support change dsm
 param name
Message-ID: <20210809122125.GC4866@sirena.org.uk>
References: <20210806080834.16705-1-steves.lee@maximintegrated.com>
 <20210806110301.GW26252@sirena.org.uk>
 <CO1PR11MB5089212BFBF03F82AE41E34C92F69@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Content-Disposition: inline
In-Reply-To: <CO1PR11MB5089212BFBF03F82AE41E34C92F69@CO1PR11MB5089.namprd11.prod.outlook.com>
X-Cookie: Flattery will get you everywhere.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 09, 2021 at 12:57:48AM +0000, Steve Lee wrote:
> On Fri, Aug 06, 2021 at 05:08:34PM +0900, Steve Lee wrote:

> > This will break anything using dsm_param.bin as the default - why make the
> > change?

>  I'd like to make that as same name with other using SoF project line.
> This originally production default is "dsm_param_%s_%s.bin with vendor and product name".

If you want to add a new filename then that's fine but we shouldn't be
breaking backwards compatibility for a minor reason like that.

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmERHcQACgkQJNaLcl1U
h9BUhwf7BAZCA8ned1qlMpa1UllxHgfo0Ik5FEbiaGulDN7WWUvgdF0pKHYVFxAc
300Ly9VLhZvNbpGb42okPXkHPSgglxswYHRtLUArSvz0Tr5OjRgz1o+/geuBHrfy
z2FTjbgsDsqnCgrex86I+K1L4Srt2+0b9ycbkkSVtsJFj1mYbwfFUC7esb5Yei7c
KHnJ1XStCH4C52J0Wp2dLf7SjT4WIsHo46ZvlGYApxIzzCo3gbIf7Kd30rgNh+T0
4lhkcxuT1ypD5dxgPETQmXeug2UOdnw3E8VWA5AY2weWoD0i9xf3aEHdFETiRdX/
O0Pe8CClycH/bK3Wt/ChAQZEZA393g==
=r8T7
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--

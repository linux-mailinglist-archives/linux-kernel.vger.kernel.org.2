Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6673170C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhBJT6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:58:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232342AbhBJT6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:58:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2AEF64EDC;
        Wed, 10 Feb 2021 19:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612987073;
        bh=uXsdHRudlt30/rf8TC5oPx2prLpjvAc0fxd+6KxQlyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYmVaXnzh3cXpUvmggxxro5R5JrS2isourfy6gOZLXt2tz9e66fABoZ5PmAwXRzQO
         5AYwh/WKCEr6LRWGFUT8i92gvs9m5JTR+XApJTqEtdDDIIItlY1hINGn7+GVVW2twP
         7hzYeiVekifb3OEH+6+wULT+E17R4jrK4OV2Jk2lq7xgfuEBscvEtpZSLUvtmmfSHc
         TPk6RpB/MyLFD6qYbdbjerhdJl8qN6KdNq+Fv+7ak2S3LUwzVbGCOjrQSTGN4MNz0u
         otacXcQg+s5XXxi40nzCK4ZU3mHOamdndISV4ZuKe7THMpbLYYjuDM8WtfkGh9zuIV
         E20+o+RIyFqhw==
Date:   Wed, 10 Feb 2021 19:57:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
Message-ID: <20210210195700.GG4748@sirena.org.uk>
References: <20210204112502.88362-1-hdegoede@redhat.com>
 <ba9c1add-8ac0-766b-4577-1c2769c0e5e6@redhat.com>
 <20210209141420.GE4766@dell>
 <c0b4c612-7f60-5126-4c4d-b7085bd356d0@redhat.com>
 <20210209154511.GC220368@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <20210209154511.GC220368@dell>
X-Cookie: Are we live or on tape?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 09, 2021 at 03:45:11PM +0000, Lee Jones wrote:
> On Tue, 09 Feb 2021, Hans de Goede wrote:

> > The alternative is Mark doing a PR from ASoC to MFD to get 5/5 from the previous set
> > in MFD first, which seems less then ideal.

> Well this set isn't likely to go in this cycle anyway, so actually the
> problem should just go away.  Best to let the first set get sucked
> into v5.12, then send this one up subsequently for v5.13.

Yeah, that's probably easiest at this point.  the only other option that
looks viable would be to add the MFD and extcon parts to the branch you
already have, me to pull that in and then apply the ASoC bits in ASoC.

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAkOosACgkQJNaLcl1U
h9BVMQf+PDB5T4KOnJZ++lK/k50W3hv+2FbDKIYBpiYodByRhgKZ54s+NJ8u/HBi
SZiNYUR2j5uFjU1qIFVWLyHW+V+v790MXFB3j6ucarjXjeIp/2aPqfGRW6MwXnvL
IZqeVniPhIjVI5roUuMGZUjglbrRTfx0Sb3vXqO0CyhRHm/5tc7/jxBQ0+pbm361
f30bL2rQq4wXYh8R2Jdk5MpcE2k4gnQ4DmYdxczC/aW6ZpTEoZIsHMUNkiK+QGZ9
t0qmvvuXKkQaQeUvNxt0um3lfCZGxzoUeUrh4PdAB9gTZQikR5vjvnqs6COqQkG0
3Qvg83HX1BGiJjnuj+nzQv53C0njUQ==
=WffB
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--

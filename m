Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9072B3E9064
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbhHKMUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232496AbhHKMUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:20:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B97746023B;
        Wed, 11 Aug 2021 12:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628684414;
        bh=Jkyif3d4kFjhIKg6jx01Qag1Q6rqMPw9mCrQuXo745E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNw8VvFtn2G6ichHLHzmKNVwo6zy4RUIiOQNdZ58LxRx4M0kZ/kbsqVo+69ZfFnYq
         O7gtmpGM+7ggMv4dLWanhE2b/VUAAF/8/jdr0Cda3Kvo7bFiridVaJ1BMUNrLC7C5R
         TvHjDuz9GEh+yy+9m88QpYPNsZEeKP9nkTvQqKcKCNzrByKXs4BDtKTPn6WDwN3585
         ENA73ygZZww79IlugxoI8udwiCRua7z7AHjyJV7cZafQR53Kz9IMxy3LJypQaMDawe
         ZNZMliSWXYEEZDeSy2GzO3YRBOGag0WywFgncn/WH2uJmZvGzrcTNwudz2Cm60HWlK
         JvPShRDkBHfyw==
Date:   Wed, 11 Aug 2021 13:19:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tangbin <tangbin@cmss.chinamobile.com>
Cc:     olivier.moysan@foss.st.com, arnaud.pouliquen@foss.st.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: stm32: spdifrx: Delete unnecessary check in
 theprobe function
Message-ID: <20210811121955.GD4167@sirena.org.uk>
References: <20210811115523.17232-1-tangbin@cmss.chinamobile.com>
 <20210811115846.GC4167@sirena.org.uk>
 <7ddb13ee-2ca6-bf8d-2a83-9896d29176c5@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <7ddb13ee-2ca6-bf8d-2a83-9896d29176c5@cmss.chinamobile.com>
X-Cookie: To stay youthful, stay useful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 11, 2021 at 08:09:00PM +0800, tangbin wrote:
> On 2021/8/11 19:58, Mark Brown wrote:
> > On Wed, Aug 11, 2021 at 07:55:23PM +0800, Tang Bin wrote:

> > > The function stm32_spdifrx_parse_of() is only called by the function
> > > stm32_spdifrx_probe(), and the probe function is only called with
> > > an openfirmware platform device. Therefore there is no need to check
> > > the device_node in probe function.

> > What is the benefit of not doing the check?  It seems like reasonable
> > defensive programming.

> I think it's unnecessary, because we all know than the probe function is
> only trigger if

> the device and the driver matches, and the trigger mode is just Device Tree.
> So the device_node

> must be exist in the probe function if it works. That's the reason why I
> think it's redundant.

I see why it is redundant, I don't see what problem this redudnancy
causes.

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmETwGoACgkQJNaLcl1U
h9Cj4Af/azfVQM3xU3CdmasVulqZpZWu39+iv+ISKhYAhqPkrw6tq6sFFfpDAAQX
BAs2T83O5CvB4peKwgBRLs6paHkWbWnftWMLCVrUfMzEBfRRq6T/wLfQxmDA3o89
YRiXxOjTeZFwiWxRT+jVLh6S3QATZQBdoXU7jbqQH4rRIod5FXh8wdftLQQWm459
WmIQLpypjSCZYPpeCs+UdYs/TatHQdXD0ssS3k5m+Hq3MufufSDUgIpNJUA0aTf5
TfMTW+hMNnz9apT/9bVopicIh6Cf29Mr+O8gr9E7tdQYxNXIZD/MkcjucV8yW+Cu
QFGgT4FSUrecnNJrnFUV8P39wsYkUQ==
=f9BL
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--

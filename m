Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F493E8FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbhHKL73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhHKL72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:59:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C2DA60E52;
        Wed, 11 Aug 2021 11:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628683145;
        bh=IkkHlU9gyrF2VazbtsaLiwbyE1P1jCc9g2qGG7Vx2x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/eT3CEyzCAb4UUxxRlFCF4wE1a0f+Ul0QA/HaUt8ZUFTRKGZfjVgfzbZQzoF4RFl
         3oY8FVhGbWpz6Jwr2JI3Qkg/j5/vDZRTNmIqaOwIvoufwPAUYS24r004JzFaAm6hHq
         mogXR0mIX753NB3w5I1s1yST1LBpVRQO5DTEqVKczhWwa4TO9xpRcSboeHRMtGGNDV
         S6bZUj88e5GTcUGOTM4i/O479H/7t0F84pLt9tqM51ClNhRcJMBVS3XaKXUt2oJyIt
         AyrdP4Z2q2Pv9/AMUnYw8KnTtOjUJLl7GS8Tm4M5s46xv9heMGF3iEbOkl6bxlHN3n
         qE0gCDOE7hBUg==
Date:   Wed, 11 Aug 2021 12:58:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     olivier.moysan@foss.st.com, arnaud.pouliquen@foss.st.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: stm32: spdifrx: Delete unnecessary check in the
 probe function
Message-ID: <20210811115846.GC4167@sirena.org.uk>
References: <20210811115523.17232-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <20210811115523.17232-1-tangbin@cmss.chinamobile.com>
X-Cookie: To stay youthful, stay useful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 11, 2021 at 07:55:23PM +0800, Tang Bin wrote:
> The function stm32_spdifrx_parse_of() is only called by the function
> stm32_spdifrx_probe(), and the probe function is only called with
> an openfirmware platform device. Therefore there is no need to check
> the device_node in probe function.

What is the benefit of not doing the check?  It seems like reasonable
defensive programming.

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmETu3UACgkQJNaLcl1U
h9ASJwf+LWfdLiXawrYtfjW25aPh7dylTBVdUi25A0M6PyTBOcrj0nbIhD5AJ0M2
Q32W/NV+nTugHYOK9xIu9sgwEaq4sZMPP2tM6A0+K4oX8RijtxygqBeZQ/AWUK7F
UPPJObcnC2TO65la2HxerkUZzyw7NtI4BAMAHNQrZKUxpNnAhkLYvsIHRU+MDOcV
u8oG0tc0ZHcTwcnidQGGZEBTvS/hNnwlXVr85jYT6ZmnscKT33+0sfzyw3Eb3YDK
epJ4LR9H0dOyjqF0ubhDtIStDbHDAKgZwZTsvY5rWyxITc4bhQsAbem9qPObI0m9
j7Zt/YqiCkLlbCHIj5djMnnAdIqL1w==
=J1OY
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--

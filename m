Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D559343940A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 12:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhJYKyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 06:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhJYKy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 06:54:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E05D60724;
        Mon, 25 Oct 2021 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635159126;
        bh=Sc6M2aqA6X3s/ydL6GsxApFjLQRCTVBWSCiVS0siZK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMomWBUuCjdZrbFKtUs/sugS5NLMEb04PLOD1btwnzMmfhSb2Wj72xL6zfvbHvRJB
         P9zi3LRyYfE4XpVrQ7aaKfVMkmNmf1FMGWyoKyxG1HJtRxxGRtRJwmI+K3Jd+3e/u2
         Q2N9diJcn99vC3A5o9YGV0GLNf7zpX0DBjMVB1uSa7SJcbpe3UCe4Z666MbiOuxa9g
         FQw5qWSTCeYWpHU/jdJ3GVifHoLL3fPRMPVSvhek1R312XRbqiTgnTfsaXNVqcmtG+
         rp/IWzTs1K8kLebtEbcjvCR5GoH12JLh+6sZ6l2wVVdk/vk+8Jla4KwIZoogmI+FuG
         W7Mj3WLf1MF+A==
Date:   Mon, 25 Oct 2021 11:52:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     stephan@gerhold.net, lgirdwood@gmail.com, robh+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v1 1/4] ASoC: codecs: tfa989x: Add switch to allow
 disabling amplifier
Message-ID: <YXaMVHo9drCIuD3u@sirena.org.uk>
References: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
 <20211024085840.1536438-2-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HqflovOPVo9Qve1y"
Content-Disposition: inline
In-Reply-To: <20211024085840.1536438-2-vincent.knecht@mailoo.org>
X-Cookie: From concentrate.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HqflovOPVo9Qve1y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 24, 2021 at 10:58:37AM +0200, Vincent Knecht wrote:
> From: Stephan Gerhold <stephan@gerhold.net>
>=20
> In some configurations it may be necessary to explicitly disable
> the amplifier with an ALSA mixer. An example for this is a stereo
> setup with two TFA989X. If only one of them should be used (e.g.
> to use it as an earpiece) the other one must be explicitly disabled.
>=20
> Add a virtual "Amp Switch" to implement that. There is no register
> for this (SND_SOC_NOPM) so it only prevents DAPM from activating
> the amplifier. Also it is inverted (=3D enabled by default) for
> compatibility with devices that do not need this functionality.

Why can you not use a standard pin switch on the speaker output for
this?

--HqflovOPVo9Qve1y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF2jFMACgkQJNaLcl1U
h9DV5Af/YM0DR6tS9cXmo696/iMxLNQ3AM1Qu0F3mIN7qrGHHDl1W52M679FBZKv
O0PXBokgEXMTWx+1j9Rg8ECudLCP9LwxYjH8qz4lH70jT//QwHzzxPw7lz1bLJJl
baa+MHgLuQvhEaMybcGM/0rekTe8ax9SgvOfnMz9bMMXRU34hXKIw2kmjWMXMwxM
baJmemj3DlmuQKOPGTjU7OVOmFZtIHEpjA9prMDP/rcBJh3YycXHZ3pHrWXh/YiE
pNZIjdrrMnyK6GN4SHuONZ+7nger2TyCvHXWbsTPrmtbPtDWNZF+LFxVhWvd6QZ2
0sB1I7nN+UtVx0nrKA8zISMns81oSA==
=B6do
-----END PGP SIGNATURE-----

--HqflovOPVo9Qve1y--

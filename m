Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9C4433565
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhJSMIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230129AbhJSMIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:08:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFCD1610E7;
        Tue, 19 Oct 2021 12:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634645170;
        bh=cFUJmIuqaRcFKLfCT6FjSV4xppqcoq1e5ihmWzQnHF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFK7N47xaGP7p7aL8QNCpwGR06qtWhy+hSeW45uG485jOtRZ095PQib/sQge43GIY
         lAqapsUy2AQgEHIn/yFyMiemKhrGPOzc5Tn+F6sI/dZQk7p4U7jteAXr4ptXTjNFvU
         H7Pb/vj1iF5pySDFOzLOd/qCwvzYnbGMohozhFKEWnA2oEKIksCjDCB1Tmnwiy/5FM
         GLYqRW8LCdAQkp2mKUL4eY9e9aaLlCj7iEh6RDvaB0ZGDLIkP8uSGRUGFRcGYJLmA9
         8844GgLdmyu/R2mGLrUaMCyo3wzP6DQInlu2dEMPJjniHvoSYDLJ+m0DPkppBh83QT
         7zw7M+wpI/3ow==
Date:   Tue, 19 Oct 2021 13:06:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     George Song <george.song@maximintegrated.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, george.song@analog.com,
        ryans.lee@maximintegrated.com, steves.lee@maximintegrated.com
Subject: Re: [v4] ASoC: max98520: add max98520 audio amplifier driver
Message-ID: <YW60rmCStn2o7o31@sirena.org.uk>
References: <20211019084914.14622-1-george.song@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S2KRfR5D7PbsK0GH"
Content-Disposition: inline
In-Reply-To: <20211019084914.14622-1-george.song@maximintegrated.com>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S2KRfR5D7PbsK0GH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 19, 2021 at 05:49:14PM +0900, George Song wrote:
> add max98520 audio amplifier driver

You seem to have dropped the binding document from this version?

--S2KRfR5D7PbsK0GH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFutK0ACgkQJNaLcl1U
h9Aw1Af/TZm8rxRfgLCvDxIdIMvbXWPFtC3j2chVuegRb8xXWnL5jY5xiIv2JfFP
BVCTyX/MfX/IpKQNlYpPrM+Zsdsu2I9vWBp808eJA/NMBAeSRPcKf+QHtPa5I1ol
+IxxvNuMYmLv1kKZuYXD4BonKU4wIQIb+vScjyfKEaVwmTNstd9FRslPjG0b/sxT
29XiNWY5QvCnpSL6zgV1n4i63oydZ8yXk5u3K4QAMEYE9h9ZF+sXbEQR0xkTz16o
MA6f8o1OMdPmM/U+YVC75tLN66dUbKg+W3NKg4E1P8qZhKGyqMP947YMHYaYzX/6
ImtuVRBMY0NmkQc0s8A9TKavaMTcGg==
=TXWk
-----END PGP SIGNATURE-----

--S2KRfR5D7PbsK0GH--

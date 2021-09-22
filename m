Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136DA414DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 18:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbhIVQSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 12:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236523AbhIVQSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:18:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A80186109E;
        Wed, 22 Sep 2021 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632327421;
        bh=hBa3XK6PdkQ9LYlp6fhk+uNQaAdzZPpFlk0+zLDKaJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsZ2TsPQcNy0+w0ci/bdjyqAEav7QcvWSQybMBEwYMIxx5YLysFKFBpNvCT/HGOI6
         ZS7nb4ydH472E5KJs6jrjqoeisA3dxjRrFB6Pekc5n2usr1OBLcjqmFaxuePn+7uDC
         PtK2CRvfU3mtCtP8n/l0jcaWCefUxmUo6cDWztvog3zdkBVGRLAJwcPNT6/4GLdqOh
         pinCI0wzc+/RzAFjxWlsO6KQANXxnVJqTxCBp72HlnlwuKPx4wUOAV345NCGgopbvV
         eLAHuTQoqifPFEM5vafnywmmTYWexw+GlxtqEqB5/nEyOP5mHCbmQ0DASol3JP9U3V
         /ebWFk4TAxX3w==
Date:   Wed, 22 Sep 2021 17:16:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sprd: Add SPI device ID table
Message-ID: <20210922161614.GC4183@sirena.org.uk>
References: <20210922150812.27516-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <20210922150812.27516-1-broonie@kernel.org>
X-Cookie: Teachers have class.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 22, 2021 at 04:08:12PM +0100, Mark Brown wrote:
> Currently autoloading for SPI devices does not use the DT ID table, it uses
> SPI modalises. Supporting OF modalises is going to be difficult if not
> impractical, an attempt was made but has been reverted, so ensure that
> module autoloading works for this driver by adding a SPI device ID table.

Hang on, there's a typo and I found a bunch more MFDs that need updates
- I'll resend as part of a bigger series.

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFLVs0ACgkQJNaLcl1U
h9DAKQf+JTy6XzKf7jOYBIpMI0l6Ca/A59/BNNOzXM68wxTbGa2v5PiOx6Gd5nXo
7tPI3nzsTFqEHPF7Nn45oSBTAaomckLrfnh3kyfDxRUkQacgdRQwefm6o1VbcKmO
xO3WwN66yI3mZ4ijFU6qiSbMXd2xxHuYpLMvNT73eAl9y4ljtE0xHKcFy6EfMuLB
+xfMmBKJB1ZcGK7AIHBt0G4ogXudSaSNDHCvYby4wLrm6qUa8/YA3QeCPR2Pugvp
kMTnI9h7j4tHXBQD3Lg6VOQMvCkm7BxHsw4VgjI81iArb83/7JJNs5CGdO/0dhcJ
OxpYET1vWhmaonmfp71yaWpHsVTZ5A==
=aboo
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

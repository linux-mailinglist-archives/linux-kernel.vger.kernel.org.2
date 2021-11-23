Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7494545A2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhKWMd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:33:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234978AbhKWMd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:33:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0405B6102A;
        Tue, 23 Nov 2021 12:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637670619;
        bh=Ns5JkmySbFT6QA9eqwG9rfdvWRAQknmgxEYvcycrBc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a1uqEbqGhh/1GrRBe6Er5aosfgUQRIiHfHXbh/1OohkVNc/JaWSZolZ+TWlhL0dJN
         UV7W+kj5vXz+hKw/SWVcYa01CeAi3rONvU2Ivfp0G3uXvA4eqdypPA3XYIV83CpiXI
         VhoHX63sNcqQOJRmz/o031Ev6IyO3dlQ4rzXPKeSjTVgI+t1kbinhw2YTG2knDZv5l
         JrWZdVUdiRRpR/RmvmW0hjC2i2ABomqp7Ij2il+6oZ6pbubN8kGXuUXcqEGCuqNppd
         cPbET7g5BjhbyPneLOzyPwVPYLSSHs1dGY+zoRBLgqa741BTQwHFPxcJJoYjv9HZnG
         26u7c3imoLc8g==
Date:   Tue, 23 Nov 2021 12:30:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 1/2] DA9121: add DA914x binding info
Message-ID: <YZze1uynsB+d1YWx@sirena.org.uk>
References: <cover.1637669927.git.Adam.Ward.opensource@diasemi.com>
 <49e5f47c79c0fc1d2b52ffdf7f5872f0adfa5ba5.1637669927.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m3750QxKlX7KP7Vh"
Content-Disposition: inline
In-Reply-To: <49e5f47c79c0fc1d2b52ffdf7f5872f0adfa5ba5.1637669927.git.Adam.Ward.opensource@diasemi.com>
X-Cookie: A closed mouth gathers no foot.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m3750QxKlX7KP7Vh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 23, 2021 at 12:19:27PM +0000, Adam Ward wrote:

>        - dlg,da9132
> -      - dlg,da9140
> +      - dlg,da9141
> +      - dlg,da9142

This is removing the existing DA9140 compatible?

--m3750QxKlX7KP7Vh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGc3tUACgkQJNaLcl1U
h9BvJQf+P7Vy0RN4FOmc2PSBiVK0taHXsohE54eh382zVpdvRQclXyKSNgvOfQBk
l83a0yTfld9mq+Ge+QFomfxkcEPE5ZLhPLCPUwE2Bijp/Co+ih+bBVTSy/PRA79Z
s0HRzkNFA/gOtd1ZJgXOZP2CotnVarVUKR6ps5teSjTN2kyjxANaybCzg3Vrnhmd
eoSlGCnyXGYgyhwtp//uzF+5exmoAwPQqqo04zD3eGwaOSx3EbT6KvPUoYBeIEla
fhivgI0UhlyKQ5PZ3tVHzXJtrk4zeMaTsW/+QrdNEvFOvnqbIjcfxCEzDileF+k/
LtN860mYTYKkbCbqFfAcf1mKDsPWBQ==
=5MT9
-----END PGP SIGNATURE-----

--m3750QxKlX7KP7Vh--

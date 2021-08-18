Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E443F03A2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhHRMSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234855AbhHRMSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:18:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DFF96103A;
        Wed, 18 Aug 2021 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629289053;
        bh=FdBy4Wt7esUCoHUjBtVIgdOfY7Ijw2ITk0tl+4PPhGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YrKHThY1W0kQJjhdeWHiWJZRcuUeON49/qC/J57z3DHvFBrz4GsTy2USwf3bV9gbS
         a6qQOQdNRjvR0VcC3HUY8KaKjW9SQR/YTSKLEYXz/GSH1tV8pVeEfQEJkiUIaUpmyy
         PDlQlN30bf4wiGdD8M7svKDPGVJ1m4dDRS18PpHbkHkpeVG+HsBCmxdcIBh5i8gIdl
         2wfJHUCMZj2y1hpIO/Cfo3xsoGnbndHI4LDjOghrMB6Q6DVNUIlQC89giDh4mqjjCT
         q9otBQEHgGT7wQ/flnSr4ircNYuzjijbsRjOfqqbJRxiBxNzNnKDO+t1fVjtHsA/4O
         AWZEiZEv6y7cg==
Date:   Wed, 18 Aug 2021 13:17:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: Minor regulator documentation fixes.
Message-ID: <20210818121709.GD4177@sirena.org.uk>
References: <20210818041513.GA2408290@dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <20210818041513.GA2408290@dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 18, 2021 at 07:18:19AM +0300, Matti Vaittinen wrote:
> The newly added regulator ramp-delay specifiers in regulator desc
> lacked the documentation. Add some. Also fix a typo.

This should've been two patches.

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEc+kQACgkQJNaLcl1U
h9D/QAf/W6mFU6uxp1Hbmp5J1YyzwU3r22o+/IUif2phnVZNusUhZLRD8QU6xmMj
0b/r6F0+MP6rlHdAKLUmz1cuMAFgCfp1yfSBdi1/YUFFpIH+SsR9QlhXeSu4Tt2I
ZdEKTEIz1aIshngE3PHVelOlL/riLeinj/YlKczj8n7KKzQuwBC6KEqf/seNEynj
r52VmpDnHJaUkXHH6NW0hn/LZaSjVXLW7ejz8FCQByd33Fqcb5C1V6Es3lmyOItO
T3uh1o39T27ptK5xff2fQ7X/EYAPHj5goNtsec4Ndmu8/AeduGF4beQkJg+bN9wr
Tyd+wh5IbuMPslmm65eWLMG+fvcEyA==
=+XYd
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--

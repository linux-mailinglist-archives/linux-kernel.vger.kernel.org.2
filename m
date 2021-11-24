Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3812545C34D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 14:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352639AbhKXNhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 08:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350114AbhKXNfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 08:35:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92F8661BF8;
        Wed, 24 Nov 2021 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637758472;
        bh=bW6UwC/A//s8pdhaYbk5zSg0a52NxQK+vO9qfsnynDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uyxsqWiwZOIGB3HVz36gsc6EcYfDdsREfFt+iD9lwxFUPuXU0Hcb+fQdgsQcNWVLJ
         feePY6koqi1ixYTt9ObELV5yRDkldeFdZxmp4iX/aX+HoXx5HEHYcQeFn8HZjjZ261
         RIDWPriy94KSKiNZ8JZ/LyPieNSRaPMQ9JI88q57Fk+WCnzR0qj5udr7yxqGj3AFOE
         3yEbLQyt3f4T4u0RJrhLf5cxSNDJ0cI6iHrLnsZgY3TNwHoSACuFJoycJTlvIzLew6
         bgto9CaPC0y+nfnANQ3e1+YvQR925P7lhu39d5lnoacpBQgJU/ePpD0wdO+RX5XGoB
         Ks+ge0U5/bGTw==
Date:   Wed, 24 Nov 2021 12:54:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] regulators: Add regulator_err2notif() helper
Message-ID: <YZ42BKFsbUgQDBiz@sirena.org.uk>
References: <cover.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
 <eb1755ac0569ff07ffa466cf8912c6fd50e7c7c6.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cZY1VzanI8oRVbGy"
Content-Disposition: inline
In-Reply-To: <eb1755ac0569ff07ffa466cf8912c6fd50e7c7c6.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: (null cookie
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cZY1VzanI8oRVbGy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 24, 2021 at 09:16:45AM +0200, Matti Vaittinen wrote:
> Help drivers avoid storing both supported notification and supported error
> flags by supporting conversion from regulator error to notification.
> This may help saving some bytes.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--cZY1VzanI8oRVbGy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGeNgMACgkQJNaLcl1U
h9C2SQf7BfNOUsNVXKQ6ciyk0pZ/QpsNfsI4qbo0EeaSxiKCtpO2WrWIVNKdTUc4
aLJm25HZKVlFyMfExGtM6hk7g4jdpA8wWTkiMdFoATu84+Sx5r0IEQvYxJ0kz+mh
sU46ChI4NBudn5m8QKP6RhSiEL8TlkMSqC+Co7W5NqeD6k1s1hWZW2GK6gb8YwxD
Z4kecGcoZNr+FtXHELwFpoT7FGFCsU+bLe6x2rCZq/YjM8q/2/0IV846+3eddY/N
9/kPR0QJ3yZBeRmOkZZWbSEOUhbHojjDUMdflmkX/DxfWazxTaV6pNgDH8QY9epe
Rkd0RePv2yrCA0Em24KgaPRtlpyt4g==
=SUne
-----END PGP SIGNATURE-----

--cZY1VzanI8oRVbGy--

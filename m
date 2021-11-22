Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F9345931A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 17:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhKVQgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 11:36:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234804AbhKVQgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:36:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26F2860D42;
        Mon, 22 Nov 2021 16:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637598787;
        bh=lxf84CjEa9uBGWp+bM6eXqegAFhun1JwncxKjSydKm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ln27X7+7Ry3AocUHN791T7CL98t6MNaFPadRPirpoghnq4rLBUpvBi7zKD4zRUzox
         c5A960dVQGioGS+G66w9sAA6mVhgx4Iglx7vb7/rOnVOwxl31HxmmoUSj1g1wm3Ppj
         fA8hDBpehVT4jAhpNNqJ3//Vh6uwxKzFcURIGKa3mVGjQEC222aoD+IvB4kxNs5Mlu
         ZFBS6t9mDLeDpTYmeIPWExnBNWB9cyZSXHLdH90QXbyXaPu7YKslsyeiNcJ8IROi88
         o/Yx50BbKogoTWCz8f9Q56CseaslEhqkmmzBuWm6L9OYi093xmKEYekuyMdDy1xFpC
         3ePx7OEKt3LnQ==
Date:   Mon, 22 Nov 2021 16:33:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: lp87565: Use bitfield helpers
Message-ID: <YZvGPiLhhE4cykS8@sirena.org.uk>
References: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
 <941c2dfd5b5b124b8950bcce42db4c343dfe9821.1637593297.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v1II3Iig+bds6cNO"
Content-Disposition: inline
In-Reply-To: <941c2dfd5b5b124b8950bcce42db4c343dfe9821.1637593297.git.geert+renesas@glider.be>
X-Cookie: Lake Erie died for your sins.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v1II3Iig+bds6cNO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 22, 2021 at 04:54:09PM +0100, Geert Uytterhoeven wrote:
> Use the FIELD_PREP() helper, instead open-coding the same operation.

Acked-by: Mark Brown <broonie@kernel.org>

--v1II3Iig+bds6cNO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGbxj4ACgkQJNaLcl1U
h9DIEQf/auQz6Dzhxi1hjS3cPFSy9Pdo4/Ndda/Rd4i0vNH1dtk9N+jFAN8mPPmJ
CULg4bjG0rZk72MebLqC3tRR2w4tFxluo2kUqL3IE41zQnrYKTTYtWiI+gvSm/0Z
Cjsdy6K7M5bWhlXrZqfrIjQcmKx658ERXVob8J2uK69uMlAp8ci8NEpb+sHKb9gg
r6QrnxHSRhrWT8galEIylWY5SFGylrRS9UHYya4C9TJFUhA20KEWuRryCxoWgJNP
mxlq/z/Yqemx6pSsqx23Z5GkTYfZ3XBF+ptKCL5eoPALwWCgBzkX2gVVInwzqO5i
1ypg/Cvd951fnmx1FCd73xdvhFJu+g==
=dafy
-----END PGP SIGNATURE-----

--v1II3Iig+bds6cNO--

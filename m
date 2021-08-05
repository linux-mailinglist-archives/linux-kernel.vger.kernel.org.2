Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EA33E14C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbhHEMdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239754AbhHEMdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:33:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4C4A6113E;
        Thu,  5 Aug 2021 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628166784;
        bh=l5rwYWEFklQRXMuTSJIAteK7ZkqvTvRw2bjGloAZJ0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIINX73EPtnm1YlzmeS1CtRtyc6ZQkVYce+fx6dQ+3GRun9h5hhouMN7TbteccqBb
         BnVGpC2c+PXEDj+nHqTq+IlbBJJ0QCGOqQQiawA7Lt6wcOSvN5mkU1STMATPRz37bS
         SWxUMTKNHS1MSwK3Gd3jrdrxy4qWzRh9cC1bwmAgGdQRn6kTO97t1nKCgvd5LwciEM
         owf1Aemjpw3fw+ihigKkyInY0b8ADYcu9jX6jnqpWMHqIBI1RRh+bcpX2v3lC0OTxx
         GyAYPk5Ym8IEaNpNKxyajIr2UwiPR/WBNVEYOPAxfBe8yGvUJMaVXeO7PQQfxBqtfP
         2Ww9FrlMf6/5Q==
Date:   Thu, 5 Aug 2021 13:32:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: simple-card-utils: Avoid over-allocating DLCs
Message-ID: <20210805123248.GK26252@sirena.org.uk>
References: <20210805050706.46833-1-samuel@sholland.org>
 <87eeb8tquq.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jITzwD3HDGXid3BE"
Content-Disposition: inline
In-Reply-To: <87eeb8tquq.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jITzwD3HDGXid3BE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 05, 2021 at 02:14:53PM +0900, Kuninori Morimoto wrote:

> 	Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

If you put spaces at the start of the line then none of the tooling will
pick up tags you add.

--jITzwD3HDGXid3BE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEL2m8ACgkQJNaLcl1U
h9B2Bwf/TFmGEHGgh1Y98seQLwiGG08YJnWDhxwX4jp2iislmOcbv84PWSMMSTj5
wksMM0/GX0Spij7hDC+c/lMF9pwZuhBApKc7yps13PS+Kr5vOVw4zGoQOi3+cC1k
fZW4eblaw6NTtz0F5AIhPnPPnjOi7S15K9OOY0l2MiMRetQu1yCnJDCH+yMfqMlS
BI4Xx8NZBzz0vjOFRaRty28xp0zsF4DXcCO628llr9bMQG2AD0sKXqlge+r83XVy
uke19x1f1/mqdxvVtrON70YXJ27iL6XB9gQe/M74kqMPMzCNde0OcTfbhrAdCq7d
TufLjnhRjUfgQHOwvqIoqbKogPW0oQ==
=g/K2
-----END PGP SIGNATURE-----

--jITzwD3HDGXid3BE--

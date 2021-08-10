Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08033E7CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbhHJPul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232968AbhHJPuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:50:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C84E60E9B;
        Tue, 10 Aug 2021 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628610618;
        bh=5VQb2yLmOxBNX2UvrvQB5Gb7/UfJYuDB49AivOuWzhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwysiIRXoAEshLo/nSGcG+owFCSv0ldyJLQFtIPDBGaWmoL3+vO6wgzxZ0IWLnQci
         HIlWsTS7qaDWnAYdHuho1b1RZx2Sn4U04PAd6RvlrzMqrUy23gVqFtiLc4L6VtSBjF
         /tzGuKRTszAScQmJK+hqV4Uq02LQIYuza8/q2qRdEJXp6L3GepZraKeAiOcRNb1aP+
         GShTkwUKf2KWrpLS82gHaQJa4KkEuwsGAMAfyID+KWNceb6JmqpfqshdST14onqibZ
         C21DQ7Q2dV6rZNG63mmcon64+5AF3f89HQux9suExu3jpiDnGehoEn71xehoaT45RW
         gsK6R4q9qfb2w==
Date:   Tue, 10 Aug 2021 16:49:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] ASoC: cs42l42: Don't reconfigure the PLL while it
 is running
Message-ID: <20210810154959.GD4704@sirena.org.uk>
References: <20210810153759.24333-1-rf@opensource.cirrus.com>
 <20210810153759.24333-5-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline
In-Reply-To: <20210810153759.24333-5-rf@opensource.cirrus.com>
X-Cookie: Who is John Galt?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 10, 2021 at 04:37:51PM +0100, Richard Fitzgerald wrote:
> cs42l42_pcm_hw_params() must only configure the PLL if this is the first
> stream to become active, otherwise it will be overwriting the registers
> while the PLL is running.

Shouldn't the PLL code be noticing problematic attempts to reconfigure
the PLL while it's active rather than the individual callers?

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmESoCYACgkQJNaLcl1U
h9DL6Af/VMKIUFo2FG9w/3/TvL2WcUgeppJcWnFc3mwnYf/caE1XfD8tjYFDUrzN
rrn79TJDa0URpk2+OyFf9CpHr9ojcoTHn+gI1jkTcW8sBPXy0V/OC0MxdXiZoCjj
tgv2rSjj0HSLns9deX8SEQxS17nxPogW2rwAM+kXhGiDi0TI0tkltIo8+V/ryDGw
cM16opc5sMUys66LJQeNwgWIPhrg+ZS1uTGUPaymM2ZronJ2uJhJxxjAeoLehNGX
szEnxRXKfMYr/FoJ7aZnrVo0IbjJxsfl2j9gDD/8sTJUqKoSYnjE7/yI6K+UummP
V41vVqSdJRFtKnYlasDfVe7pKhByrQ==
=ldD5
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--

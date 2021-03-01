Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D153280B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhCAOYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236107AbhCAOX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:23:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C56764DBA;
        Mon,  1 Mar 2021 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614608564;
        bh=B1rsUPZZMrJCDAX8ICqDg3gybux1VKOF1jXfynGIiKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PmSsT55HiPJ8eQyPjRAA0TZeMrqfLPSbSH4IDpOIccciwFvG+BcARUgen0NzI8lQz
         cbBB1bqNW5/n9UBun4Nsdiq2G0BIo+UmoIlr0r0xDXc3eGwSfjR+sVSMSs+ZPnOzmL
         TFlKjUcfVUfoCiP573gpjLXpbrlaqW2f4poq/jJCIYK/UezY/tZNnHoqQejYrHq0iJ
         vrD+cqJ4BwX1Bvk9wM3/lxgsAfQErInO5ow8FeVShGZ60ZUlTZ9yQPMol4cKByANJJ
         BMTtwNoizSNdWSmaFyBlPx0otvmXMEKBFlo9QdkytSYI/Ghgb7W9VK3bGoeWyLcSMG
         H+EeLm4tSI/GQ==
Date:   Mon, 1 Mar 2021 14:21:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     dingsenjie@163.com
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: Re: [PATCH] sound: soc/uniphier: Simplify the return expression of
 uniphier_aio_startup
Message-ID: <20210301142138.GA20200@sirena.org.uk>
References: <20210224085407.22120-1-dingsenjie@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20210224085407.22120-1-dingsenjie@163.com>
X-Cookie: Does not include installation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 24, 2021 at 04:54:07PM +0800, dingsenjie@163.com wrote:
> From: dingsenjie <dingsenjie@yulong.com>
>=20
> Simplify the return expression in the aio-cpu.c.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA8+HEACgkQJNaLcl1U
h9DI+wf+J7pwCNkiy3Tn63s9OgSsXF2YUMxFNLFzCKlrtjD9+V+TelztPZcxkM9E
Cn3fxKJNPjTBBL76ejhE4T3eJ2YWyHQg4TnRPKCHmsK4Rcnf7zN62RMNZPVgP64i
de/lI2SAjbsgGyIVgsx5hlemasp2/SdAqoa95nBRG9AKKH/SW3RPptph49X+TsBp
xauqATD4e2ZD7dvxKOAJo8IZ32WCU32o5+3IrV/iY23dKQZPfTFV78jfllliy0A3
pW7smM3KkSNrJLYiCKnbRUYSeys+CJLWd0oftGSV8ZE/2cQT1THdN0oFcD+SbUCr
l62kEdf9zGex3QNolb+PQz0EPgXsPQ==
=NNS3
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12A43406EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhCRNdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhCRNdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:33:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28D9C64F11;
        Thu, 18 Mar 2021 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616074420;
        bh=nFgSQpCRtLTmhJpifU3qZm2Z/GsWGU32nCk9QrUFdCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRI2Ef90QsHosHq+cXSCbP0L9mycP8eLcgOWENqQh1DlG4wYbkwn7TOdSO81Qad4U
         zdaWNKYKca+tKJnyczBf2xFeSImd2yr+GIOaZsCwecjiH9nWk985OCW6czzIOrjAiQ
         +FcQWyhKfpZKCxVkY0CHr91ef2PI5VHc4tz3Q61I49sw7BCy5+GPJwXCprw7gVnQTg
         K6H9Xrm+kJcvZfzbQcVv9DYgIkinJ/zWLS+s5jqbfMr7Yjw0AbsGx8eSftw9P5d58g
         a2tFx/bU1xLu3y9ib4yAdGHJZMelrEiATrX9f1KemU8DpcMkzw5o46KR1z5MtWTLH3
         LQKPZt/eStwUg==
Date:   Thu, 18 Mar 2021 13:33:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] docs: devicetree: bindings: sound:  Fix a typo in the
 file rt5682.txt
Message-ID: <20210318133304.GJ5469@sirena.org.uk>
References: <20210313231850.17278-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qo7zVO9a9OQ5oQtr"
Content-Disposition: inline
In-Reply-To: <20210313231850.17278-1-unixbhaskar@gmail.com>
X-Cookie: You are false data.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qo7zVO9a9OQ5oQtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 14, 2021 at 04:48:50AM +0530, Bhaskar Chowdhury wrote:
>=20
> s/drving/driving/

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--qo7zVO9a9OQ5oQtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBTVrAACgkQJNaLcl1U
h9Cgmgf+IbGACYGGTkglCPJzmSj1yzZML+qzfH4MR5sA/axTY99X2WsqqCW8C/4N
1sTt1bBKPc7rR8CsntH5Y9rPHeNEXrlKSO/WSms35gAr9wIT9SMGU937MmzTJ+1n
8+YGSaTwIVvVPiOoRTWFOrUk2turdcWDqO0x8X3rhhJ3LHX5RXydKFhlkPGGfZ4c
ESA1YN6IZkD7uCsOlDdWpYPw0IHd4WKmWifm3UOazdVpK7HEQjj/ZRK+Vvxx7GI6
HLGqBbPU6ff3H8f7ZE06oPDRaJ7TuUjD3yt8zy+pPg4vQvJBxf2z10bYqzKf/Qtj
6dNELgYPsUfIF4yQBHGL5i0TZ7zzkA==
=is46
-----END PGP SIGNATURE-----

--qo7zVO9a9OQ5oQtr--

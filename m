Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051C941143D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbhITMVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237843AbhITMVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:21:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BF4F610CE;
        Mon, 20 Sep 2021 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632140409;
        bh=ul6TPzD2Ve3D3z0KuxVuJnclb+ELGZYZuFs2wudgrlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVQni3eTRvi12Of3dNrpOsSGWJbF2aewnGaRShhbF6Fa/rIHOYuwZvuXjmgf6vaqj
         BPPt4o+A+lHocG9AkAVZj3y5jvlN0hT97jXhBdL1E4YCHknup222zGKBB9XAzTmEzK
         NeaYt9GVaUG9VWyif+SHg4A1qsJ372jDCfA0Jz6TMtUb5dvT1CELm8Ce5R7jxHCJ4G
         9wHJc5fYEVsjFQQBvaQLYvS46OfJgB/tQnII5AYo6L26QhpMJ3lBYGfcLNTLoIRXVM
         9OIS+R2SiRgq7kWxxV303z2iyWkrw18gUDha33a2t4+MdKCgaNwOxHsLHYjcvbR1AG
         +0rf1uNYreDKA==
Date:   Mon, 20 Sep 2021 13:19:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH v2] regulators: fix typo in Kconfig and max8973-regulator
Message-ID: <20210920121926.GD4192@sirena.org.uk>
References: <20210920061137.10884-1-ramona.nechita@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <20210920061137.10884-1-ramona.nechita@analog.com>
X-Cookie: diplomacy, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 20, 2021 at 09:11:37AM +0300, Ramona Alexandra Nechita wrote:
> MAX8973 is supposed to be MAX8973A. Kconfig and the
> initial comment of max8973-regulator.c were modified
> accordingly.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFIfE0ACgkQJNaLcl1U
h9ANTgf/XKPjIv6FWptCVJo2hqxXqYVz9S49vxPK6O2jdYpoRMn4e/8EY7JgbxGZ
c7b4HsRI1T80pXSBmXrVSRPQfNzyNepLNuoESezn6SDeA1HQgOvYz8QN+e1KZJKB
90s3dQuik+iO40Qdo8nnfMyR9V4tvREPDZo1vEBha3Gh0nEl7iLSaSJvdJhYG8xy
Cn5IG63HOCcJuSUSnI9kSUGwfm0tFe3lAW3nUdk6+27V6uqjntnoK9kinoDdQEMQ
OYQv3emgXJuOEiE/DHcKcvdBY4DLjMk7MSWaca8VE/HbmoAfAkGL+EjynGZwl7QW
esgtLpJpb7LnIpvPiiWyEf/RsyPS8w==
=p9pb
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--

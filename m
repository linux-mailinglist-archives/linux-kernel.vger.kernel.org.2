Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C74546C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbhKQNBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:01:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbhKQNBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:01:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1D0863240;
        Wed, 17 Nov 2021 12:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637153913;
        bh=BiqGHhRim3d8BHLcln1M/+lQP923kEXpdloVrzcTV+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4iDoCViWqV4WupTN6YQIaCBKRFmNZGc6sauoe8wLpQM6KzFaq+zj/yz1Lq3acZ2A
         /XeBlKoWhHEmEUKg9LIxob69c+IbPX1seIKYvjnsNiIY1Ht5Sl62g2J2c7jrOgQBFR
         1u2mriO87cwIsl6FURhpgd2PQIU/YxQxqpC6Os8K6IB8myHhElTjiEPnbeqhgLaiR4
         hAo5GZ4o0CCa79d/Uudfxbq8nMbSxX9zOjrDLgvUZEj+kqWlANIlFhrIgsKDdVqtqP
         7SBhnDV0aXFdWcP6XKirnYT7dqdZLF/+3ca5Jt+J2G0imQasdUqX7WKp8cZNAqfWwN
         pDmK8Bp4Fs6WA==
Date:   Wed, 17 Nov 2021 12:58:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@gmail.com,
        linux-imx@nxp.com, peter.ujfalusi@linux.intel.com,
        guennadi.liakhovetski@linux.intel.com,
        linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>
Subject: Re: [PATCH 1/5] ASoC: SOF: imx: Add code to manage DSP related clocks
Message-ID: <YZT8c42cAczfKyMP@sirena.org.uk>
References: <20211116154613.57122-1-daniel.baluta@oss.nxp.com>
 <20211116154613.57122-2-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IqNxkZWaXy7zEpSv"
Content-Disposition: inline
In-Reply-To: <20211116154613.57122-2-daniel.baluta@oss.nxp.com>
X-Cookie: Tomorrow, you can be anywhere.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IqNxkZWaXy7zEpSv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 16, 2021 at 05:46:09PM +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
>=20
> We need at least 3 clocks in order to power up and access
> DSP core registers found on i.MX8QM, i.MX8QXP and i.MX8MP
> platforms.

This doesn't apply against current code, please check and resend.

--IqNxkZWaXy7zEpSv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGU/HMACgkQJNaLcl1U
h9DbMwf/Y2ImIQs2ZcgXwqFemeuwjb1p4nR0JrACkq7Y3Yo7dOswptvX3ngJBPA4
42pcHMl6wI+nKjqCbsmFpNxsTASko7oXls8H9MApS07yKnG0qWMLB67ljugIDICO
cPphAPTU2x2fpTrHSf4pf3aW+Z2rM1MsnIeqsAbgw+0NsUtniyHC5TQwU2xnMNzX
fCS9CFsM9RnzU794HVx3+7u4LbziYQ6iZ/pI2UXgKzEiy1T8Yk6V6eC0L6SCkRSj
q94sWfWLkFRaarFXmqalp3IpqK8pDop9Oh4GLpDb4VJrzj2/9urZGsnH9nEgRl0K
+UBpEMrgqXkb+aHQmcpaMSb2gdU95A==
=msQb
-----END PGP SIGNATURE-----

--IqNxkZWaXy7zEpSv--

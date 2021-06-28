Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0C73B5EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhF1NFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233150AbhF1NFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:05:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C04361C69;
        Mon, 28 Jun 2021 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624885361;
        bh=Y26NYPMh7hRNMuctINof5yJOo5k8WTet6vA/hQSpDXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmtcopATJkGEAjK8kZah+u23pZWB4XZLBNl3OhSp237m9Zc7/5pSCgTZIaq03mTSM
         l9fhEGbEKnG2Un5+V6Rz9Y8I6WHWhWWOxT5hgDLqJ6LtfWf3f9VMTin8VJZogGZQpg
         NAYqWMmoWkvPdo1AINeWqXoRv/v/DYgBevWxFX7itmXHlH4D/1i/8zGSwFnULg74T3
         I1qYEXcllSf7LE8gdRHE5Wz9v8SqvcfivPYp6feN4IFq/iyaRmS/2VPKDgNF/2oXmP
         9bADijpDp57Y77Rf/S5NhFM5o9u78OiBpOYCF6YNKU3lICrPgNKjSVAE8U6JvNC9hE
         TfQPkNSkS4oNA==
Date:   Mon, 28 Jun 2021 14:02:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Bo Shen <voice.shen@atmel.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] ASoC: atmel: ATMEL drivers depend on HAS_DMA
Message-ID: <20210628130214.GB4492@sirena.org.uk>
References: <20210530204851.3372-1-rdunlap@infradead.org>
 <9ba0da3b-dbdb-c91d-2def-f3dcd30cbde3@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <9ba0da3b-dbdb-c91d-2def-f3dcd30cbde3@infradead.org>
X-Cookie: Someone is speaking well of you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 27, 2021 at 03:28:59PM -0700, Randy Dunlap wrote:
> [adding LKML]
>=20
> ping?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDZyFUACgkQJNaLcl1U
h9Bt/wf8DWM389gRTL6jZi/DGboXJNS2QfPYTyMXCpfmcfQr2p+mJyijz59Aw4oU
tW1UDMrGmYvXI0euMGv3a8JsiRObGAK0rIQxmkU47hJODgKasgthC9BRumk8fktF
EfokNzzO2aOzORL1K2RaJ3vO50opo8uKzemVg/E5JqKUnmAlvPlbamETA9hdwEox
+GrNIKFTUiC8Oxc1tm18GnM44UysB1gqJDEx0heHAj/oGxFBwrpd1pCRwFd+zXu2
IjxFQkhmZQz1TFbZAu73NfVthd0++lgRv6HHmWpqQkZTT8nufLa+RsbR5JVKrBwr
IRJdbTzonmq8HqiailSlQlvtyoRxvA==
=wQXC
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--

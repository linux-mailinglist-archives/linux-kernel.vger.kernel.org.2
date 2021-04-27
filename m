Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7844F36C329
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 12:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhD0KVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 06:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236735AbhD0KUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 06:20:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FB4D611ED;
        Tue, 27 Apr 2021 10:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619518797;
        bh=Y1Sf0bjD5hEhEnLL4TFrISbrwe7DqxOPsCTILOOKIc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+W4G3Wt3ezZF1DPhgVS8L0osuBSYKgvXTFNxPRwd2su++/HqqeCZYvXKLXmymz7w
         6gbrlpW6pvoICl+ktRH3yavDILTeFMBvtZvICRhr1zfTllPEWdy4D+UwHd/icWf4MS
         1TslGw713EaPmxXHQMqrGFN2N1N9icLKrR7KWUpVIgl9js4BW/es4DX1BqmRunx/eT
         gIDh9KBNRgu458IeAQi5YjZwImKmv45BiLAQcSwJ9BUzFjlXY1fEgqATlI8lTTtVzc
         nzuC59Df87iNHbtFwVhnBFsB6A+QOjoMnlSef04EJCsoUAIWTn3ymyYFpIMmpJVME1
         c4Tv9AYBuhRYQ==
Date:   Tue, 27 Apr 2021 11:19:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci-results@groups.io, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: broonie-sound/for-next bisection:
 baseline.bootrr.asoc-simple-card-probed on kontron-sl28-var3-ads2
Message-ID: <20210427101926.GA4605@sirena.org.uk>
References: <6080e82c.1c69fb81.cd60c.2a13@mx.google.com>
 <3ca62063-41b4-c25b-a7bc-8a8160e7b684@collabora.com>
 <877dkp5141.wl-kuninori.morimoto.gx@renesas.com>
 <20210426144242.GF4590@sirena.org.uk>
 <8735vc4r59.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <8735vc4r59.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Don't feed the bats tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2021 at 07:28:34AM +0900, Kuninori Morimoto wrote:

> > > If so, all sai1 - sai6 are using "fsl,vf610-sai",
> > > all saiX doesn't have .name. I think it should have different name.
> > > In your case, at least, sai5 / sai6 needs to have

> > You could send a patch along with re-adding the three patches I dropped?

> Thanks, I can do it.
> But I want to confirm above first.
> Let's keep Guillaume's happiness :)

This board is in the Kontron lab - KernelCI is just reporting results
=66rom it, we'd need to connect with someone from Kontron for system
specific questions.  Guillaume, I don't know what e-mail they wanted to
be used here?

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCH5S0ACgkQJNaLcl1U
h9CVnAf+OzAymrPGqi74AroobdIikqiR4xtw2bKKWThMR3fGvwPaQtbr6qtmLwoY
n96fzVSW/xSOiZ4oMSvbT+eO3ZO89M1ecPNxROmwkErYOqH8yZZ/Rja26bBNX5zm
UN/nsMq8b3qcFhrMKfxQf0yDxWLOwxDNGOt21SlbRcztz3xJYDFU/iom5j946UbO
7Zeg+aqzP3KyHwUjyBdyuA8TfJ2k0Dpv4uL5K+Nk4/0/wKtUJf/hdmtFOyNej2GZ
EpX64Wy+uu83WSQ9tgjsVmxQun4TJw4KgVPKxk0m6uPnxe1NODim67sxCo1F2z12
PQAcIhsegTpqWM4b3lVMQKekQ5Ux5Q==
=tr2h
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

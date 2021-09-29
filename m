Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B986B41C4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbhI2Mbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343531AbhI2Mbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:31:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A483613A0;
        Wed, 29 Sep 2021 12:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632918602;
        bh=FTNDmUlvMT5ZqQ/Z2KvcauJAJmdd+/ztjAw1kxwI6z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eyrq5jvoebysBxaZXASykBblpjG3GOfzan58gaYSwlbbRA+OZrfHEXoSYjonTQmB3
         z11Sotsg9T8gxq94qfQ5lVG2GtpJtlVefQicADpdfGkaiVPqP62z8l5LTjzYhXs7FE
         KQKmbXXnbD+ox36a487aQM5Lt5gFrkZiTCYX9rguNcdBojv7tA2ptiWw7hgkTSmyUe
         Tonh5pB3opo3Y247zLkoPrruf4lvd6Avw18+igb/g8LPOFPN54BqeDaBFd8xgjYJxU
         KNX1sz5pQOoq44GXfM3t8gOcoLqw97ElFHzbVvUUOQJRgU4DK7GLwKXMQJ5gKa6QNN
         AldWqEGZ7o6ZA==
Date:   Wed, 29 Sep 2021 13:29:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] regulator: Add Unisoc's SC2730 regulator driver
Message-ID: <20210929122912.GO4199@sirena.org.uk>
References: <20210928073609.198975-1-zhang.lyra@gmail.com>
 <20210928113057.GJ4199@sirena.org.uk>
 <CAAfSe-vM8iG1OtQeVR1CxQtpvA8kqSs3pJ78RQQOL7GcWcTwSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hOh8F6DNH/RZBSFD"
Content-Disposition: inline
In-Reply-To: <CAAfSe-vM8iG1OtQeVR1CxQtpvA8kqSs3pJ78RQQOL7GcWcTwSw@mail.gmail.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hOh8F6DNH/RZBSFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 29, 2021 at 04:20:37PM +0800, Chunyan Zhang wrote:
> On Tue, 28 Sept 2021 at 19:31, Mark Brown <broonie@kernel.org> wrote:

> > Since this is a part of a MFD I'd not expect it to have a compatible
> > string?

> Since we switched to use devm_of_platform_populate() [1] to register
> MFD subdevices, compatible is required, IIUC.

I'm not sure that's a good fit for these regulators, we don't gain any
extra information from the compatible here.

--hOh8F6DNH/RZBSFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFUXBcACgkQJNaLcl1U
h9AS7gf/Y9ZY1fjRz+eP/5LZIskshRKmSZlQJ4lfJeCRxczaRp3TycTxCFvMVcZg
Q88ZKfEJ7vR3JoO00LFqXal38XAlx7X5GPh1SYa7cF8UGmWmU2lwELfTMSnU8dRD
jL7PJZGas/d2vXXwyuvZ2YxzrUN6BHMA0YwU2EdK85z+4hNeSCQ84UKAVX4DPRMV
S4RwAo6RWQTC+gyYS+oDR2Mv3S47A724sX7sAYJbEMdLvZMpMplNqG0f/xVEfMqx
rf6iP2EQ7o1krLR6SAdH5ZshmvNovy/1OcYc5WzOydIvHjjcnVTnIDQFTCYGn5tm
Abs5ShUfbg352yF0fiUuQKAouXRk4g==
=pmbW
-----END PGP SIGNATURE-----

--hOh8F6DNH/RZBSFD--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4E53E93CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhHKOm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232555AbhHKOmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:42:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 839BE60C40;
        Wed, 11 Aug 2021 14:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628692922;
        bh=567DqEJ2CW8yoSvw1a5r0eKHS+MofAlVun4Dh6mctKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4nzoWszuVSWD73z+V3eW7ZyJ6MkRW74PpSMwcdiB/R7qEeMB1o8ISO5BGDySgBJB
         3uqKiK55QBIZIP2CGQ2d2udlzk1wS83qUnCPxWJxQiXoALMiq/tzoNfNEi3QgKai3k
         Z4CaQVTgkMUctnm2fYN3ns33UQp/mHzrP4cjGDL+dyGiZUnC5lH1zAzNQaEUTvmz4I
         6pV0OhGv7VDZqhKvHDz+trOk0szvz10ayMFJWWCvJ4M5SN+Dn5nhKoTxzjBlq3b4Xn
         XzBy9ExsbfE4rMRCAX6vrzrI2ZcKaWq1jAoaqnjtWwA+mncFk2LfjLl2lJXKZN8sF1
         IyUAKbNbmVUVQ==
Date:   Wed, 11 Aug 2021 15:41:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] ASoC: cs42l42: Don't reconfigure the PLL while it
 is running
Message-ID: <20210811144143.GE4167@sirena.org.uk>
References: <20210810153759.24333-1-rf@opensource.cirrus.com>
 <20210810153759.24333-5-rf@opensource.cirrus.com>
 <20210810154959.GD4704@sirena.org.uk>
 <c194004a-2a22-5354-9042-3ce811236319@opensource.cirrus.com>
 <20210811115637.GA4167@sirena.org.uk>
 <bae1afcb-d983-c17c-d932-3afac16df501@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Content-Disposition: inline
In-Reply-To: <bae1afcb-d983-c17c-d932-3afac16df501@opensource.cirrus.com>
X-Cookie: To stay youthful, stay useful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 11, 2021 at 01:21:24PM +0100, Richard Fitzgerald wrote:
> On 11/08/2021 12:56, Mark Brown wrote:
> > On Tue, Aug 10, 2021 at 05:27:45PM +0100, Richard Fitzgerald wrote:

> > > cs42l42_pll_config() could check whether it is already running and skip
> > > configuration in that case, but that seems to me a rather opaque
> > > implementation. In my opinion this doesn't really fall into the case of
> > > ignoring-bad-stuff-to-be-helpful (like free() accepting a NULL).

> > This doesn't treat the situation as an error though, it just ignores it,
> > and there's nothing to stop _pll_config() generating a warning if that
> > makes sense.

> It isn't an error. hw_params() will be called for both substreams
> (PLAYBACK and CAPTURE) and if one is already running we mustn't
> reconfigure the things we already configured. The DAI is marked
> symmetric so both substreams will always produce the same I2C BCLK.

If it's a noop reconfiguration then there's a case for saying that
_pll_config() should just silently do nothing anyway regardless of
issues with reconfiguring, though you might also want to warn dpeending
on other expectations.  If it's not a noop reconfiguration then
presumably the new configuration not taking effect might mean that other
things aren't going to see the clocks they expect.  Either way if a
reconfiguration gets introduced via a path other than hw_params(),
either now or later, having the check in the _pll_config() would catch
it.

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmET4aYACgkQJNaLcl1U
h9DrmQgAhIQarTTvYNjhmlbeS0r6u4MqTIjCzyT8my/0LDFR/3QbeNOLzkt5BmaN
he52NPO92gWzet0lby3zYDerMvDsHZniAfV/c0U+u+ZhN6wRWMzNbAfH6VR6ijgw
fL0cT2Gtr4C7WGWnDrvBNJxx1QgiQjIZD4d8wTT1lKZNWEYK9gUUyUA9OEYR4YFM
wVvKPIS6N2zRx1kRauCCy4tOtq3k+MorJ04T6VpUKc/72CUmx8uSI7Fc9Z5H0UO6
Do70jom82Aj6dEbbSWCyXHQnxaB5JiuUkr/7TLXVea2Gfr1v1ssxc1R4uXlo3O11
mADp4anO/f5zLjL4+o5tC5ndq2RCew==
=Io2A
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--

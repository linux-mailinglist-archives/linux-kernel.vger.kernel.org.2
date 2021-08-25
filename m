Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1AA3F7AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241872AbhHYQgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233004AbhHYQga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:36:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0107061183;
        Wed, 25 Aug 2021 16:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629909344;
        bh=lXnkq/OxLTvjEhU15v7KYQcknr43nW72rX7brdtLXAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KiY+yrJSkj+aong9SNv67r9yIm2BsATM7hlZWQ7pyLel9yHNa1vvZW/fdryuzkuLS
         3InxG/fuRu4gO+Aohy5ZlejFOi4w7nBnxXf+gsGmt68Szo+w+ZTI0QORVtfsrqDEhG
         rY5J1JijSd5QHWtlBrIvdQIFmOwbUxl91O+2KvCWq1tMlkHvg7CWJYsqml0ny4QHNG
         sZsCijA7X0g3fjRuy7UEJSPBsp065ypkCZhJf3EAnBkgOIMXTUQATKhNmDMaIyW4+g
         NdInZYOrlGFuCvODe8eKoqrHVx6sgrXLKf/FL4/a7mSFcw5Ut9qyvxNJXJyyKvsLKV
         KyE4/eJgvSl3w==
Date:   Wed, 25 Aug 2021 17:35:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: "BUG: Invalid wait context" in ls_extirq_set_type
Message-ID: <20210825163516.GM5186@sirena.org.uk>
References: <20210825135438.ubcuxm5vctt6ne2q@skbuf>
 <20210825155427.GK5186@sirena.org.uk>
 <20210825160334.zffm2ctcklo66qkx@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XbHSybK3LHOYQtWI"
Content-Disposition: inline
In-Reply-To: <20210825160334.zffm2ctcklo66qkx@skbuf>
X-Cookie: MY income is ALL disposable!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XbHSybK3LHOYQtWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 25, 2021 at 07:03:34PM +0300, Vladimir Oltean wrote:
> On Wed, Aug 25, 2021 at 04:54:27PM +0100, Mark Brown wrote:

> > No problem with adding raw spinlocks to regmap, I think it's just nobody
> > needed them before.  I've not looked at the problem in sufficient detail
> > to figure out if that's actually the best solution here but from an initial
> > pass through it looks reasonableit looks reasonable

> The question becomes how will syscon be told that one of its consumers
> needs the regmap to use raw spinlock locking? The syscon regmap is
> initialized before any of its consumers probe, AFAIU.

I'd expect it to figure this out based on the compatible string for the
syscon device.

--XbHSybK3LHOYQtWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEmcUQACgkQJNaLcl1U
h9A7iAf/fDYYVBLqSBzkmVn3Eu5qODLHv6s4wdNkyEbIfARpFsDUQUyed+umqmUA
i4v3VaAWK1vPZPH1ejsN/n/QhQWln2NEm/ejfDZiNt1rQzbbHtUliAOmJhlpePB5
kP9jhXlJsqMmvx3JbExGFEw7hTqUVAmDUZxz8oSWTcQlB+5ZElbhb8xUIJm6yC23
MBy0fYFZ4V73u2g+oMYaLgABFChmIYOIE33VnO1diskIOwi5IHPfvbie/TtwRia6
V957WLNnCHjW2gHMoayAeUq9ThhKqRhVq5Pqwrgk9rhh+LS3QbzeSnwTzgm9xVty
B5z47m5NGyr14KkXi6xMlcqRqnQNcw==
=oO38
-----END PGP SIGNATURE-----

--XbHSybK3LHOYQtWI--

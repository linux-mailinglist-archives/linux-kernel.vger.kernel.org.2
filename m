Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6A3FDF5A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbhIAQH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241778AbhIAQHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:07:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6C896103A;
        Wed,  1 Sep 2021 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630512388;
        bh=7QX3Kxr7bXUh4h7TnUfEwUUan5kKwq4tFnWGdO/tCkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvUhBOu8DTpNcf94/RDbJnGx7anVZCA7eXI66B7eNfe/37VwrqJN9+dhojpjShF5M
         6genJGxCPKyhRj0uH2Cm1+SurHDU+q6CEsVizHx0Z17Do+rA7CalEFHhk7SLvg8wXU
         KZDinRDyPEnfFkYT0zKakVag4k3P1ebdNl5YNbTI/TKxnka9pgZ4EnzLM0Zxjvp5yO
         eWDz6msjkMDACrrM+jlpZijZsfnwz9BgCTWyvOsi9hv4RMrsliIpNdnK1aCIPpw4ek
         XYHZyMIsnDYxsDGyJhFVk01gn4EYfHgyMbjGIWeg+ZrEmNutHC4hCjh6l0tLuZcSYE
         /lysZQ2Y6SNqw==
Date:   Wed, 1 Sep 2021 17:05:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regmap: teach regmap to use raw spinlocks if
 requested in the config
Message-ID: <20210901160555.GG5976@sirena.org.uk>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-2-vladimir.oltean@nxp.com>
 <875yvr3j5c.ffs@tglx>
 <YSzM5S3VKOBXniRu@sirena.org.uk>
 <87bl5fggrf.ffs@tglx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
In-Reply-To: <87bl5fggrf.ffs@tglx>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 30, 2021 at 04:16:04PM +0200, Thomas Gleixner wrote:
> On Mon, Aug 30 2021 at 13:19, Mark Brown wrote:

> > That probably does make sense, I think we're just using regular
> > spinlocks for spinlocks mainly because they're the default rather
> > than because anyone put huge amounts of thought into it.  IIRC
> > the first users were using spinlocks for their locking when they
> > were converted.

> So if the actual spinlock protected operations are not doing any other
> business than accessing preallocated cache memory and a few MMIO
> operations then converting them to raw spinlocks should have no real
> impact on RT.

I think Vladimir's point that something might try to use one of the APIs
that can do multiple register writes atomically to generate a very long
register write sequence is valid here.  It's far from the common case
but it'd be hard to audit, it's going to be a lot easier to handle going
to raw spinlocks in the cases where it's specifically needed than to
keep on top of ensuring that none of the users are causing issues or
start causing issues in the future.  This does make me feel it's a bit
safer to leave the default the way it is since if you get it wrong then
lockdep will tend to notice very quickly while it's less likely that
we'd get tooling spotting issues the other way around.

> One way to do that is obviously starting with the patch from Vladimir
> and then convert them one by one, so the assumption that they are not
> doing anything nasty (in the RT sense) can be validated.

Vladimir's patch is in Linus' tree now so users that can safely do so
can start using raw spinlocks.

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEvpOIACgkQJNaLcl1U
h9AFIQf/bE5viYQeyIDVsUQaOdSbUGtzoUNU4V3tf1pDOpXf/OJGxUeekjut/A36
LI+l575vY04LCU33tvlHnQ1KWKjphXKxc5xBrFvtjLl3pLqD89LBedMZw6RUs4xP
GgyiIelfxz2ei2U65yRAM+CqnJJ7zWvHiMYKODMyoNTeB1r6X2B3oHsLJj8VaODJ
K0WmtEmicRaxoC4+wye89csiwT0jvBbMtBjGY/eSmXH/yQR4krARZQ+O3XTP8Z+7
OsMh8toL5f00yvCiyVEvIWGT6XT/QXeqpmz/734FHtt005I+Cy/iyN9wFM9jNj4N
dwSVMsl85U1rV5VkLIjDXLx30eqeTw==
=br0m
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--

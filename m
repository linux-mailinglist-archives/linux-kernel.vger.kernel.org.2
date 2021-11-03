Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2DC444A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 22:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhKCVbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 17:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhKCVbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 17:31:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE20260F58;
        Wed,  3 Nov 2021 21:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635974955;
        bh=QHW65s3qziZ829pmv4kNPFVMJdUsIme66oYxqBjmzqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSgzKLkCrmJnQBoGqptjPVMAKgi0OicvSohQI3KmnXF/dmy8TJfJ7FPIwN5W1E/o2
         XQp6I/rr58J1qJC5L4/C/oMW1GBHEVo1TtlYBUkvzq6tpFTrBq2lSl/b1mhBuXM0Q7
         vrmJmxMPPlhZgRJvF933dIWtZFtf5Fttgt91r8qEJUCvc0kTf7C0rPkIeDCowK8Lju
         VnbLhnP5ZQPg4nMOiQFV9NPsGG8YhFBV1WWoaWwPffLJmOhuHGgGPrKfVxWqoyolAZ
         0F2hFT68vZJUwJY9cm1aK01eYZ4xdSaCEK9es5BFmRSnmRhtEq0uLLaC98jVRo9h2a
         xaJcJD03jRRyg==
Date:   Wed, 3 Nov 2021 21:29:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: allow to define reg_update_bits for no bus
 configuration
Message-ID: <YYL/JwHxKsTmGT84@sirena.org.uk>
References: <20211102214138.28873-1-ansuelsmth@gmail.com>
 <YYLAXL4HjgBGuF91@sirena.org.uk>
 <YYLnlbTFRUdLrmpW@Ansuel-xps.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gJshutYzvFzMAJPu"
Content-Disposition: inline
In-Reply-To: <YYLnlbTFRUdLrmpW@Ansuel-xps.localdomain>
X-Cookie: Thank God I'm an atheist.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gJshutYzvFzMAJPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 03, 2021 at 08:48:37PM +0100, Ansuel Smith wrote:
> On Wed, Nov 03, 2021 at 05:01:16PM +0000, Mark Brown wrote:
> > On Tue, Nov 02, 2021 at 10:41:38PM +0100, Ansuel Smith wrote:

> > > -	if (regmap_volatile(map, reg) && map->reg_update_bits) {
> > > +	if ((regmap_volatile(map, reg) || !map->bus) && map->reg_update_bit=
s) {
> > >  		ret =3D map->reg_update_bits(map->bus_context, reg, mask, val);
> > >  		if (ret =3D=3D 0 && change)
> > >  			*change =3D true;

> > I don't understand this change.  The point of the check for volatile
> > there is that if the register isn't volatile then we need to ensure that
> > the cache gets updated with any change that happens so we need to go
> > through paths that include cache updates.  The presence or otherwise of
> > a bus does not seem at all relevant here.

> I put the check there to not duplicate the code. The idea here is:
> if we are doing a regmap_update_bits operation on a no bus configuration
> and the function have a dedicated reg_update_bits function, use that
> instead of the normal _reg_read, check and _reg_write.

Yes, I can see that this is what the change does - the problem is that
it's buggy.

> To workaround the CACHE problem, I can add a check and detect if cache is
> disabled and only with that option permit to add a reg_update_bits
> function to the map (for no bus configuration).

That's what the volatile check that is already there does - if there is
no cache or that particular register is uncached then the register is
volatile and we don't need to worry about updating the cache.  There is
not and should not be any connection to how the device is physically
accessed, any connection there is clearly an abstraction problem.

> Again the problem here is in situation where lock is handled outside of
> the read/write and the read/modify/write operation has to be done in one
> go so splitting this operation in 2 step (like it's done for
> regmap_update_bits) would be problematic.

Unconditionally introducing a data corruption or power management bug
for any device that provides an update bits operation regardless of
their requirements to use that operation for a specific register is not
a good idea.  If an individual device can't cope with some or all
registers being cached then the driver for that device should configure
it's regmap appropriately to ensure that the registers in question won't
be cached.

> Another solution would be to expose a way to change the cache externally
> to the regmap operation so that if someone require cache operation and
> require also a dedicated reg_update_bits, he can do that by implementing
> that in his own function.

I'm struggling to see a case where this would be useful without the
register also being volatile in which case it's totally redundant.  If
the register can change underneath us then it is by definition volatile,
if the register can't be changed underneath us then with a cache there's
unlikely to be any meaningful upside to using a specific read/modify/write
operation in the first place.  You might have some case for wider
registers where you can do a smaller transfer but that's got to be rare
and I'd expect we'd have to be doing a lot of register I/O to care about
the performance diffrence.

> A third solution would be check if it's possible to cache the value
> externally to function... Something that calls the reg_update_bits
> dedicated function and then update the cache if needed.

That's exactly what the existing volatility check does,=20

> But do we really need to add all this complexity when we can just deny
> an option with cache enabled and force to use the normal way (else part
> in this function)

> Hope I was able to explain better why we need this change.

We do not need this change.  The change that is being proposed will
cause bugs, my best guess is that it's trying to work around a bug in
the driver you're developing where it's enabling caching but not marking
all the volatile registers properly.  If there is any change needed in
the _update_bits() implementation then where we get a device specific
_update_bits() operation from should have no influence on our decision
to use it, doing that is a clear sign that there's an abstraction
problem.

--gJshutYzvFzMAJPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGC/yYACgkQJNaLcl1U
h9B42Qf+JoTlobP4UDMi964BCwkqNghuGiaNUdlolWhuqT5oa9u45crHd4NXG+wW
xRQ6x1cwAxUw2a8cCSF6FCqnaqKaLYCSJ2cw70CLTAXsak5Uh2l1xQOuIFzHlhQp
e+TR6JZO4CsenLvvqs84B/DwUNZkKUl6arKRgdvoyZX6Uv3pVhCt1rdnr3G9gIIh
ZzEMq+R3WHgYBax4BykcfwiqTNTC14Fbmg9EKpKJ09BfNvP6IjfiofoYh3M9oISg
yddop8Vr0YPokKapSQKme8D/Wi+NWR8kjJapxxmcyOdnsmu9UIaGn4pr1l5vbz0g
lei72LA0hlqabdzOdIO1dnTiSEM1Ng==
=54PD
-----END PGP SIGNATURE-----

--gJshutYzvFzMAJPu--

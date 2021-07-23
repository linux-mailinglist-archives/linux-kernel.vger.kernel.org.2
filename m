Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEC43D3DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhGWP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhGWP5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:57:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA24F60200;
        Fri, 23 Jul 2021 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627058286;
        bh=pd1ix9gd0V9QAYHQpMWrkQIf6jQWsci2L6UchtBY9t4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qI86xF2+XwpGobd+AVtrk9Vt3Xg0RhWBA3tocM463ffJOJYeaWWBW2Y9DsC2bDnvz
         owj4l9QwiliBJA2eG5gU87ZpumHw/fLqTc3cl7AbWRx3MNrxJ6JKQM6FdNXWnLHlJq
         T/YNgAUIBzy8BXYKyVTo+lkKuvESNJ4OSnXB/bX2cBuT+yBXgUwXWLuiYX2AbWdJs+
         f1fybymRgSsSLJO9/08MtdJesr9lazeDZF10pv0BQWzhNN9Na69lpQpujxg/HAgv4X
         I46TcWgBIpkYYM7PNKO0SwlsbOJlUW7Z7gX1XOFM0oJmfL0xUAW9pecYsBZVSttmQN
         Tj9hfsiu8gW5Q==
Date:   Fri, 23 Jul 2021 17:37:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 1/3] regmap: add regmap using ARM SMCCC
Message-ID: <20210723163759.GI5221@sirena.org.uk>
References: <20210723135239.388325-1-clement.leger@bootlin.com>
 <20210723135239.388325-2-clement.leger@bootlin.com>
 <20210723144317.GF5221@sirena.org.uk>
 <20210723175315.3eb149c7@fixe.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0NB0lE7sNnW8+0qW"
Content-Disposition: inline
In-Reply-To: <20210723175315.3eb149c7@fixe.home>
X-Cookie: Integrity has no need for rules.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0NB0lE7sNnW8+0qW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 23, 2021 at 05:53:15PM +0200, Cl=E9ment L=E9ger wrote:
> Mark Brown <broonie@kernel.org> a =E9crit :

> > I can't see any SMC specification for this interface?  Frankly I have
> > some very substantial concerns about the use case for this over
> > exposing the functionality of whatever device the SMC is gating
> > access to through SMC interfaces specific to that functionality.

> This would require to modify drivers to check if the access should be
> done using SMCs, parse the device tree to find appropriate SMC ids for
> each functionality, add dependencies in KConfig on
> HAVE_ARM_SMCCC_DISCOVERY, and do SMC calls instead of regmap access.
> I'm not saying this is not the way to go but this is clearly more
> intrusive than keeping the existing syscon support.

You're not doing this at the syscon level, you're doing this at the
regmap level.  Any user of this code is going to have to be modified to
use the SMCCC regmap and discover the relevant SMCCC interfaces no
matter what, but by having it we're saying that that's a sensible and
reasonable thing to do and encouraging implementations as a result.

Device specific regmap interfaces do not require adding anything to the
core, there's the reg_read() and reg_write() callbacks for this, if
there is a sensible use case for this at the syscon level and only the
syscon level (but I really do strongly question if it's a good idea at
all) then you can use those without adding a generic interface for
defining SMCCC conduits as regmaps.  TBH what's being added to the
regmap core is so trival that I don't see what we'd be gaining anyway
even if this was widely used, it's not helping with the SMCCC
enumeration side at all.

> > Exposing raw access to a (presumed?) subset of whatever device
> > functionality feels like the wrong abstraction level to be working at
> > and like an invitation to system integrators to do things that are
> > going to get them into trouble down the line.

> Indeed, access is reduced to a subset of registers offset which are
> checked by the TEE.

I really think it would be clearer and safer to have the TEE expose
specific operations that encode the intent of whatever it is trying to
accomplish rather than just expose the register map and then audit the
operations that are going on in the register map after the fact.  It
seems like it's going to be more error prone to do things this way,
especially as this starts getting used as a generic pipe for exposing
things and things get built up - as well as auditing concerns if any
problems are identified it's going to be harder to track the intent of
what the non-secure world is doing.

--0NB0lE7sNnW8+0qW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD68GcACgkQJNaLcl1U
h9AOoQf/XcPYNux2gSP2MFrnxE4ztiYuGYt2dJkgiDZ37OOoWt/eiXqZWhYPe+GC
Mw1O6d/fIJbEVU5aXXE6omUMRNf/gR/SeYzUl2x9Uh8o4IkkVKQ3zNGaLu7O2jys
93zlueWjwPP58aw5/G0JGSQvO6eYa6/jx4Zr8jbewaPzHI24kKYHtgNAcBoBHUAX
ELuNj+8mbq/eh8C8yIRT55HAeT7umgJ2WxKCLFAEweh5pLTMZKlDl6V6+2bN4zZc
58OQhAfe7s5BHZt0wravJkSUPmogBBn9B4GsJd/2KYs5JVclJoZ6Tqb1akhWdBDV
5QO+gPCQxEFZ39kKZLHcwRUxmb/bCA==
=Rmsv
-----END PGP SIGNATURE-----

--0NB0lE7sNnW8+0qW--

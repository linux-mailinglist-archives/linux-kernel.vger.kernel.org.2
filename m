Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A8D356A5B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351589AbhDGKxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:53:10 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60222 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbhDGKxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:53:07 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2FBEF1C0BD9; Wed,  7 Apr 2021 12:52:56 +0200 (CEST)
Date:   Wed, 7 Apr 2021 12:52:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Johan Hovold <johan@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, tony@atomide.com
Subject: Re: [PATCHv2] gnss: motmdm: Add support for Motorola Mapphone
 MDM6600 modem
Message-ID: <20210407105255.GA15534@amd>
References: <20210107224530.GA23250@duo.ucw.cz>
 <20210129224254.GA28853@duo.ucw.cz>
 <20210228204601.GA20966@duo.ucw.cz>
 <YGWU7U1fIkDmc3Mf@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <YGWU7U1fIkDmc3Mf@hovoldconsulting.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Could I get some comments on the gnss patch? It is fairly simple, and
> > I believe it is ready for merge.
>=20
> Let's get the mux driver in shape first.

Well, gnss driver is now completely independent of that in the new
versions.

> > Here's new version of the serdev multiplexing patch for reference. And
> > yes, I'd like you to review the design here, too. Yes,
> > gsm_serdev_register_tty_port() needs to be cleaned up, but with ifdefs
> > you can see alternative approach I tried to work around "controller
> > busy" problem.
>=20
> As I said before, if you're trying to work around the one
> client-per-port assumption of serdev, you're doing it wrong. You still
> have one client per *virtual* port.

Yes, I have one client per virtual port. But those virtual ports need
their parents.

We can have

serial@ -- motorola,mapphone-mdm6600-serial
(serdev here)
modem -- ts27010-mux
(here is the problem!)
serial@4 --                                      serial@1 --=20
(serdev here)                                    (serdev here)
gnss -- motorola,mapphone-mdm6600-gnss           modem voice -- something

and I believe we agree on that. But serial@1 and serial@4 still need
some kind of parent, and that's where I'm getting the controller busy
problem.

> > +++ b/Documentation/devicetree/bindings/serdev/serdev-ngsm.yaml
>=20
> > +  ttymask:
> > +    $ref: /schemas/types.yaml#/definitions/uint64
> > +    description: Mask of the TS 27.010 channel TTY interfaces to start=
 (64 bit)
>=20
> How is this intended to be used? Looks too Linux-specific for a binding.

The mask says which virtual ports contain "something". We have kernel
clients for some, and we want to expose the rest of the used ones to
the userspace.

> So is this is probably the issue: you're skipping one level of the
> topology and do not describe the virtual ports.

Well, docs need to be updated.

> You should probably just replace the ttymask property with explicit
> nodes for the virtual ports to enable. With no client devices described
> in devicetree, these will then show up as regular tty devices under
> Linux.

Yes, that can be done.

> If you add a compatible property for the virtual ports (e.g.
> "ts27010-port") you might be able to just use of_platform_populate()
> instead of walking the child nodes in gsm_serdev_register_tty_port().

I have "gsmmux,port" for that. And yes, I can take a look at
of_platform_populate.

But as I explained above, there's still problem with the parent
devices.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBtjwcACgkQMOfwapXb+vJklwCgis+MEqjZRedqKlYpB5J2L1oq
jUIAoJyH1QQEEk48890A3alG5/nau3rD
=osY7
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

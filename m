Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2E32012B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 23:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBSWHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 17:07:10 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:54062 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhBSWHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 17:07:08 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 124491C0BBC; Fri, 19 Feb 2021 23:06:27 +0100 (CET)
Date:   Fri, 19 Feb 2021 23:06:26 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <greg@kroah.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, tony@atomide.com
Subject: Re: [RFC/context] add serdev interfaces to n_gsm
Message-ID: <20210219220626.GB31435@amd>
References: <20210107224530.GA23250@duo.ucw.cz>
 <YBQvvUitX4MtRrh+@hovoldconsulting.com>
 <20210131170639.GA21067@duo.ucw.cz>
 <20210210212836.GA18497@duo.ucw.cz>
 <YCTzKm+70jwqkdLK@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <YCTzKm+70jwqkdLK@hovoldconsulting.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > +config GNSS_MOTMDM
> > > > > +	tristate "Motorola Modem TS 27.010 serdev GNSS receiver support"
> > > > > +	depends on SERIAL_DEV_N_GSM
> > > >=20
> > > > You need to post this driver together with the serdev-ngsm driver. =
This
> > > > one cannot currently even be built without it, but we also need to =
see
> > > > the greater picture here.
> > >=20
> > > Well, here it is, for greater picture. But it is not ready. Current
> > > problem I have is gsm_serdev_register_tty_port(). The way I do
> > > platform device registration causes oops on module unload. Help with
> > > that would be welcome
> >=20
> > I would not mind comments on parent patch and some help here.
> >=20
> > Basically I tried to work around limitation in=20
> >=20
> > int serdev_device_add(struct serdev_device *serdev)
> > {
> > ...
> >        /* Only a single slave device is currently supported. */
> >        if (ctrl->serdev) {
> > ...
>=20
> I haven't really had time to look at the code yet, but trying to work
> around the single-client (slave) assumption seems wrong. You still have
> only one client per port even if the mux driver provides multiple
> (virtual) ports.

Correct.

But this limitation prevents me to registering multiple slave ports
with master serdev as their parent.

a) There's a physical line

b) Then there's serdev connected to it

c) Mux splits it to many virtual ports, but I still need something to
specify as their parent. serdev b) would be most suitable, but this
check prevents that.

> But judging from a quick look it appears that you are indeed registering
> one tty device per mux channel in gsm_serdev_register_tty_port() (as you
> should) so perhaps that's not the issue here.
>=20
> Do you have a stack trace from the oops? Are the client drivers holding
> the ports open while you unload the parent driver? That sounds like
> something which could go boom unless you pin the parent for example
> (serdev doesn't support hangups).
>=20
> Also, did you forget to post the gsm_tty_driver implementation? I don't
> see a definition of that symbol in the patch.

I'll gather the data in next debugging session.

But .... this way I have to provide fake platform device parent for
gsmtty1 and friends, and that just feels wrong.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAwNmIACgkQMOfwapXb+vKp9ACffT4yVFEV15BkWD5iLeBIEm0n
O90AniTGK8aO1ojtFj/c5T68cNQHr1aO
=Ynou
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--

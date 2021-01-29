Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EE8309029
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 23:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhA2WfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 17:35:08 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:48590 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhA2WfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:35:07 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 58C291C0B77; Fri, 29 Jan 2021 23:34:10 +0100 (CET)
Date:   Fri, 29 Jan 2021 23:34:10 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Johan Hovold <johan@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, tony@atomide.com
Subject: Re: [PATCH] gnss: motmdm: Add support for Motorola Mapphone MDM6600
 modem
Message-ID: <20210129223410.GB21629@duo.ucw.cz>
References: <20210107224530.GA23250@duo.ucw.cz>
 <YBQvvUitX4MtRrh+@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <YBQvvUitX4MtRrh+@hovoldconsulting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> > Motorola is using a custom TS 27.010 based serial port line discipline
>=20
> s/serial port line discipline/multiplexer protocol/


> > diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
> > index bd12e3d57baa..a7c449d8428c 100644
> > --- a/drivers/gnss/Kconfig
> > +++ b/drivers/gnss/Kconfig
> > @@ -13,6 +13,14 @@ menuconfig GNSS
> > =20
> >  if GNSS
> > =20
> > +config GNSS_MOTMDM
> > +	tristate "Motorola Modem TS 27.010 serdev GNSS receiver support"
> > +	depends on SERIAL_DEV_N_GSM
>=20
> You need to post this driver together with the serdev-ngsm driver. This
> one cannot currently even be built without it, but we also need to see
> the greater picture here.
>=20
> Does this even still need to be a build-time dependency?

Not any more, it is now normal serdev driver, that's why I posted it
separately.

> > +	  Say Y here if you have a Motorola modem using TS 27.010 line
>=20
> s/line discipline/multiplexer protocol/

Ok.

> > +#define MOTMDM_GNSS_HEADER_LEN	5				/* U1234 */
> > +#define MOTMDM_GNSS_RESP_LEN	(MOTMDM_GNSS_HEADER_LEN + 4)	/* U1234+MPD=
 */
> > +#define MOTMDM_GNSS_DATA_LEN	(MOTMDM_GNSS_RESP_LEN + 1)	/* U1234~+MPD =
*/
> > +#define MOTMDM_GNSS_STATUS_LEN	(MOTMDM_GNSS_DATA_LEN + 7)	/* STATUS=3D=
 */
> > +#define MOTMDM_GNSS_NMEA_LEN	(MOTMDM_GNSS_DATA_LEN + 8)	/* NMEA=3DNN, =
*/
>=20
> The comments are inconsistent; does the latter two have a "U1234"
> prefix?

It is U1234~+MPDSTATUS=3D and U1234~+MPDNMEA=3DNN, -- will fix. Hopefully
85 columns is okay with you here.

> > +		/*
> > +		 * Firmware bug: Strip out extra data based on an
> > +		 * earlier line break in the data
> > +		 */
> > +		if (msg[msglen - 5 - 1] =3D=3D 0x0a)
> > +			msglen -=3D 5;
> > +
> > +		error =3D gnss_insert_raw(gdev, msg, msglen);
> > +		WARN_ON(error);
>=20
> The return value is not an "error" but the number of queued bytes.
>=20
> So that WARN_ON(error) makes it look like you never even tested this?

Well, I did test it and it works. Unfortunately Droid 4 produces lot
of output during normal operation, including periodic WARNs, so I
missed that. Sorry about that.

> > +	error =3D serdev_device_open(ddata->serdev);
> > +	if (error) {
> > +		return error;
> > +	}
>=20
> Nit: drop the brackets.

Ok.

> > +	error =3D motmdm_gnss_init(gdev);
> > +	if (error) {
>=20
> You must close the port before returning.

Ok.

> > +static int motmdm_gnss_write_raw(struct gnss_device *gdev,
> > +				 const unsigned char *buf,
> > +				 size_t count)
> > +{
> > +	struct motmdm_gnss_data *ddata =3D gnss_get_drvdata(gdev);
> > +
> > +	return serdev_device_write(ddata->serdev, buf, count, MAX_SCHEDULE_TI=
MEOUT);
> > +	serdev_device_wait_until_sent(ddata->serdev, 0);
>=20
> This code is never reached.

Fixed.

I'll get new version out. I'll also get serdev/ngsm patch out for
context, but that one needs more work.

Best regards,

								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYBSNYgAKCRAw5/Bqldv6
8mSBAJi1kAWjSBXDoTpBI2Qz+8GKk1i0AJoCH/eeZhdN9svw0xJbyDQ27uqyhQ==
=AxdB
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8136F0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbhD2UUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:20:02 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53092 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhD2UUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:20:01 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AC1301C0B9F; Thu, 29 Apr 2021 22:19:13 +0200 (CEST)
Date:   Thu, 29 Apr 2021 22:19:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 058/190] Revert "media: cx231xx: replace BUG_ON with
 recovery code"
Message-ID: <20210429201913.GH31692@amd>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-59-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IbVRjBtIbJdbeK1C"
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-59-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IbVRjBtIbJdbeK1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

i2c.c
> index c6659253c6fb..f33b6a077d57 100644
> --- a/drivers/media/usb/cx231xx/cx231xx-i2c.c
> +++ b/drivers/media/usb/cx231xx/cx231xx-i2c.c
> @@ -515,8 +515,7 @@ int cx231xx_i2c_register(struct cx231xx_i2c *bus)
>  {
>  	struct cx231xx *dev =3D bus->dev;
> =20
> -	if (!dev->cx231xx_send_usb_command)
> -		return -EINVAL;
> +	BUG_ON(!dev->cx231xx_send_usb_command);
> =20
>  	bus->i2c_adap =3D cx231xx_adap_template;
>  	bus->i2c_adap.dev.parent =3D dev->dev;

No big deal either way, and this will only be hit during
development. Linus does not like BUGs, so I'd keep this.

Best regards,
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--IbVRjBtIbJdbeK1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCLFMEACgkQMOfwapXb+vJttgCfTFmrErR7nc21scrzzK8qxsxO
tWAAoJnBCy0oUriYCvU5qcu9t1QeO0qP
=VI4q
-----END PGP SIGNATURE-----

--IbVRjBtIbJdbeK1C--

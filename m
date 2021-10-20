Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394014345CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhJTHUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhJTHUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:20:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9BCC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 00:17:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1md5rH-000749-7I; Wed, 20 Oct 2021 09:17:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1md5rG-0005GN-51; Wed, 20 Oct 2021 09:17:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1md5rG-0001ka-47; Wed, 20 Oct 2021 09:17:54 +0200
Date:   Wed, 20 Oct 2021 09:17:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <groeck@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel@pengutronix.de
Subject: [PATCH v2] platform/chrome: cros_ec: Make cros_ec_unregister()
 return return void
Message-ID: <20211020071753.wltjslmimb6wtlp5@pengutronix.de>
References: <20211019203850.3833915-1-u.kleine-koenig@pengutronix.de>
 <CABXOdTeOO=Yf37_p1c8HVigkqqRyR90RqRDaLk5qxxp3jAGgEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xabgq57hwkh66s6w"
Content-Disposition: inline
In-Reply-To: <CABXOdTeOO=Yf37_p1c8HVigkqqRyR90RqRDaLk5qxxp3jAGgEA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xabgq57hwkh66s6w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Up to now cros_ec_unregister() returns zero unconditionally. Make it
return void instead which makes it easier to see in the callers that
there is no error to handle.

Also the return value of i2c, platform and spi remove callbacks is
ignored anyway.

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---
On Tue, Oct 19, 2021 at 02:31:46PM -0700, Guenter Roeck wrote:
> On Tue, Oct 19, 2021 at 1:39 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > -int cros_ec_unregister(struct cros_ec_device *ec_dev)
> > +void cros_ec_unregister(struct cros_ec_device *ec_dev)
> >  {
> >         if (ec_dev->pd)
> >                 platform_device_unregister(ec_dev->pd);
>=20
> Isn't there a "return 0;" hiding about here which would now result in
> a compile error ?

Argh, you're right. I forgot to squash this in after my build test :-\
Here's a v2.

Thanks
Uwe

 drivers/platform/chrome/cros_ec.c     | 4 +---
 drivers/platform/chrome/cros_ec.h     | 2 +-
 drivers/platform/chrome/cros_ec_i2c.c | 4 +++-
 drivers/platform/chrome/cros_ec_lpc.c | 4 +++-
 drivers/platform/chrome/cros_ec_spi.c | 4 +++-
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cr=
os_ec.c
index fc5aa1525d13..d49a4efe46c8 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -302,13 +302,11 @@ EXPORT_SYMBOL(cros_ec_register);
  *
  * Return: 0 on success or negative error code.
  */
-int cros_ec_unregister(struct cros_ec_device *ec_dev)
+void cros_ec_unregister(struct cros_ec_device *ec_dev)
 {
 	if (ec_dev->pd)
 		platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
-
-	return 0;
 }
 EXPORT_SYMBOL(cros_ec_unregister);
=20
diff --git a/drivers/platform/chrome/cros_ec.h b/drivers/platform/chrome/cr=
os_ec.h
index 78363dcfdf23..bbca0096868a 100644
--- a/drivers/platform/chrome/cros_ec.h
+++ b/drivers/platform/chrome/cros_ec.h
@@ -11,7 +11,7 @@
 #include <linux/interrupt.h>
=20
 int cros_ec_register(struct cros_ec_device *ec_dev);
-int cros_ec_unregister(struct cros_ec_device *ec_dev);
+void cros_ec_unregister(struct cros_ec_device *ec_dev);
=20
 int cros_ec_suspend(struct cros_ec_device *ec_dev);
 int cros_ec_resume(struct cros_ec_device *ec_dev);
diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrom=
e/cros_ec_i2c.c
index 30c8938c27d5..22feb0fd4ce7 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -313,7 +313,9 @@ static int cros_ec_i2c_remove(struct i2c_client *client)
 {
 	struct cros_ec_device *ec_dev =3D i2c_get_clientdata(client);
=20
-	return cros_ec_unregister(ec_dev);
+	cros_ec_unregister(ec_dev);
+
+	return 0;
 }
=20
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrom=
e/cros_ec_lpc.c
index 1f7861944044..8527a1bac765 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -439,7 +439,9 @@ static int cros_ec_lpc_remove(struct platform_device *p=
dev)
 		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 					   cros_ec_lpc_acpi_notify);
=20
-	return cros_ec_unregister(ec_dev);
+	cros_ec_unregister(ec_dev);
+
+	return 0;
 }
=20
 static const struct acpi_device_id cros_ec_lpc_acpi_device_ids[] =3D {
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrom=
e/cros_ec_spi.c
index 14c4046fa04d..713c58687721 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -790,7 +790,9 @@ static int cros_ec_spi_remove(struct spi_device *spi)
 {
 	struct cros_ec_device *ec_dev =3D spi_get_drvdata(spi);
=20
-	return cros_ec_unregister(ec_dev);
+	cros_ec_unregister(ec_dev);
+
+	return 0;
 }
=20
 #ifdef CONFIG_PM_SLEEP
--=20
2.30.2

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xabgq57hwkh66s6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFvwp4ACgkQwfwUeK3K
7Anrewf/fWDClNhaUx4DF67d8fk1edtbLUy7Gm1pQ6mXEnaLRhWPmlUToh5TlZWg
Tb7TaS5eEwX5SgCmn/WSp9nYWHtyXj63DyTgQXRbR9QjgCmDz3Ce1S6e8zhs+9cx
tNoomN74bDyBhFLWeALUYWst+gAtOzrWJN+AiinXhie6pZzi3q4Z8q1HWVNkNqMh
VT4OZI5a9Sw5BoZlmIogJxoJtjBaX+F/t5BFon04iVeGBSW38YDhnlflTTFGwohS
vTx6J18hfJxCodA9iVeZv8Tq06KaBSLs34bJwMk5K+ByMoYw75WyUCk8nqBu26+m
lZ2RzVzA3Adkcs1bLwXTSB/NskACfg==
=lLJp
-----END PGP SIGNATURE-----

--xabgq57hwkh66s6w--

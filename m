Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4696C45B526
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbhKXHTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:19:38 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:43966 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhKXHTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:19:37 -0500
Received: by mail-lj1-f179.google.com with SMTP id 207so3355363ljf.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hOyNwcjpujQ89PSte/9uG1qn2aVX2XCadmIOMHMjkMg=;
        b=LI5yFzjU95D5aEl9j1zYYYDajCLKby/zgSxJoUTx1fuaON76aZt9bUASXjJ/oLAXeT
         2+3W+P4jCSVuI+i1EHFFUEfI7jhYi+45d0D1VIaiwpNula+bp9lDGuvQ3ZpyTK5cxlyc
         4Y8lTlGPd1jEDynlrlrON8Q6/zs2eRYqAz6NVX8+NUDZpu35eJmy+yu1RCFFD/AynEkw
         DJe5bVgr/v5fnqi8saoqnGnEVehPqoNn3L7DmWf0hsUieNTBu8PBFnTAQ2zL4BZ4D87+
         WO44+uN+9K5nBK2xb6mYYyHkLvG2zrx94Li9Ucr1VGaDSBQ8/Mq9rRyicpeGp2QkaPrU
         EqzA==
X-Gm-Message-State: AOAM533IwuyCNCDKG4vbOh7s3LokvtBC/dnzlnvjWfefDI2V01UzGAXN
        nNQG9MJvK4Or/BaUHFP88SUyAfRQgyQ=
X-Google-Smtp-Source: ABdhPJxHJOl4ZicVqB/6h1O86Rp2I9R7X5OplhlHxdWkn8Q649K096T7zQgdBJDLOjvDgKzNajOmLw==
X-Received: by 2002:a2e:815a:: with SMTP id t26mr12729641ljg.79.1637738186869;
        Tue, 23 Nov 2021 23:16:26 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id c2sm1204077lfb.270.2021.11.23.23.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 23:16:26 -0800 (PST)
Date:   Wed, 24 Nov 2021 09:16:18 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Provide event map helper for regulator drivers
Message-ID: <cover.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LqZwnRwUZAwLQPDk"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LqZwnRwUZAwLQPDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This series provides an event map helper for regulator drivers and few
other minor things.

Regulators which provide trivial notification IRQs can use generic IRQ
mapper. Trivial in this context means the IRQ only informs one type of
event, for one regulator.

I did these changes for a new ROHM PMIC - which unfortunately requires
(hopefully only) one more HW revision before it is good to go. So there
is no rush with merging the first two patches - but I decided to send
them as they might lower the barrier of using the notifications with
some non ROHM ICs. Please use your best judgement whether to include
them at this phase or not.

The last patch is a fix for IRQ helper removing an unused struct member
and I think it should be merged no matter what is the fate of the
previous patches.

The series is based on regulator/for-next

---

Matti Vaittinen (3):
  regulators: Add regulator_err2notif() helper
  regulators: irq_helper: Provide helper for trivial IRQ notifications
  regulator: Drop unnecessary struct member

 drivers/regulator/irq_helpers.c  | 41 +++++++++++++++++++++++++++++++-
 include/linux/regulator/driver.h | 37 +++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 2 deletions(-)

--=20
2.31.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--LqZwnRwUZAwLQPDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGd5rcACgkQeFA3/03a
ocUVZwgAid2Ba6HdmnwOi4CjXFrgYy4vCJEJI2TWHwsTlbEX3ecomlAr9/96KUw9
ipcMBHIFW+TizazDJcCSewaHks5bVgHmQVsjODqvFzYTFEfgRZBxnxhhHvdT5oyg
OImx0Xx9ejWlduZFpxUxWCgg8K7QRJFgawE1SqUnLivME66/luO4KkBx7RYz0ttP
3zeSbXxJmpjdjTZnnASpuNqZj+fgZKh7KbggjFEowxr/s9YukrH+Fbo7I5AC2aZT
PMkOW7Me41kz91H0FCsRZBjLpYt3gk6QOnzKA0+tlPr7Y+clXUSLEmRhOX+hqJow
GJdf/L04lKzBOth3mWKyNNupafbuNg==
=oE4F
-----END PGP SIGNATURE-----

--LqZwnRwUZAwLQPDk--

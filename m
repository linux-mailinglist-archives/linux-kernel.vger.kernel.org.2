Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3D23EF911
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 06:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhHRETC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 00:19:02 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:46914 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHRETA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 00:19:00 -0400
Received: by mail-lj1-f179.google.com with SMTP id w4so1087198ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1rLzHdhqii2A1rmaN3/gIAE+yMQGJqjPwuNexzMDhkI=;
        b=m/IQ7A7TmyJaT8dwgvyGBjM9q+xgG7KD038BLrXukpd7Y0yJZc+jJuyG+nLyu2Jjjl
         e79ra6eKm7R+u3At26/MoCWRHNj9wjGk44ExqBLnf2c5YlfGNVbBVnhJ+tHuEmXr9T4E
         ewq1ELETXjef90arwQ2XY8AkfrgMCAUGhdCGOK2h087cLUjh0LcWVQZxVyz+7exVvwu0
         Fy+ynNAz12sZUw+B84U00Y3+KcD9VvvGVfpQyjOFqt8e0ZEzzGABLDKSWghznDtfTgQ+
         NUo9MCbTTjfWd8Oqin7pXgh08IAI7Bo3uw9hMnQIPRZEi/r6eT4J6gobewvRzMxgMtHU
         a4LA==
X-Gm-Message-State: AOAM530mXEm+wkYHg1TCTzU65/E0kwuhAGZfqOcO3E2locv60/3q8+mq
        ERdBn7vxSIYnI0t+VRCOz2E=
X-Google-Smtp-Source: ABdhPJwZVSao3xmhiHC8EbUZcXlUBkTg+vFgFpNJ2fSinS5uQh+1QvXYQFyjUA/4gHpRV7Y7cTUMdw==
X-Received: by 2002:a2e:83d0:: with SMTP id s16mr6073687ljh.328.1629260305656;
        Tue, 17 Aug 2021 21:18:25 -0700 (PDT)
Received: from dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id r19sm392261ljn.139.2021.08.17.21.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:18:25 -0700 (PDT)
Date:   Wed, 18 Aug 2021 07:18:19 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: Minor regulator documentation fixes.
Message-ID: <20210818041513.GA2408290@dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The newly added regulator ramp-delay specifiers in regulator desc
lacked the documentation. Add some. Also fix a typo.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 include/linux/regulator/driver.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/dri=
ver.h
index 4aec20387857..5b6f594f99ae 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -337,6 +337,12 @@ enum regulator_type {
  * @pull_down_val_on: Enabling value for control when using regmap
  *                     set_pull_down
  *
+ * @ramp_reg:		Register for controlling the regulator ramp-rate.
+ * @ramp_mask:		Bitmask for the ramp-rate control register.
+ * @ramp_delay_table:	Table for mapping the regulator ramp-rate values. Va=
lues
+ *			should be given in units of V/S (uV/uS). See the
+ *			regulator_set_ramp_delay_regmap().
+ *
  * @enable_time: Time taken for initial enable of regulator (in uS).
  * @off_on_delay: guard time (in uS), before re-enabling a regulator
  *
@@ -462,7 +468,7 @@ struct regulator_err_state {
 };
=20
 /**
- * struct regulator_irq_data - regulator error/notification status date
+ * struct regulator_irq_data - regulator error/notification status data
  *
  * @states:	Status structs for each of the associated regulators.
  * @num_states:	Amount of associated regulators.

base-commit: 36a21d51725af2ce0700c6ebcb6b9594aac658a6
--=20
2.25.4


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

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmEcigoACgkQeFA3/03a
ocVlPgf8CdBfAw1q+dHWZ1Pu9v/AFqBTNRjSrNeOPn+/uRyB3tJzajUfCdmGOC4S
hyzvf4vQh+aWPLpxl7OXXINIf8x3/9lGJWO+oWdPFg5enwCAAG9yYGvUHSU6r0+W
8eMav9UZdyH7USpcTPmvw1UipXSYTCJJggbmyPBSAD6b0oUtlAnIbqdTYmHkBj8l
dhpnLGyefdVln9tEvuC726if2wznCieltmkbHbyx+d1it/FEq620BhPyTT/DFeKF
TOHhHPE44muRWUi8c7cpoJdsz/WB/DfJyaE30P1v1I5ldkafoNJJirx1oqwVX8gq
SWweGREh32gLRhNmeyeaXkIjv7Ictw==
=FHDw
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--

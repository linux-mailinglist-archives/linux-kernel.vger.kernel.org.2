Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C542067B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 09:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhJDHQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 03:16:02 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:40834 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhJDHP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 03:15:59 -0400
Received: by mail-lf1-f52.google.com with SMTP id y15so1714004lfk.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 00:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=l6aWN+r+oDiekRJvAuKpO9Ca5yW/BsKMDHW9r84u7wg=;
        b=cXsDDq/5+Ulc0+iL+ELvWwkkowOkQqOvtKIGL2NjVKCI3De9i4IFSib73Q/JraHUZe
         KeQSkBWyohWNuiIyo+FEMDK0o+GPpgAhjlUTuJhlsJrYdfWzov6ySeNa0CkG+gbi3mhZ
         gP1x5eQlmArFzMHscZI+ElBCqlgOrZT1gjXAXFNEKkzBJr8e82ACN5tMN6eFMPC05GxA
         Yk9ZKBWYFAUldSaWyWBQb0fNvNRQ1FATQg+ac28mq5Pk+Y6hlwDu/GxDkU1A9nmRlY/L
         aQ4Oi+hdnWOboxOVWEpOCqXlrq3bldxNYvE2YX+dQD2KJst0TRsPU6AK6XzID8S6Ff1F
         Wjsw==
X-Gm-Message-State: AOAM532gXo0vJ55+eBgkb3ySzr+uskR3113v1rO+7gJlARozVil57Bka
        UfXFjVz4jmnVs3lklbtfhQY=
X-Google-Smtp-Source: ABdhPJzjV0pntWwc1b/17B5/xj7+tjnzGZN3yPU10nfDYt+vPxNvyWLyRz3Iy1SDsgWUwkgfFp4mTg==
X-Received: by 2002:a19:7417:: with SMTP id v23mr2232477lfe.677.1633331650351;
        Mon, 04 Oct 2021 00:14:10 -0700 (PDT)
Received: from fedora (dc7vkhyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::5])
        by smtp.gmail.com with ESMTPSA id t10sm326516lja.139.2021.10.04.00.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 00:14:09 -0700 (PDT)
Date:   Mon, 4 Oct 2021 10:14:02 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] regulator: bd71815: Use defined mask values
Message-ID: <YVqpujZLZmaiqwe8@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z/4hLZ9mR/mtoFod"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z/4hLZ9mR/mtoFod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Consistently use the defines for buck control mask values.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd71815-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/bd71815-regulator.c b/drivers/regulator/bd71=
815-regulator.c
index 16edd9062ca9..acaa6607898e 100644
--- a/drivers/regulator/bd71815-regulator.c
+++ b/drivers/regulator/bd71815-regulator.c
@@ -461,9 +461,9 @@ static const struct regulator_ops bd7181x_led_regulator=
_ops =3D {
 			.min_uV =3D (min),				\
 			.uV_step =3D (step),				\
 			.vsel_reg =3D (vsel),				\
-			.vsel_mask =3D 0x3f,				\
+			.vsel_mask =3D BD71815_VOLT_MASK,			\
 			.enable_reg =3D (ereg),				\
-			.enable_mask =3D 0x04,				\
+			.enable_mask =3D BD71815_BUCK_RUN_ON,		\
 			.ramp_reg =3D (ereg),				\
 			.ramp_mask =3D BD71815_BUCK_RAMPRATE_MASK,	\
 			.ramp_delay_table =3D bd7181x_ramp_table,		\

base-commit: 9e1ff307c779ce1f0f810c7ecce3d95bbae40896
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

--Z/4hLZ9mR/mtoFod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmFaqagACgkQeFA3/03a
ocWMnwf+OJsvLNpcSpY03BFfl2KGdiyG6ZBAid71ePed8ez+UtbjxhE6rWYJ2lwA
jrJWkjbzp/CPZmsuhYPvFeokUEW6zOuwHfomlQMvGPuiDhYqu+9+jJ1rNQ3LsldO
eHp6572Fa1VT+vR/UKDVikCc0c42hh5JM9evQIdfAHGYv6liHojNq8zWRiOzGsz0
3aud09/E8xMUHA7ceT+BRAXio3eKRHzS4Kj5s3ERm5NvDJ0C+6dhi9lnt+5PaH6c
4bawkc59LZpdur6P59x5cbBqFIGmfTWM6v23y4X2LFwq/LuhPdzDQiplYzIBn+WQ
5rl8iKCHimT0vBgcyxW+ovF30Sqnow==
=5HDa
-----END PGP SIGNATURE-----

--Z/4hLZ9mR/mtoFod--

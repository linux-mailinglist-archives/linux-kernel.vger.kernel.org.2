Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E638E37E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhEXJnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:43:41 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:41661 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbhEXJnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:43:40 -0400
Received: by mail-lj1-f180.google.com with SMTP id p20so32745108ljj.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 02:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=s1qIoo2mpJomZI8zBF/n2aDzGVvZumG5cCI+hVwl1g4=;
        b=SjZrXMCOzvIoGwTJCIEclbtibepR2+KJ8kW+6yqWWxJt1XW+k++nnuPNk6lNYgBfqv
         xxsGRFFxUm5cVrkdFxJLYA5HyrjsxYT4+xPNBavXKfGAb+YADG7CCryUrHMS1VFEDamE
         UHvxZuJWSeWPb1Dk7llM4xBRYpvElpMNj9c9UiHZBbsy0gHSbvB9cntYJH+y9ruKGBTi
         ZEd05PalbDUXaICIgjHU2mmY4EXdlXl+Vu0BO+WcvW7rRdHhSwZXSnOHbkxNoWsgEhVk
         rjRWLI594nC+oNTeABk7OOIp0e/5B9rbrNH6MYL6dTg5AS19F83uUZqmS2oLvPTj4utV
         lf8w==
X-Gm-Message-State: AOAM531nURRsodyEdijBQhd/68gsbf2a/HTs7w4jkyDzvgbFRdLC9Ots
        sAV2BoVAHTuD6oDbOq6RC1MzbEcccEdVmQ==
X-Google-Smtp-Source: ABdhPJxy0dpGWDO+qkxEPKR/vn1qyhAROHyJMb8XUH2zlj7UNJBpinOoOiXYjkyYdF/EHD+ovFSDJA==
X-Received: by 2002:a2e:58d:: with SMTP id 135mr15963170ljf.424.1621849330760;
        Mon, 24 May 2021 02:42:10 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id y18sm1687039ljc.83.2021.05.24.02.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 02:42:10 -0700 (PDT)
Date:   Mon, 24 May 2021 12:42:04 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd718x7: Fix the BUCK7 voltage setting on BD71837
Message-ID: <20210524094204.GA463579@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The BD71837 voltages for other regulators except the first 4 BUCKs
should be forbidden when regulator is enabled. There may be out-of-spec
voltage spikes if the voltage is changed when these "non DVS" bucks are
enabled. This restriction was accidentally removed when the LDO voltage
change was allowed for BD71847. (It was not noticed that the BD71837
BUCK7 used same voltage setting function as LDOs).

Additionally this bug causes oncorrect voltage monitoring change if
BUCK7 voltage is changed when it is enabled.

Fixes: 9bcbabafa19b ("regulator: bd718x7: remove voltage change restriction=
 from BD71847 LDOs")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd718x7-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd71=
8x7-regulator.c
index e61295b30503..b1eb46961993 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -334,7 +334,7 @@ BD718XX_OPS(bd71837_buck_regulator_ops, regulator_list_=
voltage_linear_range,
 	    NULL);
=20
 BD718XX_OPS(bd71837_buck_regulator_nolinear_ops, regulator_list_voltage_ta=
ble,
-	    regulator_map_voltage_ascend, bd718xx_set_voltage_sel_restricted,
+	    regulator_map_voltage_ascend, bd71837_set_voltage_sel_restricted,
 	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
 	    NULL);
 /*

base-commit: 55f0e3d2ed3d198f639dcbef0366732fa7c71816
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

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCrdOEACgkQeFA3/03a
ocU0Fwf/VlgwikHznlaBYi98GPEJYGMwH+mOR06cbHuhewR6mTQwt71826k3U95A
eeMyTlkJmdLuUtyydGS0deg1d1n+4+1taAQxMl+BdM6lld2NamqSawjuaLhouTWz
wBG2htoZzTryM+ndJhe9aH3WaPpMGBTwbtjgFvaPBuFqTW455pOLcc7CpOLYfnfl
ZjF760VPpdpk7ss6njFtuJcf/hgGkZesrEyrU4GGmLlw7whPVcOsuaof/tTgLA82
bloefJm6mAgWGf36/ymdZz0YOr/RF8hVpcon8fSJhzy7sz9IvLIKQjB0TYRgSdu3
+Q+538N365BsuUbu/FM4tq5yg+UEaA==
=xn/r
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

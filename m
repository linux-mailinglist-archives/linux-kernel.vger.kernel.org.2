Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710B23980C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 07:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhFBFrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 01:47:51 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:34802 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhFBFrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 01:47:48 -0400
Received: by mail-lf1-f50.google.com with SMTP id f30so1524180lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 22:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eB/SsSiNJz8twoNtmkDq3O/Qh3VdnYQCQtSpUtitE5I=;
        b=s/HKEHsceJH6KvrNpwviSnjhorUg56zWJaeVEE8+9BVUK+2PktEtFyEmdEFgTmbtiJ
         zgBr4zePD2GNTKuaOJIG7R0dk0LqqU7QycxGooGwgmqxZEWD/VDFUOhjCq65lZxO/yKf
         AHrGovm50u5ytiW8uWO0aQ4KlqliuA0UQ0vUk6bjENMyqDB6dRWSUDPePkefxJ5L/Fhh
         q7EopFjR6j9X95on3+FqAI2Th2DKXgXpIgzqdo+r1VLUV2dGD4eXmzSPgVPVuVUYrC6O
         86RKDsjFCeTyRrSgJpSVOP/48QoiQdnhXuevDKdPCo0kBG6Sd5oqia8Dq38CvMusUHtz
         i7cA==
X-Gm-Message-State: AOAM533Elny2GT3JAihe1441Cjdpm0w/VZQDjalLFua7Gj+AihFvil+d
        L233Ap7t9JfV1Fjq7prZ9jBDQb6aoPo=
X-Google-Smtp-Source: ABdhPJye4TLz2Pa9NmfpNS0N9H79wSxvfAqQ5g0pmZTxV/HM4k+08ClEmh+UqgQ2PCdq57nqqTSHDw==
X-Received: by 2002:ac2:4206:: with SMTP id y6mr20531896lfh.206.1622612765181;
        Tue, 01 Jun 2021 22:46:05 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id t83sm799491lff.181.2021.06.01.22.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 22:46:04 -0700 (PDT)
Date:   Wed, 2 Jun 2021 08:45:58 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] regulator: bd718x7: Fix the BUCK7 voltage setting on
 BD71837
Message-ID: <bd8c00931421fafa57e3fdf46557a83075b7cc17.1622610103.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Changing the BD71837 voltages for other regulators except the first 4 BUCKs
should be forbidden when the regulator is enabled. There may be out-of-spec
voltage spikes if the voltage of these "non DVS" bucks is changed when
enabled. This restriction was accidentally removed when the LDO voltage
change was allowed for BD71847. (It was not noticed that the BD71837
BUCK7 used same voltage setting function as LDOs).

Additionally this bug causes incorrect voltage monitoring register access.
The voltage change function accidentally used for bd71837 BUCK7 is
intended to only handle LDO voltage changes. A BD71847 LDO specific
voltage monitoring disabling code gets executed on BD71837 and register
offsets are wrongly calculated as regulator is assumed to be an LDO.

Prevent the BD71837 BUCK7 voltage change when BUCK7 is enabled by using
the correct voltage setting operation.

Fixes: 9bcbabafa19b ("regulator: bd718x7: remove voltage change restriction=
 from BD71847 LDOs")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---
v2: Improve commit message
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

base-commit: 8124c8a6b35386f73523d27eacb71b5364a68c4c
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

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmC3Gw0ACgkQeFA3/03a
ocVnIggAvA326QapYYYa5yAnyde5LBT/L0EzrSF5u+ANNNiBBNVCY75sC06AihLH
wO5MTySOE1nNsHs6mH7KxohCncaynpVvMMiddNyeQSNRFCYjP+hEk7Xvt4vtEFjG
fxbPWE2EuUMpLGz+8GSB1cHnP0/1w3l1V5P0B44eHxkgAu2I4OGfAu20aPabqBGK
iNu8rlqKy5GzOwC1jtCZbiP6VgJUszMd5xuswlCuRgGMsl2E9k3uzSE/92gw3OxA
gc43wBMmARm9jYUfpyE4JbOKpxM6iumWumFB2RbogLwNWu+ue43zEZkcFclwBZU9
srwMqZEAty+sjgZOaKeAAkJKixGjmQ==
=QnE1
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

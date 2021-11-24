Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842AF45B414
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 06:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhKXGBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 01:01:17 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:38899 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhKXGBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:01:16 -0500
Received: by mail-lj1-f179.google.com with SMTP id l9so3035823ljq.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 21:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tyvxej18x/DNYvEsoV2zknfM5bP1ygL5b1M+7EMvI+M=;
        b=opnmcfzRnVpPaeMqPhSZ/PhoVfgbxBx/G/fIQcbi+KCmoMGSNQ9c40e36Mk9z4C0f0
         Up3F30R943T321JQReHi2eeHb2lvcy0ccPpSMJlA+cdWViDJYc64Rf/K7ilRcB1/3cJH
         zCdhDmbmOstRtb9PM3yGUs8wiDwAGcMf5NkvAOsjopZ+OyAR/LNEsrnf8gZRrjBmDHrU
         W/vrO9cEvhMuaOWp8agn/IDzy6evDjFse1RJVJloP/nXvWfzqptRL+E0jaGcjueimlPn
         IQhDEQJpLOZtM8okYTSCbIHtG9MA9SP9RqjijxpUg9iy3xB9mC+WxkNzkNCv9lDSUSJr
         CQWQ==
X-Gm-Message-State: AOAM531lycsDKQVj5xg3a3lwZPJDvUKzE6JOMCMrTQviBZcj7xe2qu8m
        j+Q/HUIlEYRwUegqgtoV9Jo=
X-Google-Smtp-Source: ABdhPJyJN8yFuQRNBRMtXeFK+n2Rk4+Kn0PTuOFenekvPs7s7wwhUbZU9iyvpC9PU7DaCHr7NuT+jA==
X-Received: by 2002:a2e:7310:: with SMTP id o16mr12524464ljc.394.1637733477787;
        Tue, 23 Nov 2021 21:57:57 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id v23sm131530lji.79.2021.11.23.21.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 21:57:56 -0800 (PST)
Date:   Wed, 24 Nov 2021 07:57:49 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: rohm-generic: remove unused dummies
Message-ID: <YZ3UXXrk/Efe7Scj@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SqVkFfLSlFLJRQyO"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SqVkFfLSlFLJRQyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Function rohm_regulator_set_voltage_sel_restricted() and
rohm_regulator_set_dvs_levels() had inlined dummy implementations for
cases when the real implementation was not configured in.

All of the drivers who issue the call to these functions do SELECT the
real implementation from the Kconfig. There should be no cases where the
real implementation was not selected by the drivers using these
functions - such a situation is likely to be an error which deserves to be
noticed at compile-time.

These dummies could in theory be used for compile-testing the drivers
only (without the generic rohm regulator pieces). However, for such
compile testing we should manually drop the selection from KConfig - and
I guess that if it does not work out-of-the-box, then it is not going to
happen. Especially when there should be no reason to omit
compile-testing the generic rohm_regulator part.

Crash test dummies.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---

This patch is a result of me breaking the build with the dummy-function
which I forgot to inline. When fixing it I noticed these dummies should
actually not be there. As a result Mark asked me to send a follow-up
patch removing the one I added - and I decided to do double the work and
remove two of them :) Anyways, I'd suggest this to go via Mark's tree
even if the header resides in a file which may be regarded as MFD
territory.

Reference to previous discussion:
https://lore.kernel.org/lkml/YZz4FkRoiVIbfgEf@sirena.org.uk/
---
 include/linux/mfd/rohm-generic.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-gene=
ric.h
index 080d60adcd5f..5ed97a1d0908 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -82,20 +82,6 @@ int rohm_regulator_set_dvs_levels(const struct rohm_dvs_=
config *dvs,
=20
 int rohm_regulator_set_voltage_sel_restricted(struct regulator_dev *rdev,
 					      unsigned int sel);
-#else
-static inline int rohm_regulator_set_dvs_levels(const struct rohm_dvs_conf=
ig *dvs,
-						struct device_node *np,
-						const struct regulator_desc *desc,
-						struct regmap *regmap)
-{
-	return 0;
-}
-
-static inline int rohm_regulator_set_voltage_sel_restricted(struct regulat=
or_dev *rdev,
-						     unsigned int sel)
-{
-	return 0;
-}
 #endif
=20
 #endif
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

--SqVkFfLSlFLJRQyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGd1FEACgkQeFA3/03a
ocURvwgAyms6+BeYd1iwxh0IMq+GHounQTylV6m6UviIRTTuJszMnYOjUnZmssvJ
6SBIYAj2e8Si0+Jhi4gA+KumEwxFNAYfTS4axmxik4aESfI5vaSMCAupmPq7dIdw
qGzy5EWt2ChmelpI01zQ7Ne93nMP399ck/eyWVgStQ7nHNggxZZvAUjQpf76Yf/0
xhMVFGMUbuQs2ywE2391lSOfmQ3mAcAaU4yApxrsJUcF5kr0PGSBVhf8Ygy0L2a3
15+U8O6FrF9p0HRBodTSgAxEpaoggsAyB3J8clqu4fXpOEfwfSe1L5mWAMyGVoFv
zgN5v+jrjPRFSqyU1c6SBGRNWVF28w==
=9kUp
-----END PGP SIGNATURE-----

--SqVkFfLSlFLJRQyO--

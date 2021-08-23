Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968263F4635
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 09:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhHWH5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 03:57:45 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:40500 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbhHWH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:57:42 -0400
Received: by mail-lj1-f176.google.com with SMTP id i28so29875468ljm.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 00:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3fiQ469i6TN3cLShqb4YTdeeV5eKDu16epu3jZkZfiw=;
        b=R1tchoAYcuRJ7CZK+p3amFjg6wAhLLM8f32/oPKwgP/6kcShvaof37/kjJUDPhazY8
         Ch2+RUi0q4B1gn1rEVbzolqtPBJPak5grSqgbLSEDolLMhUauH7Xp7muc+3luTNtaSZ0
         CB3LwZvRedFSxAP8HWbBGQBf10r5lAsB65bVCtADkH93t88112lc8OKiS6VLrTtPDcwl
         gITOcq135IiDe/sd+BksJzA4AJlx07SaqmB2sZ2hTvOD8k39UhbScYHIPk+I4/0sAh5Z
         1TZJ8OYYzqMMiiw7OLA+u3S6EQStLWrGexX5W+5OxA5MMkWPowmDHT6Ox6WWicRCMbrz
         sLQA==
X-Gm-Message-State: AOAM533M2Ly10OQ725nY0wCJTrj8iKAAoXbQNRI45HJjctZ3nzBB+McI
        ezDv0cO4oyz18H8eaeYwJQs=
X-Google-Smtp-Source: ABdhPJzau7jN/Qw875c5hKAHDDcLS/5CAWVc2/xij5XwTPuC8qYJsqUT2kupWt/Toqy/Pqhq9411tg==
X-Received: by 2002:a2e:a910:: with SMTP id j16mr26718532ljq.207.1629705419269;
        Mon, 23 Aug 2021 00:56:59 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id h19sm1376626lfu.138.2021.08.23.00.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 00:56:58 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:56:51 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: Documentation fix for regulator error
 notification helper
Message-ID: <20210823075651.GA3717293@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The helper to send IRQ notification for regulator errors had still
old description mentioning calling BUG() as a last resort when
error status reading has kept failing for more times than a given
threshold.

The impementation calling BUG() did never end-up in-tree but was
replaced by hopefully more sophisticated handler trying to power-off
the system.

Fix the documentation to reflect actual behaviour.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/irq_helpers.c  | 2 +-
 include/linux/regulator/driver.h | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helper=
s.c
index fabe2e53093e..522764435575 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -184,7 +184,7 @@ static irqreturn_t regulator_notifier_isr(int irq, void=
 *data)
 	 * If retry_count exceeds the given safety limit we call IC specific die
 	 * handler which can try disabling regulator(s).
 	 *
-	 * If no die handler is given we will just bug() as a last resort.
+	 * If no die handler is given we will just power-off as a last resort.
 	 *
 	 * We could try disabling all associated rdevs - but we might shoot
 	 * ourselves in the head and leave the problematic regulator enabled. So
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/dri=
ver.h
index 92bf7584a2f0..bd7a73db2e66 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -527,8 +527,8 @@ struct regulator_irq_data {
  *		active events as core does not clean the map data.
  *		REGULATOR_FAILED_RETRY can be returned to indicate that the
  *		status reading from IC failed. If this is repeated for
- *		fatal_cnt times the core will call die() callback or BUG()
- *		as a last resort to protect the HW.
+ *		fatal_cnt times the core will call die() callback or power-off
+ *		the system as a last resort to protect the HW.
  * @renable:	Optional callback to check status (if HW supports that) before
  *		re-enabling IRQ. If implemented this should clear the error
  *		flags so that errors fetched by regulator_get_error_flags()
@@ -537,7 +537,8 @@ struct regulator_irq_data {
  *		REGULATOR_FAILED_RETRY can be returned to
  *		indicate that the status reading from IC failed. If this is
  *		repeated for 'fatal_cnt' times the core will call die()
- *		callback or BUG() as a last resort to protect the HW.
+ *		callback or if die() is not populated then attempt to power-off
+ *		the system as a last resort to protect the HW.
  *		Returning zero indicates that the problem in HW has been solved
  *		and IRQ will be re-enabled. Returning REGULATOR_ERROR_ON
  *		indicates the error condition is still active and keeps IRQ

base-commit: aa9f92097dcc83848ee7e4ea5ddbdd15db5eff64
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

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmEjVLIACgkQeFA3/03a
ocV9oAf/YY4wlG/S5a53C73lsLy+GEZnxUrrORWvq5Sbl1DFq1JqU23jCI+WpQbK
lnZ6aGrMNnlKtxM7Yo1AyspGqCC0F46VJGr8uElt0mJ5hvJ28WBUBitk1VjczPMO
t2CAXFF/JVdngMimDNAhmUlGlJgW6XYnIrWDeB5jtS0AMDl1Q+4dDkdILraxKz20
I2gXGt8K6kUMB4yEBxmaZ+uPvMakNUMHNvPmBiZowHy1qaK0WEiwZwpUpBffQs3K
prkss8q7MRTXehSZ16nko9D/GBO2N/X5LykJVuyD3TRaqRKUGs+YL2Pa0jlQ9dad
CGJMk+3klaJ26++KeHgfoQLddXeb/w==
=Px85
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

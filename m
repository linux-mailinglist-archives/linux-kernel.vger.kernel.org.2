Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D52B45B52B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbhKXHUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:20:04 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:42648 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhKXHUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:20:03 -0500
Received: by mail-lj1-f179.google.com with SMTP id z8so3374510ljz.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UGG6QPMMDpK2R0jr9YHuvYphEa9UmDAwDV7bpKHnSqs=;
        b=gTn+dsN0htzJ6M2ESLsPL85SjzYfXkApiKgZCJSgGxe1+LIn95xn0xs0weBkzKwJi9
         fgK+jjP9ViBPhDFp6Qa2m8Yo6MbYkMn053adNxOymqRwO6ggKz6b7nGFCZmLI9xaQXsr
         g3ZTTfutvycYEWGk1S5L85d8lkj8Y670QCJ8qZ624tqIL4evDgCgP5QIsceMRksIk/+q
         4EjTDUjNL+pZjjYD2t5raFWmXyr4GgW7BqZ4NwvjoXCXAEOFaOqnAOvaVo/gqoa/NV3Z
         pzzNarKvpvodht0PvLxPvSiiYsrNkpMFiXaKPJ43eOY76qgzECgXqPqvxc2XJudZMYa+
         iGDg==
X-Gm-Message-State: AOAM530+lNMhPNwkv7+Md+1XqCLLSh4Ei/y4eVc8McTE9kwjxMsAcU/O
        3TWQIuUTmlgeTEFQe9UZImQ=
X-Google-Smtp-Source: ABdhPJwk4QO50e9im6YO8c49CbF5+BACL2Ms0P1ZWrpu+LiAD5i24fKIp5Jt8kyJXgvorsb1eMIk+w==
X-Received: by 2002:a2e:9617:: with SMTP id v23mr12621798ljh.363.1637738212990;
        Tue, 23 Nov 2021 23:16:52 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id bt3sm1523587lfb.132.2021.11.23.23.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 23:16:52 -0800 (PST)
Date:   Wed, 24 Nov 2021 09:16:45 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] regulators: Add regulator_err2notif() helper
Message-ID: <eb1755ac0569ff07ffa466cf8912c6fd50e7c7c6.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VeZSEWKKs89CeiVe"
Content-Disposition: inline
In-Reply-To: <cover.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VeZSEWKKs89CeiVe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Help drivers avoid storing both supported notification and supported error
flags by supporting conversion from regulator error to notification.
This may help saving some bytes.

Add helper for finding the regulator notification corresponding to a
regulator error.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 include/linux/regulator/driver.h | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/dri=
ver.h
index 1cb8071fee34..f0827d34cb65 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -646,6 +646,40 @@ struct regulator_dev {
 	spinlock_t err_lock;
 };
=20
+/*
+ * Convert error flags to corresponding notifications.
+ *
+ * Can be used by drivers which use the notification helpers to
+ * find out correct notification flags based on the error flags. Drivers
+ * can avoid storing both supported notification and error flags which
+ * may save few bytes.
+ */
+static inline int regulator_err2notif(int err)
+{
+	switch (err) {
+	case REGULATOR_ERROR_UNDER_VOLTAGE:
+		return REGULATOR_EVENT_UNDER_VOLTAGE;
+	case REGULATOR_ERROR_OVER_CURRENT:
+		return REGULATOR_EVENT_OVER_CURRENT;
+	case REGULATOR_ERROR_REGULATION_OUT:
+		return REGULATOR_EVENT_REGULATION_OUT;
+	case REGULATOR_ERROR_FAIL:
+		return REGULATOR_EVENT_FAIL;
+	case REGULATOR_ERROR_OVER_TEMP:
+		return REGULATOR_EVENT_OVER_TEMP;
+	case REGULATOR_ERROR_UNDER_VOLTAGE_WARN:
+		return REGULATOR_EVENT_UNDER_VOLTAGE_WARN;
+	case REGULATOR_ERROR_OVER_CURRENT_WARN:
+		return REGULATOR_EVENT_OVER_CURRENT_WARN;
+	case REGULATOR_ERROR_OVER_VOLTAGE_WARN:
+		return REGULATOR_EVENT_OVER_VOLTAGE_WARN;
+	case REGULATOR_ERROR_OVER_TEMP_WARN:
+		return REGULATOR_EVENT_OVER_TEMP_WARN;
+	}
+	return 0;
+}
+
+
 struct regulator_dev *
 regulator_register(const struct regulator_desc *regulator_desc,
 		   const struct regulator_config *config);
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

--VeZSEWKKs89CeiVe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGd5t0ACgkQeFA3/03a
ocVoNwgAtBjp+pGzqNr9hOl9kk168J8+Ri4VKDrpdmvmC4sbfyYTpdQxfj/LlcG/
HRj1bax+Uw7R3zt1fcyKdT6j/detM+pGzQneIdeVHs68hpNq3eZ9OE4VnY6cY/Q3
ExfgMVsj6w1JbIfIksMyXX5AZyeuJWrpSSk324f2gvL78UG53Sfb86jdxIk61Mk4
9rFppP8Oil2Wqz9lLMSr1HPiHHefZiT66drvwjEsTNOaQpJY7PKw0jbMgVR2Ev3k
49OR/+KyBElYw28y6QOcsowCIJTGLMMUCo1uwv6zZuHPHQw7TPK3muxiMA59uDNI
XOIn6TeP1riq19Q6TvWdc6Bluq4zaA==
=xyUF
-----END PGP SIGNATURE-----

--VeZSEWKKs89CeiVe--

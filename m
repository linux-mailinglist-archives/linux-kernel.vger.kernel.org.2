Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8166458CED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhKVLHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:07:05 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:46618 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbhKVLHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:07:04 -0500
Received: by mail-lf1-f54.google.com with SMTP id b1so78458881lfs.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 03:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k/MG5d7XB0O8wkojaYfKdw6GgnUDp9DpKqC0q1wOTmI=;
        b=Yc9Gh0wAqyg8Xb1b8a/AcdsVu2MQTYLOsUYTQf5MBgKzwpOf7L++nKUwiatftx3Qf7
         wbHOO9ZwuK3Yu04fsmDKPIZmJWiwXpD3By4XTNkJVkSW/WkzrYzwhsp+CfbPpNRN6duO
         r9PxQEyecVr+Yc6tn2NjWaX1WE+07jKyqg80JMZuBOey454HQYeJK8COY+uQaxfVZrpg
         JzQMVTW/wckaVBJbd2WFIL8xYHgRdcGtP16RibmWocZSJ5ADkZW8gn/MC7IWJLEKVL++
         anKgKOpPYK01NlOJSOQjOS+tf12KY+QoBwqPbaaKgzqpl7sVhReiQfcn/ojezzbyEcO5
         wuLw==
X-Gm-Message-State: AOAM532PNteSN/dlNMSJvigXErOAqxVrn1Xa5Sgvd2VxT59u+idPyNcm
        8PAehm3Q2LAfFsX215KlGrs=
X-Google-Smtp-Source: ABdhPJwcj0Qm/Y4rmzuMYXjbs8oq9V3UIAYbxD8NJQpeoLoI1kWt8hR2W8k1wMvVGbP+SKwSeN34Aw==
X-Received: by 2002:ac2:4568:: with SMTP id k8mr54784951lfm.80.1637579036965;
        Mon, 22 Nov 2021 03:03:56 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id t12sm918958lfg.307.2021.11.22.03.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 03:03:56 -0800 (PST)
Date:   Mon, 22 Nov 2021 13:03:49 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] regulators: Add regulator_err2notif() helper
Message-ID: <8170d328e7d1c4849813eb7dcdc3dcc0caed7adf.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jXEb6OOm5ElkW6X/"
Content-Disposition: inline
In-Reply-To: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jXEb6OOm5ElkW6X/
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

--jXEb6OOm5ElkW6X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGbeRUACgkQeFA3/03a
ocXV8AgAySTyHU6+SlHd1rsfOaIqavZEecpG9GWQ4VmB2Rl+DTex88OQSZv+CbgC
gkh65xobrRoC7bWqUdWp3BsozU4mBXKyvCGU4I5jHLVIYXc5CRBMH7W7lwo4JMov
CMW/qtjPVruSI82E8fY6FRReTcQrHcRoopzq8S1xTcF87PNvMfhtuHNM2/6nCqKd
qw6wONFQzFE7BEO+Blhy67Tyddn/iptAtoyxvWmfC9VBEwQ2Ocp/bk3egShUm0h/
0m6btSXWMd03TSu095ENQmIh8qDxcOg43I+QWZqApdis5bIuRsqnCXc9Cv5/PRCP
WN7LsgVQ3iLJyiKF2/kOvd2LEEUiXA==
=WOmp
-----END PGP SIGNATURE-----

--jXEb6OOm5ElkW6X/--

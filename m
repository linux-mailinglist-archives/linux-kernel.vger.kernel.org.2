Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA308455AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 12:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344222AbhKRLwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 06:52:13 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:35447 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344056AbhKRLvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 06:51:35 -0500
Received: by mail-lf1-f42.google.com with SMTP id u3so24639536lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 03:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VhEcikd5VDqiynnrQUNWK+7wvJw1qCYAPPrLTTXr0VM=;
        b=C8kSEW1QO21403rrHE1BnA/Tj3Cu9utqfTBi9XhT5WH2wfyTctzgeg6aiu8Rn+hOUH
         l9wVvoGGSP86x9oBO8MJ+daHJkJvZak8qgiFmVE5FfgEZZYofrerqBdj0KbVgBDCtMJQ
         MrJkTWJtI9lI2LrY0EvXp8Zw+GpDKOoPcW0TP+X+qWWU7acH1OfuHTN6iwRLw8/y4d/f
         cDICUJKpHtbdgwx9YuIh+S0tzQn5w50kIf8K1kXT4d64B8AuShhnvwBN+5/tzdMFZ2LG
         8icE/WiIQlZ7kokcZ8my3j8Q3FfpHUndtzz2M7ij7C0Zmvd9x2JNem2iVVFTEIy/Wc2V
         ZtzQ==
X-Gm-Message-State: AOAM533xXOYmWiVf0/LCPaAcxY3vQoeBZpDE7gIAvr1lhs5MHlVywTYt
        AUn0WE//+Bf0YJFG3BwW8g3qRhQg8us=
X-Google-Smtp-Source: ABdhPJy24PqAlHnUJwndRAKUgW7n0NVkWdsJWIrzaCoyorGHSXLLNQOmovONXMXZ4Eb4LZKiJ9Tqgw==
X-Received: by 2002:a05:6512:2618:: with SMTP id bt24mr22689140lfb.46.1637236114581;
        Thu, 18 Nov 2021 03:48:34 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id j21sm283597lfu.151.2021.11.18.03.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:48:33 -0800 (PST)
Date:   Thu, 18 Nov 2021 13:48:26 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] regulator: irq_helpers: Allow omitting map_event for
 simple IRQs
Message-ID: <2a5d9589c1c76ce537f795ee0aa6d3a7a6093283.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="685tIhOjb+225JCy"
Content-Disposition: inline
In-Reply-To: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--685tIhOjb+225JCy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If the device has dedicated IRQ (or irq controller already splits the IRQ
appropriately) for single error indication on a single regulator then the
map-event callback has not much to do.

Simplify the usage for such devices by using a common helper function to
return the regulator and the reason when map_event is not populated.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---
 drivers/regulator/irq_helpers.c  | 52 ++++++++++++++++++++++++++++++--
 include/linux/regulator/driver.h | 36 ++++++++++++++++++++++
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helper=
s.c
index 522764435575..e06127006c1b 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -153,6 +153,42 @@ static void regulator_notifier_isr_work(struct work_st=
ruct *work)
 				 msecs_to_jiffies(tmo));
 }
=20
+static bool single_bit_set(int val, int bits_to_check)
+{
+	int bit;
+	const unsigned long bits =3D val;
+
+	bit =3D find_first_bit(&bits, bits_to_check);
+	if (bit =3D=3D bits_to_check)
+		return false;
+
+	bit =3D find_next_bit(&bits, bits_to_check, bit + 1);
+
+	return (bit =3D=3D bits_to_check);
+}
+
+static int map_event_simple(int irq, struct regulator_irq_data *rid,
+			    unsigned long *dev_mask)
+{
+	int err =3D rid->states[0].possible_errs;
+
+	*dev_mask =3D 1;
+	/*
+	 * This helper should only be used in a situation where the IRQ
+	 * can indicate only one type of problem for one specific rdev.
+	 * Something fishy is going on if we are having multiple rdevs or ERROR
+	 * flags here.
+	 */
+	if (WARN_ON(rid->num_states !=3D 1 ||
+	    !single_bit_set(err, sizeof(err) * 8)))
+		return 0;
+
+	rid->states[0].errors =3D err;
+	rid->states[0].notifs =3D regulator_err2notif(err);
+
+	return 0;
+}
+
 static irqreturn_t regulator_notifier_isr(int irq, void *data)
 {
 	struct regulator_irq *h =3D data;
@@ -320,7 +356,10 @@ static void init_rdev_errors(struct regulator_irq *h)
  *			IRQF_ONESHOT when requesting the (threaded) irq.
  * @common_errs:	Errors which can be flagged by this IRQ for all rdevs.
  *			When IRQ is re-enabled these errors will be cleared
- *			from all associated regulators
+ *			from all associated regulators. Use this instead of the
+ *			per_rdev_errs if you have a simple device where the
+ *			IRQ can indicate only one type of error for one specific
+ *			regulator (and you omitted the map_event).
  * @per_rdev_errs:	Optional error flag array describing errors specific
  *			for only some of the regulators. These errors will be
  *			or'ed with common errors. If this is given the array
@@ -341,7 +380,7 @@ void *regulator_irq_helper(struct device *dev,
 	struct regulator_irq *h;
 	int ret;
=20
-	if (!rdev_amount || !d || !d->map_event || !d->name)
+	if (!rdev_amount || !d || !d->name)
 		return ERR_PTR(-EINVAL);
=20
 	h =3D devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
@@ -351,6 +390,15 @@ void *regulator_irq_helper(struct device *dev,
 	h->irq =3D irq;
 	h->desc =3D *d;
=20
+	if (!h->desc.map_event) {
+		if (rdev_amount !=3D 1 ||
+		    !single_bit_set(common_errs, sizeof(common_errs) * 8) ||
+		    per_rdev_errs)
+			return ERR_PTR(-EINVAL);
+
+		h->desc.map_event =3D map_event_simple;
+	}
+
 	ret =3D init_rdev_state(dev, h, rdev, common_errs, per_rdev_errs,
 			      rdev_amount);
 	if (ret)
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/dri=
ver.h
index bd7a73db2e66..f9d1115627e5 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -529,6 +529,8 @@ struct regulator_irq_data {
  *		status reading from IC failed. If this is repeated for
  *		fatal_cnt times the core will call die() callback or power-off
  *		the system as a last resort to protect the HW.
+ *		Simple devices where a particular IRQ can only indicate one
+ *		type of error, for one regulator can omit this callback.
  * @renable:	Optional callback to check status (if HW supports that) before
  *		re-enabling IRQ. If implemented this should clear the error
  *		flags so that errors fetched by regulator_get_error_flags()
@@ -644,6 +646,40 @@ struct regulator_dev {
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

--685tIhOjb+225JCy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGWPYoACgkQeFA3/03a
ocUcuQf/eQEnzns9bJ//yUqc5Mc2eZxGMEuoEFRi+gA2BNeVTtwk6stFR8V6rONj
8/1cpQnlX1UAZB18OCgep/L/uZCV8pEHtO/3xrU6WM2xUAyxyPLA/mUjes+qb/wx
ewyMDBNLOlvEfL6IvdL5SRtWe2/d3UZvsnzYs8fFQttJLS6ljorG35mD8RT2bXzp
0SdpLDdVpQkpLeb5wjJ7YFPd4Gj/QYEhlYYW2rS0e4TFnmFdoHCuGryzxB5I2vxP
U8ghsvSR5IzJmYXvY3EozX9Z7Gq4FXdXjSnjr69hoefCuEvtJouGuEdMcwtBs4I3
W4JhcfZHKREE5TX+zw1fEq5j0vpfNQ==
=O7V1
-----END PGP SIGNATURE-----

--685tIhOjb+225JCy--

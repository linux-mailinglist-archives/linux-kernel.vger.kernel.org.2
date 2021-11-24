Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD82645B52F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbhKXHUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:20:34 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:33445 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhKXHUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:20:31 -0500
Received: by mail-lf1-f52.google.com with SMTP id bu18so4826174lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=145nBthxB0WKQxptofOIfjC/viUogIb0Ow4wshzW5kc=;
        b=Sy27LkxnMvRP6dzQYpFMk9VAJrI71CFa/GUxvZIoPxhpevREuAyuWfhjryMfwPSQQ1
         qYXWIwu9hJix4IxclGo0U+dSuGattiXEs7Xa3+zDTC8ruoIDJRUQoOB/gyJYDUCGedwG
         6L4XKl3nrSL7M4/PC41NFcnfOs2FztQlTYdxGuHUFHyLz+xAsyhKLwriIJ2Ek/K7EFf4
         7YbE5v8lA5ZMYi0dMF79/yBtqBkeAe2TAVWp1xc/pPeatr5QvbAFVH13UWfscbDAVUEg
         8/5e8vMwzaeuFxPHjQhzcsLW/4YYVyIM8ihVIwOsQa2T508Ivy3weck3VIfgPUZv65My
         hmBA==
X-Gm-Message-State: AOAM531l0HIPnrUIUn5UwRFyf7YrDn2R09NTLnQgGlG/2ZL6ZppfBIiE
        sV8FtB/2IFkxiR/ww1yDXN9YICmYNrU=
X-Google-Smtp-Source: ABdhPJxzcUKrfNXRopOWd8pADZCFBgJW717p1Y10u8WHH62bAXe01qkaE9bmX4wd/16oZLSrz4dw9g==
X-Received: by 2002:a05:6512:2033:: with SMTP id s19mr12295080lfs.290.1637738240787;
        Tue, 23 Nov 2021 23:17:20 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id f17sm957469lfl.117.2021.11.23.23.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 23:17:20 -0800 (PST)
Date:   Wed, 24 Nov 2021 09:17:13 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] regulators: irq_helper: Provide helper for trivial
 IRQ notifications
Message-ID: <603b7ed1938013a00371c1e7ccc63dfb16982b87.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ttpqo1ZQhfs8TNea"
Content-Disposition: inline
In-Reply-To: <cover.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ttpqo1ZQhfs8TNea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Provide a generic map_event helper for regulators which have a notification
IRQ with single, well defined purpose. Eg, IRQ always indicates exactly one
event for exactly one regulator device. For such IRQs the mapping is
trivial.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---
v2:
 - use hweight not single_bit_set
---
 drivers/regulator/irq_helpers.c  | 41 +++++++++++++++++++++++++++++++-
 include/linux/regulator/driver.h |  2 ++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helper=
s.c
index 522764435575..fe7ae0f3f46a 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -320,7 +320,9 @@ static void init_rdev_errors(struct regulator_irq *h)
  *			IRQF_ONESHOT when requesting the (threaded) irq.
  * @common_errs:	Errors which can be flagged by this IRQ for all rdevs.
  *			When IRQ is re-enabled these errors will be cleared
- *			from all associated regulators
+ *			from all associated regulators. Use this instead of the
+ *			per_rdev_errs if you use
+ *			regulator_irq_map_event_simple() for event mapping.
  * @per_rdev_errs:	Optional error flag array describing errors specific
  *			for only some of the regulators. These errors will be
  *			or'ed with common errors. If this is given the array
@@ -395,3 +397,40 @@ void regulator_irq_helper_cancel(void **handle)
 	}
 }
 EXPORT_SYMBOL_GPL(regulator_irq_helper_cancel);
+
+/**
+ * regulator_irq_map_event_simple - regulator IRQ notification for trivial=
 IRQs
+ *
+ * @irq:	Number of IRQ that occurred
+ * @rid:	Information about the event IRQ indicates
+ * @dev_mask:	mask indicating the regulator originating the IRQ
+ *
+ * Regulators whose IRQ has single, well defined purpose (always indicate
+ * exactly one event, and are relevant to exactly one regulator device) can
+ * use this function as their map_event callbac for their regulator IRQ
+ * notification helperk. Exactly one rdev and exactly one error (in
+ * "common_errs"-field) can be given at IRQ helper registration for
+ * regulator_irq_map_event_simple() to be viable.
+ */
+int regulator_irq_map_event_simple(int irq, struct regulator_irq_data *rid,
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
+	if (WARN_ON(rid->num_states !=3D 1 || hweight32(err) !=3D 1))
+		return 0;
+
+	rid->states[0].errors =3D err;
+	rid->states[0].notifs =3D regulator_err2notif(err);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(regulator_irq_map_event_simple);
+
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/dri=
ver.h
index f0827d34cb65..15cd94bb6769 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -701,6 +701,8 @@ void *regulator_irq_helper(struct device *dev,
 			   int irq_flags, int common_errs, int *per_rdev_errs,
 			   struct regulator_dev **rdev, int rdev_amount);
 void regulator_irq_helper_cancel(void **handle);
+int regulator_irq_map_event_simple(int irq, struct regulator_irq_data *rid,
+				   unsigned long *dev_mask);
=20
 void *rdev_get_drvdata(struct regulator_dev *rdev);
 struct device *rdev_get_dev(struct regulator_dev *rdev);
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

--Ttpqo1ZQhfs8TNea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGd5vkACgkQeFA3/03a
ocVXsAf9HGSQIqCKiChg/n73avsVe9hhmDIG/ylMy0WO1wiDo69XfHzZ/o5ZMaLL
4hYglx9l3xNG09KcqIKPauDIDLNrz7nURBvFdHLm2R/zhyV+byuS2IACzZnjvz4p
V/jAJr8/lrJ0IaFezrop7UnO1JbEtSaFpoE0COK8gJKlgzac5QN122duSTicwNF8
QpO+cAB0YvN/q/zNNgHoBcbyk79+WO6WCMmVtHcJrJ6ZjLLNzqdN4zzqGGOV/oUv
eS4eXRp+gIwMI1ERAlIh/GRxoLBUuEOJoZ0snle+tz9y73LefbrkZtCQgED7vaFn
hnzDIBlLLjyuLGK9R18DSlO796hSwA==
=WZyb
-----END PGP SIGNATURE-----

--Ttpqo1ZQhfs8TNea--

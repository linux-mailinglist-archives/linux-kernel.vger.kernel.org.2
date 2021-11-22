Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF36458CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhKVLH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:07:28 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:43915 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbhKVLH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:07:27 -0500
Received: by mail-lf1-f51.google.com with SMTP id b40so78955765lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 03:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J6MvBhAG8VwEwH8SlMOtr1wi86UJLCo7Y3XfP0z8e3c=;
        b=jldJp3HaDQhwW2uHdX/Qlpu+7BtW0KB8661PfEHgUSmWnLm0Mi3ZVe86MQ6HdA9BS7
         ef4i/ABGCtlFXBpcLw5k1GGf8sYoCPc7r8xhChoSw+ZVVWTMiSb3f+kLqNanA9edebsd
         apXUkEML44oOnTbhO0kbCJ9gRO2zSgUeqF0rBvLV8YyofK5nT5Uk/f/nkj86Tjwl+DDe
         eQtMOtsJ3DsdrZ6Gqya52ovqq56Rv7Sn+0WQ/uWdoRLp2ZmY93n8yWgbY0exgdCrkubW
         lqlveqP8plWcWz8S0ylRBNM6JWHu737MzVYJc+vbtHMEuj0P2LNaUicTuE5w4T3nezv3
         VqCA==
X-Gm-Message-State: AOAM530LlLly08veOD7x1jfnS6PM96czA4hv6wQqyXGjkzj17GO5YPBt
        XdWAqRU+fhdtyowR6zs5g0U=
X-Google-Smtp-Source: ABdhPJyVpfEsbhTBqTfue3nEhfsZX66BWZNW8HK7/MtNBGBShPYv/M2K7P9SFkYAX7vX5pnJ3aMXng==
X-Received: by 2002:a05:6512:1392:: with SMTP id p18mr46122905lfa.591.1637579059879;
        Mon, 22 Nov 2021 03:04:19 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id q13sm921429lfe.121.2021.11.22.03.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 03:04:19 -0800 (PST)
Date:   Mon, 22 Nov 2021 13:04:12 +0200
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
Subject: [PATCH 3/4] regulators: irq_helper: Provide helper for trivial IRQ
 notifications
Message-ID: <fc622a2135be79f718d32efac156558470568340.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T8g6xEKWj2gKfHyq"
Content-Disposition: inline
In-Reply-To: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T8g6xEKWj2gKfHyq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Provide a generic map_event helper for regulators which have a notification
IRQ with single, well defined purpose. Eg, IRQ always indicates exactly one
event for exactly one regulator device. For such IRQs the mapping is
trivial.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---
This change was introduced earlier as part of the series:
"Few miscellaneous regulator improvements". Other patches from the
series were merged so this is now a lonely one and also the commit name
was changed to better reflect the new apporach (provide helper instead
of allowing omitting the callback). Changes from the initial idea:

 - Move the single_bit_set() to location where it is usable also for
   others.
 - Export helper for trivial mapping instead of adding the callback on
   behalf of the driver.
---
 drivers/regulator/irq_helpers.c  | 42 +++++++++++++++++++++++++++++++-
 include/linux/regulator/driver.h |  2 ++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helper=
s.c
index 522764435575..4ba1f1975f16 100644
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
@@ -395,3 +397,41 @@ void regulator_irq_helper_cancel(void **handle)
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
+	if (WARN_ON(rid->num_states !=3D 1 ||
+	    !single_bit_set(err, sizeof(err) * 8)))
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

--T8g6xEKWj2gKfHyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGbeSwACgkQeFA3/03a
ocVkVwf9FxCjiGGCEZL1RQFZxJoW6AtcgqA7gosPiXdL4EEvvOOalJYKa8BGqlcZ
83vIIykERq5STmZHo/wXI92CEj7QXXqewm9TWSoPI7+VD5ggG+GNuS1qY1/otAjh
g5WkSGvBuazqSbQwgmhZxL54DfVUHckJUV9kujHPqR09s1JK+WualWGGFWz1y6Bl
I41g4hGNubTy6gOWEtl9KP66cJcsnwjmQU6rsJ6Lhi9gvR4CFkr26FZf/+n5TMIN
mGYlRui0BrThWSFym/d+fkpGNy2NvT3Zw/J1SRsUBWwKmuCO2pyiuyvePTuQaS66
+ER4fH3xkrfwPcyJ/cU+IKm40GidqA==
=PqSJ
-----END PGP SIGNATURE-----

--T8g6xEKWj2gKfHyq--

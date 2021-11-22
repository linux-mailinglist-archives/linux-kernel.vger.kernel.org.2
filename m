Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D1E458CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhKVLHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:07:48 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:38849 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbhKVLHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:07:46 -0500
Received: by mail-lf1-f49.google.com with SMTP id bi37so78825446lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 03:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2WvGvO1SLMm51JT/9D4wYQ5ZDjELDFHAo+03Uj5f0m4=;
        b=fPbmXwQPc5aCncD5NUNnoXw0WLCi6QMTiRBnyz3hj6i4qQ3/13dkVU3jhi6Jm/fLYh
         8qKa1Vru72bD6czm++LddSQMpuI+AUCMt6C5uIMPBdYE/cyd4cvA4oQyDppvkMJqPKKR
         ec/Y2Z0r99MG0Q/vdp/QlzoMlTgJCAM2TpgngoXgl6okXHueD0wlhQb8rvOn5p7/VBLf
         dAyddA9wCLt4dDV9/BAjiO10ZDLU+/NQuHElyhK6EvZRTjXFAf48V6zP9wnIF6GixG0Y
         Suq2q+nKFb47VDNRNPcDn2xbYIb+Br92v70zq8+Sgq8LA0HBqKcNeXUP1BceCCmWDC0/
         zBbQ==
X-Gm-Message-State: AOAM532km47seKVwqs/uaomcjXbGuiOXACDilHar1T8psYUEgg1WUi6P
        UGf4C6/ycIu+pv1nmBcr4BE=
X-Google-Smtp-Source: ABdhPJx5MoqdZVO4mfQbtzcvXCeZtHrfQW2+jYAw6dgjTaUc1qT9Z6Y9AstGL72g2rgESCr3+bjuHw==
X-Received: by 2002:ac2:442c:: with SMTP id w12mr56579250lfl.554.1637579078443;
        Mon, 22 Nov 2021 03:04:38 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id u2sm928587lfi.108.2021.11.22.03.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 03:04:37 -0800 (PST)
Date:   Mon, 22 Nov 2021 13:04:31 +0200
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
Subject: [PATCH 4/4] regulator: Drop unnecessary struct member
Message-ID: <6f635786ca7e79455b769a665a4f613a5ff7e7d6.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WZkBsU+ykOfKRD2c"
Content-Disposition: inline
In-Reply-To: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WZkBsU+ykOfKRD2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The irq_flags from the regulator IRQ helper description struct was never
used. The IRQ flags are passed as parameters to helper registration
instead.

Remove the unnecessary struct field.

Fixes: 7111c6d1b31b ("regulator: IRQ based event/error notification helpers=
")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 include/linux/regulator/driver.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/dri=
ver.h
index 15cd94bb6769..4078c7776453 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -554,7 +554,6 @@ struct regulator_irq_data {
  */
 struct regulator_irq_desc {
 	const char *name;
-	int irq_flags;
 	int fatal_cnt;
 	int reread_ms;
 	int irq_off_ms;
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

--WZkBsU+ykOfKRD2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGbeT8ACgkQeFA3/03a
ocU5twf/f3wRhXefkZsR8TkClSzcfRXOVvkmLU1kvpcFzX+rHfQeeAMPBni7IfO8
BTmF8vGwIELPsBuBb9e5E9JnMZE1fVWWmFOfodexbxud9Aat/LMD/IfXxx66IxqL
7UHpmcexItLZOVpMJZlI5mRhhkO7P0Pmk92vnkhIoqri7wzfmYuzGFV58HAQXmr0
lVA5MK35vCtUjGocb34wq4iuTNC9SAVHKroD11bP8ihwB8bTff6zXroGRtwMdGtm
X55ACvL1trDkraxnFXjpTwQbeJulGAajbGOSnu1katWMH0kSk3fRpviXwuGJurdg
RV8qP1fJ8E0XYH7KyPn3sb7t+KO7rg==
=W2SV
-----END PGP SIGNATURE-----

--WZkBsU+ykOfKRD2c--

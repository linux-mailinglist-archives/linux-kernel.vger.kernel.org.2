Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702D945B531
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbhKXHU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:20:56 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:39775 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbhKXHUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:20:55 -0500
Received: by mail-lf1-f43.google.com with SMTP id f18so4684361lfv.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OKotMJgI3SCOAu1zbD/a/YXW/h3YqnmJ9AuD/UHlnhk=;
        b=PfTfVuULH3C01sd+7a64VJLWPRE0PAnkoFZBvW7KwMLtrqhkHFN1p4ISPmS3R2lNhw
         3DUdSNLK0ZCzAGxqU70vNURLhavUTbjjbaeNJteP1/lDYfQrujDuuIb+Hk+MtaJ9JZHm
         iV93VOMFVVcube0cxoetnrtwdpMBGxYnk9UdSJcGuts6dd2gkOYk8rwAlqTYdnh4jCY9
         SQpDTxJHhRKA7D+ZlrOqtUM9K6j5TZ8++ol9YLiG2giqDnOGLlyYMpXCV95FoAK/h8gn
         FTHHCCU+Xeuf2TA7eTPUzpnrTXpTNMizjvKS56gRKYytJ3P4AXl11n0oLC3YsGmml2xc
         PBgQ==
X-Gm-Message-State: AOAM530PCyHqzRgaIr/M5psvL+GAlfc19G+fLLBBAgztnGXgvwvLxv87
        adB30TDADY5dWEkaBatQ5Lo=
X-Google-Smtp-Source: ABdhPJwMRHppWpnfJEyg28imvyc5V9MAfBSlnwf7KtS65jgGcXncDn/Tv/Z8oEjQEynxlmTKIPRjeg==
X-Received: by 2002:a05:6512:1395:: with SMTP id p21mr12330015lfa.98.1637738264716;
        Tue, 23 Nov 2021 23:17:44 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id d3sm1501511ljl.93.2021.11.23.23.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 23:17:44 -0800 (PST)
Date:   Wed, 24 Nov 2021 09:17:37 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] regulator: Drop unnecessary struct member
Message-ID: <5f6371e178453fa2b165da50452f7db4e986debb.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wz+LmvgbZpfoOuhE"
Content-Disposition: inline
In-Reply-To: <cover.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wz+LmvgbZpfoOuhE
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

--wz+LmvgbZpfoOuhE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGd5xEACgkQeFA3/03a
ocXokQf+KY8qELMwR0VjXx6/RplQ3KkCw2Ku6ptxz5UlbX9AHeWpRflyrteO0jGl
5oRsosVDqV5lpC6MMfbiQrIQzyOuDzrbo3palnd0JgY32mO6s2X3yjl1B7Yxg1y7
cxQLGib94BtF92Pz9DuLAezScnemh3PcvKe9nc8RRDnReN8bKLFidMGC/DJ1UeEw
z/chojVpJRQQopJeCw6tLkTgd+rShpvPMN0FrI9KW/3kp31F46kOet9JxYmCYgjw
tAKNuFdd31exqd3dm4g7G/O9TPa69CBcDOVBzPim5hjJ2ZSQM/T/PvcVUXk7sttt
dsQ+vZUbNaHdmaxdCHImWsUUA1NQ/w==
=XKac
-----END PGP SIGNATURE-----

--wz+LmvgbZpfoOuhE--

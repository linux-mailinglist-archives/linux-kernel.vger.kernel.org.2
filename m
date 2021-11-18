Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED94455AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 12:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbhKRLyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 06:54:00 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:42707 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344377AbhKRLwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 06:52:39 -0500
Received: by mail-lf1-f48.google.com with SMTP id t26so24585816lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 03:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vvLuYqIdAjTKtWzzRJZdjzNeCIqI9odcukAPTACZ0g0=;
        b=r1kMily9uTsIP+mzB2/OYvSO07qrDBxMMqO1nRjGkEerXFtDgNEKGgEWMDWshbzYWa
         7mUV/akpr1b/Iwmy9yolSkUgLXK/9dm3tvEK04zjvbmf/T/rfI1125gPyn0NCCQ/q7/H
         CW50pQSE7mm23UcTiPJq2Owaf2474UP25YvmjPxL/K6kewMvkESf6ptGqCYn3PVR8NSl
         X1+KDFIUKDulh1j51TvNDAqlBxgQyqQ5yI+iC9JYchDtp5TswK4nShHWaYiZZF5IxDii
         YGPRLwMeFgtvEENeNrQo9nE3Hhjw3+jlD4h2dJfk7k/1mfhEn15QsqIjbkcPAOHFmKzO
         5r3Q==
X-Gm-Message-State: AOAM532+4XsSTl7JanSA59U1t/2v7ygfmbMjLvq4n3DL8QX8S9ymhwva
        c09hCdSmx4UqvopHey492pU=
X-Google-Smtp-Source: ABdhPJyGMXX3DPV58w/bTnVplHNmv2i70+g9tj1Ca/riisdZjgq+DuXs7pRcWPUgIzK272LUwpZUDg==
X-Received: by 2002:a05:6512:220b:: with SMTP id h11mr23253741lfu.151.1637236178291;
        Thu, 18 Nov 2021 03:49:38 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id c30sm284718lfp.31.2021.11.18.03.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:49:37 -0800 (PST)
Date:   Thu, 18 Nov 2021 13:49:30 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] regulator: Add units to limit documentation
Message-ID: <111114aca991e41e49a32f89b74e95285f07c1e3.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H6YBovHvEvRRxAQr"
Content-Disposition: inline
In-Reply-To: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H6YBovHvEvRRxAQr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The documentation for limits used at protection level setting
did not mention the units. Fix the units in documentation to
match values passed in from device-tree (uV, uA, Kelvin) to
avoid confusion.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 include/linux/regulator/driver.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/dri=
ver.h
index f9d1115627e5..cf87f435d7ca 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -101,11 +101,13 @@ enum regulator_detection_severity {
  *		is requested.
  * @set_over_voltage_protection: Support enabling of and setting limits fo=
r over
  *	voltage situation detection. Detection can be configured for same
- *	severities as over current protection.
+ *	severities as over current protection. Units of uV.
  * @set_under_voltage_protection: Support enabling of and setting limits f=
or
- *	under situation detection.
+ *	under voltage situation detection. Detection can be configured for same
+ *	severities as over current protection. Units of uV.
  * @set_thermal_protection: Support enabling of and setting limits for over
- *	temperature situation detection.
+ *	temperature situation detection.Detection can be configured for same
+ *	severities as over current protection. Units of degree Kelvin.
  *
  * @set_active_discharge: Set active discharge enable/disable of regulator=
s.
  *
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

--H6YBovHvEvRRxAQr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGWPcoACgkQeFA3/03a
ocUGCQf6AifRw9UDBqhAR7aAB7hMmf9NWr3GSZhqQCrcsTt6jOLikgG7umHhfvzK
K9ELaSRgQgRPj9IB+5oJo3KF7rGfQJVNEzxBAKk/CCNXoBJ1ixdvjzfrGapOQpDd
wYQIEMBozBA9NX5tl7kmHizyHp734y1j0jrIqm3AfFGC4EpcCzFbMDJoNJfzUe19
a/bBqQgbLVXT9+ccdPvzzpeIG/79pqP1CTDkzL80kgjo3XzBI8GA/u3D9JVeUMin
wQwuF7MMUhkMU6mLkqxHKidFHolKdzSelNLEObWnKKZCmLkUhOxC7/8kd2CKC8uL
sAW+yb+P+7CYJhYRy7m0zHW5S5+H2g==
=16Q5
-----END PGP SIGNATURE-----

--H6YBovHvEvRRxAQr--

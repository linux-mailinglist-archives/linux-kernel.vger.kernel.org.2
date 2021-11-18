Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250AA455AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 12:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbhKRLyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 06:54:09 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:43634 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344278AbhKRLxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 06:53:00 -0500
Received: by mail-lf1-f49.google.com with SMTP id b40so24709514lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 03:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Cxm6iOnxibHlU5EDJ17psgT3RGiU7FkEbmZffAh1yI=;
        b=KPBr6446D/OMvXxTmiSEv8Nnl+Z19C+1C4ZgV0Opz39AibVv6Q1mVTIyYjARRdaF/2
         Nj71kA9vDUq68h3xoPaJT+JDSymlSU+d+74QRNO/bs9GSnBECPy8rEpGt5mWE0Xkpdtq
         g7oEb4EonaNpoVKwlNL38dHq0SE29BWHXhtzlECRg+zu4g8/jF+rRumsBDl5eG0tcLuA
         Y3QHBDSg2lFYgznHzmkoHQ7jDkXDRUoibVgiRQCHV9Urw2KJDYanN/ljX0cKoNjZA+og
         SWnQboO+sBG8nTj+sj4aYDtxxFNXCu/Wd9QiJzZm+TnzlPaxQQToPeKmDGrO74i8DLve
         dw4w==
X-Gm-Message-State: AOAM532l8f+71NzjTPABYDEo9aYIlpetL0EErXY6UjnpjCcK8mt5t8nC
        KbD5PlyMrJ/rBX2d7MFKI6k=
X-Google-Smtp-Source: ABdhPJyIh1mD+h3Mh+l0UYOEjyK2zUrsn/C+mdFcbhpGUBVAEN5sOhbUGwmALRqZhtk+wxXgp1VnGQ==
X-Received: by 2002:a2e:a451:: with SMTP id v17mr16377044ljn.85.1637236199648;
        Thu, 18 Nov 2021 03:49:59 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id j1sm283865lfg.154.2021.11.18.03.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:49:59 -0800 (PST)
Date:   Thu, 18 Nov 2021 13:49:51 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] regulator: Update protection IRQ helper docs
Message-ID: <0c9cc4bcf20c3da66fd5a85c97ee4288e5727538.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kw3Q4DtylVkgx81W"
Content-Disposition: inline
In-Reply-To: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kw3Q4DtylVkgx81W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The documentation of IRQ notification helper had still references to
first RFC implementation which called BUG() while trying to protect the
hardware. Behaviour was improved as calling the BUG() was not a proper
solution. Current implementation attempts to call poweroff if handling
of potentially damaging error notification fails. Update the
documentation to reflect the actual behaviour.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 include/linux/regulator/driver.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/dri=
ver.h
index cf87f435d7ca..ddbca4971f26 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -501,7 +501,8 @@ struct regulator_irq_data {
  *		best to shut-down regulator(s) or reboot the SOC if error
  *		handling is repeatedly failing. If fatal_cnt is given the IRQ
  *		handling is aborted if it fails for fatal_cnt times and die()
- *		callback (if populated) or BUG() is called to try to prevent
+ *		callback (if populated) is called. If die() is not populated
+ *		poweroff for the system is attempted in order to prevent any
  *		further damage.
  * @reread_ms:	The time which is waited before attempting to re-read status
  *		at the worker if IC reading fails. Immediate re-read is done
@@ -518,11 +519,12 @@ struct regulator_irq_data {
  * @data:	Driver private data pointer which will be passed as such to
  *		the renable, map_event and die callbacks in regulator_irq_data.
  * @die:	Protection callback. If IC status reading or recovery actions
- *		fail fatal_cnt times this callback or BUG() is called. This
- *		callback should implement a final protection attempt like
- *		disabling the regulator. If protection succeeded this may
- *		return 0. If anything else is returned the core assumes final
- *		protection failed and calls BUG() as a last resort.
+ *		fail fatal_cnt times this callback is called or system is
+ *		powered off. This callback should implement a final protection
+ *		attempt like disabling the regulator. If protection succeeded
+ *		die() may return 0. If anything else is returned the core
+ *		assumes final protection failed and attempts to perform a
+ *		poweroff as a last resort.
  * @map_event:	Driver callback to map IRQ status into regulator devices wi=
th
  *		events / errors. NOTE: callback MUST initialize both the
  *		errors and notifs for all rdevs which it signals having
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

--kw3Q4DtylVkgx81W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGWPd8ACgkQeFA3/03a
ocWN/Qf/WnmQq9PqJb99zC8iiyOdtP4183EboxxQfWMGzXRPr2wMOEpBZY87N2wd
0BW/voat2zccN8GzLfi1xZSSPCcXiP2tBK5FrpVaGPQcWmdaZhhj1D/F7V2N2rnH
MAev065scvHLfgn8ocLNi7Bv0XgSO0MNik9dODo5OaPlinlZM6td9sJ0jMB5950s
1E9X53eOt+h3i29BXH3abr0Gr2hJEn4UCMmsZ75yHaV3N35jjK9D9k9lMCvkuAGn
ScKwhGEYCzeuEvCGPkOC2PDn/ecWz/ukqWmIwJH24vkCztf3f27ME2vqQgn+NCbe
4tJ0d9S2qraidwAovBhslxZcPT3Y7A==
=JHsO
-----END PGP SIGNATURE-----

--kw3Q4DtylVkgx81W--

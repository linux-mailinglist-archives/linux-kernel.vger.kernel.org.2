Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D73A455AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 12:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbhKRLvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 06:51:12 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:37730 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbhKRLvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 06:51:10 -0500
Received: by mail-lf1-f44.google.com with SMTP id c32so24705630lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 03:48:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WjEPo+4pFXoa2OYpwI90zm5uszBj3a/lWeST2vrDunM=;
        b=wlk6Av7Rnsh2ktvm6kZBiN0f6oHsN1GsbPYmjxAOEN7STl7xB1p5vOJ6Fvzr+dzqUM
         5L1SPEoY8QGcow/0yCeVxe4YAgebP9N/isFIK4U+FxAfucjcazURN/bT63SiBTiDVnfn
         q0BAmoHptshGpZ3R+uHVk2M17NOTHNaKhL87FBMnEopM7xcT5+dVVyTGiRIsKUHBGoqY
         Y1Os9Nibhu9VHx+Mw+ilZbRllWc4/iddXmlUcKtUGzwsHwYIsWBwbHPzspkN1w9pOJri
         6wkJuxFKRNR5qpvqqeNZCh9q+VzFbK7EXOBvo/TYUdzQaND9DrYt8Qd7R1SuonRuYCLE
         fimA==
X-Gm-Message-State: AOAM531bvonmBuxAZUZHhxbxlS6dpaReyqqO7qvVQCJP15XgbHIkzpby
        skrQwlQPDmP53QsM+KVdesI=
X-Google-Smtp-Source: ABdhPJzK5ucCnEiXBwlRdOqshazDMWpzPuCSTJB6Ps+/+exokmqWZl5uUPZaHNVN8rjhibsf74NnOA==
X-Received: by 2002:ac2:4aca:: with SMTP id m10mr22971738lfp.437.1637236089160;
        Thu, 18 Nov 2021 03:48:09 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id s7sm253559lji.67.2021.11.18.03.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:48:08 -0800 (PST)
Date:   Thu, 18 Nov 2021 13:47:59 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Few miscellaneous regulator improvements
Message-ID: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v7yfdkaqYfY3ffMP"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v7yfdkaqYfY3ffMP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Minor regulator improvemnts / fixes.

This is a collection of minor improvemnts done while developing drivers
for yet another ROHM PMIC. Please note that the new generic function
added in Patch 2 does currently have only one in-tree driver using it.
(call added in patch 3). I intended to post this with the set of patches
bringing support to a new PMIC - but it appears this new PMIC requires
one more HW-iteration - meaning it will be delayed probably by months.
It'd be easier for me to add this upstream now in order to avoid
rebasing/conflicts with other changes introduced meanwhile. Please let
me know if you don't think that's Ok.

Patch 1:
IRQ-helpers do not really need to map IRQ to specific notification in
cases when the sole purpose of an IRQ is to notify this specific error.
Allow omitting the IRQ mapping callback.

Patch 2:
The new PMIC I am writing drivers for does once again allow (base) voltage
to be changed when regulator is disabled. Create a generic function for this
as it seems ROHM keeps designing such outputs.

Patch 3:
Use this generic function with the bd71837/47/50

Patch 4 & 5:
kerneldoc updates.

--

Matti Vaittinen (5):
  regulator: irq_helpers: Allow omitting map_event for simple IRQs
  regulator: rohm-regulator: add helper for restricted voltage setting
  regulator: bd718x7: Use rohm generic restricted voltage setting
  regulator: Add units to limit documentation
  regulator: Update protection IRQ helper docs

 drivers/regulator/bd718x7-regulator.c | 29 ++------------
 drivers/regulator/irq_helpers.c       | 52 +++++++++++++++++++++++-
 drivers/regulator/rohm-regulator.c    | 16 ++++++++
 include/linux/mfd/rohm-generic.h      |  7 ++++
 include/linux/regulator/driver.h      | 58 ++++++++++++++++++++++-----
 5 files changed, 126 insertions(+), 36 deletions(-)

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

--v7yfdkaqYfY3ffMP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGWPWEACgkQeFA3/03a
ocU0Nwf/UR0EUE+s97WaDjMeH7rbP8bhOEurT6SaQqS56Ex2SCSorWvadrsrsi8N
0vdpA6Ogf3jLWqmeqFVfTq7S3oP2rB8vQBQOVVDHH6eqQaTcwuy0bLNYwBuwONft
PW/4s+1CptSvczvFBqnHSNiGcCfbIDYbf0514cI8j77fSivOCLg6sDaJWIFXHwB2
UXT7/V9mctJiEJoFKkPy5NwyiLM1BOcNFWccA2c2a/hNIH4dzL87k3VqW4yXkpV6
1Gp9raBavkptu0TRw/btZPimjJk+5nj+FRmACjuqXZyyyTC7J5UUVrtegI7JT/Vy
06ncVBcebU3lYGpelbjPLemvETKYiA==
=yqIM
-----END PGP SIGNATURE-----

--v7yfdkaqYfY3ffMP--

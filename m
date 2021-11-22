Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECFD458CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhKVLG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:06:27 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:38709 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhKVLGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:06:18 -0500
Received: by mail-lf1-f45.google.com with SMTP id bi37so78805139lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 03:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2uO9K1+1EyUicJ86OxABQkv9usDmCdKPa9SivHe30SM=;
        b=ls7ebK4exc3fxpSwSnnZRNse2eW/CZCZpIMEtylTa+COffRJ7f4yf2nIBs7v9M4Ref
         R5gik8x2BSQM91NBYf1jpbbeuIsC/lIiU0q+1f1hW0hQ07OSogM2QEoarqSO1gaXHpv2
         36dKls/+uNmkSeFJFJl600V5nc+snwHbb3DuxjjxgRiXPgG5zx3ZqOPyTUr2BoGx33/Q
         4gHxGI15jqiH6xy12+3JVdqxDOEhHCxeoG73jijYqsuZ8y66g++tBrpnS5jnlwrxNilq
         uF51dDGja6jgh3z/o7ex1hkC1YvINhRx/D+bX/EhoP11puunoUc3EEqt7kmFBTnpDD0r
         gLlg==
X-Gm-Message-State: AOAM530VFhMqYdJrX//sSabkHlIhSGqjn6pJ39n1ZZpzRS0IqJJgTgS8
        d1usFqletJtTu5kR08irKUQ=
X-Google-Smtp-Source: ABdhPJz6dGVQQxeCE16bCoaZfJy6CLOZAJ5hxuV1iLOKhDayBloRf/A/W5AAQc8+f3MS2pb17w7uHw==
X-Received: by 2002:a2e:858f:: with SMTP id b15mr52067804lji.177.1637578990502;
        Mon, 22 Nov 2021 03:03:10 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id n15sm910391ljm.32.2021.11.22.03.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 03:03:09 -0800 (PST)
Date:   Mon, 22 Nov 2021 13:03:01 +0200
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
Subject: [PATCH 0/4] Provide event map helper for regulator drivers
Message-ID: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FSbosQ8Mp8Vk82Ue"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FSbosQ8Mp8Vk82Ue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Misc regulator fixes.

This series provides a trivial event map helper for regulator drivers,
new single_bit_set() (needed by the event map helper) and a fix to
regulator IRQ helper parameters.

Regulators which provide trivial notification IRQs can use generic IRQ
mapper. Trivial in this context means the IRQ only informs one type of
event, for one regulator.

The series also provides a bitop helper which checks if there is only
one bit set in given mask. This was believed to be useful also for
others outside the regulator framework.

Last patch is a fix for IRQ helper removing an unused struct member.

---

Matti Vaittinen (4):
  bitops: Add single_bit_set()
  regulators: Add regulator_err2notif() helper
  regulators: irq_helper: Provide helper for trivial IRQ notifications
  regulator: Drop unnecessary struct member

 drivers/regulator/irq_helpers.c  | 42 +++++++++++++++++++++++++++++++-
 include/linux/bitops.h           | 20 +++++++++++++++
 include/linux/regulator/driver.h | 37 +++++++++++++++++++++++++++-
 3 files changed, 97 insertions(+), 2 deletions(-)

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

--FSbosQ8Mp8Vk82Ue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGbeNgACgkQeFA3/03a
ocUP7wf/fm9TDeoKpFqeUKufqsIuRk0YoCsG9ZnzQBBzDBFxJ3YZbeqEY7AexgQR
2jQ8q0hQpKTtAmAZncOkENQucjm1/S49AZD45EmHp+kGLSGP9M6FmXiseWf/yz0Y
hAdfZU2FbUUkeS2CaV9eoOvHpQADNl47640uZVd2OnEbh8Rtf0YdJGF+CySTBroM
GjexQHZKXkD/D3srIv3bbXmlzmYd+q+oBUzwXXM8NtF1ejc8pyicd1Glm/poIM1A
nU5HpFRXGZJ8+7YQSXUTSP2GsWTDVptqboTiBhcipFbh8hzYDjko+FSDam9DXYOo
pInx465IPoFjpM3giaYSYlPUj2wHHw==
=8tij
-----END PGP SIGNATURE-----

--FSbosQ8Mp8Vk82Ue--

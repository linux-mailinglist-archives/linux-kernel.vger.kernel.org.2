Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7D139F338
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhFHKLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:11:14 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:39781 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhFHKLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:11:12 -0400
Received: by mail-lf1-f44.google.com with SMTP id p17so30422579lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 03:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=x0Bhz05IKdTNr57LviEu/A1ZvlgQ2LGE1gaNPef2MLY=;
        b=BkM8GgQhusUqfFBPFWR8m1p0zUd1sYuJHya6fVvV2O2F517SyQLSsdVU2OyQkr9t+S
         EFHs9rmBKOLuTKvpJr4Lm51cCiaoqBwTMUYwFU1y7jLFS0y1wv5YaUAaU2RlPi0wg+SI
         WH46vYB4GQC3S9/o+zoP/EwNqTrFS5aLMJ0isoSfyxl6lCprj/yTi6M1+qGBMEGJB9zN
         lQNZQgJDpZsuHsPSR3p8Jvmfn4t0uiGfNFU3gXTd/Ogc1u2Io9BPb6cBOnlRNtNi6cBg
         K2oTzHCba4xNBOpThYNGbxMdEhR0QP5gG01NjAmZgdMxL5agE78tmFZfgyYFwwOOiYPl
         ff+A==
X-Gm-Message-State: AOAM532c1s4QTCxSVn9eDVn1TLRiEDq4c0uGATghuMmOknp03d8xKbZv
        D4m6NsbVE6rFgeaylTrQyzE=
X-Google-Smtp-Source: ABdhPJwmBmevNrHjfO/Q1x/BaHwExCl5i8sTSYsvSYiDXoa345UfsiEThsSgKJYj8WejOBOg5VmN4A==
X-Received: by 2002:a19:8083:: with SMTP id b125mr14347496lfd.204.1623146959157;
        Tue, 08 Jun 2021 03:09:19 -0700 (PDT)
Received: from dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id n17sm1566589lfh.220.2021.06.08.03.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:09:18 -0700 (PDT)
Date:   Tue, 8 Jun 2021 13:09:12 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 0/5] Add devm helper for work-queue initialization
Message-ID: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This series adds new devm_work_autocancel() helper.

Note:
"The beef" of this series is the new devm-helper. This means that
normally it would be picked-up by Hans. In this case Hans asked if this
series could be taken in extconn tree:
https://lore.kernel.org/lkml/fbbfba71-bdcc-b78f-48be-d7c657adce61@redhat.co=
m/

Many drivers which use work-queues must ensure the work is not queued when
driver is detached. Often this is done by ensuring new work is not added and
then calling cancel_work_sync() at remove(). In many cases this also requir=
es
cleanup at probe error path - which is easy to forget (or get wrong).

Also the "by ensuring new work is not added" has a gotcha.

It is not strange to see devm managed IRQs scheduling work.
Mixing this with manual wq clean-up is hard to do correctly because the
devm is likely to free the IRQ only after the remove() is ran. So manual
wq cancellation and devm-based IRQ management do not mix well - there is
a short(?) time-window after the wq clean-up when IRQs are still not
freed and may schedule new work.

When both WQs and IRQs are managed by devm things are likely to just
work. WQs should be initialized before IRQs (when IRQs need to schedule
work) and devm unwinds things in "FILO" order.

This series implements wq cancellation on top of devm and replaces
the obvious cases where only thing remove call-back in a driver does is
cancelling the work. There might be other cases where we could switch
more than just work cancellation to use managed version and thus get rid
of remove or mixed (manual and devm) resource management.

Changelog v2:
  - rebased on v5.13-rc2
  - split the extcon-max8997 change into two. First a simple,
    back-portable fix for omitting IRQ freeing at error path, second
    being the devm-simpification which does not need backporting.

---

Matti Vaittinen (5):
  devm-helpers: Add resource managed version of work init
  extcon: extcon-max14577: Fix potential work-queue cancellation race
  extcon: extcon-max77693.c: Fix potential work-queue cancellation race
  extcon: extcon-max8997: Fix IRQ freeing at error path
  extcon: extcon-max8997: Simplify driver using devm

 drivers/extcon/extcon-max14577.c | 16 ++++--------
 drivers/extcon/extcon-max77693.c | 17 ++++--------
 drivers/extcon/extcon-max8997.c  | 45 +++++++++++---------------------
 include/linux/devm-helpers.h     | 25 ++++++++++++++++++
 4 files changed, 50 insertions(+), 53 deletions(-)


base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
--=20
2.25.4


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

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmC/QbYACgkQeFA3/03a
ocWVkAgAkgdmVUXw7/c2OcDYQnNDHZfPtRF3VqV3cPt8sd/ofPjq7WoWIJtVBF7d
QDA+KtyxJVhJFw/+1D0AkqRedbVmluO64Nw20amqvSEQlBTRfno3RDkyspXDPYkK
yyiD9b8g98GGVNmKRbfiZJzE9Gg3heO922R9kB36hBfrIbj6r6rTH+0glp3KDWwk
uLj3DRHWgyRi7PUVOQjcYfQr9IC9jzTnPcNXuQc/iYyDQN/iI5TGcd1V5NVIXi1M
CWvLdwDeHkfsjkHZXyOGiQvBNDlfYNCEJxhOF6qfPCLlmni1NkJ7KL5yG8iQcqhr
xnePyvmy290qVxn+tSX2saef5PE20g==
=wgrs
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

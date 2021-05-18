Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DAA3878C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349132AbhERMdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:33:11 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:45851 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbhERMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:33:03 -0400
Received: by mail-lj1-f181.google.com with SMTP id v5so11313502ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=U6gXrrpSi89wtHqkw9KgypBTUR8uSSzHumrX4PYBgUY=;
        b=U4tQqN1TKEi2r9zn3wCUleKSVoHdEfJZE0YImPb4aLGjeRq6uw+/cZqg5zujm6aUuE
         wCn0la/eNXdZgxnLSPpJtJNbjhkEBUtVg4RhKn2kQwy6SYRAcnUjt+FXW9m3hYSIPB+/
         f14l3U8Fb9tkVeh+LOH4UrAFAOgrDKqNmkeXx6KpgcPmL7kXn7/cgFGYpGdphVqUJrnR
         M4psx5MjVK32W90jY78UZFdX45X3Geww/2Ljws93cUzW4fl5oACHCBd/6hwu3nZHh8WB
         cB0tN9SZMeYElR1W0kteklLbgMiPiBBUuLNYeCUFMCY/uKiOuO70Ro1uTBKvks12YmSb
         OOeg==
X-Gm-Message-State: AOAM530Syswu0UCIaiuGKPwprmoph2JWzC85aTZYQK4MvIz7EskxKRat
        8TKXlV8TI0CB8WVRVrfDHNM=
X-Google-Smtp-Source: ABdhPJyHyXFqzfU32asVYpf0HUMJnGSSf61ZZ2+BdzH9P/d+esdFiC7ajqG8Qk/07W3cpuMOI6Hwjg==
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr3950221ljc.12.1621341104972;
        Tue, 18 May 2021 05:31:44 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::1])
        by smtp.gmail.com with ESMTPSA id f22sm2272967lfc.102.2021.05.18.05.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:31:44 -0700 (PDT)
Date:   Tue, 18 May 2021 15:31:37 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     hanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add devm helper for work-queue initialization
Message-ID: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This series adds new devm_work_autocancel() helper.

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

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCjs5wACgkQeFA3/03a
ocXp+Af9FUnvsT6iYZeynsTba1l9IMbQN64AaS84eJGdGYtaWW6XaVgVyaZ2Tlqo
9Mnudjq54zvg35Ht2cCuM67S8pQ25C2uU4pIBu1YIOtNKssEldbN2U4DX3QJoHtH
qhCeYqUIf5pfxBPOcAKl+DwGb+hMnYGbRQHumV/wt6kVavWIqvqHASnhLuXkZjLt
2lxYwOJ7KoLe07psHf9y3Nz5flJCRxElRLsYB0AplG+abq8vH9V36AHf3qIaWmsE
JU6KxgXtAJVsrln6b3OVracnYUv8PttnEH153t7E/k/5qsj/QqXShwL5hD6pIqQJ
7SBDj8lt6ArzFiVre11eIA8TB8SBYw==
=aJZx
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

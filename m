Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CE8377DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhEJIK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:10:57 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:40706 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhEJIK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:10:56 -0400
Received: by mail-lf1-f44.google.com with SMTP id c3so22038394lfs.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 01:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7tH4knyw6Whk885CsosqnIlAXCVU34LfnvgaVGiCFuw=;
        b=WZBWCz/LetCdIm7nesSS21mOYYHwoLSxxA8C+VYsgQPBvJxUx1vYpx70Wpywq3Lfba
         XX81iFL1VuvEYEq/tdhOqXYqfkg8CfICTFeb8KkwCjT5v/nv3Btu92+s8SRkuo/mHzTe
         +oyo1ZSXaJ8F+c/IJ3NOzHfe8r21dVHGE+C10yRLcfcPSqeH0ugeeFpQJOAJGK2V0xip
         ON1LMQiFE+ANtk1JgRkwJpaV7xuobaq+SCVHuxyKbyIm6pdHeVDf+DhbwqGANiATrxbR
         Qd8PuxxBtxXkdTRV8vCaopMnjx1RCdYV/LPWflLedlM6V5QAbg8FRGvYh4th1jleKNHV
         rtcg==
X-Gm-Message-State: AOAM531HXM3cbk4Vk7u9djeuhiRk3P4SSE2NPZnMSomlPt7hFSHQR26N
        ADu+KbIuG+gHbnNOW8suHE8=
X-Google-Smtp-Source: ABdhPJw4A5KR7TOxZSfAeiPBFk/0O1sO73gIfTZQHHXVa0j/o4I5cBZr2ajPoyRUjV10kDoAFxB1jg==
X-Received: by 2002:a05:6512:791:: with SMTP id x17mr16791596lfr.661.1620634190611;
        Mon, 10 May 2021 01:09:50 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id v8sm2560614ljj.137.2021.05.10.01.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 01:09:49 -0700 (PDT)
Date:   Mon, 10 May 2021 11:09:42 +0300
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
Subject: [PATCH 0/4] Add devm helper for work-queue initialization
Message-ID: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
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

---

Matti Vaittinen (4):
  devm-helpers: Add resource managed version of work init
  extcon: extcon-max14577: Fix potential work-queue cancellation race
  extcon: extcon-max77693.c: Fix potential work-queue cancellation race
  extcon: extcon-max8997: Fix IRQ freeing at error path

 drivers/extcon/extcon-max14577.c | 16 ++++--------
 drivers/extcon/extcon-max77693.c | 17 ++++--------
 drivers/extcon/extcon-max8997.c  | 45 +++++++++++---------------------
 include/linux/devm-helpers.h     | 25 ++++++++++++++++++
 4 files changed, 50 insertions(+), 53 deletions(-)


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
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

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCY6jUACgkQeFA3/03a
ocUJtQf/YgMQAiZZvZ/35XkaFRdxSQFHYqF+lXZd2JPZNUfD4VdH8Ur+uzlo9kEF
MKaFAdUyZaFp49CtZ5VgDx63tQUVRsTsWfVQG/958g5XoYb7twVAnxDudCsAXbBx
zHuAtIQT0EU3MQObmBMQv74HDkVUkt05z1IuiYtC+ahuyeHAz7Ax97n8/jfpKG7p
vJTNc48q0ehoSSo7c1Ykn5XeGekBeWtEAQowg2XJ32LheyJmc2tIeUdKiUpbeiU8
rcNfrM2T6rjyKVjbFDKYPpKjL19jz3x7sspryV9jJ95A5H+6UWwzN9HrRyCzoIqT
qQ9zhz+PB8iHWSjYxLBfV6H5duEIXA==
=iLmi
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

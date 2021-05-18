Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D83878C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349138AbhERMdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:33:25 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:43920 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbhERMdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:33:23 -0400
Received: by mail-lj1-f173.google.com with SMTP id w15so11315602ljo.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m3O3uuc1lsxcVKAp+gTgPGUKzpVh0qjcS5oeKkSB+I8=;
        b=Lald4TM+ScyLs5XHPpxXOvBd4NBTgfYp6rIXS/i6ZMNMVNAGW4jn8S4qPJJ2upfUJP
         HfL0lJh1CQgw6F+Neq5zfwIjgI8sjwym2+0fDvU6uZSTja7U8rtALV9rXAY5UBeEBvAB
         zPmeNxfrUk+VmT7EdfcA5MEGouRhZ5M/NJdlnKDPuUO93JMPsctidNZtRtUHBwBksZav
         WJqJVqPkSIWYdg2y90lO3bG2rzisAPlEHxOWI9HAWU6qGGuMQ3oqEjadh014/39gLgk6
         2L6F0Zsm42jLQY8LZu0M6I/jxXp6Z4RovqOZMNFuaHqMV3rFUo/MBTs2KF6M2HcOyCaO
         L16g==
X-Gm-Message-State: AOAM531IZKisnjWD2S1AY0d0JqODpCo3zEdNtYdp4a+x61CXjuESW/EO
        lNYRxXKf/9UlRtQOiQ/lY+Y=
X-Google-Smtp-Source: ABdhPJxUSPeL2jQakCuWquNNceCMrWj4cubjOe34vvY6h3r4AOWGJYZif1kXqIfXphyPGqRbjYoaZw==
X-Received: by 2002:a05:651c:2047:: with SMTP id t7mr3702329ljo.446.1621341123814;
        Tue, 18 May 2021 05:32:03 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::1])
        by smtp.gmail.com with ESMTPSA id z20sm2122972ljk.123.2021.05.18.05.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:32:03 -0700 (PDT)
Date:   Tue, 18 May 2021 15:31:57 +0300
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
Subject: [PATCH v2 1/5] devm-helpers: Add resource managed version of work
 init
Message-ID: <c9a85344a2f280a6b60886eb44075a1563e5bd9b.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A few drivers which need a work-queue must cancel work at driver detach.
Some of those implement remove() solely for this purpose. Help drivers to
avoid unnecessary remove and error-branch implementation by adding managed
verision of work initialization. This will also help drivers to avoid
mixing manual and devm based unwinding when other resources are handled by
devm.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 include/linux/devm-helpers.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
index f40f77717a24..74891802200d 100644
--- a/include/linux/devm-helpers.h
+++ b/include/linux/devm-helpers.h
@@ -51,4 +51,29 @@ static inline int devm_delayed_work_autocancel(struct de=
vice *dev,
 	return devm_add_action(dev, devm_delayed_work_drop, w);
 }
=20
+static inline void devm_work_drop(void *res)
+{
+	cancel_work_sync(res);
+}
+
+/**
+ * devm_work_autocancel - Resource-managed work allocation
+ * @dev:	Device which lifetime work is bound to
+ * @w:		Work to be added (and automatically cancelled)
+ * @worker:	Worker function
+ *
+ * Initialize work which is automatically cancelled when driver is detache=
d.
+ * A few drivers need to queue work which must be cancelled before driver
+ * is detached to avoid accessing removed resources.
+ * devm_work_autocancel() can be used to omit the explicit
+ * cancelleation when driver is detached.
+ */
+static inline int devm_work_autocancel(struct device *dev,
+				       struct work_struct *w,
+				       work_func_t worker)
+{
+	INIT_WORK(w, worker);
+	return devm_add_action(dev, devm_work_drop, w);
+}
+
 #endif
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

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCjs70ACgkQeFA3/03a
ocWjqwf+OPxXtqU46xdpV/uhzcGHvxZLr/FoKPpKD7aLi/trCQjnQKg6+7839ADt
13NdZuVhbU5Yi0L76MLpqOdOANtfw5l52oZiR5fT5jXpWz0MZgtvbEgFB+B/QEsp
/9I1hs5JoRoKPrl0jIv+01uItubjiHzsCVRqGkngMeYWbcJmR5HTVx/BNngx84ST
tQaGwRcBXZ189jDQD9/NMFyH+8IEmnFf1uQA434Y4F2wTPSkZ13zACwmCA4M/yAw
gTHuH4BT/9Kulgjs6hij2D0xgT1aGp0W7Pov4huFcGeCD4Vg7sfBYUM2SVMeZWtM
cL+kIB8I36QdTW9piNcbmuC3y7YC0A==
=pr/G
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

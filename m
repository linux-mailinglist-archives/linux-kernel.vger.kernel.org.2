Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB05377DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhEJIMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:12:10 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:39840 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhEJIMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:12:08 -0400
Received: by mail-lj1-f174.google.com with SMTP id y9so19706790ljn.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 01:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T2RRW0h88ZXeJPK5vS4HJQzRpjJqgpWiS/CVUpEBoKM=;
        b=m4XK2t0r+86FEHTk+on1YPnqILmUS5yK5rk6CfbCxCZufUpMvl1OQRV1qgHQt/etHB
         ce4/BoTuiVcc3HqP7OLwHm6YCV5QR/eZ2b1d+7DXTiKCI0MTvlNsAmDUQR/j7h+et+q3
         O3d0Q6jmttM0bAwFb4CLi4vfMGMQtc7uvZ8NBu2UvMiW9syX75eclNGCsbM3plJpPoTo
         SFhOpH6Ka1uQsBMWd+a1ULqwFsdTVK2N9a7OCM1uRDI2RnCMOpL+GGE4UTqN7GFcsWyH
         /528ybYfft3xwL0th4WjnBAMriX37c7kvmiUcJ6KjzknxT+3xfYwXg3ZPjWpJFRkcnHi
         08/Q==
X-Gm-Message-State: AOAM530f0nLnuLA1EqedB4ByQhJPP+SzfI21z71KqMDL3R4BDG1NBKTv
        HKMSw+dSSmFb0SQVy5gfLIY=
X-Google-Smtp-Source: ABdhPJyTkgEwS1M3KSdCFi2LNKvFE4CwoJqV65NG7Sn9q+Hwasaa6Fl64V2xDphte1MGJAuFkYy3AQ==
X-Received: by 2002:a2e:b0c2:: with SMTP id g2mr19029800ljl.492.1620634262782;
        Mon, 10 May 2021 01:11:02 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id q20sm2174231lfm.194.2021.05.10.01.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 01:11:02 -0700 (PDT)
Date:   Mon, 10 May 2021 11:10:55 +0300
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
Subject: [PATCH 1/4] devm-helpers: Add resource managed version of work init
Message-ID: <82a9670d02ae96de4976c655d97b74c4a137f145.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
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

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCY6o8ACgkQeFA3/03a
ocW3qggA1VTAbi3U5FOcBGvMft5pSzZ4AyfA7SmxVrZCNlllbTnVSs5OO5yE/N7J
vG7mvpqL7ESpiAFm+aJusxmSWTMziixs8vM2qge3HXFKuSK4BzWkLXIIV8w8ZEaE
7k34mguDmNPEbRAV9cQDpLYJ0xQDzBvdm7m6fBD22OaQbcCcZqMg6fim9HPBVokx
4QLzkPrLZEwVhbXmw1hL4hqbBUIIGAhjIFjxYFtJ9leDMdTTC7O9wigdaH9eUful
Gj1Gu4TSWmwbT9BuF+JQtAa4vZfDc5sdlrdrJdWNVZH/R8+H/P/sK5jyoIe8Nyd8
csxqUuXIWyESROsxGs0pPfOoaxd+SQ==
=fqDY
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

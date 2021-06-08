Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F71D39F339
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhFHKLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:11:38 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:46830 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhFHKLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:11:35 -0400
Received: by mail-lf1-f48.google.com with SMTP id m21so15477843lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 03:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0p4gNJywAN3I6UnH9N1ZNXkMA7T40D7e5tXK5aYE/i8=;
        b=M/dtGJ8TQlqSMrcFirIULbBeXB0NndIdhhRjFYDtwjFjheIEc6/P8E4xCwA/1/TZq2
         X18hhmPpD7uBv9+qKP+JTt623mo1AWsjNCk3JxeCiDw/pd8WL9IbDyVNLRiSypHsfo1X
         e3N7JRM7Y0t2L6wZJ6p3kQPgvIyQryAyqiOKN7k2RYx8sUh89IWXmjkzy/hMzGZ16qpb
         NzMr81NZeJuB69XVPLd44L+Nc2YT4bBDozR9B+WNV8fqn6sN7Eaxom0tf3w3x++9v8G+
         e/l4+zDkPM2ekxjUUzSPnMHLtOdEOsRz8ZITOXG1z84bsYoYH7UPZSn5BRdgWv5dyeqK
         kjYQ==
X-Gm-Message-State: AOAM5323OpWgAjvgXGrqlUiG8KO07TMM2xdn2/2Ofop9gTFItudLRLNO
        XOQjBA0rLprvmS9OUv73NdI=
X-Google-Smtp-Source: ABdhPJxogbHzYrmmvbnW9SikO5L9bstP7FTxJHVumR5EWCeUc7Ovx/bKTmCloyEn2/rvmJubAPHdZw==
X-Received: by 2002:a19:5e18:: with SMTP id s24mr15251819lfb.545.1623146981981;
        Tue, 08 Jun 2021 03:09:41 -0700 (PDT)
Received: from dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id l3sm1964503lfe.230.2021.06.08.03.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:09:41 -0700 (PDT)
Date:   Tue, 8 Jun 2021 13:09:34 +0300
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
Subject: [PATCH RESEND v2 1/5] devm-helpers: Add resource managed version of
 work init
Message-ID: <94ff4175e7f2ff134ed2fa7d6e7641005cc9784b.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmC/Qd4ACgkQeFA3/03a
ocVfjAf/TXwSLAWwMrpwPhfRWyy2kMdMH1Z8G20g7aQ+1aF7/w5iyhtX4YoXFeiM
p0YaVSuKrDKNTOo3/HPpoinlkns1hUBnP02qbUnoFs5A8fqpx8/cdEaTJ5E5Q1eR
EatkB3Kz0CEerT17/yGZ32WZfyPH1w6QtqETkvuaJC5sijG4Bqgnq6w7Dt6UeQqq
IkAuo5aD6xnf/400KYA8TQ7Ik6VEZ3VjybCSohYgJ2iFhdEnEGVgU/bDlSZb3bwu
Jm9+C/yrmkmD58MT8YdIRTD9u98Jx6JTp8OV1f4oCg5CtHa9WAQQ3Surku6J0C06
DLHbJr6TS53SDeOusMkSp93RiS9d8Q==
=p2gc
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

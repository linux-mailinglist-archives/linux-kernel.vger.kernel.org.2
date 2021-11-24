Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1436445C2F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 14:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347981AbhKXNec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 08:34:32 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:42858 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351391AbhKXNbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 08:31:31 -0500
Received: by mail-lf1-f51.google.com with SMTP id t26so7185270lfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 05:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=epjy1aOQZHu/xXQzL3GUzpYTVb+f377L0blx6kRXmRg=;
        b=CzKlpH3ZAkTPj78pJt7ezkANNnvVAcOyRuHzVQ0sm9CC68RRyeuagXVjreBdjcSVRA
         cSOw5eSSNmoGQxA4CjajXKYmE2I8sTAl9bvZ/0u5ZENcubhWKMuCdFkXBI90jKR8AcRB
         tMxr9b1BILt6qpDirCWPTTdyNcrnQigIVtFGxDT9Prr+5/Ki77xYZiJj7jd95Qsk9umh
         hQTICU6PnVHhNGtDZIgVUxLUWOUpbH8wx8J8kD+XsFs06MAGLwKfc8Z+8yReGdcra9U1
         hVGYov0sBiZ8yhQfClXFUn5MEjjHsjtgyj78KbqeaK7incwUY0WpbC+4uvUnoZG3JRN2
         PCag==
X-Gm-Message-State: AOAM532E7Uk3h2J5K0F0S+hXVHLyKDhmfQdPuklVSjBxd1EalpdGZ0g/
        zQYCw8JM5hAIvaPmRfN4Yx0=
X-Google-Smtp-Source: ABdhPJza90Jj5jsFmnLHH+m7IIe3fqkjAthIJ4glV3qPi9a4jvqMMXcIht0I6M57q/rfvbRhwiS+cQ==
X-Received: by 2002:a19:ca10:: with SMTP id a16mr14870024lfg.96.1637760492949;
        Wed, 24 Nov 2021 05:28:12 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id f19sm1616781lfm.119.2021.11.24.05.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 05:28:12 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:27:58 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Craig Tatlor <ctatlor97@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Prashant Laddha <prladdha@cisco.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fixp-arith: do not require users to include bug.h
Message-ID: <YZ493geVwvenRxWx@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fSeqgrcYP7RTxlQ2"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fSeqgrcYP7RTxlQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The fixp_sin32_rad() contains a call to BUG_ON(). If users of
fixp-arith.h have not included the bug.h prior including the fixp-arith.h
the compiler will not find the BUG_ON. Thus every user of fixp-arith.h
must also include bug.h (or roll own variant of BUG_ON()).

Include bug.h from fixp-arith.h so every user of fixp-arith.h does not
need to include the bug.h prior inclusion of fixp-arith.h

Fixes: 559addc25b00 ("[media] fixp-arith: replace sin/cos table by a better=
 precision one")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 include/linux/fixp-arith.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fixp-arith.h b/include/linux/fixp-arith.h
index 281cb4f83dbe..e485fb0c1201 100644
--- a/include/linux/fixp-arith.h
+++ b/include/linux/fixp-arith.h
@@ -2,6 +2,7 @@
 #ifndef _FIXP_ARITH_H
 #define _FIXP_ARITH_H
=20
+#include <linux/bug.h>
 #include <linux/math64.h>
=20
 /*
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

--fSeqgrcYP7RTxlQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGePdIACgkQeFA3/03a
ocU1EQf/Wmq/s89GlVG+2iNaGzoFswIhbupI/VJi+8uw19RquTf4cYAZ6+xwAAeC
IM+LTAKq3yUbMtGpoEQxdx617kMh5u5+9NtweUFEUbvPFA2M/kNESoiOzAOEY2r2
uxvJ3O1DJP6cqfdcmQnZeUw00XnxBdlf4z/ZHB0RYFAGeWGUJlvJWuX3DB7CDvjY
mbeIMZun4gclYLBTyLotOOUpkFEviNWmM59xZMpdxB/2E4+HdS7lkioX23Bie6Fd
yghGzj/TAUlI34zQO6I+y5ApdIS4YADO1DD4Xo71pLc/6nyJekiVX8s7H3dKzoZX
QaPKLG9TPOLyGIk2NvpKAG7THhafFA==
=ud6k
-----END PGP SIGNATURE-----

--fSeqgrcYP7RTxlQ2--

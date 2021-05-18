Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBD23878D8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349263AbhERMev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:34:51 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:33785 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349182AbhERMeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:34:24 -0400
Received: by mail-lf1-f43.google.com with SMTP id h4so13945091lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gsf/m7mIQ6PYu5YbvaOuD/pdRJemWposwKmnveF4B0c=;
        b=oyyPy0s0c0yEjUEzHu3NgJalSRgBHsGRtfpvBVd7CyX2T4/ElhuCGqFb6Ay3PgDB/M
         PcHOOh+mEQ494mJ+gKacq5uWjIBQ+oGbryeiyl326FuhFXDJ//Zm7fC0MqNTPTUB95g6
         5kPH3L955ve0VcMzwc17YqP11pDN5JEJe01Py7koDGDRFoJnOKQqpfy0o8Gi/0CvBFpT
         yQVIi23bTWyqwRa0gVfg7rqFf1Hv9zA9MNEZ8NfOT/VKnepra6sMp6Jv0UDaZ4LLFGpu
         9HxQyojE6sesIjSwloz54bKVEQ6qIXN7e+dtTkQKzv3dp3zDwiMHXq9wJzQVAsoXvT3+
         WsEQ==
X-Gm-Message-State: AOAM533TPmqkXH2u0IZtKBSSCFQemamXRl3ApvHNwNsW9yf21yTS6/iT
        t3wxJ1H0JpRyFspmMxMJSf4=
X-Google-Smtp-Source: ABdhPJyGBoK8AVZK4ifpwDy4Bj4ZXJ+xHgLD64wSgxML3iIZyyxEEReem3gHLrR9j0pEuFjz8R0xxw==
X-Received: by 2002:a05:6512:ad2:: with SMTP id n18mr4202898lfu.608.1621341185312;
        Tue, 18 May 2021 05:33:05 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::1])
        by smtp.gmail.com with ESMTPSA id t10sm3294683ljj.44.2021.05.18.05.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:33:04 -0700 (PDT)
Date:   Tue, 18 May 2021 15:32:59 +0300
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
Subject: [PATCH v2 4/5] extcon: extcon-max8997: Fix IRQ freeing at error path
Message-ID: <1a0f3e0d3c9786f97a0a041469a52ee145712619.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If reading MAX8997_MUIC_REG_STATUS1 fails at probe the driver exits
without freeing the requested IRQs.

Free the IRQs prior returning if reading the status fails.

Fixes: 3e34c8198960 ("extcon: max8997: Avoid forcing UART path on drive pro=
be")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
Changelog:
 v2:
   - new patch (avoid backporting devm_wq just to fix IRQ freeing)
---
 drivers/extcon/extcon-max8997.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max899=
7.c
index e1408075ef7d..c15a612067af 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -733,7 +733,7 @@ static int max8997_muic_probe(struct platform_device *p=
dev)
 				2, info->status);
 	if (ret) {
 		dev_err(info->dev, "failed to read MUIC register\n");
-		return ret;
+		goto err_irq;
 	}
 	cable_type =3D max8997_muic_get_cable_type(info,
 					   MAX8997_CABLE_GROUP_ADC, &attached);
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

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCjs/sACgkQeFA3/03a
ocXlewgAufKhlFYpINVhcR2XVpvTVYevE7AUXdFlKDEH65bRVtIb2BmwjY7oR53t
OSPJ68wHpR3toon307/LsvQNGrmekfTGYDnr+6unpqic9kj7s0D/b4XXcOxOBcMw
FJPb3BS93qcGHpPMuppfho1meog797HLTUlZ/T7DJaxGComRgB1jeDXWZP+sxg0/
9Dz32IaaP8bBG0ZAPnyuYKO4IBiXrM+LE9oL/yj7WVkqRObI4VlpnF9OtrdU0q51
jq9k3uFqbfodgC3ocDcOOW41ZrdQr3CeY2JRAz1iMy2HgsNZ9pj0rDijannwb9vm
A9co4k3lZdRErNm2akVFu2/Xr0SPlg==
=uXtA
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

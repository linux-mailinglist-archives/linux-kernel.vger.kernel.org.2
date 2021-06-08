Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE0739F33D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhFHKMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:12:34 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:35490 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFHKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:12:32 -0400
Received: by mail-lj1-f176.google.com with SMTP id n17so9115770ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 03:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hC/bUTe4C3Mf/fq6tr+MOBpjPKYzbk4EZErkWwBrNCw=;
        b=EFF9qlFQkmafhwnN0e+tG75fozohVa9VqXVDeop6+qR+pQh262mPYkb/kGjW3n0WGO
         YnsnEXhYi4wVD/tJQmUll6YUaE/mGhVr1rBfr/nGKkhZUZRWHTzoF5SbQ4AFy5e5jcuJ
         xhQ0Z2MZieWD2Mo9m62p30XqI52KuxWwIW8g9L7Tp4OeU2ZXhDaTaS8bCSwfAAmNyH9O
         s7v3XZckin8V7vcAJVuhpjfYeWHVhBtY6xa0Q9DMFkb1uWe3DL1HpFF5V7Idd2vL/U84
         xXGxxLfhIE79ZW64rmqbOG6+NAE8aAbd1MgK/VbeQc8ulHo5lznhSuXAtLDkO1CjkvPA
         FWIQ==
X-Gm-Message-State: AOAM531FCsRMns8CxUMrQTFXlqdhNRTNB5L9XKM8fFaCsSOHwdqh77KZ
        jygFuTg8imln2TQEIfW45+U=
X-Google-Smtp-Source: ABdhPJxDHwCSXj094RVo/hyImgBn8gHmy2+STgMJOdKEN5tCbdcFnVglG6u/xb6F9hcE5jUooHIwzQ==
X-Received: by 2002:a2e:82c5:: with SMTP id n5mr17840837ljh.191.1623147037594;
        Tue, 08 Jun 2021 03:10:37 -0700 (PDT)
Received: from dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id w41sm1838416lfu.88.2021.06.08.03.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:10:37 -0700 (PDT)
Date:   Tue, 8 Jun 2021 13:10:31 +0300
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
Subject: [PATCH RESEND v2 4/5] extcon: extcon-max8997: Fix IRQ freeing at
 error path
Message-ID: <27ee4a48ee775c3f8c9d90459c18b6f2b15edc76.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If reading MAX8997_MUIC_REG_STATUS1 fails at probe the driver exits
without freeing the requested IRQs.

Free the IRQs prior returning if reading the status fails.

Fixes: 3e34c8198960 ("extcon: max8997: Avoid forcing UART path on drive pro=
be")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmC/QhcACgkQeFA3/03a
ocXqIgf/ezmPnP396g//POOJDYK3Os4RZ4WtBbGr3Z4ej3uaShsN24XWDHS/kLGJ
Zh8WkHs4XzaYojkETufKbk/ILRdlyrao3QPlVpB6SRDAwEHnIGyBu/FUowHe1SbZ
fH/wA6mdNj7iErOJzuwT+DzjNLfzDM5Qs5qGohKA+wObQGOYDwoX258dbFC//3Dn
4iblO/E53Mxq1ke13FHGpTSUb1PW9+0asz8zG0qBoU5KI7cyAjZLQF2mMGaGuXWH
eycUVvJGkeIGzkcUBRVgQ/L3bPSnAp8w90d0Is3lANR9PuSTOST/rPvzk6xi6OWQ
PtyZsbw8JC0jUPsM9SOPN0q4ZUbfAA==
=3tDT
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16AA312202
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 07:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBGGfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 01:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGGf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 01:35:29 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7FCC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 22:34:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DYKBr1zhHz9sVF;
        Sun,  7 Feb 2021 17:34:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1612679685;
        bh=bpQveLnpCX/LNAs86JjxKwiHHv0Svm2bvTC0YEw3Wto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tyeLaujk/FYKEzkPpmotleIQVxdKhwoqTMo+WuJt2D5i0Wv9YfI9jiuY2fk2Fz1Vm
         pQ1mD1JRuAWCZC913yM4mpWZ6/1t/W2PE6IE1r18K9pf8LoE1TIQ6kES94o0HFkk0p
         QXF9Z66issAmayQ8KaQm6wxV7H4nSFUG2shm0wTJ1WZh7UFq7uxPzldd4aWWEoHwWg
         fFT7sIUtbXiiZ5cYzYlNvj1EiaoxZrXDJJk58ws8Emc4a97je+c5Pj64vCAtcmFSvg
         +r3YrF1sUN8qSkHk6kOUzWb3g2i5mNTE4x+CuEe5t95FWRkXX9WEFQy6V4Iut5jOsJ
         x2ayIAl8sWvrQ==
Date:   Sun, 7 Feb 2021 17:34:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: emxx_udc: Fix incorrectly defined global
Message-ID: <20210207173441.2902acac@canb.auug.org.au>
In-Reply-To: <20210207000030.256592-1-memxor@gmail.com>
References: <20210207000030.256592-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EFly7mjZir32_rG.96/uofl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EFly7mjZir32_rG.96/uofl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Sun,  7 Feb 2021 05:30:31 +0530 Kumar Kartikeya Dwivedi <memxor@gmail.co=
m> wrote:
>
> The global gpio_desc pointer and int were defined in the header,
> instead put the definitions in the translation unit and add an extern
> declaration for consumers of the header (currently only one, which is
> perhaps why the linker didn't complain about symbol collisions).
>=20
> This fixes sparse related warnings for this driver:
> drivers/staging/emxx_udc/emxx_udc.c: note: in included file:
> drivers/staging/emxx_udc/emxx_udc.h:23:18: warning: symbol 'vbus_gpio' wa=
s not declared. Should it be static?
> drivers/staging/emxx_udc/emxx_udc.h:24:5: warning: symbol 'vbus_irq' was =
not declared. Should it be static?
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Given that drivers/staging/emxx_udc/emxx_udc.h is only included by
drivers/staging/emxx_udc/emxx_udc.c, shouldn't these variables just be
declared static in emxx_udc.c and removed from emxx_udc.h?

> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 3 +++
>  drivers/staging/emxx_udc/emxx_udc.h | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_u=
dc/emxx_udc.c
> index a30b4f5b1..6983c3e31 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -34,6 +34,9 @@
>  #define	DRIVER_DESC	"EMXX UDC driver"
>  #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
> =20
> +struct gpio_desc *vbus_gpio;
> +int vbus_irq;
> +
>  static const char	driver_name[] =3D "emxx_udc";
>  static const char	driver_desc[] =3D DRIVER_DESC;
> =20
> diff --git a/drivers/staging/emxx_udc/emxx_udc.h b/drivers/staging/emxx_u=
dc/emxx_udc.h
> index bca614d69..b3c4ccbe5 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.h
> +++ b/drivers/staging/emxx_udc/emxx_udc.h
> @@ -20,8 +20,8 @@
>  /* below hacked up for staging integration */
>  #define GPIO_VBUS 0 /* GPIO_P153 on KZM9D */
>  #define INT_VBUS 0 /* IRQ for GPIO_P153 */
> -struct gpio_desc *vbus_gpio;
> -int vbus_irq;
> +extern struct gpio_desc *vbus_gpio;
> +extern int vbus_irq;
> =20
>  /*------------ Board dependence(Wait) */
> =20
> --=20
> 2.29.2
>=20

--=20
Cheers,
Stephen Rothwell

--Sig_/EFly7mjZir32_rG.96/uofl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmAfigEACgkQAVBC80lX
0GzVdAf/ZuxHC/+djnJBoVnV7z59At9u7Ao6hlXOy+Omihl76+GejLqgXsUDFyAy
04/F3n6OWtDkiMZPG49RD+njyHOO2SwqHX1ENT5c+QGNS2nTFQktmZl3oNENXwzZ
HDWho0eZZllZocQL9gqbyzSO5gFlfSOM92uyhRfGonZ34KKiPKSLo7xwG0bUFpdV
arQ2ILJf4a4YHubchu8DV0e8Q7L/ji3wDZOEyu8QukCSSWo2M+yoar8gUGaFmDc5
KnHIKnhmMrP6ySYHLQHzKF4GfytLeWCZGHsPcLECpJmYxFkv6hPaTUAKo7XFW9g7
BNjJv3E6K8HoRsOpESAeOdok2KK39Q==
=fhfA
-----END PGP SIGNATURE-----

--Sig_/EFly7mjZir32_rG.96/uofl--

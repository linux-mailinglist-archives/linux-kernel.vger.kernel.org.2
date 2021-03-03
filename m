Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F1932C49A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446549AbhCDAPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353558AbhCDAFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:05:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7A9C061793
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 15:45:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id i14so5217775pjz.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 15:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=viX38uAFosgjfxzIEwtp5/9ccsD8S6gdRKmkOGqC4ZM=;
        b=tFw0tarov1iJTLDTtNFsY2OxaIaZkTz7n2/ahcBHcHPiq9cvYu60bFUCM4aRbJGqlZ
         as3OtvGnOee5YgEPLwEkaHn1SKn1xzvecBx496QS5UY4NzAn2gWyhbF0RgJyPKxBxav+
         y43XeDofv7CRWcYyMPhmufgMMue8wz748Nqj7aQoTa4yFpY5i3Ub2SnesvOCHWuK354l
         PofuS4LjSPn0ExF/HAhym9QS0VNGjR1Vji4fSbQWFasw/0gfkEZiDdcxPh6nmOxBd4qp
         Jm6KmxgroFH/aUjq5D3q7j9N50r3xDphm12o5ViVf10BrexxBkEB9n0KC2x6isEpzxn7
         UJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=viX38uAFosgjfxzIEwtp5/9ccsD8S6gdRKmkOGqC4ZM=;
        b=oTtpB3NHLM4cYlrG6S7ie4vS89rmcO+AG6duFuxhY1ZS7IJ8uKvF5VaLeoNAr6m1f8
         rtuh5EEjNrqKVEZ6x9WJDkHUqPNrniqsJjTWkm9esm/Fc9+ASVBF8bR8H0Z/dpYGNr9d
         KnW/6SWlPstu7Bo1isSq9lIUzO6S6Y3/6JiskQXh7fp1xXHyUlA/+lwhBbied+vCCW/o
         h3SO9DwSmur0CA/blc7WAzNHvp8WN9yRwDEzzhzDYdxtv9YQOBFjbVHKnD7PFeUtzHgs
         K/yqzIGgwAp6A08qGgqxzIWGBiOWVRs6j5hi6Jp5V3zN351EUnUhs7AR8T5ckkRjZc/G
         XoDQ==
X-Gm-Message-State: AOAM530Ezp0sU+P4POLQGnGNdAVhvExxGUNrQRwU0i73SwTcDFv2x489
        sv8BXVHW02s6a2DOQohELFk=
X-Google-Smtp-Source: ABdhPJxn3OSRLrQuZ4nBXaa8upf3S/fO9o5Z1S7dSoMRGMJjVVU9S7YOZ/bt29oVlETpRFTHHd/vBQ==
X-Received: by 2002:a17:902:b601:b029:e3:7aab:704d with SMTP id b1-20020a170902b601b02900e37aab704dmr1485394pls.58.1614815148698;
        Wed, 03 Mar 2021 15:45:48 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id q15sm8823607pje.28.2021.03.03.15.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 15:45:48 -0800 (PST)
Date:   Thu, 4 Mar 2021 08:45:43 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     lee.jones@linaro.org, alexandre.torgue@foss.st.com,
        mcoquelin.stm32@gmail.com, olivier.moysan@foss.st.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] mfd: stm32-timers: avoid clearing auto reload register
Message-ID: <YEAfpzWhfkfh0xTs@shinobu>
References: <1614793895-10504-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ufg0QVK99FQVDHYN"
Content-Disposition: inline
In-Reply-To: <1614793895-10504-1-git-send-email-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ufg0QVK99FQVDHYN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03, 2021 at 06:51:35PM +0100, Fabrice Gasnier wrote:
> The ARR register is cleared unconditionally upon probing, after the maxim=
um
> value has been read. This initial condition is rather not intuitive, when
> considering the counter child driver. It rather expects the maximum value
> by default:
> - The counter interface shows a zero value by default for 'ceiling'
>   attribute.
> - Enabling the counter without any prior configuration makes it doesn't
>   count.
>=20
> The reset value of ARR register is the maximum. So Choice here
> is to backup it, and restore it then, instead of clearing its value.
> It also fixes the initial condition seen by the counter driver.
>=20
> Fixes: d0f949e220fd ("mfd: Add STM32 Timers driver")
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/mfd/stm32-timers.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> index add6033..44ed2fc 100644
> --- a/drivers/mfd/stm32-timers.c
> +++ b/drivers/mfd/stm32-timers.c
> @@ -158,13 +158,18 @@ static const struct regmap_config stm32_timers_regm=
ap_cfg =3D {
> =20
>  static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
>  {
> +	u32 arr;
> +
> +	/* Backup ARR to restore it after getting the maximum value */
> +	regmap_read(ddata->regmap, TIM_ARR, &arr);
> +
>  	/*
>  	 * Only the available bits will be written so when readback
>  	 * we get the maximum value of auto reload register
>  	 */
>  	regmap_write(ddata->regmap, TIM_ARR, ~0L);
>  	regmap_read(ddata->regmap, TIM_ARR, &ddata->max_arr);
> -	regmap_write(ddata->regmap, TIM_ARR, 0x0);
> +	regmap_write(ddata->regmap, TIM_ARR, arr);
>  }
> =20
>  static int stm32_timers_dma_probe(struct device *dev,
> --=20
> 2.7.4
>=20

--ufg0QVK99FQVDHYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmBAH6cACgkQhvpINdm7
VJJxoxAAvmyLErbMqKfNrxP50BUUqWebF1D4DmGUYCIujUBwxU6POmqvwMt5QEV8
hlIOgqb2eDTONsRi5Dv7egYSwfkIInRUcNKGsfXxOUaDYl3/Z2mEnJSPd4d8pQen
Zd2+Cz7TFpT4Rtl10oVXR+LQJMGTHvcsmrF9yjobD3NHAqoOV0d4/3DUusm7BGdt
qUEF7BY7nCyiJYQkWChUhSFx/pyW1rtfl0Y5kAaF3+GOvLhCY+2qzo3yGNy3mMfz
tQEZ1BWs92cBdZMAjpzUM3dnMlTRWd1LwfWv5wzK/i9ATK+g5xoSqYwuWYP+5vqU
PxyfEfuLTTU+dfYJ5cqxGZk7Clwogw7OuauF/i9CLrAuV/ZWMkxUtBiTUnLkgcn3
IHiVYFmoKihOkobzi/uJf75KSBeDJnyFnf8tuV78i5ii1tGukeUU6gaj6mF2dUae
0l3ML9KTNSW5SXFNO9IalrlWp/5xQYZFkbArUZxVfuCDe+AEDfmiyI603DOHsDfi
4qY/3l1t6gOG3oqpnaUDTruDtCKbvQ00Q7rnoqBmlWrXGskxnwmhwPdqnArwQZLG
+7HJhkDV4u37OuEsGIoc1+lDAzZUgW1wMf0xhfgQ/qxet33WcQGbjyInq7OH0Vy/
N/tCPeqwcfEJaNOoqOxqUZ2HogY1m/d9QoZqCKja2gyhlKGRBXI=
=GfL2
-----END PGP SIGNATURE-----

--ufg0QVK99FQVDHYN--

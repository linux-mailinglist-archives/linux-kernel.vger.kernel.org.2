Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1CB3EEE8A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbhHQObW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhHQObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:31:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEA5C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 07:30:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q10so28982657wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 07:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mff/KrbdRQ7GMVkZOauUgCMqNwRXeH+sm4TeEoBv3U0=;
        b=u8+H84uELvlzgdezF3nYJ0McQ5Xj4i8lL0+3lRNi1gK59PUCL3TzgVcq/hNgg1pnUf
         keYu0VXSHFK0//H0ocERWFJufdJ/PAvg/pbPsJjcxWwVWdBvPyE3o2LedEUrcGwEHXLv
         7Qzqy+ywlpD7bZs7ounwUw4HrtXEFf0k3mLGgFH2c+wcaGft2VG3u1S1Kub1HQH6/Yxn
         dQOg+GJek+LDuvoaVnb9QiKZQ2jD/CRNg7ZvUAnaMXkYtbNbCax1VRGE5y9v36hVz/ev
         8e+QXpxORsfFbQNE9tSJve76xzV0GHP5xABHYpNb+Gt8YnlACpMVCMS+A4jBBhC3gGum
         Z41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mff/KrbdRQ7GMVkZOauUgCMqNwRXeH+sm4TeEoBv3U0=;
        b=NPneso6msvTjwRqn8rdwLAYwdaGVLyMFuTH5oBaQf3C2gwKKHqMXJ27QJdjfQx90Q5
         A4BFKStIClSSmGpNrkHmXFuZBcsIbet1ygB39H8VTSgeImeJQsGO37DrXTUQVLlXY6bG
         B0kyfj67NHZrAg32M8mN44XKREf1YsWY/D51pZxS1/LkRC7mu53Co1tmXmleYORiDXT+
         gxuO9c0heu+P5Bn+bInpDkXSgEGrGcpv3VV1tUI4TkmsgMNB/UDxQtfjE7AuuRxzQUhx
         wqKtd60t9B2FzJeTwKpvIQGANYljEJZjFVcuCr5Z0UgUT4xNsNWAmszS8OMpydDaIjvj
         fUMw==
X-Gm-Message-State: AOAM533ixvK0ce0CYydcA3uyPyHXsOvV8oUoea6mNAgUY7GPpU0ZBEHn
        tre/0I3C8nX7i7X8OJ5CFPk=
X-Google-Smtp-Source: ABdhPJxOj8gM8S1nzCaTfcKKXYsn6jPSd6jLWRhx3PjuqTTun4h/sr6al7tzYuxoZ1I9fYGNqsLJfA==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr4553548wrr.49.1629210646315;
        Tue, 17 Aug 2021 07:30:46 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id c190sm2281338wma.21.2021.08.17.07.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 07:30:45 -0700 (PDT)
Date:   Tue, 17 Aug 2021 16:30:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] ARM: tegra: paz00: Handle device properties
 with software node API
Message-ID: <YRvIFJKmFlB6ntI5@orome.fritz.box>
References: <20210817102449.39994-1-heikki.krogerus@linux.intel.com>
 <20210817102449.39994-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PWzmajiJWetKR0l1"
Content-Disposition: inline
In-Reply-To: <20210817102449.39994-2-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PWzmajiJWetKR0l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 17, 2021 at 01:24:48PM +0300, Heikki Krogerus wrote:
> The old device property API is going to be removed.
> Replacing the device_add_properties() call with the software
> node API equivalent, device_create_managed_software_node().
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  arch/arm/mach-tegra/board-paz00.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/boar=
d-paz00.c
> index b5c990a7a5af5..18d37f90cdfe3 100644
> --- a/arch/arm/mach-tegra/board-paz00.c
> +++ b/arch/arm/mach-tegra/board-paz00.c
> @@ -36,7 +36,7 @@ static struct gpiod_lookup_table wifi_gpio_lookup =3D {
> =20
>  void __init tegra_paz00_wifikill_init(void)
>  {
> -	platform_device_add_properties(&wifi_rfkill_device, wifi_rfkill_prop);
> +	device_create_managed_software_node(&wifi_rfkill_device.dev, wifi_rfkil=
l_prop, NULL);
>  	gpiod_add_lookup_table(&wifi_gpio_lookup);
>  	platform_device_register(&wifi_rfkill_device);
>  }

Seems alright. Looks to be doing mostly the same thing as the original
platform_device_add_properties() was doing, except for the node now
being managed, which is irrelevant in this context.

I'm fine with Greg picking this up. I'm not aware of any other changes
to this file that might cause a conflict for v5.15.

Acked-by: Thierry Reding <treding@nvidia.com>

--PWzmajiJWetKR0l1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEbyBEACgkQ3SOs138+
s6GcABAAkM3QeZ6vIBKH2n8pDoukbj0QrIy/8FfR8pk1lEsU3hsn5EqGdZu09R7F
vPKwO6SNMelfneNLFFTahNc8gT/4JaUGOxghr24Q4NmmNY8mgPCsglXUsrWN+4V7
QNWHILymlPOBQVgFJulqpsN/x05OHeKzygoCMyK6jq8zWau5O/Q2Bat5A4tiQitq
c50woG8Vv4upPrldO73T1QFjHQCPWfEXrgPt+l7PJOE57O1ztmKe2AlKKyy/1Nbv
564eOFI8xwEqZYfrO1DpSTOUc6gPkjelYu99XIKghwf3jL/jZs2ncZHVoYBuNLFQ
UBCofpMZ26aMi/BymhFy2BR3eAQ3j6uoieyA+F9eqUANp7jZfxvvcyA3B+an+B/2
jpG8l8D+LKqU609CI3dH3c02GBoXnLoRcCCwn/6T8EY1hflIyUFgG6TspKZ1xGIj
7938dZVqA0THn7eoTXYwCWpPL0OhwXRN49clyTxflO538n3uJOVvSIVRjrLUbret
vrU4oOSN5hj14B85R90zTiWvICINDZSZgWEsASdLD/gIpUwhX3DERMre+JLucZIs
i9O0hun0ycoxhEwox/BRoNnY1sOwvIi7N/SgXnRMnSDXvzXN2zdmnG4kR9W2aMhG
pOkFVvwaywtXVjMURHyQIoB+Dmj8NGkW+/4sh7fVgu6wuLJEvUQ=
=Nfjr
-----END PGP SIGNATURE-----

--PWzmajiJWetKR0l1--

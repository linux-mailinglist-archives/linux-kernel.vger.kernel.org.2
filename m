Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCE93F4F83
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhHWRbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhHWRbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:31:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3744AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:30:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id t42so13404428pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xmm91rkjJlab8b0Klygz61qOGG30GBcTtu1l2IdR8Do=;
        b=Jf0Z5DAQz2sRFu9Jdki6NxKB54qaYV8H2Rx/d8GjGOzfF2fTEME1cngl9KSuzgH77c
         2px8n9CBlFIjN8BY5W/gbuXmEUcSdKv1dHigrcdxqbQfrABSahOvuW1U6XROl2mRJ5Se
         8NsK42VM8tsm6Z7oBWCCXis7Th04nI7ccRuTUivdvJWjjvb1oQkQ2jXmfF4EXpweR4YC
         QEDprERqNeRZXxNXG3mno2N1goelHTOU9ZsDxBLwVSs+e0jQvSKOeKq+cNIwca3TAC/6
         bYnMfE0jh/Pv5CbZx8KzOwFuyID1KdGb4j4h5g0c98eOP4Zys6HdfqUGUIB0q2XUOxna
         2AEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xmm91rkjJlab8b0Klygz61qOGG30GBcTtu1l2IdR8Do=;
        b=Bv5Y2u4T8hv+pd/PunS20SnzAJ2IVaPYTZICTLSS3lx5K7HCZQtqpLW8NOvNRNjjSV
         NJ7UyPmoL/IWLsbZPs0h2FFaKWMsZzGS7E0wgbvLXMqWJmYi2cn0+uJeCYvTwnX8qKtn
         g7gSoocySXZci0RiT+5HCSIi0J+jN1nDeUD7FeWrlaLTMOrmnCVwHDE/nODzaF8Rvuj/
         1+9gtrz5JZsslFsEObfmjsWf/ZpEwHBWhijyV8x8zISVULwb1M5jOiLS+PCppzgHIaHH
         4XXRpwBkHL0CgqnGugQKAYo3ucXbiWr3BbswWoQl/piEsxjVq1PqTX9NEufTquHIYZoP
         5OUw==
X-Gm-Message-State: AOAM5312U5Lj1ZrBTxHGiJQDyQNcDwleBTOf4nrnG4aNJDipAibsj9wc
        IerMlJ8oRlxbywRhATSIXqUXy6fe68xzbw==
X-Google-Smtp-Source: ABdhPJzV/SodcEFANxJO5+bV04KTefAp5puc9270wPDPBVJcGatDODoJdJJ9f98Ri13/nyfYgd6VeA==
X-Received: by 2002:a63:5f14:: with SMTP id t20mr30047026pgb.433.1629739858324;
        Mon, 23 Aug 2021 10:30:58 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:7e3a:73e9:2510:18d6])
        by smtp.gmail.com with ESMTPSA id b10sm16609267pfi.122.2021.08.23.10.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 10:30:56 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:30:51 -0700
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_proto: Update feature check
Message-ID: <YSPbS6By2DWbpZy+@google.com>
References: <20210802184711.3872372-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HNBq682VbNMSbrU5"
Content-Disposition: inline
In-Reply-To: <20210802184711.3872372-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HNBq682VbNMSbrU5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Mon, Aug 02, 2021 at 11:47:10AM -0700, Prashant Malani wrote:
> EC feature flags now require more than 32 bits to be represented. In
> order to make cros_ec_check_features() usable for more recent features,
> update it to account for the extra 32 bits of features.
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

FYI, as discussed, this patch was dropped from the series.

> ---
>  drivers/platform/chrome/cros_ec_proto.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/c=
hrome/cros_ec_proto.c
> index a7404d69b2d3..772edad80593 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -813,6 +813,7 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
>  int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>  {
>  	struct cros_ec_command *msg;
> +	u32 mask;
>  	int ret;
> =20
>  	if (ec->features[0] =3D=3D -1U && ec->features[1] =3D=3D -1U) {
> @@ -839,7 +840,12 @@ int cros_ec_check_features(struct cros_ec_dev *ec, i=
nt feature)
>  		kfree(msg);
>  	}
> =20
> -	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
> +	if (feature >=3D 32)
> +		mask =3D EC_FEATURE_MASK_1(feature);
> +	else
> +		mask =3D EC_FEATURE_MASK_0(feature);
> +
> +	return ec->features[feature / 32] & mask;
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_check_features);
> =20
> --=20
> 2.32.0.554.ge1b32706d8-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--HNBq682VbNMSbrU5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYSPbSwAKCRBzbaomhzOw
wl2bAQCH3tFVlx/twk8FkUFBugzU6S2gzWbwlpPTaB8a3Jt7vgEAqFW4sxcgNPgz
TdPDdTAqB3iFEPpbYX2lH6zgXo/5dwU=
=rMxV
-----END PGP SIGNATURE-----

--HNBq682VbNMSbrU5--

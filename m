Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A116E36A012
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 10:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhDXIJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 04:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233139AbhDXIEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 04:04:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CBBA61476;
        Sat, 24 Apr 2021 08:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619251406;
        bh=ACi0xfztTvH++jH+Sgr+d8QkUSznqRyTg1Zs4Bk80Fk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OBnFQfIhClQawJYzIr6EVCR+DS6WGZN4AbZl2o4PbOsOqLIdQAhZ/6TL+kJWQ/XCm
         p5k7l75JVShk1xItZv3dNxSzdxUNzeNvNdhmFvtaH5D2Bm0lKIhdvavuCTCrotCiEQ
         AREFZdGRskLbcvUPZntzQf8ZhncHGMlxs7oxdPtdujtWqW7Jibzzw73yfFfQVmzwoz
         GxOV2wzuQyHIdIPRrxo9YERintgvpbFi29rF27dCmrjLmx/Liew9JR4XGB/aFWh/PJ
         Eh5rLy1ZwoQB6mtnBbsrruUOSbnR/GQIgx4YthU8t9Q44abWDOf2K0EgTD0dbeSVBd
         vZoX2WeOfqHbg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] usb: gadget: Drop unnecessary NULL checks after
 container_of
In-Reply-To: <20210423150626.138188-1-linux@roeck-us.net>
References: <20210423150626.138188-1-linux@roeck-us.net>
Date:   Sat, 24 Apr 2021 11:03:19 +0300
Message-ID: <87v98ckt2w.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Guenter,

Guenter Roeck <linux@roeck-us.net> writes:
> The parameters passed to allow_link and drop_link functions are never NUL=
L.
> That means the result of container_of() on those parameters is also
> never NULL, even if the reference into the structure points to the first
> element of the structure. Remove the subsequent NULL checks.
>
> The changes in this patch were made automatically using the following
> Coccinelle script.
>
> @@
> type t;
> identifier v;
> statement s;
> @@
>
> <+...
> (
>   t v =3D container_of(...);
> |
>   v =3D container_of(...);
> )
>   ...
>   when !=3D v
> - if (\( !v \| v =3D=3D NULL \) ) s
> ...+>
>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> After the recent discussion about a patch which tried to add a check
> against NULL after container_of(), I realized that there are a number
> of such checks in the kernel.
>
> Now the big question: Are patches like this acceptable, or do they count
> as noise ?

Not noise in my book :-)

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmCD0McRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbrFhAAjK7QrZdqVxK2EgTc5xcbtApDiUCVH3Cp
0SmpmqjFrREa0zV8cIbCtAW1ARmlOMCvo3BJ/vJseF/QlD74oB5Pw2VgldBEuMzP
otOni5XlD6Jx2xq0F0HsZE4XNZL7QxRvjfQrhZjIdMZqAbuYlDC447vBAeX7ysBD
jXiclZFO0rb9UcXaQVdW/6wGghKVdCwqCXkl1vgxsYR5cL6ifAOzfGE9Nvhb5Q6f
o7Rm40i8vyal5LCer+SsR7EbAysbl0hd2cWdj2Y8vT4z9fLXc3zGFlrMxlgfKuYR
FnBmzlUkIMAbMGOnkGf/8cC88IW1ehYpUhw4s8JsZD6HrFlnL/3OOUpTNlsq+8pe
8FeqNCLYHqEykxYW3EFkt4VHt3vpWAaiumZzJL7sqQ3WV2Ac4bMNwkgbQw+uJVjS
CZxTf0CMTCT2pSi4MsS+FXd986ksgaJ6s6IbUeQzQ1uMbiWHGTIvWCqS1z0QCrg/
djoVPITcUtkifyNKkScnnVEygu3UjyzZmwzJwtwbW4+1qC5ttXRUvmkd++9ZhE7e
nswhJQt20YkIsJU9+TgXoQHZHacNrAZXzbHjQcjdApl6oB22tXtbFzoy6PIy/HzU
1AND1nxp5J0rDxqIvAa3hhZSyUcT4H+KOt9sgpKlxPd3OTGXqiWb2QKJTgUtUYmN
BpcEdOxCWog=
=xIff
-----END PGP SIGNATURE-----
--=-=-=--

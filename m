Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4AF313E1B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhBHSxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbhBHRHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:07:37 -0500
X-Greylist: delayed 9298 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Feb 2021 09:06:57 PST
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FFCC06178A;
        Mon,  8 Feb 2021 09:06:57 -0800 (PST)
Received: from antares.kleine-koenig.org (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id 4E74DAF4026;
        Mon,  8 Feb 2021 18:06:55 +0100 (CET)
Received: from antares.kleine-koenig.org ([94.130.110.236])
        by antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236]) (amavisd-new, port 10024)
        with ESMTP id iLo2XktlSSdX; Mon,  8 Feb 2021 18:06:54 +0100 (CET)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5ad:2000:36f3:9aff:fec2:7e46])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Mon,  8 Feb 2021 18:06:54 +0100 (CET)
Subject: Re: [PATCH] USB: serial: drop bogus to_usb_serial_port() checks
To:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20210208154806.20853-1-johan@kernel.org>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Message-ID: <9306d82c-d030-1243-1079-1ff5339f6cc5@kleine-koenig.org>
Date:   Mon, 8 Feb 2021 18:06:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210208154806.20853-1-johan@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="k49IEZqBnOohKuCwZKCjS1Cxw6MLoXDJA"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k49IEZqBnOohKuCwZKCjS1Cxw6MLoXDJA
Content-Type: multipart/mixed; boundary="cOM6hUIfA6GQyQV2hyh18WCASW6jV7myA";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Message-ID: <9306d82c-d030-1243-1079-1ff5339f6cc5@kleine-koenig.org>
Subject: Re: [PATCH] USB: serial: drop bogus to_usb_serial_port() checks
References: <20210208154806.20853-1-johan@kernel.org>
In-Reply-To: <20210208154806.20853-1-johan@kernel.org>

--cOM6hUIfA6GQyQV2hyh18WCASW6jV7myA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/8/21 4:48 PM, Johan Hovold wrote:
> The to_usb_serial_port() macro is implemented using container_of() so
> there's no need to check for NULL.
>=20
> Note that neither bus match() or probe() is ever called with a NULL
> struct device pointer so the checks weren't just misplaced.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>

Thanks
Uwe



--cOM6hUIfA6GQyQV2hyh18WCASW6jV7myA--

--k49IEZqBnOohKuCwZKCjS1Cxw6MLoXDJA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAhb54ACgkQwfwUeK3K
7Ak5WQf+J+4IrFTCasBl6iUF3PXecU/H/9Yf2akmx/hBq8TAukMBZndHvCfL0Yug
efqNj3qZyAywgvT8HCNceIP4i4Xjwt5HK5WKYklqD0mpNkXWSZAHx7j0D1DbCJvd
6dY4moUgaLdY/bYdMlQ/ZfNparSgaBWiHwBU1HlJ66XGXapxIycwrb13VfaSnRrX
B52gOQ6xDjJLGDpiSFz20s/mziM2/F/h2OAQpL7N66A3QSvJS33SDNrl4c1dRcYl
qByp+i3I+job5NmjaBtA21aIu+iQ4xe8PZF4NFnuQo+kkuZ+3tkuKPoNGp5MzRdK
z7Xk0kT60wl7uZ6k0M8eiOuBaqHKVA==
=+3gP
-----END PGP SIGNATURE-----

--k49IEZqBnOohKuCwZKCjS1Cxw6MLoXDJA--

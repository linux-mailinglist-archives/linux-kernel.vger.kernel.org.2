Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6858378DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbhEJMxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344100AbhEJMPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:15:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41634613EE;
        Mon, 10 May 2021 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620648838;
        bh=Ur1B/wCit+6l0V6M8hMBh5IZ/BNcaRSGE/mfwjUYbEw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=D28IkS6QYmnsDUmiTdDt5HLBQB5r6+hCXD8XPYV/ix0IYcUv7MnYhngDy1G5NLL7e
         EQIbtOTwcd0bwfHrbhssYidgxnZhUadQ2Hp7apkIEmKaEbvs2BaXN4CPoN1ABGxzye
         sRPtnBCSJgNJmT8bvaa0lK5mAQRgLdOkXNSAkCLSdw49NYYTkutuJ2Mvd3EhpNe/tI
         HZzoqAVFzL6HCuS17zNTbAYbp/xnCb+1vrB53ASLumCQIFUKJpJXrUUFuIRi6Vq5P3
         vG50BX7icNu1MY2wdzC8zTkEgBeUpU7K71MtOBP8OntzV8pBn2usdFf+ZqnrFzvp1r
         ako0+UaITIuoA==
From:   Felipe Balbi <balbi@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] usb: dwc3: imx8mp: fix error return code in
 dwc3_imx8mp_probe()
In-Reply-To: <20210508015310.1627-1-thunder.leizhen@huawei.com>
References: <20210508015310.1627-1-thunder.leizhen@huawei.com>
Date:   Mon, 10 May 2021 15:13:47 +0300
Message-ID: <875yzqhjlw.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Zhen Lei <thunder.leizhen@huawei.com> writes:

> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
>
> Fixes: 6dd2565989b4 ("usb: dwc3: add imx8mp dwc3 glue layer driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCZI3sRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUgY3wgAkomzqc3jX75ptc4cjAAsXxv9HBMlZES9
l1vCJ5UayD1pjjFp/4Iqm8PtCMwBSIEpOA8AaVUcYFqZkHAgLekj0F0688ZwDHi0
l/xL3OVBAmI45ssdibhrirA+UlqnWUKBGXz5UKsDzNlmutocbrjlP2Q1nZwhYGoU
1PNZK9O2PgLs54jWLqNnQVj3bDDkwGoUWXf4vu/TkhmkNgCVqOEJgLjthQtUBsRJ
x6JqWu7P7Zjc6A+Xci4QyBnSldpz9Ek9y/C23hiR6dNFSmunX2IMhH64UgvwPVEI
eGxu07AYEDZsTvqtPYK2fjwfC1e98OULVbc4wQCrcuI0Pq7a5plEVw==
=rgU+
-----END PGP SIGNATURE-----
--=-=-=--

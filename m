Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B05336A014
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 10:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhDXIKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 04:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234643AbhDXIKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 04:10:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAEEE61360;
        Sat, 24 Apr 2021 08:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619251763;
        bh=K9GyT3PFlQx4FBRYAIiv5Tm15IYgz0y+dAxeGlaSEsU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ofhXQYpdJAF0PxXPwobcIl4RrFFBrUBu6seFW5T+ssDNcGZHbrbeqLmS6sAFGCBX0
         GPe4O26uLNTwjkYZN+W9L/WrOPlh5K+GoZmplStOeZceXKAue1C90QBuPOkBNL8eI6
         CWAdYORkFaXfM4ZmfIFdaQKlmCwGUnxZgVHspWC4sAhbnvGHEJwVCJtkasvkMWziCc
         hOdpu3qNTW6ecr4Im7pfjkE3yxrhaKo5JCxqvmAtVwvrcl/5CycYTVuJP78Oapvh5b
         /siKFHa7pNmVHzM4rXBVo6Cfjc7YDvF6qpOl1kdn5CtAU9Kp14KFp1wHQIUCqNyCZr
         x+oB9Q1opd8lw==
From:   Felipe Balbi <balbi@kernel.org>
To:     Wei Ming Chen <jj251510319013@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, Wei Ming Chen <jj251510319013@gmail.com>
Subject: Re: [PATCH] usb: gadget: function: fix typo in f_hid.c
In-Reply-To: <20210423132417.4385-1-jj251510319013@gmail.com>
References: <20210423132417.4385-1-jj251510319013@gmail.com>
Date:   Sat, 24 Apr 2021 11:09:16 +0300
Message-ID: <87mttokssz.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Wei Ming Chen <jj251510319013@gmail.com> writes:

> Replace `me` with `be`
>
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmCD0iwRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZ+Ng/+JiO1BZQCZktGHGRfGaHOpabmcjvHb+ai
IAUuD35W9/35BJtgGUEUy71fPFr2aOl2l7QGIFSsLsVJyBx0EgFt+czvgax5sZUv
y2cZLY8zoZrdOntjZ797ByNhrSWm7Y52n3RAUBce+quRo0x3bwRZFa+b5r9KWnQz
mWmM2C6IAwHoDBvqz2OyMx1OTSkdQ9gdvbWMuWdrg20UmxLNYFNi2KMRRHJdSf5G
mbkNrw1tCkzs24ugXGW/2c6NscOm1l0P4Kf3CwjRpH4R/SaXPQf17xyUnwuIbzMQ
cnWpML0YMsLFnJHpnqCZdpltc4sXsPk1YiYnSq7Qg2d5eyhNa47dO1S/ehJyE7Ur
CHG60Fpu5AP32u2IRdtMEoOzz6WD+KN2uj7fGY5NL6z/3YwFPxf3s43dr0N1LeGg
Yng9v63X4mWBz9HXKiiscfWAtqiaUvq7MRKaKNx0lSzSWq/cBdDR6XXZ6i7wj015
Vex3LqzTXhcoghKroWv1lr45ndFIYzSfYmUvclxTEdb5M6Em3F44AwF7A73qyqP1
rlfMJ6+Ip+G6MD7DRwKnW1AKum1ZSKB1kdbE0n2WDszHzTzxh/VyfpKNVTT0Zhv4
BxLV+vcu2h2sy7ApkiLE4mEzhossrwB9L4MDCTNF+030kYV0dGDVF7hRsv2KTDXP
iRGADs1NQRM=
=lVfK
-----END PGP SIGNATURE-----
--=-=-=--

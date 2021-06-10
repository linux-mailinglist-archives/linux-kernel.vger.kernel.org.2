Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AFB3A283A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhFJJ0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhFJJ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:26:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E9CE613FE;
        Thu, 10 Jun 2021 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623317076;
        bh=oy4qESkdnKcP3NQlBhbmQ9kp6vNt7W4YelwBDv3HMhs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=G0tM02obRUONAjN4/SwVjbc5w+QUPX8BZqucF0ldMd4VQ6OOPegHfT7RRl2S3AXDs
         zWSHYy2GNbJFSx+XqdNVl5gOuhwfZIP5LM3NFzYdHh/wGcgKbwREkt08l4MJS68YnI
         rXiIjYKzp2704ZR+W78Vg0I/U7YA3eQ7y0vnpTuhjnd9sc8q3cWtPiH5Iilrdm+urm
         HRWsaz7TVnlNZVkKDSIJ/Qb3nr8cQXmm0BBXwiXtQGRhpcEURumGl3ZQbiSen0CraE
         QCh3TCta3xM7HaZ8Mg+hyb4F4O1NZ4YaaV+CD2Ago1Q1GERLt3Hg/xfUzs/96t6svI
         FeOugIVm8yHrA==
From:   Felipe Balbi <balbi@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>, linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH v3] usb: dwc3: support 64 bit DMA in platform driver
In-Reply-To: <20210607061751.89752-1-sven@svenpeter.dev>
References: <20210607061751.89752-1-sven@svenpeter.dev>
Date:   Thu, 10 Jun 2021 12:24:28 +0300
Message-ID: <871r9a2htf.fsf@kernel.org>
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

Sven Peter <sven@svenpeter.dev> writes:
> Currently, the dwc3 platform driver does not explicitly ask for
> a DMA mask. This makes it fall back to the default 32-bit mask which
> breaks the driver on systems that only have RAM starting above the
> first 4G like the Apple M1 SoC.
>
> Fix this by calling dma_set_mask_and_coherent with a 64bit mask.
>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Acked-by: Felipe Balbi <balbi@kernel.org>

> ---
>
> Third time's a charm I hope - this time much simpler :)
>
> I still think this change should be fairly low risk.
>
> Unfortunately I only have the Apple M1 to test this on but here

wait a minute. The M1 includes a dwc3? That's awesome. Mind sharing a
regdump? Should be in debugfs.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmDB2kwRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUhOVQgArAs3+Ywns0Y7SVUQSIAwRGUnHuSVqK0i
5xGxGB5tEiQa4FA1DwywFkhJBcnq1JW0180X0rSZfSf6mSTLo3GJDD017GY5AKom
Zn8YXZZ0RCwoW2TxFda2QDv49m1RH8mwn4YS9F96x7Q71qbc5tM5dRctYqhJKprL
O6pn3vHztKI3a6/NR2L1MePdtxKItia8OKGt1Eq/YOoK4Soh1kMf8rKMnle3t8p9
XhL7ToKD4PLpFP1LMJyBIR0Df7AIZKwv48rpDGvmQklTCXJ0MVrtg7zONI1WwG0x
AQBMojE9tJ2ix15hkH9O/IlgLrn/ERINLN9xbm8kdCeoSJGrY3PB2Q==
=CWyw
-----END PGP SIGNATURE-----
--=-=-=--

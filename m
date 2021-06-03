Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4A9399A8B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 08:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFCGU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 02:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhFCGU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:20:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40DAF6100A;
        Thu,  3 Jun 2021 06:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622701123;
        bh=TW6SOGvkYRGFXEoLac/9lkzf6uKJi+kDsb421UC3MBU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mvNOgQiEaDh9KusshAxJoZLyKNh+7kiecylqAVt60X59SRMhTglrF1053MfwfWkQq
         O+ONqvd0HGM+5POy0frGWpgXAU0AHUcstCM21nXgpEXVTLXMHCjEEvXWzGqCWkxHiI
         WbGIjoSc7Sc+HHASY7znaFf+l238IvzuOrhShTHVIrwSFTgNXcMoLDemAB17t4ynzp
         g7SvA5iWad/uN7+WT6pp3QDBTrJkB9Gy/8JyKbfHxAkvmcT5auP4X2pBTJgjCHOIhj
         uMkCkKGzo5tUPojKmx69mKkLYsNNWjojKvAfVTekmUi4yOsTZjiYT6/mf4CJrqPloa
         5AJuLwUVvnhxw==
From:   Felipe Balbi <balbi@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>
Subject: Re: [PATCH 2/3] USB: dwc2: drop irq-flags initialisations
In-Reply-To: <20210519093303.10789-3-johan@kernel.org>
References: <20210519093303.10789-1-johan@kernel.org>
 <20210519093303.10789-3-johan@kernel.org>
Date:   Thu, 03 Jun 2021 09:18:34 +0300
Message-ID: <8735tzeait.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Johan Hovold <johan@kernel.org> writes:

> There's no need to initialise irq-flags variables before saving the
> interrupt state.
>
> While at it drop two redundant return-value initialisations from two of
> the functions that got it wrong.
>
> Cc: Minas Harutyunyan <hminas@synopsys.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmC4dDoRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUhzWggAvllpN00vgnjz60Jk0k7RhU/M9LSg46/0
SKapbuJDCRcAEQAX7BfhhG3mLcNcGCCi8UGv7lz/2OlBzDRmGsPgnoIU7tIJ+H9e
6O/5VcHbTMRrSVoQ21UvH4r40LXei/T0DjrSZmhgTlvgNw/6WQHiIC9LbFLZ7T5S
NCNkL0YYbctNvv21PoqvcfH4PoajF/axDau9ffhEhtOwXwGwyNZmaS6SJc5Mz8c/
xMwMcuXgRbaNK55M6egs9eFLsGAfvqo8I/psb53ExqZeT1PbnpeZC3krJJ+vhCAN
4a9JR2IBXSMQkKNVjPQxXtv6Kf6tQ4KWI18rlXlPnlp87Mdu+P03Iw==
=r83D
-----END PGP SIGNATURE-----
--=-=-=--

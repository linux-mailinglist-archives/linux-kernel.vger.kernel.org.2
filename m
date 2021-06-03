Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B359A399A8D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 08:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFCGVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 02:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhFCGVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFFCE6100A;
        Thu,  3 Jun 2021 06:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622701163;
        bh=epzZlkMg9+AF90DX6Ya+DaGXInmYp9+trcjFwb56wg8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=J1CjHf9OCdcl/H9dkWKaYxwVkl18/L+2WA0Hk7nCvJ/ZymLp0gqfDl9t3g3UJaxop
         zU3m5B6O0Oo8QVsAlyvg4M4/f5U58hn/o7hxVa4jN45AzfMXxXaJAlJ/VmH0ODoe8Z
         JW3fBTopGWOpQ892PyAFI8CJCgjcVa1CTdmQRb5nSpP9ME8SYDQkK03ZXWUJ+qG34K
         Zc6JTjWbKHXqlmLAJFVD2wBMDHm9fFVw24SSn1AxiJhvSoFzHCj1KaQ6XY6v8gthHP
         YpGBR+r3gs2aPwYTEg3PLWNX3Wd02c4m19PIWBjBQ2l7D+u9sqYnq7rJFai6zMgPCo
         5ZmT1wV0qMOwQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 3/3] USB: gadget: drop irq-flags initialisations
In-Reply-To: <20210519093303.10789-4-johan@kernel.org>
References: <20210519093303.10789-1-johan@kernel.org>
 <20210519093303.10789-4-johan@kernel.org>
Date:   Thu, 03 Jun 2021 09:19:09 +0300
Message-ID: <87zgw7cvxe.fsf@kernel.org>
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
> Drop the redundant initialisations from drivers that got this wrong.
>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmC4dF0RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUhBEwgAuPyUcqpIpRhPjoUAY0L+AywXlN7zDqLO
xsm5hGpKTtt7juaQ95Sj4UpxgBuksFlB1VZ0i3Dsy0x3EiKexCMCx500o26rLm2u
f2L58wRkCH+o3NUU+zHKzeAmRDEgxz/mrOlQkc1GTjbyAFTDIjCsq7OttRl4lGM9
vIAUjV8GBAGa/yvgtyFFLCe9m5Jq6a+odod9RWYd++H/aX+XNlNQWfWlehVY0ISR
/u1UXy1JcoIV1WejxifqspM1ktibDcspOjiylzQu/XMiUVEzjZjQba0L3uvVuOlB
FylO1vLrjCpvc2aTZo3NJjG6CBnsz5WabLES2Nei3Q59YXAPO7hiUQ==
=hdG9
-----END PGP SIGNATURE-----
--=-=-=--

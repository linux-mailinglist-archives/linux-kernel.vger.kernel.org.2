Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7C139A344
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhFCOfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhFCOfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:35:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC354613F1;
        Thu,  3 Jun 2021 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622730802;
        bh=EjEoDnvgK2MJvh26amyQpg9t7v4gmriBNUumXz3zNBo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VXMa5slI73rX3bHFoFxb33pQ940v/wxgHB1dbJTZjL/n7JIO04MbkV8pdAOhf3Xlz
         8JcqwwUQn7duaHLT9JBq36/tlQol4KqAZZHDPzIQI5wkmNgWUqoXCeyF9nz3Pvm2sy
         WQJlK1RQNhZfYlty9az9GhitwhjQdIuL6iMJxtZ8/AAjnvjRo73S1KvRTH+QcyJgkD
         +rxzey5NdfD5nXpnB2sI/2/5XpP1UiNVnmx739FymrzIl8Z0kko2HfSorlRepz54TS
         SqxmwLOpULCEIGP38cJvwIvwqlcIO/0IsJuBbIfWDvp0ip3h96WQBgfjTi+YRyxImO
         OBOq6kIy3x/zA==
From:   Felipe Balbi <balbi@kernel.org>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: udc: fix kernel-doc syntax in file headers
In-Reply-To: <20210522115227.9977-1-yashsri421@gmail.com>
References: <20210522115227.9977-1-yashsri421@gmail.com>
Date:   Thu, 03 Jun 2021 17:33:13 +0300
Message-ID: <87czt3c91y.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Aditya Srivastava <yashsri421@gmail.com> writes:

> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for drivers/usb/gadget/udc/trace files follows this syntax, but
> the content inside does not comply with kernel-doc.
>
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc.
> For e.g., running scripts/kernel-doc -none drivers/usb/gadget/udc/trace.h
> emits:
> warning: expecting prototype for udc.c(). Prototype was for TRACE_SYSTEM(=
) instead
>
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmC46CkRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUifDwgAtnFMd2i8Hm17HXt+UzjKTpBWvV88ADMj
uimkyjbm0+77YJUzI+viw9vludqI6MrQF1/IuPgTZ29XV8ddjv5OdGytFkuwJy4J
CvzgSFYcwLbIfN5XqqPxbnJfBW1+XpADGwcgcwUeyC86I7TaJu/8j/wl6ioE8NYd
h/kmY5UEZslh+0I0m/wRmis8Lhf1xJM4zr7uUGdNhgqSOq2b4cXeZGObxJww1/Rp
Ij0f6oVi6QtjPSaMr+pmqXrffP2Gk2WpFoNunEIbeEBiyifAaTRaAxf2ya9mC7Do
OvliCxol/kn35vvnXRON2o5NP0rtcsF0VCkMgLKPaJ/bqVtMADbiIg==
=8Y62
-----END PGP SIGNATURE-----
--=-=-=--

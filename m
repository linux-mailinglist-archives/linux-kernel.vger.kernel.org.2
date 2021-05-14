Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4AC380420
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhENH0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhENH0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:26:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A436561446;
        Fri, 14 May 2021 07:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620977100;
        bh=15ezUcoX2Tp5onmLNEbYjA7IRAW1s32VZAsjPbUMDow=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZygTqMk0DJgrTsghfeYNhwDq/A2Re2zuZq73koYZX9dSAxSTJGNGMewoHynPWP9OK
         tyjXLV8feLl1cQW7K51qvI9gaDAbyNLf9fsuTC8GWNcUmQAcQNrYeRo3LvWOKusKfC
         u+dFSPgr6AQVUmiLbYGM5XiFxmqTNDSdHardsgZLnDDWVwRHUbfFSYWUhozMLl3NWu
         xKWI0tvuk0bqyn1cax0UPNkX8M479xy960BvU8QwGFa+tjs5+SITjval+q4fvNUGs2
         g5WWMQ1p6q+srbokCw8B3UuBQAfG2MFcaSnOX3XyFlgQHZY2zzs/48wy52snIqq3QT
         g24j/t25VVGDQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] usb: gadget: s3c-hsudc: Use struct_size() in
 devm_kzalloc()
In-Reply-To: <20210513193353.GA196565@embeddedor>
References: <20210513193353.GA196565@embeddedor>
Date:   Fri, 14 May 2021 10:24:50 +0300
Message-ID: <87k0o17p6l.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"Gustavo A. R. Silva" <gustavoars@kernel.org> writes:

> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows
> that, in the worse scenario, could lead to heap overflows.
>
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCeJcIRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUh9UQgAoHsTFS64PtkTiiLe9txwadAGZu1jUqWd
rifBnWCjW0qkcPu6k74kykvO743iZ8S1NBFifgaARaSmiPvH3v6hIYbiN+co+QWR
dvkErw3FeTn5FqhAJdamv4nXcRecdmiutseGRUBExLA+vjbDKrCAp+3MNzf9emws
cTyBJaRgp0GCshhHyGKzvxRLRDt3USNBvN67vIxJMNgC0C2gg1D8Kp6qok5PzJCq
ppiCSPMw6ytSbKUGh5XBATPcgxE64jRoFFNObtPxByKlmvqTKC6rYQ0I9y48un+c
/Lo/5hc2yiepHWuwx6LE+LSSCkoFDQnhZt28yDELxP7Tl0bXqDnK3g==
=3cIq
-----END PGP SIGNATURE-----
--=-=-=--

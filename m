Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9611737513B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhEFJGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233765AbhEFJGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:06:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55BCB611AD;
        Thu,  6 May 2021 09:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620291932;
        bh=RQtejeb/yHmg2LjOLazx2HnGHfv6Vmre/ryI1b/Expk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HgUaKDr1PcDAgF8LzQgM3dk0+SpZgzDhG2faG496/DEQKJR/uTzzDOaHUOL50qO/s
         USvyVwDxJ5FOSSRuXJlx9KUhdmOLpikP/ir3OC3BSVamnKodTj0brdgB9vnyogvJKp
         +O1k6bdacx7hGDSY5f6icFHkld5YKvJlJRCBFhMpBi/rV5FAuqPNks0Pg7kvof7cVW
         9URRkHrdaSw8v6TrWkYA9FScPMBXo/5XWDtF6PyrP3gJ+IDoh22U+qwVM+AvAoDUdf
         4pqW6HQSKtZWPFvhZzUnmCXx8N3K4+d5ox2kZcgRAklA1VqrUn+3SkcGMUjXYbtaVS
         UOu64NkudfcZQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Wei Ming Chen <jj251510319013@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, Wei Ming Chen <jj251510319013@gmail.com>
Subject: Re: [PATCH] usb: phy: Use fallthrough pseudo-keyword
In-Reply-To: <20210505141936.4343-1-jj251510319013@gmail.com>
References: <20210505141936.4343-1-jj251510319013@gmail.com>
Date:   Thu, 06 May 2021 12:05:24 +0300
Message-ID: <87lf8sgrl7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Wei Ming Chen <jj251510319013@gmail.com> writes:

> Replace /* FALLTHROUGH */ comment with pseudo-keyword macro fallthrough[1]
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highli=
ght=3Dfallthrough#implicit-switch-case-fall-through
>
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCTsVQRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUjddAf+JvgIlEB1k4Dpa+ecjbyO2Lobqo63zQ56
tXcMESB39J4/k67yVpRiasdUpP0jGxQB0NgrcLUHEcfFObhyC7110v9hxgbUEMNy
Lq3bE2lm+g+uGPEjT58GoHRnfC/Tlr215tFEA/8q9buW2fFMCOT3QCfygqWB8xLW
1jjjukdxIvw7Xm32yIOFIf+AKTbtbTuMXwfYr+s+Psdajo4oSPLZNJJ4g4klfiq7
7pFZYP41yqPgU1LK3ZsPUziIyZrpL5DJxOgpxJP3tYU07I/OkC5DukTtU3qw/hK3
ilThBnfCZQhUBD2KpkTnPTy3oOlFGdSnzu/UQ6AUzT+VD49CjmWdWA==
=B5lj
-----END PGP SIGNATURE-----
--=-=-=--

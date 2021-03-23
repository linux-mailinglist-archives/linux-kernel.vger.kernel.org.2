Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E5A34661F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCWRQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhCWRQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:16:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8204061937;
        Tue, 23 Mar 2021 17:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616519795;
        bh=M0vsensJWPkDXt6/BdRDvTl7TrhY/roqEdREaiWe4Aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrBxWn9XF3SVWYtxSyaWE/PGGCPwatw6+L1Zegl2o9i4DdoNwG2N8w0qWq/KtzoWt
         Iw65MpUaiG3kh9PklkmSdeLA7YRckxblBhqpxvz/cOEtG7JHpfLL/UKdakQlVXa19M
         KxxSK/aUsoAcg/CxFMheZFJRMUibExyVdduXflTgwxrKL1MttmrCok381pty0+0VMf
         Wap98k1Ej5sJ8kubdJyJ/d0O3rvpbHfmwYHNJs545AwbwPiyAkkG4GfubpA2bKhR5+
         2n2k0aODiK31yBD/NFax+IZItyT/7GmUD9QrfSFDGHZecx3MNHXiy6ct+n8rnjJNjK
         cPgW+282nD0OQ==
Date:   Tue, 23 Mar 2021 17:16:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jian Dong <dj0227@163.com>
Cc:     matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, huyue2@yulong.com,
        Jian Dong <dongjian@yulong.com>
Subject: Re: [PATCH] regulator: mt6360: remove redundant error print
Message-ID: <20210323171628.GA9323@sirena.org.uk>
References: <1616502161-125407-1-git-send-email-dj0227@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <1616502161-125407-1-git-send-email-dj0227@163.com>
X-Cookie: Do you have lysdexia?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 23, 2021 at 08:22:41PM +0800, Jian Dong wrote:
> From: Jian Dong <dongjian@yulong.com>
>=20
> fixes coccicheck warning:
>=20
> drivers/regulator/mt6360-regulator.c:384:3-10: line 384 is
> redundant because platform_get_irq() already prints an error

This doesn't apply against current code, please check and resend.

Applying: regulator: mt6360: remove redundant error print
error: sha1 information is lacking or useless (drivers/regulator/mt6360-reg=
ulator.c).
error: could not build fake ancestor
Patch failed at 0001 regulator: mt6360: remove redundant error print

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBaImsACgkQJNaLcl1U
h9CT/Qf/fI+Ve9XBpCARK5KtyPiB7dUkhxs+7CfYhtmLauGIgs9dnR9mwm+ElsWg
nfZeRuqUg7IjUq9JQotr15bdGoqm6/nUAOglznOuZISAKv3dXm1bmJj+2QqEdfp7
mViOgfHw0o1h6FPjOZ+lGmFUCNUG/DyOaVcR71m2Bsz3FvJhqa40FAW6xzvH1dak
it71vBH9Y+kCDR0nx8wifGqLwbXQTaPIoGjMjk0soSLk7/5nGLK0vVmizur23gEy
scR531mK5sMFyYWPrDMXJBKyk8MS2er/Y97uD2IDc0dWggg/PHbkSxmHxe5x2D1c
CB1Uvi23YM/iAswBL+0fwkRApum4gQ==
=GJoq
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

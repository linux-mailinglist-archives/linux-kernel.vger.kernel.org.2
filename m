Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859E440B041
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhINOJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhINOJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:09:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F250F61029;
        Tue, 14 Sep 2021 14:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631628507;
        bh=fqwCCupSF77352KDo9ompY2pM1lqBxKCi8JVICSlgrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNdZhTlN8CuCs9WFOrYL891xdTAozdtuiTLEDsYNzMmEz0kI1G1LU/eX/4fYVYygb
         LT+IAKPQwskUk2qeD7DQ89Zw8RM25S1v3FLVopPuE6xQ+wMsG9Ji4T7kfHrvHrGziW
         vNwX37C9AqAiUd5+NRy9FQj0rij5UBG3p207TT9IIW1vYs3OuTAgWMOKAEKOfYBoqG
         nW2gvG1UY/uRrtERP1q3VzIiF4yy1tnKmzoMPcFcAfex4y5FQEzbgtrOk+SGO2qp/Z
         mbHzfHQbO6RfJlxOKqxPu8BkUPuPnNhGPzWoMy5KHHrHb+K+sQyGcvHJvwFeFQKp3J
         bxOAOfOhr/ICw==
Date:   Tue, 14 Sep 2021 15:07:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com
Subject: Re: [PATCH] regulator: rtq6752: Enclose 'enable' gpio control by
 enable flag
Message-ID: <20210914140747.GE4434@sirena.org.uk>
References: <1631627912-7974-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Content-Disposition: inline
In-Reply-To: <1631627912-7974-1-git-send-email-u0084500@gmail.com>
X-Cookie: This space intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 14, 2021 at 09:58:32PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> Fix 'enable' gpio control logic if it's specified.
>=20
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> This patch is to prevent the logic error from the below cases.
>=20
> 1. All off and both are sequentially controlled to be on.
> The 'enable' gpio control block to be called twice including the delay ti=
me.
>=20
> 2. Both are on and one is preparing to be off.
> The 'enable' gpio control low before register cache is configured to be t=
rue.

This should be in the actual commit message.

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFArLIACgkQJNaLcl1U
h9AlIQf/bdWt4tGRoiJtrw+Y1ldiRsKwZnI5hysySYZmQH2w9IgOmdl5APRYS1dH
x7bIJFuL2HH9Pj9W8JIhJcsYd9GbMiy829pMuiF+JVWVI00Kf9gepWiclCMRxVK0
RulYd/68pAmuhKoFbenU0CzgN0FlDYBTN8i26uN6NoudvBrV4doyu+fvpC4K/OJ2
CVpDWtRsGDBgcvNjd4Nft+52CVTIUwKtB1Hiwqkr0iLglhvJo/qZBVU2QQ24YwKu
/Qq2f1NZj4C5XFtaBXIk+GFYZIaXdoiukq8X24lF0CvU/7C1VnwzloWC/Wcw6+g/
LaBrzG2KN8bLJA7/jm7z9wv72XZKww==
=SUpR
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--

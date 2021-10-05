Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA474225AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhJELvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhJELvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:51:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF56361244;
        Tue,  5 Oct 2021 11:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633434560;
        bh=OYKLoUxga2Z9QEKV7pqLX90gCdbIV7CSTh1BJVCbJoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CYThp0I24XkY1HoLCdXYs4Haf9/qWmESYx39fldrtD26bgsa1Dkp1SGek6xVMyXW2
         z+UJpkigdK49F1AYblHNRnNTXqj6Rs80gGyXXR6Xh/Dq67bYzzlpNd3fIuYpU/6H7e
         f8tRClr7CuNwPIwdEaKnF4bwJy3yPQ9oMjxNRZY3tJOjL84uYvkXZ3KCxhcXQfTgu2
         TPz5CCwdj1eSsLedfVyKd6wkkfP9zmm1GrTYrs+C/8FPlPFmMgp7wbOBOqYiDdSoU8
         x3h17eopCN7WqgBapnZdnq2Jf4tLRRLBPuq4hv7wFXNcZCWLPhxhf27dxaL6ra+0Mk
         2KC5ehL3rAQww==
Date:   Tue, 5 Oct 2021 12:49:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        allen_lin@richtek.com
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: rt9120: Add initial bindings
Message-ID: <YVw7vbpu4TS+7Su8@sirena.org.uk>
References: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1uf5R5Qh6EaOZEfX"
Content-Disposition: inline
In-Reply-To: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
X-Cookie: A is for Apple.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1uf5R5Qh6EaOZEfX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 05, 2021 at 09:16:54AM +0800, cy_huang wrote:

> +  richtek,use-dvdd-1p8v:
> +    description: Indicate DVDD 1P8V is used, default for 3P3V or 5V design
> +    type: boolean

I would expect this to be done through the regulator bindings, they
would allow the driver to query the supply voltage.

--1uf5R5Qh6EaOZEfX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFcO70ACgkQJNaLcl1U
h9ABHwf6A3xy1bgkNIerD9TnHgMwpJijHvMW21OjyqwDF+uG7yxxoG3Div1cwEAY
fbBFC5RMEB+oR4RsKiY7+dwC5niavCbgH//Sv7Ylk+oi9UeWRXnTV7cDIZ6TSBBh
xmJprY83kaDlasiD+wWoES3v09jy+TRCWHluCp22Iv2+ZoP5ljT6EUFWeJ/t5FQc
5oI3zoIXHJCSpbKLjf7s5UUdF69SeAKj5CA9QeaSKR6FkV5tGsyUKII0+mKy0PzC
iBrp/xxKCAets2qxF8AllbjtKvNUt0lyDw54DZAzweZ44Cxr1Cfht1JudKGmCJuP
ZYQoeMTMN8x/39hHIxq7dCLdQ87V2Q==
=Ukfp
-----END PGP SIGNATURE-----

--1uf5R5Qh6EaOZEfX--

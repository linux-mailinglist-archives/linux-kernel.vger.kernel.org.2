Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B34436387
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJUN4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231656AbhJUN4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:56:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C551960E05;
        Thu, 21 Oct 2021 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634824472;
        bh=lj7Vy6G6Z80lDGCuR96G4sMzF/Y1joYmQP4M+9yhfgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+TZHuqIlCHt1wg04z7EpGh49E7KoKbTMN9QxrAsy8nu7hOc7eOJUYvymKZW4UrXO
         6Ov3FfD2p06hQT2syJPZUa7acj/oKbSxjXEmX27FNWn1PJ7OnzUO8Sh2wO5XYAxR8x
         HJusLK08MiABhyabi2X5xhoQISYQuRylQfHK728IFb/2bdSMr/HXQaM+AhUNpy/KYB
         NjXi9Qr3QuhRv3pDHZ2PJ306oeZTJ4xzr2GmvrxW/pafwwj7xJwJafZQyaSiobr7G6
         MEk742cJeS+IF3CPaW3DleBoyQs84otiIeOogSxdTMsBo8RONAQHp+98OfMjaefqhj
         ZklH/0gD64xlQ==
Date:   Thu, 21 Oct 2021 14:54:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3] regmap: spi: Set regmap max raw r/w from
 max_transfer_size
Message-ID: <YXFxFc1C7QnCQZx9@sirena.org.uk>
References: <20211021132721.13669-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YGyYHpIGTSbyDXNL"
Content-Disposition: inline
In-Reply-To: <20211021132721.13669-1-andrealmeid@collabora.com>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YGyYHpIGTSbyDXNL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 21, 2021 at 10:27:21AM -0300, Andr=E9 Almeida wrote:

> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> [Andr=E9: fix build warning]
> Signed-off-by: Andr=E9 Almeida <andrealmeid@collabora.com>

It wasn't just a warning, as I told Lucas it was a build error given
that allmodconfig now has -Werror.

--YGyYHpIGTSbyDXNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFxcRQACgkQJNaLcl1U
h9BrjAf9HIvL8NiTdvdOVk1wtnPu9hsIhGzfKU+c1xNUrlUDDCOj0QRxwDgokHap
ggABTQb+lexCJIz7BFQ6EOfQrzdx6r4INUCYpfJ0lYuFaW8mwrrEJPOogDfsSgi+
CtzoLqgaZGQgOaK8lfXFJX0fVoVyNh4yxP/HFWjPd8ybMtjBFj5j2RBEOuXE8PE4
8QKAe9KbcfULKBk8flUVBy2QPU/akVkTiob8T9ew/nkc9DuHGpu/BKO17lgaEPKh
Wt8+5usYBwabswkk7qliwyhRJZ31vdPX89IP2cC/Jsh9AqYpcNxQ4XngFVbzGkAX
Tp3EKOQyJdGn+3cxhn+RH2fUZx6uAQ==
=YUXJ
-----END PGP SIGNATURE-----

--YGyYHpIGTSbyDXNL--

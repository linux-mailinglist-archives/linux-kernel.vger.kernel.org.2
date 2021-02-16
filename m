Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA6331C870
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBPJzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhBPJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:55:37 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34DFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 01:54:57 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DfxCb1VDbz9sVF;
        Tue, 16 Feb 2021 20:54:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1613469294;
        bh=HYvXuZb0knOPlmLWaF+c88CkwNdfH+UjhMJy6nY83yM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cSM0tWu6SScpILWe7jYBWYC5KL09z8s/aYofNbdDYSJn5dOStu2l91K0YDo2erpdz
         AoaobN63qCW/tJS52EehjlUmqJSbPzeuUMc62Duq0JCi/KseSgS818TXxSoC8b2FOh
         e/h4nRoQ5Ux15AJwg/5RhBdUqhzSwTECJbOhTqhMQMCC0zk+O5C63mxxf6JhfFZiLX
         gc0+S2uEL1uQK4QidvSqGegey3eSrwQ+v2gH/ZM56OreiQLSe3DFNCa0DdDiam4qfb
         3YR+CFNmT+49TALz4sWjb0Lh2ErDzhwDSqOYx6Qim1Ab2e+Ggut4aslCnD0Eo7XLvX
         aI9TIpb168/KQ==
Date:   Tue, 16 Feb 2021 20:54:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Juergen Borleis <jbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2] fs: ubifs: set s_uuid in super block to support
 ima/evm uuid options
Message-ID: <20210216205450.50883f70@canb.auug.org.au>
In-Reply-To: <CAHp75VftQ6y58w+D6=nSwx3DRcLH3iwfx3RT8yv6rgS8O6OWHw@mail.gmail.com>
References: <20210216072334.7575-1-jbe@pengutronix.de>
        <20210216072334.7575-2-jbe@pengutronix.de>
        <CAHp75Vcha++UUE6hw0n_pBnA24q_uJQekABSSktmjCoinfpSoA@mail.gmail.com>
        <CAHp75VftQ6y58w+D6=nSwx3DRcLH3iwfx3RT8yv6rgS8O6OWHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qWYkc+vcu08yJpPLKWMWqLZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qWYkc+vcu08yJpPLKWMWqLZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tue, 16 Feb 2021 11:11:08 +0200 Andy Shevchenko <andy.shevchenko@gmail.c=
om> wrote:
>
> Stephen, do you have a check in Linux Next to catch the problem that
> Co-developed-by is not being accompanied by a corresponding SoB?

No, but I will see about adding one.  Thanks fo rthe heads up.

--=20
Cheers,
Stephen Rothwell

--Sig_/qWYkc+vcu08yJpPLKWMWqLZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmArlmoACgkQAVBC80lX
0Gyk9gf/cFLJBzqkelOcDcdg5i1eeRR+JHjg9FI5JWGHEWeLOksx5PD3/ZQGfkP4
2u4fkkaD+ukCwxE7CfUOxzADMZI5anlQtjaiZfwi0uMfDZdXa1RBYbs6yGAcJ6Bf
3uAaMUGhr4YUgsJ1WkfUe1KUmZeQQ/MAfRVHquYWIm/cqRLME6qFr0covEZ8PPt9
8YMuV72cn0w2+b293YNTRqVQ5NUtwPBvNGcnZebTyHupuFAH5Af22tYaQl514VZk
YJ1QuGrqbl8GvkeY3nzTC83+G2ghN/F1GZIQy88oaSf2N9l6UcvUMyQFWVrNL8oy
gcqSu9z46WumC3RP41TP+GYDwX92aA==
=319X
-----END PGP SIGNATURE-----

--Sig_/qWYkc+vcu08yJpPLKWMWqLZ--

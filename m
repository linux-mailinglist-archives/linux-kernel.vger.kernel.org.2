Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41BC37A62C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 13:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhEKMAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:00:08 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60365 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231282AbhEKMAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:00:06 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3BB615C0121;
        Tue, 11 May 2021 07:59:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 11 May 2021 07:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=dJn1C+naCnCJOpwVV8GK+Sd40jw
        0sKcNTiMpmiqDSvs=; b=geGrHHDZB8RiMMYalIgYdHTCVgpZG5I+Lxq9mVA5c2f
        phxY5FMMhZuWE66kNFv3FKQWdQqGiWhmx2c6jj/y6/rDOUlijcYsLdLpkv2tysA8
        NFboeya42h4DE+pCp61t32c4GzESQ2FYpJ4lz4ZtMoSR0IXDWz/J8P54URoFqd3e
        +XGp3SB1FGx/jUbjAGQMOydTA1JsjsmhWX60Y2aefvTVo/DALqrDSKunG74Kfx+e
        hmrYrUVC+aRZfFvn1F7fQV2vGhD23rfnzLQgEHKBXDnMHP9P2lbkTj3lLdiviTaH
        54DTi1n4jrHwCNSmaiK7vNzi6oT4EPi+4DGVpL3+ZGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dJn1C+
        naCnCJOpwVV8GK+Sd40jw0sKcNTiMpmiqDSvs=; b=sERhTGj445O6XTC5lRKT1R
        yT349vK8NISJnD3xDxZ9U16AMywZGpNp4z8OBBlBmeJ3jr0H3+MX9qlOqmIrV3J3
        jHd2Y8vDcVOVP5sBPpG64jx1+BpWjz4su0mW/+ov0o1LyQ/8RwVA1SUch/y4NNJa
        Y/y/aBTPXzrvMleIYu8qDb5ihO0hIAtXCRll1YMRFA+fw7B9tTRhEFU6vHC61Mig
        1sHQZzyEwlsrWUy4BUjG56rxc3WgGp84ZUwxOpn7Wl7l5aQF5ofkaxbCYLzJE1ae
        dIhN2KxAKpHX5rs5x8+Y8fo8LhpKBadlAlCNK+qijqXxiqiZK2dqt4FT74rfGm7A
        ==
X-ME-Sender: <xms:g3GaYMI3D_JCp2j--3_2hJAN8DNwgaIyYy4RBHzj5CBdyzslzY7zIA>
    <xme:g3GaYMIlYadTS3AeWSn6-Wq6B6Wutw-auCdTPcjsVc9PlMLWtPJGeQZAbftD15JQg
    I9xJJ-BuABwFJP0MQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehtddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:g3GaYMu3gY53XofWpMsHFqFM4EWBc7Pf4_Ou_zreyKFUZoG9zBMwkQ>
    <xmx:g3GaYJYPY_b8S8bTVwVSvm1nhwr4c0qGhNNfjkLXUfx2mqotWGOr5g>
    <xmx:g3GaYDYrupYLPEe9DDkxBNJHReN2yTI2hvD1JF_8lBfa7HEFErsXiw>
    <xmx:hHGaYKw3eM9_ssGasm33OSLRec0Z62qqcGFv7pslL1THnbCLYxxnnQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 11 May 2021 07:58:59 -0400 (EDT)
Date:   Tue, 11 May 2021 13:58:56 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     wens@csie.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update my e-mail
Message-ID: <20210511115856.muaj2qnv3dpfiyp3@gilmour>
References: <20210505173335.1483575-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pxe2xiyh5bq4m3l7"
Content-Disposition: inline
In-Reply-To: <20210505173335.1483575-1-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pxe2xiyh5bq4m3l7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Wed, May 05, 2021 at 07:33:35PM +0200, Jernej Skrabec wrote:
> Old e-mail address doesn't work anymore, update it to new one.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Merged into drm-misc-fixes, since it's the fastest way to Linus

Maxime

--pxe2xiyh5bq4m3l7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYJpxgAAKCRDj7w1vZxhR
xYlNAQCAZxVcV7whXEQtZ0N9FfucijyeXC66mlU9WxsiuTPWkwEAi+GuUiHTdEFL
RqzN4RbnbUEuUzRlQK1PguzJMaXdtAE=
=2qgq
-----END PGP SIGNATURE-----

--pxe2xiyh5bq4m3l7--

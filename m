Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459FD3F1477
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhHSHom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:44:42 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57039 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231351AbhHSHok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:44:40 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F22C5C01C0;
        Thu, 19 Aug 2021 03:44:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 19 Aug 2021 03:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=vqHEFmRLPXy4aW0PbN0wGkXPUzD
        nDzq+Y4jb3Y6XRvo=; b=il4ZH5R/KimZdVI6bBZabPFI4yvjZqxguE5YEM9DFJc
        0Dwd3sOqPQyt3HkyNhCEGXgNzQybSoeIxWs/zQQoloooCJMnj32CCAoqivfmpk+L
        ypwh3tKoA/9QGXDLjZMm35WhuIfwsm+0z738Fwq21uf/8Z5D1RveyYRinehpnp9s
        WT2tialQb8qOPjrPHW5pFLHUb5rhh0SPrp8EuUSahFSW7xFzrk3JnfKnRY29i8Nf
        3p7fUTglcLarIy/0UyZJBt2GbMohpkxXopSuE02MAoupu06oM/otDudqahoatfYk
        0K14PR2+QN4YAhjHBiwg9xbknI8mQGQfAQKRz9IoPaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=vqHEFm
        RLPXy4aW0PbN0wGkXPUzDnDzq+Y4jb3Y6XRvo=; b=qZsLQvaHJgUCUWwQCSX3ea
        T6tSykS393jHhdwvRdwN7B4cGczTSP6lfAWP9AZezCsgOZZIWL2DgPeyL3Ic9IVa
        FwBHqRG5hQ6l6Z27FTZV9HVpBeLr+LAD5Nb/rDvAiBfpFl5jfj4+nj2LPqCEkUZ4
        x2BfNR/FRMYbwkeLMLdk8jyZ9PAHgpx1jpJG8xfc+LfAbtzJonutMm4+zsjhNVzv
        6wImCtLLU+O1n9eMaMKRZ91yVgvV468eC7EBRV7TIQsmtFuwxvzlDmWjnHH5tDRQ
        ffOsAFmUQ+bZpM5ZpnC3DBexTKnbjRdGKC2hYJPducVgHAi0h753JRhLpCSwEcjA
        ==
X-ME-Sender: <xms:wQseYZOiUGQG4Ow-4qJ3j0BCLb07JvP6kMlGtWD6OWuNeIus1V8oJg>
    <xme:wQseYb9m38mDUjLrZUFgnCXpjVpdQ4kAzgM3s_ZRlS3vF-hajtMnxA-j84hKcEvlY
    FTKwMRciAz1CJdDUeE>
X-ME-Received: <xmr:wQseYYSx4vs4eRlmTO27MMXl1XlwSXrHHz_gOeq0tztjCWswpaueX9MXoKsHFmKJsK2uxyKK34aGUAeL068obzXO4_9N2AAnJmMK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeigdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:wQseYVuZlU0Xbc54SN-4haPkgBj9DDtALZU2Kky-6KJWUvjdN5FRvQ>
    <xmx:wQseYRfSofa_bBMo-xNZMKr8J_xfZoQuD0iTbOgwt2KJUK5n6BNAbQ>
    <xmx:wQseYR26wYWJusRrdtVFfZGqn0H6Je9SQdV6dCG4AgILdeG1dED0Yw>
    <xmx:wwseYaG7u9ONHZ7XKBdg9sDoVEigbm97pH6T3sxy286eTiUf6Wh8ng>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 03:44:01 -0400 (EDT)
Date:   Thu, 19 Aug 2021 09:43:58 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     wens@csie.org, linux@armlinux.org.uk, jernej.skrabec@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: sunxi: Add a missing SPDX license header
Message-ID: <20210819074358.qkvu4ynwk7s7ssuj@gilmour>
References: <20210810132954.107518-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vbqmul2x32a7rofh"
Content-Disposition: inline
In-Reply-To: <20210810132954.107518-1-wangborong@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vbqmul2x32a7rofh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 10, 2021 at 09:29:54PM +0800, Jason Wang wrote:
> Add the missing SPDX license header to arch/arm/mach-sunxi/sunxi.c.
>=20
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Queued for 5.16, thanks
Maxime

--vbqmul2x32a7rofh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYR4LvgAKCRDj7w1vZxhR
xYU/AQD4g6jwiHmuIFjM33kxqZ9OzeTFf8y/Gr80kcYW+7ZIaAEA35RX0bkLIFYO
NyGZqgj3aFPd96sZcQrBUI5FpgMbpgE=
=lOWc
-----END PGP SIGNATURE-----

--vbqmul2x32a7rofh--

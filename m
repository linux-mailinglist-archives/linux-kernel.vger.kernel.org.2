Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DD142A1F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhJLK2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235153AbhJLK2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:28:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07EB06101D;
        Tue, 12 Oct 2021 10:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634034377;
        bh=BrITH1xjQZbOUU0u8LEr9vezLFbg9RmKItK0VM60vKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFedl6eR9kW+f5m4w4GlvQqtMXJ+JZwLN+vHuipimbxGj0s6mhOQCu7jCTYdTRFHV
         P/leMmdVNa4KP0v4E7SSziZUmNG7xBzWoE3Je6s4ZdTtqqXpxT33nruGiPRDIeg/P7
         24Hdb9IYznSd8Ts5Z01dMFNCMv2MSu+AQdL8jx3GDrvYffkCOxrXnPnUxN4b/Ty8EL
         4VblIqKJPrPC7L/ReHPp661ltZxPbehxQ17H+9TE0UkaEWaCFtbHWxbMJFB6TvEbPL
         X9XFTeqKzfaBQ1xkCx4YQeQQsomKWNBJ3h3jTRJ1DtBQuEmyWRACk/GbPUwMi6ImT5
         7LQ3xJRB8j+FQ==
Date:   Tue, 12 Oct 2021 11:26:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mike Rapoport <rppt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 8/8] ep93xx: clock: convert in-place to COMMON_CLK
Message-ID: <YWVixgDQtJ8EGbwo@sirena.org.uk>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-9-nikita.shubin@maquefel.me>
 <ed557882a9530f2fd6245e34657be62399df76bc.camel@gmail.com>
 <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com>
 <e50f2da7af1fa6f02fd413081fa5762837b86895.camel@gmail.com>
 <CAK8P3a3jAdYQerE03O5s2_PBUqt5QPCPSQxxs54E7-V=0HVBXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QFJPU4twXCy0KaVZ"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3jAdYQerE03O5s2_PBUqt5QPCPSQxxs54E7-V=0HVBXA@mail.gmail.com>
X-Cookie: You buttered your bread, now lie in it.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QFJPU4twXCy0KaVZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 12, 2021 at 11:05:08AM +0200, Arnd Bergmann wrote:
> On Tue, Oct 12, 2021 at 10:37 AM Alexander Sverdlin

> > There is "ASoC: cirrus: i2s: Prepare clock before using it" still
> > unmerged as well with an ACK from Mark Brown, I did remind him
> > about it again this morning, but I can resend it to you if you wish.

> (adding Mark to cc)

> Let's wait for him to reply then. I don't think it matters much either
> way, since the series is not doing an atomic conversion if the other
> drivers are merged through different trees, and Mark has given
> an Ack for the driver.

You're going to have to tell me what's going on here:

   https://lore.kernel.org/all/20210914103212.GB4434@sirena.org.uk/

--QFJPU4twXCy0KaVZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFlYsYACgkQJNaLcl1U
h9Bzmgf/VkshJHITVrFQCN2jqp0y6M1vFldlCg8Fw+HyF3OCZxgRvNLSzGUcZ7N3
9o8869KN4ceDI2r+SjktmmEU7qkiA6h2Fw4+5o1hhPQJqIJGmpu18jPOdzKkHv9z
8Af28F6QF7oIT1hA0edaoaMJEZ4Q7Ml/Jqc9nRlAUMnifh+L6Bt55cZo5ODLJe/z
YRNnPY9d8xgJ2+Rl0D71SAeoSFTZRFP1dDwkRgJO3isCciFOqXBzSLXhuq7l3ayO
rSmnwQK6b1BamwS0dhYETq3DwNTybhJahlz2FZAaMyf7/j5s+eDpUt+Vk5LySaxc
To04k+RItVutNQBR2jONFExjQ5OXJg==
=G91W
-----END PGP SIGNATURE-----

--QFJPU4twXCy0KaVZ--

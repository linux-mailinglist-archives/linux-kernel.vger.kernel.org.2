Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CFB42A319
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhJLLXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232820AbhJLLXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:23:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D716C6023F;
        Tue, 12 Oct 2021 11:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634037707;
        bh=5TZcfUv7KHDeuiLZlOU2VoV6xvB44QlTLMSKj27Xauk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+0Tk4RcclOGw1W41KNbltEZ5Fl5OK1CRs8g5cpgNaX2JOCs55PB7+BkbThzmPtuI
         efk59CZsjQjq+i3LpV+63cwe21l/eINduXANnPWMxEYyEyyINrq4eQOUurzx10d2PL
         GgB6pZYW0hRrPOsaf9cJm7AU+z42v0RE/93GpHsYsK/0Y0OjL/kwW7d4j3EuJfkH1v
         3Zk36WPd3/EwE7Y1qqzkVZc/YzWkwuKaSxeIyTSgXw1f5hKzTKMyBWmoCErZQhvtAH
         Plr50loUc3Jzhyb5tQAE2cc7QP76TW2ptgLUr/IeRIFuQsIplCIZvxdwVCXN5Wxv/B
         8t5MpLo5GVNGA==
Date:   Tue, 12 Oct 2021 12:21:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <YWVvyKq4W4VShiRU@sirena.org.uk>
References: <20210726140001.24820-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-9-nikita.shubin@maquefel.me>
 <ed557882a9530f2fd6245e34657be62399df76bc.camel@gmail.com>
 <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com>
 <e50f2da7af1fa6f02fd413081fa5762837b86895.camel@gmail.com>
 <CAK8P3a3jAdYQerE03O5s2_PBUqt5QPCPSQxxs54E7-V=0HVBXA@mail.gmail.com>
 <YWVixgDQtJ8EGbwo@sirena.org.uk>
 <7f7acc8986aca1c895de732297b2995d05ec23e7.camel@gmail.com>
 <YWVmvHsEkPFkrD/R@sirena.org.uk>
 <7ec1690ea0ca9f6538b8228f78e62b2f38405fd4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XPZuH0qkmk8iDPBP"
Content-Disposition: inline
In-Reply-To: <7ec1690ea0ca9f6538b8228f78e62b2f38405fd4.camel@gmail.com>
X-Cookie: You buttered your bread, now lie in it.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XPZuH0qkmk8iDPBP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 12, 2021 at 01:03:56PM +0200, Alexander Sverdlin wrote:
> On Tue, 2021-10-12 at 11:43 +0100, Mark Brown wrote:

> > > Nevertheless, there are no dependencies in the patches 1..7, they are=
 all
> > > pre-requsites for the last patch 8/8.

> > So what's going on with patch 8 then?=A0 Is there some plan to merge it?

> Looks like Arnd is ready to pick it, and the only dependency which is
> not yet merged into Linus's tree is "ASoC: cirrus: i2s: Prepare clock bef=
ore using it".

OK, so I'm still unclear as to what's going on here.  Arnd's mail where
I got copied into this subthread suggested that things were getting
merged by individual trees which is generally easiest?

--XPZuH0qkmk8iDPBP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFlb8gACgkQJNaLcl1U
h9Cx1wf/eLZsbBTFRXBtM+c8WRHyqyefqRBy3QgNb7vmCUGL7weCbVTh2u0bNNSv
Gqoa9u+0ZbLXjJ/yrgIX8HhrxcvrfgbzYl99okre6gQooyRSdeOQKr2u9bqD2ha0
biPkB+FKPn61kkrGIq1k/4ZcLD5foszDlxrgwitXGFyBA/2URxt0D/dU6VNggbMA
ujPhETPIZdV8qPymzFX3Ja7QP+8uFyJ093ci8EcqkZfW05EQwNgkUO6P5m1Tsi7M
GH5NrD9fOjShFFa6VBhRE1cx7ulozkMjnJ+yDu+wUL/9fkqzs/ZVi4wLtj/J42u2
TCAIxeDQfqYGpW8IPuMtZubQWgqXtQ==
=0+9E
-----END PGP SIGNATURE-----

--XPZuH0qkmk8iDPBP--

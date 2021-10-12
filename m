Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD7342A289
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbhJLKpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235900AbhJLKpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:45:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A1E860E53;
        Tue, 12 Oct 2021 10:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634035390;
        bh=ZzuHwAkSRLULPaz5CoWOR7W7eK4U24fD6YHIlI+xiI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbozJf5gW2DrlHhLoCJdkCk41D5YsfI/EZpV7yYxzGe4aPj34aoYbKQk3TNci7H5O
         38By9ZLPYiV+y0C24F+0oVgwcoofLiSsWHy2xuk5c/JmIa7JbmTaO7Wpr43lDC/PfN
         5HiGZbCfHCDmuxM4Sjwvvu/qutgD5kM7Urq0iRLnVrbzPWfkYlQI1+V5unIh4FcZF2
         NsKXgGkt1MKkXcuUJOsjcwk8PYYHKdCO6qZmCxJcWwq5FHmF/RTfJvs8mVK0eqksm+
         MnkU7rKHEjqbGJ1WICWZo3Zy73JDDA53HxYwCvs2kVVEI+2+RB8V3KKJXX5Vfzb+6s
         eLPLxZV9sICXQ==
Date:   Tue, 12 Oct 2021 11:43:08 +0100
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
Message-ID: <YWVmvHsEkPFkrD/R@sirena.org.uk>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-9-nikita.shubin@maquefel.me>
 <ed557882a9530f2fd6245e34657be62399df76bc.camel@gmail.com>
 <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com>
 <e50f2da7af1fa6f02fd413081fa5762837b86895.camel@gmail.com>
 <CAK8P3a3jAdYQerE03O5s2_PBUqt5QPCPSQxxs54E7-V=0HVBXA@mail.gmail.com>
 <YWVixgDQtJ8EGbwo@sirena.org.uk>
 <7f7acc8986aca1c895de732297b2995d05ec23e7.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="os5yym2RVMTDw1VG"
Content-Disposition: inline
In-Reply-To: <7f7acc8986aca1c895de732297b2995d05ec23e7.camel@gmail.com>
X-Cookie: You buttered your bread, now lie in it.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--os5yym2RVMTDw1VG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 12, 2021 at 12:36:54PM +0200, Alexander Sverdlin wrote:
> On Tue, 2021-10-12 at 11:26 +0100, Mark Brown wrote:
> > On Tue, Oct 12, 2021 at 11:05:08AM +0200, Arnd Bergmann wrote:

> > You're going to have to tell me what's going on here:

> > =A0=A0 https://lore.kernel.org/all/20210914103212.GB4434@sirena.org.uk/

> here you were asking about "spi: spi-ep93xx: Prepare clock before using i=
t"
> which you've already applied (as 7c72dc56a631).

Right, you asked me to do the same thing on two patches so I didn't send
the same thing over and over again.

> Nevertheless, there are no dependencies in the patches 1..7, they are all
> pre-requsites for the last patch 8/8.

So what's going on with patch 8 then?  Is there some plan to merge it?

--os5yym2RVMTDw1VG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFlZrsACgkQJNaLcl1U
h9CB6wf/a0ZkktyCoQ535RjWNK5MCH2fqOa/THbkumTymP6jPTw0SFzxXku9k7zv
LggvJZEx3SDK7E7ZqwYp/YpehuetaLvRYM66Zy7zjaq4glHzY3cjhaJ/rvkoEQsg
njPJHrVDG/k4qAnQCNmz5xascl8CnwtOPul0ExjkSUx5IZXZewlaNKnpweoGACVF
OHuPHPpSWiTtKYs1QuVWAXZKJjceTCX+CXb4vKHh5aIBjIF9w/YxUsnNg9ny3T2Q
iGSf90YAOc/7qMEQ46kK9kv2bh5lkTtpGqVd1CqEksTRY649YzMqBZ56C3vCiJFI
zsgbbJ/RLlNwBhWj1sKQAanHv+Ohnw==
=+n8j
-----END PGP SIGNATURE-----

--os5yym2RVMTDw1VG--

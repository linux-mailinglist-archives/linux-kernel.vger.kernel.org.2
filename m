Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0072E42FE31
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbhJOWeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235622AbhJOWeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:34:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D66E160698;
        Fri, 15 Oct 2021 22:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634337128;
        bh=srVq9B6jdx+qQuHvDEeRfVkqSSFLinZjEJIeG1yNMTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=axer42DcN4pwdhdxGwYyMzG9wAjsQdoPV9LWlLFXWOJntBXj1k9TMM5Bf/oYvfaF5
         Zl2Mrm1mebm7O/kRX+YUnibz3qX3430LmiVr3BLXGuRd2u5sEIo97qoSOEJk3eK1pY
         XXXhPDcwYWrWml4TSSIWboEzpaHs7l6ReKdtvgZmXfj9pN6Dbk/cuHVDLM5qI+Llzp
         S64IXs58XzaOJcgnq0lsifAVZrzZWXJZkPimZyWqYayun/ylERvaQ5KlDBoQpaATSz
         WYCmR5NRCxo/IwbasBHj7w5NOsBxdms1qq/9NJcjla1q5DIYhZpaRNz9KRwJtM3J/6
         yTW+BjhI6wNsQ==
Date:   Fri, 15 Oct 2021 23:32:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Nikita Shubin <nikita.shubin@maquefel.me>
Subject: Re: [PATCH v2 8/8] ep93xx: clock: convert in-place to COMMON_CLK
Message-ID: <YWoBZY2sRaROxy+Z@sirena.org.uk>
References: <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com>
 <e50f2da7af1fa6f02fd413081fa5762837b86895.camel@gmail.com>
 <CAK8P3a3jAdYQerE03O5s2_PBUqt5QPCPSQxxs54E7-V=0HVBXA@mail.gmail.com>
 <YWVixgDQtJ8EGbwo@sirena.org.uk>
 <7f7acc8986aca1c895de732297b2995d05ec23e7.camel@gmail.com>
 <YWVmvHsEkPFkrD/R@sirena.org.uk>
 <7ec1690ea0ca9f6538b8228f78e62b2f38405fd4.camel@gmail.com>
 <YWVvyKq4W4VShiRU@sirena.org.uk>
 <00781d5212bb4015064d07e762ae0695d16e834e.camel@gmail.com>
 <CAMuHMdUCpfpORD9r28r1hdtdKMPyvXtkYZQsiBCfM8WDcLYKFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="epVURa0amJBnKkSs"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUCpfpORD9r28r1hdtdKMPyvXtkYZQsiBCfM8WDcLYKFw@mail.gmail.com>
X-Cookie: 1: No code table for op: ++post
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--epVURa0amJBnKkSs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 12, 2021 at 01:30:19PM +0200, Geert Uytterhoeven wrote:
> On Tue, Oct 12, 2021 at 1:26 PM Alexander Sverdlin

> > I only wanted to ask you to pick ASoC patch, I can resend it if you'd like.
> > It has no dependencies and all the previous patches were already picked
> > and are visible in the Linus's master.

> So it might be better for Arnd to pick up the ASoC patch, too.
> Else he has to postpone the final CCF conversion patch one more cycle,
> to avoid regressions.

Yes, I think that makes sense and I already acked both patches so I
think if those plus the final conversion patch are good to go then the
best thing is to merge them all via arm-soc.

--epVURa0amJBnKkSs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFqAWQACgkQJNaLcl1U
h9AXDQf+MxBU9o6R/OZ60uL3Rz3i0E1fTV33FJ35Ri6ld1qjVpt71GQl+ubfJhQv
wudxmCgnD0g+DykNBBWbyF60UyNLvvc5ivzGTngf+PUpunDG7lsHI8lCz+khVls8
25Krb7OOPqKwkeSveY6p52l0964p/REen5Q7gm3LYWVpJKZFMEmLW1WwrVwRUcZS
rNFM1mRe1m9iJzjyVPZ3AoMGXeBEwlcRN8ruNyd88n6xLxpelPTrU/or5xldwygB
cqBPRP390CoNhpbXypRM16FB6W35/YiHMuCUUgq1nkaJ0M6sIU82ZrZvnvk/GtE4
LYIfKt30YQM8ANpznGqtZHb3usEZKw==
=IocB
-----END PGP SIGNATURE-----

--epVURa0amJBnKkSs--

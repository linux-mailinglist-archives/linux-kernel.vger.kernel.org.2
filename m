Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3282B40AB77
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhINKO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:14:57 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:34109 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229968AbhINKOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:14:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 2394F2B012D2;
        Tue, 14 Sep 2021 06:13:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 14 Sep 2021 06:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=oBkNfwyFzUbtgbbxm3sHHN53g0U
        wRCANpiEbWwktEsI=; b=1saxKCPQGLyQ9IO2OCEV6o2kPTwXjd3vIQWapzf+fgb
        UrZX1Z31cJBJH3O0CvzaCg/tJkaEdV+0R6lk0cYA+rZfyc2qOpIvEh3+XHu1Pos+
        fvkJVg+kT7eusAULpNBvxiQsVXYmOxgrNSR1RZjT09LjCZKSxUYtOQEKYtKJvJ4a
        yQOReC6tqf+5wImhT4ZO6iJpNzHiELkq6QJ+xafntOwLx5XeIPlQRcKeCMM09t5o
        njLYtmJXMM7j04HxnUnrGh3ytwZ0Wu7yqjMgcJpqtCzKrr9Fn3sCorKJJqakz015
        W5ZMOobvkDQK2RjyHOfwZVkFRgwFN6ez+3sU9Z8aL/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=oBkNfw
        yFzUbtgbbxm3sHHN53g0UwRCANpiEbWwktEsI=; b=fMXTe22TPUjVB0nQGW/3a8
        CIVrrOSnSNZOEcSpfwA8vNQubDmNMKhzvpLEeS71tvXMf/EwQoKLZ7ItUhGCW1tS
        G8KQrpTPC8gkugyxfY2EFx4ldevGSRS0toLemois9zOzY/oHXesYC4squj9fGWIR
        4rwM6m3sLmQ1gJ5Q/DEDayWghxTyfyL8HXvP+PRk+axI5cE9TXh2erkAcDUk8tOV
        t+NUaonwkCTGXimxrQkDXaqNQzfsRgEiviuRQBZAvciS1g2+14UbaafZPthI3jlf
        XSmgBKf5YhPb6QFZ3mBlD+cqdlTupVo6whS4uulpG5CddzMheuY2fHNN31RpyPrQ
        ==
X-ME-Sender: <xms:yXVAYbAM0iwHcxani78TfepPJ6irhUYyuxp0qLWL-Ja_IGRcCW7xNw>
    <xme:yXVAYRijC2fVqg7QhatKutOfgIDCUbzsuEryoPb3NqepWou-Z24MdN1sbyhvkxBJ1
    48vSx45vj-80PHyR88>
X-ME-Received: <xmr:yXVAYWlZ_HWSTrWyPik46VRYoL27Q-2-6wfjJ2oeDClJCioBsWZ5e0fm0MY2pq-fXcWMiMirsPxU-JzI6rvv1QpF-FWH9Jx8Zyiu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:yXVAYdzTdbRlpEDy3hE0K7RDUO3DnmSX2VlgiwnJ4G0nmVURW4B6iQ>
    <xmx:yXVAYQShlgXeh0lvaJGEFaIren79h9upkTV4D44J3yIM1WdtR9Ds3g>
    <xmx:yXVAYQbDYh4Xry2PetppjAx-z-khpXo8-u4k1GzxE4xpInri6PeZFg>
    <xmx:y3VAYZTbrtyLiJeLzEM8XDa0LznC8y4g5sNdg7YjpkgjASH5p-q_8jU_yYU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 06:13:29 -0400 (EDT)
Date:   Tue, 14 Sep 2021 12:13:27 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Christoph =?utf-8?Q?M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        philipp.tomsich@vrull.eu, Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        Wei Wu =?utf-8?B?KOWQtOS8nyk=?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
Message-ID: <20210914101327.47baun6mop3mc56j@gilmour>
References: <20210911092139.79607-1-guoren@kernel.org>
 <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour>
 <CAJF2gTT_8VLTt0B=LxXAPWVpHaBaVxy+V0rGCjr7JZyRiO7LfQ@mail.gmail.com>
 <d2ac3da8-f4d5-52c1-da7f-f8260a0bb604@infradead.org>
 <CAJF2gTTVj2J6_rCXAG81PB3vJZO2TTwpD03vAE2q+K=9zh_TzQ@mail.gmail.com>
 <CAK8P3a1TY+XT1vF=wAh0XA5BXU5Z6Ab1d4DekXbVsN9aj3aL5w@mail.gmail.com>
 <CAJKOXPdH0C0CJe_oxZ2rG1UeE5G9w2mh2Thh8LynpNHQk2g1qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bilmfgj3f2ue6b6g"
Content-Disposition: inline
In-Reply-To: <CAJKOXPdH0C0CJe_oxZ2rG1UeE5G9w2mh2Thh8LynpNHQk2g1qA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bilmfgj3f2ue6b6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 14, 2021 at 12:07:08PM +0200, Krzysztof Kozlowski wrote:
> On Tue, 14 Sept 2021 at 11:31, Arnd Bergmann <arnd@arndb.de> wrote:
> > Some subsystem maintainers want drivers to be selected by the SoC
> > option, this is why you need the 'select SIFIVE_PLIC', but usually
> > the drivers are selectable with a 'depends on ARCH_SUNXI ||
> > COMPILE_TEST' and enabled in the defconfig.
>=20
> I would say selecting drivers is even more useful for distros and
> other downstream users. Especially in the ARM world where we have so
> many different SoCs - how could a distro person know which driver is
> necessary, important or useful? Having all main SoC drivers enabled
> when ARCH_SUNXI=3Dy, helps distro a lot.

Imply, maybe, but select is far too painful for everyone else.

> > If you want to get fancy, you can use something like:
> >
> > config RESET_SUNXI
> >         bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUN=
XI
> >         default ARCH_SUNXI
> >
> > This will make an option that
> >  - always enabled when the platform is built-in
> >  - user selectable when compile-testing for any other platform
> >  - always disabled otherwise
>=20
> +1 for this pattern.

Yeah, or a default

Maxime

--bilmfgj3f2ue6b6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYUB1xwAKCRDj7w1vZxhR
xaW4AQCjA2HZIq35rcUZ4xRg5zpPUX/IlJenhzSsJVR4kVhhUgD/Qfn9Rkd94UgU
C0UYsWax+a1VpEmYSy5tBJAotQXQvQw=
=u+RQ
-----END PGP SIGNATURE-----

--bilmfgj3f2ue6b6g--

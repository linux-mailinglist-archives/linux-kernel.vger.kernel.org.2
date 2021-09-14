Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF4040A73E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbhINHWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:22:11 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:55319 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235026AbhINHWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:22:09 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 9B6392B01244;
        Tue, 14 Sep 2021 03:20:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 14 Sep 2021 03:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=r3z+1fszfE1gQgB+PhQEZNe+vTo
        g8UxvAWLg30OlyPQ=; b=G/gD/Kl4b74mLyIJd66lZu5Yo/D9Zk0LH8gY7wH/FeP
        Nz1yR7TGM5Tq0E7jBj+Pe3dw8XmUvCZ2Tf9FwAZziG5eUb7iU5dzblMZ6dbRHN80
        L/jIwwft+KbSprXsqoLwqJ6XHHccmimf0nRcHEclkc6zFCSyrAcGeTMMDhEbUL5g
        wmDRwywS2rXzOQkmC8smWI6tvBmlvvqalWta8k842lHyTCYj+ODRs8ueNNE3/jY2
        gCikhcckj1hv3T3VCwF4to7TgudEPWamZLvkB15itzkpwHnOAnzXMpexWqBbgeWF
        UtFiUKET6oGgH3ZWy4esp18i4Zw+xDoSBxkrsX2BulQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=r3z+1f
        szfE1gQgB+PhQEZNe+vTog8UxvAWLg30OlyPQ=; b=iqgPMLNMOcjMDFc71SsBK/
        pKmNlqq+8UkXZzNtVuUuU7HxNxUaM2hBQD5L1DuNkQpAn6vyH92KREn8xDSa+XjF
        6DGiyYTz8UZmCmOtOnlH93x7oacEqWLjVMn8RUKnjvOJzV0WJsa/LHXu24yGFQ1R
        mdC3MONrY2bsXSKmIR0e2ttQGAPyACnQ9S6dNvojMTe7YsoBA7pjQd32TsoF97rY
        pGqKZ5Gj56rykhpKFyMJ7xveBTs4uQjMd6xsyqDdPd0M13xGZJ2EQihmRRRCfGdq
        6Z8JqfaH6vJ6KeL7nYsbWuQB8OnpSDcjBNuqq7nzOZS3bq6gU29JIg47q0dhqT5g
        ==
X-ME-Sender: <xms:T01AYax4d-hSa4FQiv6LmMkRkyFLGxdEOWkq8BMVndsVOjWkDRC_8g>
    <xme:T01AYWQFz__bZUsK2WkcuQt0Ox356iPNIP6F-JmDVo0Cg1KR4fh7OHSaWOgJrpBIg
    bNnXFUkq1ZSlELUPAA>
X-ME-Received: <xmr:T01AYcV7jZGtMirbdWn8_G8gxUM2TJ0FwLA-l7XlUQOzx95oOCLBUlteiuXkPBKpi49wFkGJHHLtSI62CC-AvXPZfrsF-cLuUWA2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeevgeduteektefhtefggfdtkeekgfehhffffeegudelheegheeiueevfeeg
    vdeigeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:T01AYQgd8Er7NkXUTfsDojYWAB-uSohRL8WzfNGhQ8R3jDwtzoyNxw>
    <xmx:T01AYcBQ9ZHyzc0uvap5l6kDamTJYv4AIw9-WdYEhXvNBf_gWFH_EA>
    <xmx:T01AYRJ-5v0xCO2AOrHEOYLeTYD7ZFMyZrrb-jlsWry0noifvTuTTQ>
    <xmx:Uk1AYc35cNV5-xhOsRonCfKX3hUuZfYfsQaClMSncnytyQXu6A6-Yh4jkvM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 03:20:47 -0400 (EDT)
Date:   Tue, 14 Sep 2021 09:20:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     guoren@kernel.org, Liu Shaohua <liush@allwinnertech.com>,
        wefu@redhat.com, anup.patel@wdc.com, atish.patra@wdc.com,
        palmerdabbelt@google.com, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, lazyparser@gmail.com,
        drew@beagleboard.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, taiten.peng@canonical.com,
        aniket.ponkshe@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
Message-ID: <20210914072046.s3nhxaut6kihe3tn@gilmour>
References: <20210911092139.79607-1-guoren@kernel.org>
 <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour>
 <e46bb02d-961d-672d-76c7-9844d76ee69b@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zjkz7mw5vd3whnco"
Content-Disposition: inline
In-Reply-To: <e46bb02d-961d-672d-76c7-9844d76ee69b@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zjkz7mw5vd3whnco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 14, 2021 at 05:49:52AM +0200, Heinrich Schuchardt wrote:
> > Hi,
> >=20
> > On Sat, Sep 11, 2021 at 05:21:39PM +0800, guoren@kernel.org wrote:
> > > From: Liu Shaohua <liush@allwinnertech.com>
> > >=20
> > > Add Allwinner kconfig option which selects SoC specific and common
> > > drivers that is required for this SoC.
> > >=20
> > > Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
> > > interconnect issues for dma synchronization, so we set the default
> > > value when SOC_SUNXI selected.
> > >=20
> > > Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Wei Fu <wefu@redhat.com>
> > > Cc: Anup Patel <anup.patel@wdc.com>
> > > Cc: Atish Patra <atish.patra@wdc.com>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Chen-Yu Tsai <wens@csie.org>
> > > Cc: Drew Fustini <drew@beagleboard.org>
> > > Cc: Maxime Ripard <maxime@cerno.tech>
> > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > > Cc: Wei Wu <lazyparser@gmail.com>
> > > ---
> > >   arch/riscv/Kconfig.socs      | 15 +++++++++++++++
> > >   arch/riscv/configs/defconfig |  1 +
> > >   2 files changed, 16 insertions(+)
> > >=20
> > > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > > index 30676ebb16eb..8721c000ef23 100644
> > > --- a/arch/riscv/Kconfig.socs
> > > +++ b/arch/riscv/Kconfig.socs
> > > @@ -70,4 +70,19 @@ config SOC_CANAAN_K210_DTB_SOURCE
> > >   endif
> > > +config SOC_SUNXI
> > > +	bool "Allwinner SoCs"
> > > +	depends on MMU
> > > +	select DWMAC_GENERIC
> > > +	select ERRATA_THEAD
> > > +	select RISCV_DMA_NONCOHERENT
> > > +	select RISCV_ERRATA_ALTERNATIVE
> > > +	select SERIAL_8250
> > > +	select SERIAL_8250_CONSOLE
> > > +	select SERIAL_8250_DW
> > > +	select SIFIVE_PLIC
> > > +	select STMMAC_ETH
> > > +	help
> > > +	  This enables support for Allwinner SoC platforms like the D1.
> > > +
> >=20
> > I'm not sure we should select the drivers there. We could very well
> > imagine a board without UART, or even more so without ethernet.
>=20
> The draft of the RISC-V platform specification is available here:
> https://github.com/riscv/riscv-platform-specs/blob/main/riscv-platform-sp=
ec.adoc#uartserial-console
>=20
> The specification requires in section "2.1.5.1. UART/Serial Console" that=
 on
> platforms with a rich operating system (e.g. Linux) you have a serial
> console. Hence requiring 8250 support for the D1 CPU is justified.

I mean, not really? The platform is required to have a UART, but nothing
requires the kernel to have a driver for it as far as I'm aware.

Maxime

--zjkz7mw5vd3whnco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYUBNTgAKCRDj7w1vZxhR
xbLcAP4ydU6yZPm2aqeZbdBFbajBZuxuBTifIing7bv4DsbamQEAsVTigkpi8Fxu
cJpZogfYIkGjA8oqsLG4qw2IQ3eV8gM=
=Q8eQ
-----END PGP SIGNATURE-----

--zjkz7mw5vd3whnco--

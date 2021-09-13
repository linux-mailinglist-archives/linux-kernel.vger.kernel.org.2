Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF15540874D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbhIMIql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:46:41 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:40311 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236022AbhIMIqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:46:40 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 563CF580C64;
        Mon, 13 Sep 2021 04:45:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 Sep 2021 04:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=3xA6WliwGm5jheo/QDh1OhhZHgC
        8t0qVZf0QWCOOHQY=; b=QK6e7NYjQrp3tC9TWK86Gz7Llio7+rF5/1HJVaEFRSU
        hm2686y27TjHe+yJ37qLGYnfd4xHOdMPASf1rPnSgC7lKW7sKhsr1WGlunegHLyP
        1BdtwcGB+0tYCUuW7LAYIWxQ//uEIw+SvAd83lOSzzQJuHZzTjWOL7axsfxTAsaF
        NPnxjr4s+kqB09JEzRn6eywmxALCnAw4zPqw5V9BBckKB52aufakZ9iKGufj/7aF
        QZzB4eVRb98Z3LoCV6sQ4LeHkQIwJi9qvEgFEKcLIvUoqtooFJ2lTNU+7mbw3Rj/
        C2WaOdVdxA3lKpBNTL9BcPTp6VQCHcMbeXCbcFb8cKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3xA6Wl
        iwGm5jheo/QDh1OhhZHgC8t0qVZf0QWCOOHQY=; b=k7OjXt+/juxGGdFbWdXMNy
        BZ5IJiEWYmT62dPp6ekQ/Mb9USqzKMaNXssS/U8ddVrj5J35CZg1+yXLxTbXv1Gz
        z52tz7cVTBV19ptU0HlrMfr7JRRAg5zn6vyo025iWM03Zw0KlN1dJolHW5vdewOp
        ZT+jUaYMjzm3DXWaBumhNi+HRiCdbTXeSSi1xxsi56/8/KF9Jp/nOJNW2zikUqrD
        NZjk8+btDjxFK5hlt6U9UquOWh95iACkP/SI/a98Z5abkIz77TGgxaiiDcnZv680
        W6OAjtsomwZd9BLvL4uO1GI/a1NpHcV5axUeKGHW0p1FUywy1WnNGO8WVKTYzqPg
        ==
X-ME-Sender: <xms:og8_YfeGI-H8Jzo1-4nlnDG2CzdriHN4qqJokV0kqSXQ-irHKwR49A>
    <xme:og8_YVN9DK0SBXqSgmmCShDGwpiDISkwR1hw4RxHafOylk48FpsfISNILrzsAZOHG
    3P7lIgbYJyZpXvOA64>
X-ME-Received: <xmr:og8_YYhGzmCx7aKLDWDfVwg4U0mooJAx95Yu5ICCqGSdZY2WtLYJiT7ImqTYTu_71J4DXKLjZyZMTHRvS1wrexvWgJtyYtO2DqSr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegjedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:og8_YQ-kdcXTlmRHsqOj73Kn8AkrFpXxTNmqxeRu7aqI6aP3C-jFtQ>
    <xmx:og8_YbsYlEB4kfkPeHb3sKr1Vsgmhxiut0TQ0WzfaJcfhzjCijCu3Q>
    <xmx:og8_YfElkQQNWjLF0uU1obSU68HDbbsSDil_rJUBvAiJluItFn1lgQ>
    <xmx:pA8_YXTCZWgfiG9sLalqvJ0FGekWvOy48LUP0K_qo2D3_FbiXA5-CQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Sep 2021 04:45:21 -0400 (EDT)
Date:   Mon, 13 Sep 2021 10:45:20 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     guoren@kernel.org
Cc:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu, hch@lst.de,
        liush@allwinnertech.com, wefu@redhat.com, lazyparser@gmail.com,
        drew@beagleboard.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, taiten.peng@canonical.com,
        aniket.ponkshe@canonical.com, heinrich.schuchardt@canonical.com,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
Message-ID: <20210913084520.kkbsupogkzv226x3@gilmour>
References: <20210911092139.79607-1-guoren@kernel.org>
 <20210911092139.79607-7-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p2xnpxdfevxsmmn3"
Content-Disposition: inline
In-Reply-To: <20210911092139.79607-7-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p2xnpxdfevxsmmn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 11, 2021 at 05:21:39PM +0800, guoren@kernel.org wrote:
> From: Liu Shaohua <liush@allwinnertech.com>
>=20
> Add Allwinner kconfig option which selects SoC specific and common
> drivers that is required for this SoC.
>=20
> Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
> interconnect issues for dma synchronization, so we set the default
> value when SOC_SUNXI selected.
>=20
> Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Wei Fu <wefu@redhat.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Drew Fustini <drew@beagleboard.org>
> Cc: Maxime Ripard <maxime@cerno.tech>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Wei Wu <lazyparser@gmail.com>
> ---
>  arch/riscv/Kconfig.socs      | 15 +++++++++++++++
>  arch/riscv/configs/defconfig |  1 +
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 30676ebb16eb..8721c000ef23 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -70,4 +70,19 @@ config SOC_CANAAN_K210_DTB_SOURCE
> =20
>  endif
> =20
> +config SOC_SUNXI
> +	bool "Allwinner SoCs"
> +	depends on MMU
> +	select DWMAC_GENERIC
> +	select ERRATA_THEAD
> +	select RISCV_DMA_NONCOHERENT
> +	select RISCV_ERRATA_ALTERNATIVE
> +	select SERIAL_8250
> +	select SERIAL_8250_CONSOLE
> +	select SERIAL_8250_DW
> +	select SIFIVE_PLIC
> +	select STMMAC_ETH
> +	help
> +	  This enables support for Allwinner SoC platforms like the D1.
> +

I'm not sure we should select the drivers there. We could very well
imagine a board without UART, or even more so without ethernet.

These options should be in the defconfig.

Maxime

--p2xnpxdfevxsmmn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYT8PoAAKCRDj7w1vZxhR
xbVnAQCSKte+mjnWETzsLGCmouHNDj3ez50SJLr19qM4sU85pwD6AxCJ/iy45OIu
yqt3psn20BR6AvoN5uS5dcTBkr2TLgI=
=Tz1F
-----END PGP SIGNATURE-----

--p2xnpxdfevxsmmn3--

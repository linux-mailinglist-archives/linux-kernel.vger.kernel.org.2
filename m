Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0622F3D539E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhGZGbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 02:31:45 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52727 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231902AbhGZGbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:31:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 24C255C00FE;
        Mon, 26 Jul 2021 03:12:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 26 Jul 2021 03:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=FOM45Nbgqhzqji4kt3Q5tWngXrQ
        9l5jHcneF1DYAQzw=; b=IcNhuMHflISdKzo2bgPOe/huj05/aa+FGpUaWkNife0
        j5jQFKhTGf0F8A7uUoMiuxHfun2BzrQPVgHPN+mdxhS9GFKe2k1IZBfKFUK3RtxF
        b+UDMGNMrxYqGzpDL339SMR8hUP3jAybcbmZivOtDIFWqwnc+dULEKN4pGCt7MLO
        L6h+3aUmf+ByMFgxYFY9OqCLsm2J8hOZYCJ4QYiFwmNovMsQoqSidn74sXIU0WId
        NBRHtR+znkBRmrvOMnuv7VzgYsefYM/Qs0mOmLFJnoeHUNdDx9FS0bq9cJGhGcwP
        Y0/QuDx7rcdkuzJaKyDxS2pZiq1VasEBLw7V4r8WCbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FOM45N
        bgqhzqji4kt3Q5tWngXrQ9l5jHcneF1DYAQzw=; b=wlUZrY4NL55L65s2Zz4+oK
        WkAUNO/AOre3Ip+hWRv0iGZ9ZVAaS0uDngkEPPuicRjYziHh60PaeAK2AQxUW8gO
        VD/5sqHxen90ItU7TY9XoHfrJS4F1KzSZdGhm8CSal4ghKKZbZAfY6QY+b23CDwn
        awIswNW3JkrHLZGr/WKnlZ3MTdfKDrz5BvYMkgyRPQpuBgfXPGDcWBqueYkjs+OZ
        EmnfB7xAzJ5O6yB59mfvjQfTOhLSWngvKGKcX5IgXUpHUMC/lJTZbIsp38wHklzx
        8wp1AsrRyipiCXni1winvMF9t7BYFvUqMj+0Rcfql4fhXqwi+8tugpaOh6dsr4gw
        ==
X-ME-Sender: <xms:SmD-YMsm4xMycChClaeceUEMSDG08Q65ZHUmTn9wKMeYbhWhNKx4DA>
    <xme:SmD-YJcCrKH9yD3qDb9bwtY7CoGGiZDdYWuxb1FZ627AdbGvtWOJp0Q-ar1K2BKwq
    nqSSVQibkESdzr0Mh0>
X-ME-Received: <xmr:SmD-YHwcJa31PtAoJfY6m3WJgL0fpWTzUrfREslvuIgN6DLj2HNzJTX7N-r1xRlrbPeNYOcfa69pSDQKt_k10u5GJ7SgUmXoeLhJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeeggdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:SmD-YPP0lx9Q8WPV3_hDyucRcg3_UobIqr03OI1xIl7iSJ-VLIqj7g>
    <xmx:SmD-YM9hDcAFJ5r1Mmg8dA2RpEneCFvpn9bg6rjl_2KKJ2s38tYPeA>
    <xmx:SmD-YHU7Tfkb7mNJRKoHw97fcBE1S9FU8BVTo7V1vS6k4w-OEyUlfQ>
    <xmx:TGD-YLnD2jl0karjRyCwkgUklnj7JmrPCOIK6CBGHj0IySzGt7D6qw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 03:12:09 -0400 (EDT)
Date:   Mon, 26 Jul 2021 09:12:08 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64: dts: allwinner: h6: tanix-tx6: Enable eMMC
Message-ID: <20210726071208.zobi2adk4eqeb3gw@gilmour>
References: <20210722161220.51181-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fx474fpnmwxuuu2u"
Content-Disposition: inline
In-Reply-To: <20210722161220.51181-1-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fx474fpnmwxuuu2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 22, 2021 at 06:12:17PM +0200, Jernej Skrabec wrote:
> Tanix TX6 box has a 32 GB eMMC module. With changes in this series, I
> get following figures with hdparm -tT:
>=20
> /dev/mmcblk2:
>  Timing cached reads:   1638 MB in  2.00 seconds =3D 818.44 MB/sec
>  Timing buffered disk reads: 376 MB in  3.01 seconds =3D 124.74 MB/sec
>=20
> First patch fixes regulator node names. Second patch sets proper power
> supplies to GPIO banks and third adds eMMC support.
>=20
> Please take a look.

Applied all three, thanks

Maxime

--fx474fpnmwxuuu2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYP5gSAAKCRDj7w1vZxhR
xQoIAP9tJ13mJPkGx1jSuFkL5vq/ISxHl8BzdOfBSRzO0rfOQQD+NjzOrxL8IB3e
NyT78ppbHtBmawjTJRh7aGOc6GeUOw0=
=lXOd
-----END PGP SIGNATURE-----

--fx474fpnmwxuuu2u--

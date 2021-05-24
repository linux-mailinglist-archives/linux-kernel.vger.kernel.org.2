Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B102638E61E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhEXMEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:04:00 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:37177 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232711AbhEXMDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:03:51 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 56F05580389;
        Mon, 24 May 2021 08:02:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 24 May 2021 08:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ZIvaBg3AS0bbGAJOf0B9r0173eR
        WkVY0e/Omll3dxIY=; b=BKJhzwUEpZHsChORCSs1KfnqZozEp6mUSuppZXiP3xq
        og4CUa4fdSAivnSPXZJWN/JKdEzfopJ7+G6XDonVnvwj5C3FNCcQR2Mj6GxGbHP8
        uINRZ97dcHlfT1+5VFUtQeo/377bVmHF++pNNb8k8otkHnkrai5HEYdaSrYO0B+H
        Y/tD/KL71GOtATGvJbErG/am+v1hPrB+JObgug0sFCAW34AyW9HRaSWMj43tjAeU
        ruPo4DwOWDivFiyeZLSNj/Hl6Ns4xxzZInoz2gQxBx1QLxEMM1UINmwvsOlxdVQ5
        NZ9agZvdstKSmVaJQbNB75Eu1GLqleCUKCWSnrF13kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZIvaBg
        3AS0bbGAJOf0B9r0173eRWkVY0e/Omll3dxIY=; b=bGYtk68+Wp9vhQPyVAk8HL
        i4r8QnkbgOq5eft3VCTYxZzNiA4sdfS7tBQloqYFP2SfKhcZAypRo/X/gXVuCM6u
        1DpDyPy7AASuBC29TGs5aPdsj8vlwpggpWllFtnRWQTW77UJAXiEilcesEil/TzH
        t8wOKGpkuVKV/aJDW6zTd6WfdRNElCdw405eUuWR51VCLfhAzoSHvwFijQbt0Lgd
        7LkCa/CeipSLe8BwihvOOYxCAQ0bh2wp7UqLoGRuJhPaIUjH0w6S7r+frXL+x9hy
        9bFTENuodp8H35XY9mzWO9ex0RQejHVRZhdvw9XYwdDShCVMMVrDr6UloYbouoDA
        ==
X-ME-Sender: <xms:zZWrYIm498JknHrSD4mgO0Dpcn5qiPVpM-N9py3MIqpbk6__JMT8oQ>
    <xme:zZWrYH3Ehsct838tmS2mPU488CkmmHT5sqhENa3TVasKwcw6ap7WQqhHQnTaeCCop
    256851YoERSqBGSIwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:zZWrYGpPhomkH0AMiIrovgUkTbskZnhmjzoZsp6BQ2nLmCWxBKQ31Q>
    <xmx:zZWrYEl4JKAmRekOp0CBBRFGsvTGqWCD-9xAEXgGfAKfZAh0D7X5FA>
    <xmx:zZWrYG2RKGEmB0pkRDtmGdLQqvc-g75NE__IhSgodjJNMCl8pIzUHQ>
    <xmx:z5WrYEw9XPA3Jhk2YqDLUY5H-5VDnRVUhf-HniMu19il2sYEj7T39A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 08:02:21 -0400 (EDT)
Date:   Mon, 24 May 2021 14:02:20 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 14/17] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
Message-ID: <20210524120220.j73xwq7n5qbaxs4r@gilmour>
References: <20210519104152.21119-1-andre.przywara@arm.com>
 <20210519104152.21119-15-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sox4cvhyosn2bo3r"
Content-Disposition: inline
In-Reply-To: <20210519104152.21119-15-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sox4cvhyosn2bo3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 19, 2021 at 11:41:49AM +0100, Andre Przywara wrote:
> This (relatively) new SoC is similar to the H6, but drops the (broken)
> PCIe support and the USB 3.0 controller. It also gets the management
> controller removed, which in turn removes *some*, but not all of the
> devices formerly dedicated to the ARISC (CPUS).
> And while there is still the extra sunxi interrupt controller, the
> package lacks the corresponding NMI pin, so no interrupts for the PMIC.
>=20
> USB is a bit tricky: host controller 0, 1 and 3 depend on some help from
> controller and PHY 2, so we need to include one reset line and one
> clock gate from HCI 2 into every other HCI node, plus need some nasty
> quirk.
>=20
> The reserved memory node is actually handled by Trusted Firmware now,
> but U-Boot fails to propagate this to a separately loaded DTB, so we
> keep it in here for now, until U-Boot learns to do this properly.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

As far as I can see, the IOMMU hasn't changed between the H6 and the
H616, so it would be worth enabling

Maxime

--sox4cvhyosn2bo3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKuVzAAKCRDj7w1vZxhR
xQ+tAP9TNLccFu5O4mWKvowHiezII3G2D6JMxCJJWRPCJh1mVQD9ExAK80a7U4NK
dYRCuyWYq6rDScshGrpZClp8eVpAdQo=
=aG0v
-----END PGP SIGNATURE-----

--sox4cvhyosn2bo3r--

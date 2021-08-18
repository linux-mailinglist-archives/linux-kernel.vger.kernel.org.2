Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44C63EFF7C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhHRIsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:48:23 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:59225 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhHRIsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:48:21 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2FDCF580BCE;
        Wed, 18 Aug 2021 04:47:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 18 Aug 2021 04:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=hsyVK7qJHHuj5gPDNSdTsPzWA01
        bJfj2s8A4rzDCYeM=; b=cixuqyYClMGrVDcdy8O3PVuLZefGrwyUY3KkVmwV2Ki
        dpRaulWZD+UO81GP1M18wNgod/oCl2NpcOJrU+NvrgMN9YyH5tcO6ZcW1yhAkKs7
        4RR/m93pyMh0nfxGYbaefsO1CwI6MWY+ESkQU6I6LncOIKze1EMLdHmmlO9eqtvn
        6spGbRVErUHUE+Ta4QTAYDU5Y+/2wCiu3aKw4+dtt4lRf8oOOajMqWHAL4FYg6v8
        x21Moo/MSvh5bcCooA/2DTMiYFF07fD5kzmvo44AJRsK3herexrvo5CYlB3gAcpP
        02BZ73ARUWV1rWdrojb8h0P2U3/Rn2sNladg39VFAQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hsyVK7
        qJHHuj5gPDNSdTsPzWA01bJfj2s8A4rzDCYeM=; b=oyq1CBzukwBkSlqbJKwaa8
        2XUL2pXcyW/xd6t06WoOKYm86e7mqbhy4wfpLGg81zoB81TyPWG3ysOtxmkH/e4i
        zMkmamgL2eja5jztv66Gto42gkkcWhPTRdwXmJPtYgQaJu7sgZ2gpJDB8XY2RD4T
        qqLkuqoY61ocUjP1OradkgDyRtjwE3LffYQhFRV8dSQLGEszLHJV9FtiDzB2t7NO
        WICNl1Z+nhXK+M5bIqxPgyf5v0C0B8X/b8m07K0NTXj8PwHSH0V7wTmjFvrDcGan
        Xy1r9YJkRRUw625u+8f3zooq+aJFNpF1MmA2i6Vxs6WEs5R/Q47TMYVzw4K62CUA
        ==
X-ME-Sender: <xms:MckcYRjKPL6JUzpGb6re6cHm4hms_hnUUk5wLU63_odrvlggU36mFA>
    <xme:MckcYWC4iQNpq23LPTHKqDZ9yyydhQ5gM-Qppo7xcNiOIX_mWqsqyrYQnsomZcq7L
    ebUzA42J41Coodg4jk>
X-ME-Received: <xmr:MckcYREZKm29jUCj_CByovFV9XytU9PbHRTHNDcVvJ6CT9hbl0qPKmvscmMn5gBn0r6OwbrIHWXzK9cbdJVkFDqEfLAe6bVEqKcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:MckcYWReAWwP6hrUc5UikMmM7t8YI673y6--taGdQPdBTQWMeFiarQ>
    <xmx:MckcYezM1i-b9qyTYHFZZvYNFoELvhFRk3hWwYI5qA4GNGDXkgqdIw>
    <xmx:MckcYc7kB20uoEoQfTVBE9fpnm02DsdaeI8o2Ro72BqB7lUY4-igeg>
    <xmx:M8kcYQ7HuOotLlNtJtWDim5n9-dja_usogj1Z9K0572fpkph2a2M2A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 04:47:44 -0400 (EDT)
Date:   Wed, 18 Aug 2021 10:47:42 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/17] mmc: sunxi: add support for R329 MMC controllers
Message-ID: <20210818084742.mi4mipyrjochvbat@gilmour>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-14-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e2zgsnfvydtovqb4"
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-14-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e2zgsnfvydtovqb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 02:22:08PM +0800, Icenowy Zheng wrote:
> The two MMC controllers in Allwinner R329 have a mixed feature set
> comparing to the previous SoCs' ordinary MMC and eMMC controllers.
>=20
> Add support for them.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--e2zgsnfvydtovqb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYRzJLgAKCRDj7w1vZxhR
xUb7AP9Tp1Zq7BhlAIEJVqPR6yzA+CGmxCrwfVkNkR9xx3I4HQEAtzoEcKHyLpJ8
EC9LMczaOLk2pbptHMAyMuvr0woqTwk=
=u9kn
-----END PGP SIGNATURE-----

--e2zgsnfvydtovqb4--

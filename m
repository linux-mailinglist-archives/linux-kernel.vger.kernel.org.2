Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE313EFF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhHRIvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:51:23 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:41371 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhHRIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:51:19 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id EBEBF580BD4;
        Wed, 18 Aug 2021 04:50:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 18 Aug 2021 04:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=R6lJ6leW+cTsVPjVdWDFjF3vFWZ
        GCvybB43D5rO2LMI=; b=uPkbXTamSX/V60iVmCeOVtntLmD7Y8t4ixCAw7kL3eA
        tIoqPC2BTxTYG6VYvVCQkHlQTn5Gp9OHITY0AiGGAjMi1P2kW5zwhCbHaBWCsfjU
        kuReh5QJCf3jqy/X+Zn+lkNz3TiIuTWhh+gG358W0KmgYwaN3mIEQvgJIB7BrZ/G
        Zln8Zl8qSVCpptj7CYOtTtsM6ZhAJRcOusjsyelyd0T4vupmy+CwCXRLpd8XExV+
        HrK/miY2kutI1lPrxQYtRRV+/rIXfq2hi6qF2lgYTyZeceHF+1TUDDf7we8XNx2r
        ZXMySPNBPRjdJUqEOKD6z/AtlwFYlnc3iBLPn4m9zdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=R6lJ6l
        eW+cTsVPjVdWDFjF3vFWZGCvybB43D5rO2LMI=; b=tle0rdwM8zb4CgZDBLKBjE
        1vKgNjBAD8QDVmIxU5/uBcBIjpVlPFJxxijHjZBbYlT99ZA515mHe333pSQu72XZ
        buSwIWOcaX/ZSAXQ0hsyvzEp5V9q03DesqdpitjI/1ZqKwV53ODudZBH8I5fqelc
        tcMo+6ih8pvFzVt9z3UvrP8di2F4bkJIQvK3thFqnq5vbBPmM5nSKBkRHCMxXhMV
        Ev+ieSra7YJ4WGLElT39q2aKP4WLp6/ObBI7KfDypj9ez6PmfIkAMv4RWhAA2QzT
        TEV9amcI8FMWico4aZMw9XAj7cG2Sg4GmjDQzpTTYVjB5G3Ac2XWJMRhlpxLbHqQ
        ==
X-ME-Sender: <xms:48kcYXPzZpU8VnBqM_wg6Qq9qNuxj01iS5gDhLDwrPorIPtaY3PIAg>
    <xme:48kcYR8WiYvyHFxTh0Q_PgzDnoy87Srxgc2ifUMmOdQsDDxS_3GSCCQXzU3CaMRsS
    uQcZG6H_AbRMYhkDvY>
X-ME-Received: <xmr:48kcYWSdMtE_M5G2BSQ44DuY9kmh-NSRTlzByjxTS7qGD_qJMCb1cefVGL6tEDeH6eITupV11hJFIUjG4iH5VaaHK37w7zcV2GFe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:48kcYbtHCKHNy9WEFx3PaT8z2QzLGEqRQf5sJl0xEBbfWDz0oncjHg>
    <xmx:48kcYfdQoIfV3n4ziOI_gncoMp7ONiZuj5bR-9pq4X4FEGdc2wb2EQ>
    <xmx:48kcYX3_mh4yUFc-U59PRXd4gCB_rUrzmGxuDJUOPXB1TP5p1bwsng>
    <xmx:5MkcYX3rk96Ij_8VRo-exJ3SS5OxruQ1Q-OvJLBMM4RwcpCqC5rt4g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 04:50:42 -0400 (EDT)
Date:   Wed, 18 Aug 2021 10:50:41 +0200
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
Subject: Re: [PATCH 10/17] clk: sunxi=ng: add support for R329 R-CCU
Message-ID: <20210818085041.ge57t5xxw7wnepyd@gilmour>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-11-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fkbqh4wfrgwkyngh"
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-11-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fkbqh4wfrgwkyngh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 02:22:05PM +0800, Icenowy Zheng wrote:
> Allwinner R329 has clock controls in PRCM, like other new Allwinner
> SoCs.
>=20
> Add support for them.
>=20
> This driver is added before the main CCU because PLLs are controlled by
> R-CCU on R329.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>

The driver looks good, the title has a typo though (sunxi=3Dng vs sunxi-ng)

Maxime

--fkbqh4wfrgwkyngh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYRzJ4QAKCRDj7w1vZxhR
xaw3AP9V0hAd4RHhFjea9N0FgFchD+lDzINzT7qtn2RGONO+CwD/atfpHLqGWPI4
OJx7hhJqs1h7viSdjGMl6MZ4eMBCmgw=
=eM16
-----END PGP SIGNATURE-----

--fkbqh4wfrgwkyngh--

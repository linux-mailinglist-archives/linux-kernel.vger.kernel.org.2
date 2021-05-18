Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77335387C51
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350098AbhERPVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:21:31 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60121 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241047AbhERPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:21:30 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 43D0E5C0213;
        Tue, 18 May 2021 11:20:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 18 May 2021 11:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=QY2LGwA9x5uelZUVpNRx/16d1wD
        qttCQfrZ12I/oPGA=; b=PwcauS90b1ymANWGqoBUyiccCRl7B5yxTCVx1F5z9aM
        atgynSJr2M4I8B4iLNBjy/b2UQFD8MJ97YDk66TH5dLJBEPAFOzSvMi0rs6uq2EU
        j235KoKeS+F1bv4Whw2Y2GjIYoxhkSpXJ++HT4lhC6tFPE+2u0YdRz9n22awJWCN
        8rViFtiDKRk38LV3xTBM+vx4nwIqR9WqW+aqSatBG6iAY7dnqa/ASj6k2Wyq4b9W
        uBruYheazdNRNQqkPRMxLf8qa/JuqoU3enaTtS+qucr4ru0walf/LFWMGAwD1CXK
        k9I18P3F2+Cr9C7bl/O6k/Qc5CdybWRW6X57JhLeVMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QY2LGw
        A9x5uelZUVpNRx/16d1wDqttCQfrZ12I/oPGA=; b=NsZIGokt6FVe6OQOFTQ/ly
        sp3bq5o5kCQpZG7CW8eCAVXJewG6DluJ/p2jV3W/iEcP6OSa/NtOc45r5zTG1SjL
        DJSfSrpdCCdI4mw3G8s5LF5k+6ZY7Vwu49hDb0dbLINv12AD9Ox3Tjagiv1ODWPp
        5Ic7dStTjWDgoRnUbDg/IP9aOK8v9nBfNGO4Hvf69WPSX2QXXVq3mFlmE2/x7UgW
        /MZdzixVrEwM+2afJufFQBS7oBvZVzZao8CSYOAzLoylvT1Q08fbTv3dbtStaFZx
        1ad9Gp8cSkdEXjc8Y/uCcvucKokf/nkA56m38B4RwRkjy0NF8orQYzpnsswnL+rw
        ==
X-ME-Sender: <xms:K9ujYAKvtAvA0PgzfMgwOZmARQT3WQyEf5JZJIgpHCgI1HnWm4RM-g>
    <xme:K9ujYAJs-Kpb2IrHg9tq70vY4y5Vd5Ts66lPLRb0BXFwqXs21I8SqUOfuamxlXyZN
    26RyfJCcM1q-C9ZUb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeijedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:K9ujYAshCEJFW9Nq_mMDAZxhUOCb_GowrLmVBdkzlDjdwYMHaPFeTQ>
    <xmx:K9ujYNZfLbBCuGJfxeUpyu07U7FKgwH01UnTBV_c0XDxEaSqQV9laA>
    <xmx:K9ujYHbW9_DzBLHWpp4I-y_Ta0G0rIVS4lqAiD8pXKLPk8KrrhXotw>
    <xmx:LNujYGWy0bj_QN66aoAgThB1A42h7ATr6u_qL_apyTy9Cu2b6yhz6g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 18 May 2021 11:20:11 -0400 (EDT)
Date:   Tue, 18 May 2021 17:20:08 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: r40: Add timer node
Message-ID: <20210518152008.7irfseutfryelhio@gilmour>
References: <20210510163647.2731675-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ekxstv5zhrollh3p"
Content-Disposition: inline
In-Reply-To: <20210510163647.2731675-1-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ekxstv5zhrollh3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 10, 2021 at 06:36:47PM +0200, Jernej Skrabec wrote:
> Allwinner R40 has a timer.
>=20
> Add a node for it.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks
Maxime

--ekxstv5zhrollh3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKPbKAAKCRDj7w1vZxhR
xbDYAQCNEL3wxXyQvMIlITe9jPo1wYr4plaij7prA+qhCDHtAAEAoSURmbZ/9WoL
3wQ1vhBqkq+SekxSLUqO0vbHakU5IgQ=
=o5ZF
-----END PGP SIGNATURE-----

--ekxstv5zhrollh3p--

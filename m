Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64206395859
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhEaJrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:47:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60681 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231180AbhEaJq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:46:59 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C324B5C01D7;
        Mon, 31 May 2021 05:45:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 31 May 2021 05:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=k0VB3FWrxsfXM1/w80pYSH09jaS
        p4S78U78dUKQMXm4=; b=OiQcRRpLcElS6KLN8SBFP4EMbj7iKqDed6kbPCiJvJP
        3tK+18dTT0ULQvcyVrrLSZpL/kXLTYm5kf2jwD3XlPuUCChyk98t9F58/Iz0DLsK
        OZBPrhc3trVYK9FFF8I944wQO3oO1tV4g8gbEN0INaTvG8bao15EK8YzxO8hPKpj
        CWzqJw5MwTLjSUiZp6A84mYw/IWFWAliy3LD68aowOvCAazDCyUu45ZMb6tpLTXx
        E75FheqKc0Wp7PSHyxntx/SqPg1YqIT8itv14suYmbSEWJNI2C1DTDLCkQaUX4cA
        64EmNF+/WJoFoVQWQfO7F2o6X625HXM7OhrwnKPi1tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=k0VB3F
        WrxsfXM1/w80pYSH09jaSp4S78U78dUKQMXm4=; b=IZtqvgWVjUeSxIptsEkVH+
        FMsoIPRMyOVPeXfJFeqo44nr+27D93KEYa4zA7OvQ2efO6w6vdpiCp77tW3qcmLS
        dWyLiSXRQu62nXvjZZ29DCwdR/0d4f7b7gVqvPLKvPJItsqYEgVro4CRC9rK21CO
        g0F1+DMDYee2luhe5zFbMChV7IE1Af7Y6egRdSW+9ahTGHaVSerO22VHFNrXIU/e
        lu538n4YmTCAAz5tZbczzs/u2MnZH/GneigxQ+x6WfVcu5nU5lDYhZT/1T9MSWKn
        EzNqA01cbaWchBbrmGotBopbszYK8XiVKtmFhJCNe+NRhT9qE8lp/l772/Ix4/bA
        ==
X-ME-Sender: <xms:L7C0YNvR9W6ne3nXtpKGh9XtRlV-TyArg2Tn3eA_pKj8XI_zs-iTaw>
    <xme:L7C0YGc4D8EH5dTiS83Y_x63LxlQqyJEocupKQBN4pi9QJOM9CA8kS_V_JruZMkRD
    lJlCL4hhkGCqu5VJ-s>
X-ME-Received: <xmr:L7C0YAzmeyjq0RuE8isqjK87G3caSUysj4Yignt_hPyN7SajthEfy3ovkg-7v8MEtSioWICJy87P9-VWGZro-KdlmgkvbWtombEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdelfedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:L7C0YEMnY01bLL6zb1r_O1qb1Tg-4nr9N2NeYFw8Htzp3MyaIG8lPA>
    <xmx:L7C0YN-thZDaq_-Qa2hEMkpWJGsT8k_01KPykFbuyInau5XAAFwbgA>
    <xmx:L7C0YEX-m89WT58Xn-K-m488nfc0w1yq0Rqd8SA_aKiAXMr3IVoTtA>
    <xmx:L7C0YAllIJj0Vnzfu4uS1lnen1JYuh4sZKnF2OBONIfY03P9mxOkpQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 May 2021 05:45:18 -0400 (EDT)
Date:   Mon, 31 May 2021 11:45:17 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Andreas Rehn <rehn.andreas86@gmail.com>, wens@csie.org,
        jernej.skrabec@gmail.com, rfried.dev@gmail.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: dts: sun8i: v3s: enable emac for zero Dock
Message-ID: <20210531094517.5azb57jxa4mpyz5e@gilmour>
References: <20210522205039.179486-1-rehn.andreas86@gmail.com>
 <20210525173159.183415-1-rehn.andreas86@gmail.com>
 <20210527001614.2edfc630@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c2cnun77ajscuzfq"
Content-Disposition: inline
In-Reply-To: <20210527001614.2edfc630@slackpad.fritz.box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c2cnun77ajscuzfq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 12:16:14AM +0100, Andre Przywara wrote:
> On Tue, 25 May 2021 19:31:59 +0200
> Andreas Rehn <rehn.andreas86@gmail.com> wrote:
>=20
> > dwmac-sun8i supports v3s and
> > Licheepi-zero Dock provides an ethernet port
> > furthermore, align nodes in alphabetical order
> >=20
> > Signed-off-by: Andreas Rehn <rehn.andreas86@gmail.com>
>=20
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Applied, thanks
Maxime

--c2cnun77ajscuzfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYLSwLQAKCRDj7w1vZxhR
xe/XAQDcv0jTeCL1REtSYyenCVF4RyCnXhWwRtiHWTKfIZOYggEAs+kcaYy6znKi
VOgNaNqd5btDqYh2M8zAtfEewFW2gw8=
=g+ze
-----END PGP SIGNATURE-----

--c2cnun77ajscuzfq--

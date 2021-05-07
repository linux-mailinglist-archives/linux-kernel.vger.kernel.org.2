Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98D73761B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhEGILF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:11:05 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:51455 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235320AbhEGILC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:11:02 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id AE58E5811AC;
        Fri,  7 May 2021 04:10:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 May 2021 04:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=N4E8u8LxBn6a+FLyFAp3MXCbX0H
        3BB0OfCxhAb7eG20=; b=JLT6zkTrnBLlrdM7F3lLgjU3UkNwLU70uIif/hpBRLc
        1ua8VgfE8AKvtMIR8tszSmgUQ3mCS1Ou6RDBxvy/OND8BrzgnOGptuJ4iK9W2xRO
        GItkh96hs9LBPlbJUEqhnv6LJ26NC6+cbeJ+QKK20IaYn5GvL3BEkB+OmoifDKmK
        yNhEgWLoKWyFlZvDzK6oeaQN1gKQ5r9S6rAM9tAsd1tF/9SmMq5AGJul8o6JWaNi
        2aeBalQWgvwzDLz0CSknhGi7WDIsl4eJ4497cTcphCpeIfaNWLJq0q2rhKhuhKtN
        Q2lEZ4lh13eKmFdH2Oh96wk+ZzF309xkpLFx/4IjpHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=N4E8u8
        LxBn6a+FLyFAp3MXCbX0H3BB0OfCxhAb7eG20=; b=QfwZMtHzTVjm9ge/yj7Bg8
        5Lm50oz74UF+wb04KdSOsn4XSaBemVQ/KnwT1ttgnKGSS9ulsV46TZncGclrcHN/
        G1mriT/s5x7yKmFWr+JoWeJEm5UoRDoKRLLJYfFeeow5xl4pfaEX83axCY6QyO/d
        cVYE0b3RHoBlSOG4aaElne3HUWmWdVAUVVyWoe1jC8iW3xV8knOlPZJI5lpcPS6O
        J2j+8uE6669PZyAexRk29hjwpoD/f1AbTZh6MySqG/xIojtG4evvsbkm9fVJzAN4
        3nVZ6JpmndLauuWEyG1jMiLnv8vrZpl3BdhCVg8v2D95fHi8XAusbespDJzJVG+Q
        ==
X-ME-Sender: <xms:2fWUYJLlj8PggRjMV-G_4dFjy9Fh_Jf3tFNvVeEnEygE-FYVAvaqlg>
    <xme:2fWUYFIHFBOgXCmGrLWVu7L4mlTOha4f2H0k9enK8Xa8LUhGO9VBPoFJ4NN_-0Hkr
    FV0Y2PaWHVbZt08XG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeguddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:2fWUYBsiE_FROdcKBg8XBFFx-i_25CmXUgRg8l5Pz9itlKgGoBBwpw>
    <xmx:2fWUYKYzkfXL-13Ez_tU3lkAyL-xnY5GZ7NW0sMcGQEEk7L8u8kcMA>
    <xmx:2fWUYAbmhdDOC0Zfr_Q2iaDfdzl3pY8-Z9YJLvlX4NrQOd7sxJzISA>
    <xmx:2vWUYGPHCig_IY1bK2kLs-Kks2E2xaKLDUSfMEvAoRgLjjBtpu2zlQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri,  7 May 2021 04:10:00 -0400 (EDT)
Date:   Fri, 7 May 2021 10:09:58 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] PinePhone BT audio bringup
Message-ID: <20210507080958.3ue4xfov5k5dnatl@gilmour>
References: <20210430035859.3487-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="56i3cns3wstz6rhi"
Content-Disposition: inline
In-Reply-To: <20210430035859.3487-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--56i3cns3wstz6rhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 29, 2021 at 10:58:52PM -0500, Samuel Holland wrote:
> This series uses the additional DAIs added to the sun8i-codec driver to
> add hardware routing for BT SCO (headset) audio on the PinePhone.
>=20
> The BT audio connection is represented by the "dummy" bt-sco codec. The
> connection to the Quectel EG-25G modem via AIF2 works as well, but I do
> not include it here because there is no appropriate codec driver in
> tree. We have been using an out-of-tree "dummy" codec driver for the
> modem similar to bt-sco, and I'm not sure if such a driver would be
> desired upstream.

I've applied patches 1-6

Maxime

--56i3cns3wstz6rhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYJT11gAKCRDj7w1vZxhR
xcH4AP9T2WUlgJIme8t1Ebj6AH7EiETOtA4asPtzoInpH93PsgD/RfOXEXYbcEG9
omJFQb7MNOHox4nDTKMXaKAfro5B+wE=
=uw2K
-----END PGP SIGNATURE-----

--56i3cns3wstz6rhi--

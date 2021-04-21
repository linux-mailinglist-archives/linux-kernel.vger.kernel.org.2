Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457403667FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbhDUJ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:28:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51921 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230516AbhDUJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:28:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BFC615C0114;
        Wed, 21 Apr 2021 05:27:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 21 Apr 2021 05:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=9dH6I2lCf6KaG/adJovZAIRRmL2
        xnY0W1xR7ps1E0Jg=; b=Z9yTpzRefPDTbMCbpvemRI6X9mADIGXhjCEXJNL5PX2
        KfhNOMe9z+svdtgvKSRv/bOiSh12b1Qi42l4w9feuNoHMAOCS7qAa9BuabhP9MMX
        V3+4x+ge4M0xzXypNvCB7VIvby3tCZJjgeaHDoLOjkWGR0Ces+Sbi2W+TOfCvI0M
        Tog505mPq1HN7rYDWhc+RKsrt5PU9cpcw1ooGno8bQsQ5eU3/xI0R1wwXsBSFGG5
        yPpMqSzGEppNA3m5KE2aUzsq+5Z1LiF6jmfOuIYjEIU8koCfAvnXb2ObsEGWM+eL
        PQGhEJPCkwGqjQCyjgkN1e0bYUa6lONlRnnyzoVKYjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=9dH6I2
        lCf6KaG/adJovZAIRRmL2xnY0W1xR7ps1E0Jg=; b=c1tCO1B5qpa+mxSE3EeT5L
        OjrnDfv6OhArJpEGLe0juS+SCBDM7bo5tIuYy3me1fD+vo1x9SFcoYahCfH58oQJ
        gDjLwBmwQ80k+d9MQsk2NHa0Rb4U/ZV0O3AtzMwGok1PlNWam275ldO59UmUcR2J
        /5Bi7qXhzkUC4QDF4KA4Gep89dmbUxidqnoMz8DH8PFM3cJEgpldKeUNktlvxytS
        zkM62QD6Mscf0Wv1W++SBjQVzCb45W+a+cfCMGHIJl6aM9lMxkS9IXwBZFQY5hrq
        ShrP2IiSmY/U37pYBBfEoLjQ1hzQzC8SIzEQ5w5ikCOE+VJ20GpQbaSS0lXPHWZw
        ==
X-ME-Sender: <xms:APB_YLmVQub7r2Ise749WjUjfm0ahIuMRoWRwXSV-CQqBDH-1MhuMA>
    <xme:APB_YO0RYJmtauWGYInNMyByIbCsy63OmJcS_BNivgKE8y4mlON6VjPClX709SI-j
    4cS-50iUh436NyqwLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtkedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:APB_YBro3qGu7WtCcUWnDa-eSOBXPCMRjv-YCP9y-9TWEOaO3R_-oQ>
    <xmx:APB_YDmbS_l_OUjd7EfWcJNWVAXX0gSh0N3t4ycuwxBxJ609mQ8FKw>
    <xmx:APB_YJ0RdtXWc5IfzT3kyQH3B5kY6pa7KfA7nEWweNVv9WBKW41Vag>
    <xmx:AfB_YGnxVaOse70VGiKkULfZf0E_F7Z5MiONHWQv4p89GrzNyaxN6Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C855C24005B;
        Wed, 21 Apr 2021 05:27:27 -0400 (EDT)
Date:   Wed, 21 Apr 2021 11:27:25 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andre Przywara <andre.przywara@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/2] Allwinner H6 USB3 device tree updates
Message-ID: <20210421092725.qacp3446hiyf73ov@gilmour>
References: <20210421042834.27309-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jf4xm3l2oukir3xt"
Content-Disposition: inline
In-Reply-To: <20210421042834.27309-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jf4xm3l2oukir3xt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 20, 2021 at 11:28:32PM -0500, Samuel Holland wrote:
> While implementing support for this USB controller in U-Boot, I noticed
> that the reset line alsp affects they PHY. It looks like most platforms
> use a separate glue node to represent this, and in fact there is already
> a compatible for the H6 listed in drivers/usb/dwc3/dwc3-of-simple.c.
>=20
> Since this layout matches the usual way of modeling this hardware, it
> allows using the existing drivers without adding platform-specific code.

I'm not sure which branch you based this on, but the Pine H64 seems to
be missing the USB3 support in the first place. I've applied the rest of
the changes though, thanks!

Maxime

--jf4xm3l2oukir3xt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYH/v/QAKCRDj7w1vZxhR
xTUmAP4qrMOtgHXTjgmjwRw2xJfTRkCrMp+xzzfSSSrM/DANwAEA6RyQ7yp3cV66
SblHZBPC6Yj8DUMVRy+KT0nJelfcvQ8=
=Gcf+
-----END PGP SIGNATURE-----

--jf4xm3l2oukir3xt--

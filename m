Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8367938E5FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhEXMBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:01:21 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:34919 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232494AbhEXMBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:01:19 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5584A582671;
        Mon, 24 May 2021 07:59:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 24 May 2021 07:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=EMJnP4Q9UxIeWBo2UuuYOcg1Pqv
        TS5azhJpoiLIqHIQ=; b=OUKRRQHx1ILDG0ggPhIpmjzgmg/JTKwM9OXvLkW/J4A
        gYwwfeI1/LKKRvmJpIWVJvNvfNHPnAYHkqGkri1VF+o4kxP7xFiE8n/V0gUMQFU1
        5kEqBz3KoWwTujEqAqOC44vZn1dmxYCyjJljuFFZXrre4zaazOmdneGSZu3n6mEr
        l7fiMNho9ITq/FQkB7YntIpiN8Ak9M7DosdOYxfj/2weh7sd2CDAfZYSQ1iAzOQH
        gsITZH28+VN48Pd7zWUGu4hQSbvIWjvykBNx8EbSLoG4m5sKfe1Vj1GBOKkHEMj4
        by2YGhtxgjdYXevSOiLgD/9PcbLciAK2Evtgyg6gvNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EMJnP4
        Q9UxIeWBo2UuuYOcg1PqvTS5azhJpoiLIqHIQ=; b=QW+daKaxTYMrEqLcgIuLQ1
        x/nJ3FgX44l3zujYpurXNEFfzMTJ3x8/2w8EFid7W+50f/P8Hp04qE1etNhnSO91
        I/sImRTaiWE0vVPzJIoOE+2A2b4rOIxTT4onsP5e8H2WIovRdpDa5+k3/r9tEzdv
        sYHprr8VPpbSKpsk5QSxwSldyCSRk4YZs9FpEW1r6SgfegzW27mvpF+OMLS9Dnv4
        xVMUIQWCbzmvR+ZUCI4v9lhKWzEP5PRT/RbapQP2701WF234YOZ3stIa3pZhvH7f
        186TyDxWHv6gIegVIUI8ZS4gESf+crLFl/foLJYgo2AEC/yirqZObOYol5F7YHBg
        ==
X-ME-Sender: <xms:NJWrYEQA7mP-vi29nF9adGZyG8ESh5GAS3Y9YEvMlvrFATtJr2xBOw>
    <xme:NJWrYBxROd8hQYpUmdUsN1VaX8afieB3oI1KNY4_xLQevR3kVc2u-u-nqZyvLuD6R
    vM5HwcDdEU9WaHa__c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:NJWrYB0Jd49ywHiY7McNzEEzSD5Yh075Ga63Nuus_jaZvwOb5SWFwg>
    <xmx:NJWrYIBbftkams1hnJ2B7FypRiGlw6NdXmbWtWiwmq5VSTR6zK1RGg>
    <xmx:NJWrYNi5Rbf25wmuVdEB0SV5I03fgSUv4iE_oSMUZfJpi0Te9Rik-Q>
    <xmx:NZWrYGYIyWgKOrA69diLMoaGO9GHOd7LEZnyxu-eAoKdynFFuRq8sw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 07:59:47 -0400 (EDT)
Date:   Mon, 24 May 2021 13:59:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 12/17] phy: sun4i-usb: Introduce port2 SIDDQ quirk
Message-ID: <20210524115946.jwsasjbr3biyixhz@gilmour>
References: <20210519104152.21119-1-andre.przywara@arm.com>
 <20210519104152.21119-13-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yeqfewi7xhvh3dbi"
Content-Disposition: inline
In-Reply-To: <20210519104152.21119-13-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yeqfewi7xhvh3dbi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, May 19, 2021 at 11:41:47AM +0100, Andre Przywara wrote:
> At least the Allwinner H616 SoC requires a weird quirk to make most
> USB PHYs work: Only port2 works out of the box, but all other ports
> need some help from this port2 to work correctly: The CLK_BUS_PHY2 and
> RST_USB_PHY2 clock and reset need to be enabled, and the SIDDQ bit in
> the PMU PHY control register needs to be cleared. For this register to
> be accessible, CLK_BUS_ECHI2 needs to be ungated. Don't ask ....
>=20
> Instead of disguising this as some generic feature, do exactly that
> in our PHY init:
> If the quirk bit is set, and we initialise a PHY other than PHY2, ungate
> this one special clock, and clear the SIDDQ bit. We can pull in the
> other required clocks via the DT.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

What is this SIDDQ bit doing exactly?

I guess we could also expose this using a power-domain if it's relevant?

Maxime

--yeqfewi7xhvh3dbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKuVMgAKCRDj7w1vZxhR
xSHfAP0dBPqEfgZL7NPChXsRxHByzSmhCZQ+zMbfpCQVADqDNgD7BWogJtW3+sff
zXhIKZ/oXdr2tJxXsO8tzCyO/ECdKwE=
=5PHW
-----END PGP SIGNATURE-----

--yeqfewi7xhvh3dbi--

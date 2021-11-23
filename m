Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A95945A048
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhKWKfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:35:32 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54183 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235390AbhKWKfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:35:31 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2643C5C00AB;
        Tue, 23 Nov 2021 05:32:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 23 Nov 2021 05:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=6IfWMMDl+t69qUQ48i3QLGGYzk4
        LV3KqBczbW/8Jm1s=; b=ASQ4J6wMYMN2s3SZtIROykl+wFe8rje3dHUQk0M3Ikl
        ab+WO2YbkxC8jKKIXrUubdKpKXFk8sTtl4B+VB5F44gDm+Ev3Hukinc+YhAaqLQZ
        aCMOFzu2IGMGBmnsWeGDppYLqdRngRlVNZrv3PlZZB6u/v+KJEqap/VeGmYEMzwX
        ecoizaQgnhCHuaPvoIM5cOYEKE63+bI/ljPiOouJ86NYcufliB0XAB+We3yX7U0w
        UHVHrr28SRJn/sK/c1Sf87i0nEZTtG55dXqoQTYij4EuumN5qXNKS6ei2dpYKnwL
        tQ5ao1VeRmV6AQvHc7EyCTDOnVn2U0XUDNf9uBlFL1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6IfWMM
        Dl+t69qUQ48i3QLGGYzk4LV3KqBczbW/8Jm1s=; b=nIgZTPIiHAxaS8vhnKjJ2m
        0B8WoTIjxVVDU8CJc6MnTNzTbsg3lwRYceOgaGz5jzop3Dna2PF0ix6SjPLh+TpC
        XVU7CneC1qvkr9kxqENTUqZvqpjECM5TNmHaDcuWjwJrjAv+jNAtiR/pJJJhLG40
        9v7m8YAwPbHbQ/EnYt5pe9O/om7+OmSHAJ5kC5tNOu4XMVFFAq+k0cp2F5TU0DRT
        VkR9IOf0bghdJq/jULoAQP6ShLBTxnadS8biLfcJQkZN2cFRFaExr28DaXCUh/wM
        lE03VfvdaSJNCCYj6hlGYAum7Vs9n3XTuj4bnasJMZxwqa32dZ8rKr6jh8pRwptw
        ==
X-ME-Sender: <xms:NsOcYcTJZ6HXzPVOfx4J2GjRXVh438wRZbfmEwrrxw9w5dGQ4oqlDg>
    <xme:NsOcYZwcHTnvhYmfIl923CZZwZ6f6GHAzTrRLIg13jijCH4H6VZaTA9G59C0_dmqX
    X1w99Us54bNn_zQ4Sc>
X-ME-Received: <xmr:NsOcYZ2uSRjiiTulU8KGLa90Euu_0_0PJ8M7dJSfk05BVVp3pp3NBk8Agp2Yhh-8ER8jkAOy375pP5kzodomhRWVJE6R2anAm_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:NsOcYQDT3-3MHbtlbixyMgBNwkRbR-Awib3I1dt3wvZoLT6VbZNDhA>
    <xmx:NsOcYVibIiCXpEWYGAogpYN4HVEX0QHFVqb1j9llWEJOwzJd0561EA>
    <xmx:NsOcYcrQU8yse-aPxGvY6-xmEMQ6QlSe4pdV2etLmu2AyHZRNv_FZA>
    <xmx:N8OcYQUoK2Pcp_bM8GV5l_xIqSBDZuTMVjoZnqPZ62kFy416Ru25oQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Nov 2021 05:32:22 -0500 (EST)
Date:   Tue, 23 Nov 2021 11:32:19 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Michael Klein <michael@fossekall.de>
Subject: Re: [PATCH] ARM: dts: sun8i: Adjust power key nodes
Message-ID: <20211123103219.4y2pjywt2uxunc5s@gilmour>
References: <20211122213637.922088-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fsk3ur76aps57kb4"
Content-Disposition: inline
In-Reply-To: <20211122213637.922088-1-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fsk3ur76aps57kb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 22, 2021 at 10:36:37PM +0100, Jernej Skrabec wrote:
> Several H3 and one H2+ board have power key nodes, which are slightly
> off. Some are missing wakeup-source property and some have BTN_0 code
> assigned instead of KEY_POWER.
>=20
> Adjust them, so they can function as intended by designer.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> [BananaPi M2 Zero changes]
> Signed-off-by: Michael Klein <michael@fossekall.de>

This looks a bit weird. If Michael is the author, then his SoB should be
here first and mentioned either in From or Co-developed-by.

If you are, I'm not sure why he's mentioned?

Maxime

--fsk3ur76aps57kb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYZzDMwAKCRDj7w1vZxhR
xeYRAQCN2a8TqQdMa5RmUXLYjQVlY5s4zcCu2QmCColXWwKPOwEAxxBhHi3yPRMS
6b1XvR8ir9A3uMZty7+rh1L8k4BH+QI=
=jUHJ
-----END PGP SIGNATURE-----

--fsk3ur76aps57kb4--

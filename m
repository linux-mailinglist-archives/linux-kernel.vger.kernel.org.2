Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31A93073AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhA1K0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:26:16 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38763 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232520AbhA1KYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:24:22 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D3875C0114;
        Thu, 28 Jan 2021 05:23:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 28 Jan 2021 05:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=XZ6rY75cmqr7UvehnpYsJbl4pPV
        fDKYpP2TSgwIX+LY=; b=ClCkU64xRlU8R3kM85z8BKWePs6ZggbQct3wkKZdZwI
        hUUTn7Dx8uNRMOhtTslPXqX2jv/rUa0Y7hp6R+ubVjoNu4qtFMcwqWaAlOiWz2hi
        DyppgtMyY6X+O2Z9Ju3/ayh6rMVLWOu780Cd75e0FgYnoAshCwVtouYJuyfxnh+G
        JU/nIjJBA30dc6Q7S1ABSj4A7g6FRKjwh2xtzo4suwC64Vz2K9H2WqhHKlOGYppA
        hO5dB6PZjlFrrNWl4DStQuf88vPGqi9GEDX5f1fOsREyylflqMSp+xDZ1eXUmf3E
        vkcPgxKg1ZyPoQvD0/7Wf/Z9YqFFmFZOb+i5WG13UCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XZ6rY7
        5cmqr7UvehnpYsJbl4pPVfDKYpP2TSgwIX+LY=; b=SKW29gsGlS7zuSEEQSN0vT
        7R2BswVCqK1z+PpISL1rG70UmrWVCkQK1O0UCvN69wrAaVL46+L7kj5QzXhyA4pd
        9pDeL25L9BL/wxUtCANmBdNP7X6sc39wbgFxbIMZEYRvucWTL3E9y2XwFq9OMt8B
        mJjn+EyJMUgFcpIPRq7ZV88j6NzFlrQumMz/qZIY7O9NQ5yyQTK8XbevQqD+YZ8H
        rA96IjRRmtcPOTye0eTcA4q5jLHtU7sHR5qA1VoRsFrT8Zn3pa81oDOlm5q2L4IM
        neb+cljK4rTHUgR2s7xQOKWd7GeCMsFXV4j0Hb8sr1Ix2dpVmETk0sRlX8+cR4rA
        ==
X-ME-Sender: <xms:pZASYMZGmRk5yGru3TOH3XSI0SpCEPqgY9C0ERUy5VhAWQqxO7NxIw>
    <xme:pZASYHYiV9acXy63_9508wTKzeeMBd68p3sJqBQHXoQ3leMZ2DFtmwdwgGG_sUiTj
    aV8bEisnqVmGXlJk1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:pZASYG8IOJxow-aZkvw-Aq2URMo226ilMutQFz_3_BVQjgtNnxvEgg>
    <xmx:pZASYGq9pihJMMntc2BTT9Nbrke3T2QrHSXxEnB9fEmRaBMCu6KELg>
    <xmx:pZASYHqmJ-PekSyJwXLOWq_5zGU3NqWctmxB2JPf6sHaes3ifBsXEg>
    <xmx:ppASYDI2RuqD8QuO72L8iKAkE5wj0paJHdt5MybCIuOfoMn3Fu6kAw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F5D3240057;
        Thu, 28 Jan 2021 05:23:33 -0500 (EST)
Date:   Thu, 28 Jan 2021 11:23:32 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] soc: sunxi: mbus: Remove DE2 display engine
 compatibles
Message-ID: <20210128102332.3e6i63epnu4pyceg@gilmour>
References: <20210115175831.1184260-1-paul.kocialkowski@bootlin.com>
 <20210115175831.1184260-2-paul.kocialkowski@bootlin.com>
 <YBFkh/faoPnTRZtl@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dhm3aq36fwshxmlu"
Content-Disposition: inline
In-Reply-To: <YBFkh/faoPnTRZtl@aptenodytes>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dhm3aq36fwshxmlu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2021 at 02:03:03PM +0100, Paul Kocialkowski wrote:
> Hi,
>=20
> On Fri 15 Jan 21, 18:58, Paul Kocialkowski wrote:
> > The DE2 display engine hardware takes physical addresses that do not
> > need PHYS_BASE subtracted. As a result, they should not be present
> > on the mbus driver match list. Remove them.
> >=20
> > This was tested on the A83T, along with the patch allowing the DMA
> > range map to be non-NULL and restores a working display.
>=20
> Could we get this merged ASAP (in this RC cycle), hopefully with the patch
> that superseded 1/2 from this series so that we don't end up with either
> CSI or DE2 broken in the next release?

I just applied it

Maxime

--dhm3aq36fwshxmlu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBKQpAAKCRDj7w1vZxhR
xXU2AQDNobRB5Qb8nVgu+X90jUJ+LUMOvjrOxUHztFlhy3Sd1QD/fkTRAOhfzVVh
IhTj0/Ka77jsmN6JEUQQLqmSiOcdoQQ=
=YOWo
-----END PGP SIGNATURE-----

--dhm3aq36fwshxmlu--

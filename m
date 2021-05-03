Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBFB37127B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhECIdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:33:20 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:42601 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhECIdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:33:17 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CCB7E580B19;
        Mon,  3 May 2021 04:32:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 03 May 2021 04:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=J6nQ0/KfuR+05YIPzSL8wfLQo2Q
        of4u03261kWGVE+g=; b=kClSMLa5mcDshITiOjB2rxcqeMGTFa5by0oppWXQlz4
        vS8Bj7jKdxV+CP6iR+nvNh5Fab+DFHTJgBZxcq1Ta8g1nVgdRblFsHloyA21nkwX
        +1u06G7CJOVI0IfY7cmlZ4xYSdRn74j+D9dxKYMZW7sqQ+0z8gDHIiSvqgMNrWIx
        uxVSXmKmyHeJN0CYEXQRmUsLtb+ThsMqjvkeRJo6kVeAyqXN0ePSvwLX1Z+QAwLe
        lzABQtw3knzhzD3VYPQ6wnU4eBIsHndtYlzXgnOr7unV3LB4PzfvWH2MtuYESk9+
        G+QNoz2YOx8yqVTaQbp4vOLQzTuM1GUx+GItnG/kgGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=J6nQ0/
        KfuR+05YIPzSL8wfLQo2Qof4u03261kWGVE+g=; b=JsnGR/sSFj0eVVrpr/pGFq
        KX90ABdFWvenrIUsi7fxr/Hj+GRf4o8oRwGH1uhfIzQM+sdrNZ0FZekhB3OSddCY
        6COh+a9fwX7JR/ElWdVSO9mjvvhQF/t5b4qHehenVizxXniaU4BZzWpAbgiGuDao
        HgowfPShNjKyTuwAlv32cvElFbHn6mBzcNxcHmiVvFZX4/8OFXLIIQLf92sw8AzV
        LaI0CG1wYNuQpvJTDVewkCbxmOSaMO3dszxlPIx8Y+hwj5YsZlq6uFQKy+Y473v9
        YnqIYal0vZZ1MH3aIDle5Shomnsp3SqdGb8lTfmP69lzzvicFGX6u4dlowTXk58Q
        ==
X-ME-Sender: <xms:F7WPYD7iri4vLANzRxeF5W2FB7GkVagnPPvTN-Z6EavRAkmR9mITVA>
    <xme:F7WPYI4k2Jzudz3tDq2s0M9LiZ-dWuiWRz9awgjCdjd1hjfi865e63Gx_EbwN5Or3
    Cmwyhpa6OxLe6EHEUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepveevfeffudeviedtgeethffhteeuffetfeffvdehvedvheetteehvdelfffg
    jedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:F7WPYKd8J8eQLyF6iI4Mf2SPPIDv1lNCwary5ppNbv4YvM5EljQ1Yw>
    <xmx:F7WPYEKJpUYybaaQsIf9DxUu1WV7xzCPwxcYDM-QPlyL34GmevKJZw>
    <xmx:F7WPYHKB6M4eZwZ3Hu_OOvViQ7qUmBzyPiGAuzzHRNzvC_B_wvH8pQ>
    <xmx:GLWPYGZ3NBRKwPqZDtsJOKCoJ3DAyeWaj4SuO5wsWFy3y_xaDZIFlw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon,  3 May 2021 04:32:22 -0400 (EDT)
Date:   Mon, 3 May 2021 10:32:21 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/2] clk: Implement a clock request API
Message-ID: <20210503083221.qsdurp2f3bkwfa6d@gilmour>
References: <20210413101320.321584-1-maxime@cerno.tech>
 <161981637939.1363782.4943687720432536625@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ojju5rho7xzck4mj"
Content-Disposition: inline
In-Reply-To: <161981637939.1363782.4943687720432536625@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ojju5rho7xzck4mj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Fri, Apr 30, 2021 at 01:59:39PM -0700, Stephen Boyd wrote:
> Quoting Maxime Ripard (2021-04-13 03:13:18)
> > Hi,
> >=20
> > This is a follow-up of the discussion here:
> > https://lore.kernel.org/linux-clk/20210319150355.xzw7ikwdaga2dwhv@gilmo=
ur/
> >=20
> > This implements a mechanism to raise and lower clock rates based on con=
sumer
> > workloads, with an example of such an implementation for the RaspberryP=
i4 HDMI
> > controller.
> >=20
> > There's a couple of things worth discussing:
> >=20
> >   - The name is in conflict with clk_request_rate, and even though it f=
eels
> >     like the right name to me, we should probably avoid any confusion
> >=20
> >   - The code so far implements a policy of always going for the lowest =
rate
> >     possible. While we don't have an use-case for something else, this =
should
> >     maybe be made more flexible?
>=20
> I'm definitely confused how it is different from the
> clk_set_rate_exclusive() API and associated
> clk_rate_exclusive_get()/clk_rate_exclusive_put(). Can you explain
> further the differences in the cover letter here?

The exclusive API is meant to prevent the clock rate from changing,
allowing a single user to make sure that no other user will be able to
change it.

What we want here is instead to allow multiple users to be able to
express a set of minimum rates and then let the CCF figure out a rate
for that clock that matches those constraints (so basically what
clk_set_min_rate does), but then does allow for the clock to go back to
its initial rate once that constraint is not needed anymore.

So I guess it's more akin to clk_set_min_rate with rollback than the
exclusive API?

Maxime

--ojju5rho7xzck4mj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYI+1FQAKCRDj7w1vZxhR
xTMQAP0elV2uSlbu/N/umOikVWwqHSR4+Zjv9XZ1+PjRVm0tYwEAtNHYYQWnyauP
n0zWwwpA17OqaRECQDk7YDIPgiLPYg4=
=IIJ9
-----END PGP SIGNATURE-----

--ojju5rho7xzck4mj--

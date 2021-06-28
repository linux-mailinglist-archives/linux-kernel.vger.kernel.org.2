Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F1F3B5C47
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 12:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhF1KPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 06:15:06 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:56635 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232889AbhF1KOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 06:14:36 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id D1C692B00828;
        Mon, 28 Jun 2021 06:12:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 28 Jun 2021 06:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=G1ta7c/5/ThX06wXTeoCB5eCgJv
        sZJNMAJ9Re7t/XCY=; b=zqK0dOCuCE1noPGpc5CJksQS/smvQGb8Jolv2knBnCE
        ZlMy8mWmE7m0uknVyNTvOVsTxSbsGGCm9cn2b1rk/olrODnaczcN+T6bT766957N
        fDwTL8yWcU1NZb/9ayjpe9XI4Zatz7AZUyrLAvEmULb2hUgc+xiO941tXHi1x2JB
        jskcKAK7RLx3hNUUE4tos9TSCFKgftS/fFJw8TbARbRSMqqDvuhp0Pd83nwvK/BS
        i7FB697n6KHVXTlFCJ4YdSSg1k57217XtZtEk4JaqloWzVs/e1H2Vu0VLc8xjsKY
        PD2lRyxW5Nnny+5BN8JfXK0WrBHgJmXmPCj1bCZ7MfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=G1ta7c
        /5/ThX06wXTeoCB5eCgJvsZJNMAJ9Re7t/XCY=; b=WfbrO0P+LWj1h60MSG1mJM
        1C7/kdqiLuWZRDHHGZZrg+SXS2ZUOg0zjb8RhUgnNt0dlG3OwVUOwdcXLTakQ/JM
        4bKW3bbrnk96s1Z3wBUcfyt60jq1bpN96GNfXJINW10OcJVWYxsLknxEKDGr35xl
        FRQhSyEnslD5D2qTHZvyuMXarn0NvzO+lj2W+QPblPcp4GMmgmJaX4toLt60e6eK
        Mc+wiM2hW/a90BPLw0TA8EiHXMhbnOIpU1oyKJ37/kbn/DYyipbBNeyZuz8LmNPC
        ngM4lQjLUYbBxYHx7BPUxG/0oIYA8Jjac4EOy4JO15WlW8ie8InSTdXts0TO4qPg
        ==
X-ME-Sender: <xms:d6DZYDls6_6Dhd4TzTjS-0pGkA_W4h5ixrfOPZSrjBMP3wGnH8deCA>
    <xme:d6DZYG1m-odd59MuYjIiV9aDdEN_X0syhjTrqzNBhQx1NMyf9MrChweG8VQ4-yVkn
    t28brE5HYI-hmnUOuE>
X-ME-Received: <xmr:d6DZYJrif8c1Xtan_uLx2s_SnmCQNnIyKVh6seeLPCOtJBpvtFGG8IqhaP4t5bg_ZUxBG6VL3F5wQH40wKrXjSZrvJRTT8vdjb5K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:d6DZYLlD5Y0AAC-8KzB4noid8ZdJZDJZm5yG9FyQZAuvmPoR03-StA>
    <xmx:d6DZYB3QRX7pgZTQ0WygVpsaakizD5GWWiYiyP__Tho-PY3rpLEpKg>
    <xmx:d6DZYKtGVv6xmcHiF4-JGDUzawMBiT3gV03TdxSbsb0bzWJG6ajXEQ>
    <xmx:eaDZYA3m0edaLtUq34ARbFlM4Qx7VA_V4F_a4l7NHXfIeshH-_ralAzmtOk>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 06:12:07 -0400 (EDT)
Date:   Mon, 28 Jun 2021 12:12:05 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jonathan Liu <net147@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: Move drm_bridge_add into probe
Message-ID: <20210628101205.bul2iwwljxtd24tb@gilmour>
References: <20210203091306.140518-1-jagan@amarulasolutions.com>
 <CANwerB1Bev8Ljta9OyO6vAKsQqHHmaJnjV1YRGmY4bVk_J6xZA@mail.gmail.com>
 <CAMty3ZAY7Ez9UYvfftSmqLEVWgN7xE5HevqfWirmrExZH=RMWA@mail.gmail.com>
 <CANwerB1AiiT3oXCpwP83M1=ES9M-yQoLuZO5f=eVxA42MkEbiA@mail.gmail.com>
 <YNR/uQrS75s5BILs@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pxsrq5bk7iavnx3y"
Content-Disposition: inline
In-Reply-To: <YNR/uQrS75s5BILs@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pxsrq5bk7iavnx3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 24, 2021 at 03:51:05PM +0300, Laurent Pinchart wrote:
> CC'ing Maxime Ripard.
>=20
> Maxime, is this similar to the issue we've recently discussed with the
> VC4 DSI encoder ?
>=20
> On Thu, Jun 24, 2021 at 10:39:48PM +1000, Jonathan Liu wrote:
> > On Thu, 24 Jun 2021 at 22:34, Jagan Teki wrote:
> > > On Fri, Jun 18, 2021 at 6:40 PM Jonathan Liu wrote:
> > > > On Wed, 3 Feb 2021 at 09:13, Jagan Teki wrote:
> > > > > @@ -1167,6 +1151,20 @@ __dw_mipi_dsi_probe(struct platform_device=
 *pdev,
> > > > >         dw_mipi_dsi_debugfs_init(dsi);
> > > > >         pm_runtime_enable(dev);
> > > > >
> > > > > +       ret =3D drm_of_find_panel_or_bridge(dev->of_node, 1, 0,
> > > > > +                                         &panel, &bridge);
> > > > > +       if (ret)
> > > > > +               return ERR_PTR(ret);
> > > >
> > > > On RK3399 if the error is EPROBE_DEFER, __dw_mipi_dsi_probe can be
> > > > called again and result in the following errors:
> > > > [    0.717589] debugfs: Directory 'ff960000.mipi' with parent '/' a=
lready present!
> > > > [    0.717601] dw-mipi-dsi-rockchip ff960000.mipi: failed to create=
 debugfs root
> > > > [    0.717606] dw-mipi-dsi-rockchip ff960000.mipi: Unbalanced pm_ru=
ntime_enable!
> > >
> > > Is this when you test bridge on rk3399 or panel?
> >=20
> > MIPI-DSI to LVDS bridge.

It looks more like a driver that doesn't free its resources properly on EPR=
OBE_DEFER?

Maxime

--pxsrq5bk7iavnx3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYNmgdQAKCRDj7w1vZxhR
xR8DAP94cJXuHL0Y5IP7BYZbO+0AfSWavVR1bJBD81CtyTet5AEAzxOwqJgZ0od3
0W8wv1CYlqMx3P/bxlmTi9qwOAuJIwU=
=kLbL
-----END PGP SIGNATURE-----

--pxsrq5bk7iavnx3y--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72CE3B5C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 12:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhF1KNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 06:13:35 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:43953 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232605AbhF1KNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 06:13:33 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id CA8F92B00873;
        Mon, 28 Jun 2021 06:11:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 28 Jun 2021 06:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=plgjL9DAPOj+IJveFhfJC/nWlW8
        yqlKjHxjWHKswgTY=; b=dHpm6JF8XTDHNKuetck3J/8jJbiTaSqNQ7PzuUvBDnu
        apDZj5dq/mNOEVIeZ99HjOd12zVWNnYTKLdTaR6tq4FpRgxhZwhx+HkK92a2KZlu
        kPi6jColnmgeDXf7KlqKNGrR0C45z0u35ImhL1bx8LeykjGwm9F4T1Wa76B/N5tv
        Jjdxc0VZCxEpiPyBsLrc2hxNO9icbGNsPM+udn4WXBuIqFeIbj70HYs+Srzw9bm+
        4U8gSxMAviJkKX2WP2crv5lS/TcAQ15SuB82tjdKoiQZYjL/lElAo/6GW5ZWoOp5
        PfUhFIB0x7+uAD7NyhSU9XmnqreJ0YtEarT6Iv4mviA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=plgjL9
        DAPOj+IJveFhfJC/nWlW8yqlKjHxjWHKswgTY=; b=HzQbRG9j6qI7UwV0Om93PM
        f1gD6MaVceY+aoxPGGSzdakrVsYQK3DRdItk8rR6Bm4ntDeb7MVtoaV5kREuI2un
        xKMyF0FyLhHNpBnzsyg1PwW+pfrIacx/52ZpBL68TB6X7qN4o4bLMF7+01AVKeJ1
        eEEO0ZRqgreNJ+7mgtVkBRlUHl60mRG/tG1rt6sIxKxqrYfpdj+8Px3Y4Z0Cx663
        JN1nfvPSTUXrlo8oYsxHrDmJshaI/w4mUz29jlF89yGIuIaMk397U+ylgsQKqpBT
        Lk/oB4vGN7Gr8rxOLnatDGB5VZtCSy3fAldxDMmJ0Qeu13ke2RlpxyqpEePC8vPA
        ==
X-ME-Sender: <xms:OaDZYL-qVZFb9taWay3mI4NGfAaTLsxUAOPKnvw2a4zLDWCwP53hMw>
    <xme:OaDZYHtp6yo38wpADEdsPQlhsDP1nPVT9YJiOkpCCPdCXBPvs5myatE7R-APhTvRn
    2XO0351s_LO0ySj_QI>
X-ME-Received: <xmr:OaDZYJDDxKVVVWHdLsRtF8jQM6CpdQdcpuOSWhmr_MllmKfHdYnwcfKdJEIzNuv_I0_YOQ8uT8Tw8r0NO7OEFjniAiWwF4dhvjTy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepveevfeffudeviedtgeethffhteeuffetfeffvdehvedvheetteehvdelfffg
    jedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:OaDZYHcQHsrY2zDoihnbpo7-qtAP6bTD45eexLT15RTbvVlTTTJCXw>
    <xmx:OaDZYAOxj604zesZ7jQcL7YDpubImUNDBeYNW2uQmZ7crqzKGFMqqA>
    <xmx:OaDZYJms4UiHIL36bhVZpH1KFxgAXbbN4rAWQ8JBYN030BFNVQeJXA>
    <xmx:OqDZYJkXkBh6ARTMMez2w6qOfzjbkdtWZspHPl3N-1AfPFNL7rWuLCb_ML0>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 06:11:04 -0400 (EDT)
Date:   Mon, 28 Jun 2021 12:11:02 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Tim Gover <tim.gover@raspberrypi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/vc4: dsi: Only register our component once a DSI
 device is attached
Message-ID: <20210628101102.nunllcc7rog2nkc4@gilmour>
References: <20200707101912.571531-1-maxime@cerno.tech>
 <YM6dgVb12oITNfc0@pendragon.ideasonboard.com>
 <20210621160517.5fptdj4tkbzgqn76@gilmour>
 <CAPY8ntA0dsNwiyEiSHR7AuL1ESyPvTpKWAAg=MK3Gx9HKhq5qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qpwle5uhkiiqkop7"
Content-Disposition: inline
In-Reply-To: <CAPY8ntA0dsNwiyEiSHR7AuL1ESyPvTpKWAAg=MK3Gx9HKhq5qg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qpwle5uhkiiqkop7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 21, 2021 at 05:18:22PM +0100, Dave Stevenson wrote:
> Hi Maxime
>=20
> On Mon, 21 Jun 2021 at 17:05, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi Laurent,
> >
> > On Sun, Jun 20, 2021 at 04:44:33AM +0300, Laurent Pinchart wrote:
> > > Hi Maxime,
> > >
> > > I'm testing this, and I'm afraid it causes an issue with all the
> > > I2C-controlled bridges. I'm focussing on the newly merged ti-sn65dsi83
> > > driver at the moment, but other are affected the same way.
> > >
> > > With this patch, the DSI component is only added when the DSI device =
is
> > > attached to the host with mipi_dsi_attach(). In the ti-sn65dsi83 driv=
er,
> > > this happens in the bridge attach callback, which is called when the
> > > bridge is attached by a call to drm_bridge_attach() in vc4_dsi_bind().
> > > This creates a circular dependency, and the DRM/KMS device is never
> > > created.
> >
> > We discussed it on IRC, but it makes more sense here.
> >
> > The thing is, that patch is fixing a circular dependency we discussed
> > with Andrzej a year ago:
> >
> > https://lore.kernel.org/dri-devel/20200630132711.ezywhvoiuv3swo57@gilmo=
ur.lan/
> >
> > It seems like we have to choose between having the panels or bridges
> > working :/
>=20
> The Pi panel using the panel-raspberrypi-touchscreen driver is flawed
> as it controls the power to the FT5406 touchscreen element as well as
> the display. If DRM powers down the display, power goes to the
> touchscreen too, but the edt-ft5x06 touchscreen driver has no notion
> of this :-(
>=20
> The two parts have been broken into bridge/tc358762 and
> regulator/rpi-panel-attiny-regulator which then allows the edt-ft5x06
> driver to keep control over power. I haven't had it be 100% reliable
> though, so I'm still investigating as time allows, but this seems like
> the better solution than panel-raspberrypi-touchscreen.
>=20
> With the tc358762 node back under the DSI host node, I think that
> circular dependency you were trying to solve goes away.
> However with sn65dsi83 being I2C configured, is that an issue again?

Even though getting rid of the old driver make it less likely and
reverting that commit make it less likely, we still have the same
fundamental issue.

One thing we could do would be to always register the DSI encoder and
report the connector as connected if the panel has probed. However, I'm
not sure how it helps with a bridge.

Bridges over i2c don't seem too far-fetched to consider too.

Maxime

--qpwle5uhkiiqkop7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYNmgNgAKCRDj7w1vZxhR
xbCSAQDhJXOKSKI7tHoYRtt5y+gQnDIL8yc75+P6M808aYJvPAEAynmyr1AOeqFC
SLL/qDqyjb4DPXRaAHHgn587rXB5LQo=
=oZSV
-----END PGP SIGNATURE-----

--qpwle5uhkiiqkop7--

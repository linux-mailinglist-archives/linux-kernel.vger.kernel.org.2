Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB01387AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349759AbhEROGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:06:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47691 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243387AbhEROGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:06:03 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D9C2A5C01F0;
        Tue, 18 May 2021 10:04:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 18 May 2021 10:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Rvos89H/LpzyMgRIfAPzAZw+JU0
        ysxeDmbT0To2qb2g=; b=CpxYW2jBkjGYK72+79O+NMJn28k9nvkOyuPxt4ABXHM
        2gPx/waZjCJj+xA+P0AUWDNOYQmzqMktLPjIKPDdUfx2Z+hmeQl1udfcr4HTZhSB
        l2wuH+oWpCWJUwS+4TB2brQwUavsNfLOX1eQCMKzcBuHYun+5+M8G2PCcg+3UgEm
        kaxKg1yT3JRoeryLU4RdDJCGjKxvU4cZm+8CSHPjB/OOfYtSNUshGSZDwa/EzyFm
        Dp+3kXdCoHVtyyI1wNw4cTxSXxCXQ+MjKuAKzKL+/4C5sUtyUK6Oy+cFeiCb0t6p
        8JVENJyqVH1FuX4LnfjgKR9WjnzyF6huh7stT4DrnOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Rvos89
        H/LpzyMgRIfAPzAZw+JU0ysxeDmbT0To2qb2g=; b=Ex0vCopC0/+Jsu0TC9bAeJ
        bLTJ15FOYr055yEyQqK7GhsSI10kNVhZRemI5AgkGYypVtDKHvTPmBDkkmIg+UUU
        vqeHzbL+hOT58UtpJMawk5f12pTZjleZFkYUkI3AWL0I8LimaSkmQoIExxyKaN6g
        W59j8I2NF3Y11/DF94wsyH2yN++1h1kPF/KH0QYFSFiL1KvMtLi+KAQ/jZ320rDj
        gg6mvGCPD5oaYOTZGhJfrbc7KyNiZvN+TBOlP5qWZaFIMvGT0vZJrdSN9EwUoKrv
        tuFXkGRS32VY/2tfDGhUJ1vVFSulujAaU7PbaKJuUj4feMtGgspVLBOgefdKugGg
        ==
X-ME-Sender: <xms:e8mjYBmEQXWty36TGBqO1NthOKEKID1K7Xt5OOl4GN9SbiQ0qJk9ZQ>
    <xme:e8mjYM3QlYZS1Bcj6x7udcr4xficC5T3zbB-cMhEJvYOF0SYtxZtmQJHqlDyqng-u
    uCFMfjCJLvP9ZmQixY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeijedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjedtudekleffteevffduvdekfffffedvtdeuveffgfeffedtleetueelgeef
    leetnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdeike
    drjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    mhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:e8mjYHptviGKctpG-Md3GuzlwsJQOsgBXtn5JnYSn9gP9ScOYGZaAw>
    <xmx:e8mjYBmly3FiBKs9gqJxc8fL2Hb0FxIpBYYviDiQ8L7qkVUvqc0kSQ>
    <xmx:e8mjYP2FWYeEH9yj3ugpO1dOjXTWLNhFwZMV1-UITIJgFr2BvguxfQ>
    <xmx:fMmjYEko-cYThYEoynls3VueD6EuEiYnZIOZPFskrFQ_3TU1nMRX7w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 18 May 2021 10:04:43 -0400 (EDT)
Date:   Tue, 18 May 2021 16:04:42 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, wens@csie.org,
        jernej.skrabec@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, andre.przywara@arm.com
Subject: Re: fw_devlink=on and sunxi HDMI
Message-ID: <20210518140442.4hb6og6qh5htublo@gilmour>
References: <20210516170539.2yxe43qwezonuo3r@core>
 <CAGETcx93RxfsXG51zeaUK+UyKdEDgivqkmS85mcMPp0H42X5ZQ@mail.gmail.com>
 <20210517082957.sddwy2dv5esbzmo4@core>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdh4hwf2hzbvoi6g"
Content-Disposition: inline
In-Reply-To: <20210517082957.sddwy2dv5esbzmo4@core>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdh4hwf2hzbvoi6g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 17, 2021 at 10:29:57AM +0200, Ond=C5=99ej Jirman wrote:
> On Sun, May 16, 2021 at 11:32:47PM -0700, Saravana Kannan wrote:
> > On Sun, May 16, 2021 at 10:05 AM Ond=C5=99ej Jirman <megi@xff.cz> wrote:
> > >
> > > Hello,
> > >
> > > Linux 5.13-rc1 again has fw_devlink=3Don enabled by default. I've fou=
nd that this
> > > breaks probing display pipeline and HDMI output on sunxi boards, beca=
use of
> > > fwnode_link between hdmi and hdmi-phy nodes.
> > >
> > > HDMI device probe keeps being avoided with these repeated messages in=
 dmesg:
> > >
> > >   platform 1ee0000.hdmi: probe deferral - supplier 1ef0000.hdmi-phy n=
ot ready
> > >
> > > Both nodes have their own compatible, but are implemented by a single
> > > struct device.
> > >
> > > This looks like a kind of situation that's expected to break fw_devli=
nk
> > > expectations by my reading of the the e-mails about trying the fw_dev=
link=3Don
> > > during 5.12 cycle.
> > >
> > > Is this supposed to be solved by implementing the PHY node as it's own
> > > device or by breaking the fwnode_link between the hdmi phy and hdmi n=
odes?
> > > Seems like second solution would be quicker now that rc1 is out.
> >=20
> > Seems like sun8i_hdmi_phy_probe() already does 95% of the work to make
> > the PHY a separate driver. Why not just finish it up by really making
> > it a separate driver? I'd really prefer doing that because this seems
> > unnecessarily messed up. The phy will have a struct device created for
> > it already. You are just not probing it.
>=20
> Currently it's all just a glue code for dw-hdmi, which is not using a phy
> framework and handles both the controller and phy parts. dw-hdmi needs pa=
ssing
> platform data around
> (https://elixir.bootlin.com/linux/latest/source/include/drm/bridge/dw_hdm=
i.h#L115)
> to get a specific set of phy glue callbacks hooked into platform data of =
dw-hdmi
> prior to calling dw_hdmi_probe.
>=20
> Looking at other users of dw_hdmi_probe this is the only one that has this
> unfortunate issue due to using phys binding internally as a part of one d=
evice.
>=20
> Just making it a platform driver will also change the probe order of phy =
and the
> controller, which I've heard from Jernej needs to have the current order =
of
> (controller and then phy) perserved, for some reason, and will make things
> still a bit more convoluted.
>=20
> So this looks like needs quite a bit of thought.

Yep, and even if it was simple (which it really isn't), it wouldn't be
-rc* material.

Maxime

--fdh4hwf2hzbvoi6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKPJegAKCRDj7w1vZxhR
xY/sAQCoFYzBDvdB1iFrTeEgkP1/bJEtjBgkBnXBYqumOyP2ugD/TL6HP6UhWXEA
1BAzfJ+mg2XNxf66mlBJSN2Pz/8nBQo=
=64N2
-----END PGP SIGNATURE-----

--fdh4hwf2hzbvoi6g--

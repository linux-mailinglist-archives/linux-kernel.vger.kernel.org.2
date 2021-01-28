Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6BB3078F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 16:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhA1PA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 10:00:59 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:37387 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232117AbhA1PA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 10:00:28 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2112FEC6;
        Thu, 28 Jan 2021 09:59:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 28 Jan 2021 09:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=5OGZ4sa7nMMa5GSQnCTKv+TjN+I
        K4VHNp+cb4IFmPR8=; b=srMg/gv9uyr3A3tMB36U94EIma+RMtNlNfotaB+pX2W
        09lK591L2CL8kqDgP42fHnQcKDOnKu+Xiy3DISw7yoCp+dvigwanrGUR/cCDT/Dz
        XxBbx5tbsUWiz9Z6Dh4/qHENBkQRH33zF6cDUys3U1yzAKFeLhcph6vLZxYARTDQ
        LsVyY9hSzM7lgx4l8WqhVoICinB0CwrHXPQYUmd3GSAWJP+VB/lE+HAkEIvfQ+vB
        HvP48sfGO5GeCpJU9WvAUyBcloICWbQ5Okkn92sowbkD+ujaQReHp1NSSu1vlqHG
        35ES+f6kjoO0/VMKWfuE8TUeDjCdOuidkPekOUvomFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5OGZ4s
        a7nMMa5GSQnCTKv+TjN+IK4VHNp+cb4IFmPR8=; b=ciM1ZIrzC0VpGpmcUzoVJS
        FAapLhjLiuZOClWNsTvYSKustLD0yYDboZoUKdgW40Cw1Oc2gx6+5A+gExf+WCRR
        zgbtN2+o+0kBCCTaIHiAceF65ugwWCGjwwWaV7EQJV3CycHN4hR54P/3o5oAd+SJ
        Z0OfcqOOd2VbhqGYMvS4xud5vS6M9YAuYwwPqL0a5S4RGNcuz/0d0GykdAUsR5Wc
        YZ4k5dXcHKw3dzjXWpNlhNTr8bNs1yMQ7bbnvmJXrUqdgNQJN2Fi+mzWusE2jBjl
        A/pRtjaAff4hDoJvoX1CltCI84YIGQa0iTDyk00H1rdtdgnymR1/FIivhhXsoDNw
        ==
X-ME-Sender: <xms:XNESYGonryqH-J1WFA7Bmyn1guB244ZTUp-F_0Ub2TsOvOH5ocSJfA>
    <xme:XNESYEogqxMSOYDFqV0Hmm-mfm1dc2mRiuaAPC19wsh_8GJPZciDHhjNJfK9zUln3
    S2HKQJrg0jypyAEJ3Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecuggftrfgrthhtvghrnhepleekgeehhfdutdeljefgleejffehff
    fgieejhffgueefhfdtveetgeehieehgedunecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:XNESYLOTdwY_qWAWXwh-FP_kQULYmgsd3apCybbOeBRvko_6b9G4qg>
    <xmx:XNESYF4hhNetzLiS-ctQXRx-183VDxRKgpahLnuiOU-ASB8uJEvXVw>
    <xmx:XNESYF5tKPxZuCswvPd6mE4RlqlpIe3GYHuMMbHk1gITMMpi_BNWXw>
    <xmx:XdESYI0kD7TAbbs-W4wHPWEmoHVNMNmfMWdt3zzN2EJQ2dMnBdfcww>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E8EE924005A;
        Thu, 28 Jan 2021 09:59:39 -0500 (EST)
Date:   Thu, 28 Jan 2021 15:59:37 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Hermann.Lauer@uni-heidelberg.de
Cc:     linux-arm-kernel@lists.infradead.org, wens@csie.org,
        jernej.skrabec@siol.net, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ARM: dts: sun7i: a20: bananapro: Fix ethernet phy-mode
Message-ID: <20210128145937.vtdi4e2aih7milmt@gilmour>
References: <20210121170836.GA4948@lemon.iwr.uni-heidelberg.de>
 <20210128094040.GD11559@lemon.iwr.uni-heidelberg.de>
 <20210128111842.GA11919@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w5kslxpg7pza7kqz"
Content-Disposition: inline
In-Reply-To: <20210128111842.GA11919@lemon.iwr.uni-heidelberg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w5kslxpg7pza7kqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 28, 2021 at 12:18:42PM +0100, Hermann.Lauer@uni-heidelberg.de w=
rote:
> BPi Pro needs TX and RX delay for Gbit to work reliable and avoid high
> packet loss rates. The realtek phy driver overrides the settings of the
> pull ups for the delays, so fix this for BananaPro.
>    =20
> Fix the phy-mode description to correctly reflect this so that the
> implementation doesn't reconfigure the delays incorrectly. This
> happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> rx/tx delay config").
>=20
> Fixes: 10662a33dcd9 ("ARM: dts: sun7i: Add dts file for Bananapro board")
> Signed-off-by: Hermann Lauer <Hermann.Lauer@uni-heidelberg.de>

Applied since it's a fix simple enough, but please provide a changelog
between versions.

Maxime

--w5kslxpg7pza7kqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBLRWQAKCRDj7w1vZxhR
xZhZAP9g7vS4nYGzKh6vVRVscY9TJdD67lQNA45ycuRGhxGcEQD9Hy2y+Mla2bba
Eg2vi4hyEnepZtrfYVpFn2QU4jbzGg8=
=mdE2
-----END PGP SIGNATURE-----

--w5kslxpg7pza7kqz--

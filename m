Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F773313EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCHQ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:58:29 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54519 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhCHQ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:58:21 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1F1C15C00EB;
        Mon,  8 Mar 2021 11:58:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 08 Mar 2021 11:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=wNI50N2U4u+xLorOeqrgOlZ4jMr
        Ck1cYGeKLmrYONok=; b=u6lYVfzLfXL1v7RJ2pFvLDZvWhNXf2kljHqKNcYiT8O
        LL67WByRuqbMYFo5SswBcImOrk9VLge/SJCaVPVrfUFCDD1Hoop0gkEI/l3IMI3L
        XdGXvBVZ55y+/CModYvjupZTatZnQGl90Oo+u1bPM2niC7lBixuCeqn16qXvd3dK
        HBrXUQ7bfCLH90cG10BDE7Mqe+z1VtL3YkRgiD0FB+/68WzMSno/0bn1wWVF/9IR
        Ok0G02p9TfUXQN6pRf9SB3alRaFyrzbI6UFoKTjn7lZBsOaYQX2GvnBQFOrjlXDG
        VRaYhx3rZrE74WhbFVa7H32trGjjNFI3FBU7qFg/KLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wNI50N
        2U4u+xLorOeqrgOlZ4jMrCk1cYGeKLmrYONok=; b=XOHZczjK16SALv8aVo9I6H
        DzJPHDj2Z0qwY85ElDMUZG63QUg0Knxyg6x8S/DF85xDQut62RVsXFtovwzaggrq
        0Sx2/BBbuLNu4IntoBL6iZjO9BChN9L3CDOVKVnQEcG362CxYkJN7Vwfoy9SJTsg
        /vmOlijX8S3ZVLXL4+qW6DHV1eKK2jv68JE7bs+il3uDWnch6Eqq1gMNYSKOwkzw
        nRt69nx7fdah9MfOJfIYTQq56hN5ZcBVKdfGG9WAaQBcM7up5RawRwW7c/LDGKPA
        leZFJBavERm9adh93+7QuHjwS2W4rAXG+tFHgF/SWA3p9L/NwpaRm85znRxooRcQ
        ==
X-ME-Sender: <xms:qldGYGY7NhsH1shIxlbWZS7D7aldbAAhhsMTMFKzSA2_Idjpj_MKNA>
    <xme:qldGYAI_QAhpGpnKnmNv2AO-9ZJnCaHM8D5Gcfo3AGbo_OPKOjz24khw5gJjEzKp7
    RcMmfLjmjkbkfPe2uI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddugedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:qldGYCuAgkAddbwRytpyQC-aAUDLfTPmw-Vp1VWbRylQQI8heJG3Pg>
    <xmx:qldGYEUJea9A6QOlhHaesLoISSWU6iaFaM8Yq9tHYWXjFqal7FYUOw>
    <xmx:qldGYNilBeQHlPI-fNg1ekStxEpanCv3rDocWTkFl2kqI9koF8ieXg>
    <xmx:rFdGYLmAXv0s_BZwUP7odzKqrrvuyINyEjEMD9_NVeN3L2ewcF7YpA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 740D01080059;
        Mon,  8 Mar 2021 11:58:18 -0500 (EST)
Date:   Mon, 8 Mar 2021 17:58:17 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v6 2/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <20210308165817.iubugmpqsv3ysssq@gilmour>
References: <cover.1614430467.git.wilken.gottwalt@posteo.net>
 <d7c7bb2adac0ad9171a407b29b33b384724172ab.1614430467.git.wilken.gottwalt@posteo.net>
 <20210301131305.wrsonoqwcm6ua2e2@hendrix>
 <20210301150608.014b807b@monster.powergraphx.local>
 <20210302172002.4yygufnrmrbultk5@gilmour>
 <20210306120522.7e8f98e5@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="acrjoifstrybgptp"
Content-Disposition: inline
In-Reply-To: <20210306120522.7e8f98e5@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--acrjoifstrybgptp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 06, 2021 at 12:05:22PM +0100, Wilken Gottwalt wrote:
> On Tue, 2 Mar 2021 18:20:02 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> > Hi,
> >=20
> > On Mon, Mar 01, 2021 at 03:06:08PM +0100, Wilken Gottwalt wrote:
> > > On Mon, 1 Mar 2021 14:13:05 +0100
> > > Maxime Ripard <mripard@kernel.org> wrote:
> > >=20
> > > > On Sat, Feb 27, 2021 at 02:03:54PM +0100, Wilken Gottwalt wrote:
> > > > > Adds the sun6i_hwspinlock driver for the hardware spinlock unit f=
ound in
> > > > > most of the sun6i compatible SoCs.
> > > > >
> > > > > This unit provides at least 32 spinlocks in hardware. The impleme=
ntation
> > > > > supports 32, 64, 128 or 256 32bit registers. A lock can be taken =
by
> > > > > reading a register and released by writing a 0 to it. This driver
> > > > > supports all 4 spinlock setups, but for now only the first setup =
(32
> > > > > locks) seem to exist in available devices. This spinlock unit is =
shared
> > > > > between all ARM cores and the embedded companion core. All of the=
m can
> > > > > take/release a lock with a single cycle operation. It can be used=
 to
> > > > > sync access to devices shared by the ARM cores and the companion =
core.
> > > > >
> > > > > There are two ways to check if a lock is taken. The first way is =
to read
> > > > > a lock. If a 0 is returned, the lock was free and is taken now. I=
f an 1
> > > > > is returned, the caller has to try again. Which means the lock is=
 taken.
> > > > > The second way is to read a 32bit wide status register where ever=
y bit
> > > > > represents one of the 32 first locks. According to the datasheets=
 this
> > > > > status register supports only the 32 first locks. This is the rea=
son the
> > > > > first way (lock read/write) approach is used to be able to cover =
all 256
> > > > > locks in future devices. The driver also reports the amount of su=
pported
> > > > > locks via debugfs.
> > > > >
> > > > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > >=20
> > > Nope, I had to replace the devm_hwspin_lock_register function by the
> > > hwspin_lock_register function because like Bjorn pointed out that it =
can
> > > fail and needs to handled correctly. And having a devm_* function doe=
s not
> > > play well with the non-devm clock/reset functions and winding back if=
 an
> > > error occurs. It also messes with the call order in the remove functi=
on. So
> > > I went back to the classic way where I have full control over the cal=
l order.
> >=20
> > If you're talking about the clock and reset line reassertion, I don't
> > really see what the trouble is. Sure, it's not going to be in the exact
> > same order in remove, but it's still going to execute in the proper
> > order (ie, clock disable, then reset disable, then clock put and reset
> > put). And you can use devm_add_action if you want to handle things
> > automatically.
>=20
> See, in v5 zje result of devm_hwspin_lock_register was returned directly.=
 The
> remove callback or the bank_fail/clk_fail labels would not run, if the re=
gistering
> fails. In v6 it is fixed.

Yeah, and it's indeed an issue...

> +	platform_set_drvdata(pdev, priv);
> +
> +	return devm_hwspin_lock_register(&pdev->dev, priv->bank, &sun6i_hwspinl=
ock_ops,
> +					 SPINLOCK_BASE_ID, priv->nlocks);
> +bank_fail:
> +	clk_disable_unprepare(priv->ahb_clk);
> +clk_fail:
> +	reset_control_assert(priv->reset);
> +
> +	return err;
> +}
>=20
> So, is v6 fine for you even if it uses a more classic approach?

=2E.. but completely getting rid of the devm_ calls isn't a solution, if
that's what you're calling the more classic approach.

if (devm_hwspin_lock_register(..))
   goto bank_fail

return 0;

works, and using devm_add_action like I suggested works as well to fix
the issue you mentioned above

Maxime

--acrjoifstrybgptp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYEZXqQAKCRDj7w1vZxhR
xdNWAP4gdp9fIBx2RzpL1kKkxcJVKDRRaDPqKAcpA9IqCiuiSwD/Vm/30ievTM5Z
jH/jJ4BWFIjeDbpHbDgx1WqxzOczZgU=
=9NqM
-----END PGP SIGNATURE-----

--acrjoifstrybgptp--

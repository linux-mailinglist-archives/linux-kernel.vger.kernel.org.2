Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B2F32AACE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839888AbhCBTzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:55:22 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:36193 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1573777AbhCBRVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:21:19 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D23F91680;
        Tue,  2 Mar 2021 12:20:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 02 Mar 2021 12:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=fqcxahMGQ/LpWS5cFw6l6zICf1y
        BecEtYn+u6PFqW4Y=; b=ZFCP42xG1e0drDMBaJZBcTwLBJpW0Z8R5Xc0K/ykaE6
        wcr16Jh8TpZU4Ipwo63TMEvOAak1LpNjkT/peND6UQl5KL7olZW2tYAz43fmqVEz
        7VLTG/MkszGSwSTnKvcOc4aP5XRIIedX2OId+DuGcHtjRwx2uXJzWpE+Cq1kAFB9
        s8noZNv4Evw1F6Qw4EIlTfavbN6xtz0F15OxCAVR5Qg128bx8yFP3ew7aDuZG/lg
        m8h3XJMF0pIkoeYYqzSXSTbyLONWQWRTQKC5jP40WrbcQBcT2XACty0RdgU7J14y
        rA4Gk+8Q+BZ5ZZXUDAnDgZ13xcYFOMpJ+ydtuspyJew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fqcxah
        MGQ/LpWS5cFw6l6zICf1yBecEtYn+u6PFqW4Y=; b=hqQbDvplG/MTjFwVrioyuq
        ceDIiAlBJdltt/bG0YN2Bd31Prs6PNAEEFBkQHDbZlE+JL7Z4LN5x6NM5CPeN5Zc
        HIUaY8XlZ2Le/x9YMvnZzlrPICgVn29SOmeh1o1tZPNAhip+ZJvPqONp/jtDnmVy
        0XXa269J4/z/mW8R1QNfaDuQujO6X2KlGMCVLEOXT/6jZlc+OVpttBdnbMYkaRI7
        /Enr8Gt1hW+jPCIpwBiYCsUySS+91fzCpaXkRdwnUIz1JHCjf23bvTcnCRbtpp2J
        9NBXm9RLBeNTWaNr5zxEiv3lcBFfI3YmscyKvCsU3gMYUF32eU4gKmDnPr55V1lw
        ==
X-ME-Sender: <xms:xnM-YJJi7z80xusS2hVNgf2GLhyoiYcG4IoyAOhj65i_uZbWAVw8mQ>
    <xme:xnM-YFJACg4lasBuhVbkj4NN6u3ba8LojPOPtiNooz6AEKzRODgpA8wBgcxIQkHSk
    vxP3M9Jq6TTWHXeYP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddttddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:xnM-YBtnH49AA_70nvcj_ruuTU2wUpVELhCmGlNnrZGEptuCT9nNeg>
    <xmx:xnM-YKaUyOLxx5HPifUaPeY9nRlFYpPSxNv4WZR7xFSSJOxIhjaO6A>
    <xmx:xnM-YAYzQP6ltghft5EJNxICOyOrbVf9rgDmWYLNawt92EWhQstmBQ>
    <xmx:x3M-YPzEEi8gsY8Y41yyzq9w7VBRsCWzZBf34HFen-hxDKNddE3d1A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B34F11080069;
        Tue,  2 Mar 2021 12:20:04 -0500 (EST)
Date:   Tue, 2 Mar 2021 18:20:02 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v6 2/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <20210302172002.4yygufnrmrbultk5@gilmour>
References: <cover.1614430467.git.wilken.gottwalt@posteo.net>
 <d7c7bb2adac0ad9171a407b29b33b384724172ab.1614430467.git.wilken.gottwalt@posteo.net>
 <20210301131305.wrsonoqwcm6ua2e2@hendrix>
 <20210301150608.014b807b@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tqi2ksux5rirg6t7"
Content-Disposition: inline
In-Reply-To: <20210301150608.014b807b@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tqi2ksux5rirg6t7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 01, 2021 at 03:06:08PM +0100, Wilken Gottwalt wrote:
> On Mon, 1 Mar 2021 14:13:05 +0100
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > On Sat, Feb 27, 2021 at 02:03:54PM +0100, Wilken Gottwalt wrote:
> > > Adds the sun6i_hwspinlock driver for the hardware spinlock unit found=
 in
> > > most of the sun6i compatible SoCs.
> > >
> > > This unit provides at least 32 spinlocks in hardware. The implementat=
ion
> > > supports 32, 64, 128 or 256 32bit registers. A lock can be taken by
> > > reading a register and released by writing a 0 to it. This driver
> > > supports all 4 spinlock setups, but for now only the first setup (32
> > > locks) seem to exist in available devices. This spinlock unit is shar=
ed
> > > between all ARM cores and the embedded companion core. All of them can
> > > take/release a lock with a single cycle operation. It can be used to
> > > sync access to devices shared by the ARM cores and the companion core.
> > >
> > > There are two ways to check if a lock is taken. The first way is to r=
ead
> > > a lock. If a 0 is returned, the lock was free and is taken now. If an=
 1
> > > is returned, the caller has to try again. Which means the lock is tak=
en.
> > > The second way is to read a 32bit wide status register where every bit
> > > represents one of the 32 first locks. According to the datasheets this
> > > status register supports only the 32 first locks. This is the reason =
the
> > > first way (lock read/write) approach is used to be able to cover all =
256
> > > locks in future devices. The driver also reports the amount of suppor=
ted
> > > locks via debugfs.
> > >
> > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
>=20
> Nope, I had to replace the devm_hwspin_lock_register function by the
> hwspin_lock_register function because like Bjorn pointed out that it can
> fail and needs to handled correctly. And having a devm_* function does not
> play well with the non-devm clock/reset functions and winding back if an
> error occurs. It also messes with the call order in the remove function. =
So
> I went back to the classic way where I have full control over the call or=
der.

If you're talking about the clock and reset line reassertion, I don't
really see what the trouble is. Sure, it's not going to be in the exact
same order in remove, but it's still going to execute in the proper
order (ie, clock disable, then reset disable, then clock put and reset
put). And you can use devm_add_action if you want to handle things
automatically.

Maxime

--tqi2ksux5rirg6t7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYD5zwQAKCRDj7w1vZxhR
xaDiAQDMz37kWOKq3Qu484wmOKDZzBgFivNJyBTXbWkiIsd2GAD7BmUi/T0QepTY
cwXZGdtNPkV2THt+8qnofZfOF4oPQAo=
=8SgK
-----END PGP SIGNATURE-----

--tqi2ksux5rirg6t7--

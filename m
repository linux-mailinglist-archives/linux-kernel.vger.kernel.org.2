Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA0B34E381
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhC3IvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:51:04 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33959 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhC3Iu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:50:59 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 488B85C01DD;
        Tue, 30 Mar 2021 04:50:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 30 Mar 2021 04:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=DYuF8ynynyUmg6f7TaD/4Cm9Ex5
        LmsY3DCYS1inVb+I=; b=RjkMMZ7Ogm7XVBdnoG+lxUzzkh2Votx/DWQ8H5r073x
        shyp3beqFmAg3LZrmP74zPJqge02q7IxfqoZVxClXkv+lYtOCsCuNTYuQomhIWsi
        8CMqjMnC+mrU0V4T/ajmGnSf4raTGWxzb/8LZka+C2paburpNHLhYNoEJQjH0k3b
        5ZfXaDnNsfimby32c1BHSQxs0wTEhKguVpwX4zrzp2bbyMJQgY1r3ESzodnbgPs4
        Tf7ev3vC59jAwrckodGZiLQx1LeQvc0C1H4LLKYL+/smbYMI/RmZmdvu4pU5rW9C
        aBlE/4jelctzuv1oUwWEDkQ/5O8ra4C6K5Xn8srHn6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DYuF8y
        nynyUmg6f7TaD/4Cm9Ex5LmsY3DCYS1inVb+I=; b=crrIKOXWIkCv14bpXIgj8k
        ig9wzz/YtRttVsnNfF2dlCBDsYM3IVF+ITz6WxYxOqMxNnMo5VqL/KL+tM5TpNfA
        CD/jiKQtRcR528hipEuHFZVF8EAsldzjull9tb1gqOSUPkNoOZDA4uj7PocO5qqT
        77CGFpeYy6+Bgo/SLtEJYCoAp4BL5qoZGpIegiLVOIzfFP/xRBO/c8jf8aa3OnRs
        H3p1eRbqHpPRUR8vtrGfbfuN6aaq1GnPHuJRsYZl2ptrlK7Tksv0jz6QiZMYhfUg
        Ysu+xq7l2WV8zlspu6iwI/Ss8jFcAMHlcY4lywvlSRUx4vJ2xD8YVTOH2MRx2oAg
        ==
X-ME-Sender: <xms:ceZiYPyPNdrsF0mBbr03CZBJiDa8VXPf83eWhZLgBj8Vt7my0Ma5Bg>
    <xme:ceZiYHM38LQcwayQkxBVAux4N7UNl3iZd0IrzGWNItWYZXD7gSLuEjnwAf0OHrt0E
    UTIG4uyx_lsY6baNWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeitddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ceZiYGPjQVV2XUxnND-PXMX7ke_SDLPcyCft6hHNox67yrAuzOcO8A>
    <xmx:ceZiYBSwR7r-OhYrX97o78AWzm0u9gwMhVDnzHPheY66jLTXc5o0Lw>
    <xmx:ceZiYAD6JnJEUvK_VmY-tkOWxdSqlDeC4Wqfi6hOLg1ilXOu0bLWug>
    <xmx:cuZiYCEJd4-PJCjRtwtPtTEKuUXnXH1M_QVxvFvl09LxRATGwYthIA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 224C224005C;
        Tue, 30 Mar 2021 04:50:57 -0400 (EDT)
Date:   Tue, 30 Mar 2021 10:50:54 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com
Subject: Re: [RFC PATCH] arm64: dts: allwinner: a64/h5: Add CPU idle states
Message-ID: <20210330085054.6ijkwc2jww6ovkvl@gilmour>
References: <20210322062514.40747-1-samuel@sholland.org>
 <20210323015627.08f9afd6@slackpad.fritz.box>
 <ca26bade-abab-8e01-8014-bc7c72ea13fc@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fqu5tsevk4cqb364"
Content-Disposition: inline
In-Reply-To: <ca26bade-abab-8e01-8014-bc7c72ea13fc@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fqu5tsevk4cqb364
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Tue, Mar 23, 2021 at 11:44:50PM -0500, Samuel Holland wrote:
> On 3/22/21 8:56 PM, Andre Przywara wrote:
> >> I'm sending this patch as an RFC because it raises questions about how
> >> we handle firmware versioning. How far back does (or should) our suppo=
rt
> >> for old TF-A and Crust versions go?
> >>
> >> cpuidle has a problem that without working firmware support, CPUs will
> >> enter idle states and be unable to wake up. As a result, the system wi=
ll
> >> hang at some point during boot, usually before getting to userspace.
> >>
> >> For over a year[0], TF-A has exposed the PSCI CPU_SUSPEND function when
> >> a SCPI implementation is present[1]. Implementing CPU_SUSPEND is
> >> required for implementing SYSTEM_SUSPEND[2], even if CPU_SUSPEND is not
> >> itself used for anything.=20
> >>
> >> However, there was no code to actually wake up a CPU once it called the
> >> CPU_SUSPEND function, because I could not find the register providing
> >> the necessary information. The fact that CPU_SUSPEND was broken affect=
ed
> >> nobody, because nothing ever called it -- there were no idle states in
> >> the DTS. In hindsight, what I should have done was always return failu=
re
> >> from sunxi_validate_power_state(), but that ship has long sailed.
> >>
> >> I finally found the elusive register and implemented the wakeup code
> >> earlier this month[3]. So now, CPU_SUSPEND actually works, if all of
> >> your firmware is up to date, and cpuidle works if you add the states in
> >> your device tree.
> >>
> >> Unfortunately, there is currently nothing verifying that compatibility.
> >> So you can get into four possible scenarios:
> >>   1) No idle states in DTS, any firmware =3D> Linux works, with baseli=
ne
> >>      power consumption.
> >>   2) Idle states added to DTS, no Crust/SCPI =3D> Linux works, but eve=
ry
> >>      attempt to enter an idle state is rejected because CPU_SUSPEND is
> >>      not hooked up. So power consumption increases by a sizable amount.
> >>   3) Idle states added to DTS, "old" Crust/SCPI (before [3]) =3D> Linux
> >>      fails to boot, because CPUs never return from idle states.
> >>   4) Idle states added to DTS, "new" Crust/SCPI (after [3]) =3D> Linux
> >>      works, with improved power consumption compared to the baseline.
> >>
> >> Obviously, we want to prevent scenario 3 if possible.
> >=20
> > So I think the core of the problem is that the DT describes some
> > firmware feature, but we have the DT bundled with the kernel, not the
> > firmware.
>=20
> I would say the core problem is that the firmware lies about supporting
> PSCI CPU_SUSPEND. Linux shouldn't be calling CPU_SUSPEND if the firmware
> declares it as unavailable, regardless of what is in the DTS.

I would say we have two core problems :)

> (Technically, per the PSCI standard, CPU_SUSPEND is a mandatory
> function, but a quick survey of the TF-A platforms shows it is far from
> universally implemented.)

U-boot also implements CPU_SUSPEND but will return -1 if you don't have
an implementation. I guess that at the moment we shouldn't be reporting
it as supported if we don't

But I also agree with Andre here, we shouldn't list cpuidles
capabilities in the DTS if we don't always have them either.

> > So is there any way we can detect an older crust version in U-Boot,
> > then remove any potential idle states from the DT?
>=20
> Let's assume that we are using a functioning SoC (H3) or the secure fuse
> is blown (A64) and therefore U-Boot cannot access SRAM A2. I can think
> of three ways it can learn about crust:
>=20
> a) PSCI_FEATURES (e.g. is CPU_SUSPEND supported)
> b) Metadata in the FIT image
> c) Custom SMCs
>=20
> TF-A has some additional methods available:
>=20
> d) The SCPI-reported firmware version
> e) The magic number at the beginning of the firmware binary
>=20
> > Granted, this requires recent U-Boot as well, but at least we could try
> > to mitigate the worst case a bit?
>=20
> If we're okay with modifying firmware to solve this problem, then I
> propose the following solution:
>=20
> 1) Version bump crust or change its magic number.
> 2) Modify TF-A to only report CPU_SUSPEND as available if it detects the
>    new crust version. This would involve conditionally setting
>    sunxi_scpi_psci_ops.validate_power_state, and updating psci_setup.c
>    to also check for .validate_power_state when setting psci_caps.
> 3) Modify the Linux PSCI client to respect PSCI_FEATURES when setting
>    psci_ops.cpu_suspend. cpuidle-psci checks for this function before
>    setting up idle states.
> 4) Finally, after some time, add the idle states to the DTS.
>=20
> In fact, this solution solves both scenarios 2 and 3, because it also
> takes care of the native PM implementation, which doesn't implement
> CPU_SUSPEND at all.
>=20
> Does that sound workable?

If we can add the DT node at boot in crust (or in TF-A), then we don't
really need PSCI_FEATURES, and it would magically work once the firmware
is updated. It looks like a solid plan otherwise

Maxime

--fqu5tsevk4cqb364
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYGLmbgAKCRDj7w1vZxhR
xR6GAP9Xd46Sh1ZKV6TSYgW3Ro2ikOoq7BAh96jMt2rg5YtKswEArrxcKgP0z8lf
RvhIhSmKDy+iQ+pMz2uu+FJp4/x9+gk=
=05SX
-----END PGP SIGNATURE-----

--fqu5tsevk4cqb364--

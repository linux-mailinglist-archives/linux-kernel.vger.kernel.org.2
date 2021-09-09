Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A972404734
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 10:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhIIIqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:46:53 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59863 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231549AbhIIIqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:46:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 56097580AF7;
        Thu,  9 Sep 2021 04:45:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 09 Sep 2021 04:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=fXIbsZdMOwnGpikZ6f1eRUW6Zp6
        DapCjyxIfszyQnyE=; b=2OV64XDRwKpf6BMIUyOBlsL07FXgOmvHe0OG/Z6bjzz
        ajaLwvxnDBz3oV97VMioFXPeyksXWqn2Jg0hTp01SIH3CnPcUf07R1HwdXa89oc5
        ke3l8sVQ+B4b9tiJnn7R1VCNTG3j+rD12uBmyhDwHRIqhKoiX6NFFD5S/UfuoEuG
        mIkvVGV7B/IzY4N3pBK87J//9B4kOy3RjLxgUyvYXRfksbpTCxtQnd0Q3AV8DkP6
        ByZsfRKBFnPz80/ym5TTVik/cCX2BxMA0HWoLFvhdBsIqSrXQvp27txRk108uAaD
        nj2eXK4vt3GEwMpj+YN4bfV4DUclspx3eWm9DCOPe2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fXIbsZ
        dMOwnGpikZ6f1eRUW6Zp6DapCjyxIfszyQnyE=; b=KiupMEmaeBiTfsAPFuMTny
        +0eK63fG8iVe8wC0DAoXdnJuPE6HcZ+wlCcM3bIrgguLICEpP5AwZquoUlYbLuWs
        siLD6XiJ+lWPaxcK3LwnOCOCVnvuwo68wMD/fL9hiw9PpGel8fEacFW+eyqzqOf1
        YNDyuZ+s8PfkbXOej/ylZ8Dj58j2F0NgXgIC50kz0sI+mn9wNsp+YeuAo1FWt6TR
        jW61JLo52b/soHUMCNG/hX+JKGlN07Bf2e14Q2/bwmQTpb4jg/6YXrO9yDtgzoLW
        ZY0OIv7Ze6pvLTpyB5TNZrpngihLluNbqhmSU1AY4J6MwtZkflncMom/MWtJC34A
        ==
X-ME-Sender: <xms:tck5YZd1ql8G2lK8psEMTd64M_DEzE5kp0oS7rf75N-opTK2YNxBCw>
    <xme:tck5YXPXY4Kp9IkbloUEDVxBfe-TgUNMBCOqHp9N4EK20xGQRxlwSip75wbmTsIZW
    l5Xv1k-t0WKTHNbgV0>
X-ME-Received: <xmr:tck5YShmeIdtPoSBo4zc4hu-rH0o9u1qkb6Vx01yjzPKSzFbZDyRPPWVjaN6IHkbmGuXyjAKhSYYcRmbS97Oo0TzRqLS-xa4gK-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:tck5YS_bzvvKEZZ7KML-tm-tE51uTJtXyoY4d6mO1ElLfLiuJuS5rA>
    <xmx:tck5YVtRlx3M_Ye79QOfqSJC8RiuPNM2aZhVqnHVu1spmyG3bUr_cA>
    <xmx:tck5YRECUPfd6fZ_h6-RxsDhdh0C_6d_RSHOy9hgXcCkVsihn36yaA>
    <xmx:tsk5YbIlnZuDcRzP8SP-lfQ5jlOiyb2EDHJLNrd64pM1JIGsPhRwlg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Sep 2021 04:45:40 -0400 (EDT)
Date:   Thu, 9 Sep 2021 10:45:38 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] clk: sunxi-ng: Add a RTC CCU driver
Message-ID: <20210909084538.jeqltc7b3rtqvu4h@gilmour>
References: <20210901053951.60952-1-samuel@sholland.org>
 <20210903145013.hn6dv7lfyvfys374@gilmour>
 <4a187add-462b-dfe4-868a-fdab85258b8d@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="auq6fgnyvsqqa77k"
Content-Disposition: inline
In-Reply-To: <4a187add-462b-dfe4-868a-fdab85258b8d@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--auq6fgnyvsqqa77k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 03, 2021 at 10:21:13AM -0500, Samuel Holland wrote:
> On 9/3/21 9:50 AM, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Wed, Sep 01, 2021 at 12:39:44AM -0500, Samuel Holland wrote:
> >> This patch series adds a CCU driver for the RTC in the H616 and R329.
> >> The extra patches at the end of this series show how it would be
> >> explanded to additional hardware variants.
> >>
> >> The driver is intended to support the existing binding used for the H6,
> >> but also an updated binding which includes all RTC input clocks. I do
> >> not know how to best represent that binding -- that is a major reason
> >> why this series is an RFC.
> >>
> >> A future patch series could add functionality to the driver to manage
> >> IOSC calibration at boot and during suspend/resume.
> >>
> >> It may be possible to support all of these hardware variants in the
> >> existing RTC clock driver and avoid some duplicate code, but I'm
> >> concerned about the complexity there, without any of the CCU
> >> abstraction.
> >>
> >> This series is currently based on top of the other series I just sent
> >> (clk: sunxi-ng: Lifetime fixes and module support), but I can rebase it
> >> elsewhere.
> >=20
> > I'm generally ok with this, it makes sense to move it to sunxi-ng,
> > especially with that other series of yours.
> >=20
> > My main concern about this is the split driver approach. We used to have
> > that before in the RTC too, but it was mostly due to the early clock
> > requirements. With your previous work, that requirement is not there
> > anymore and we can just register it as a device just like the other
> > clock providers.
>=20
> That's a good point. Originally, I had this RTC CCU providing osc24M, so
> it did need to be an early provider. But with the current version, we
> could have the RTC platform driver call devm_sunxi_ccu_probe. That does
> seem cleaner.
>=20
> (Since it wasn't immediately obvious to me why this works: the only
> early provider remaining is the sun5i CCU, and it doesn't use the sun6i
> RTC driver.)
>=20
> > And since we can register all those clocks at device probe time, we
> > don't really need to split the driver in two (and especially in two
> > different places). The only obstacle to this after your previous series
> > is that we don't have of_sunxi_ccu_probe / devm_sunxi_ccu_probe
> > functions public, but that can easily be fixed by moving their
> > definition to include/linux/clk/sunxi-ng.h
>=20
> Where are you thinking the clock definitions would go? We don't export
> any of those structures (ccu_mux, ccu_common) or macros
> (SUNXI_CCU_GATE_DATA) in a public header either.

Ah, right...

> Would you want to export those? That seems like a lot of churn. Or would
> we put the CCU descriptions in drivers/clk/sunxi-ng and export a
> function that the RTC driver can call? (Or some other idea?)

I guess we could export it. There's some fairly big headers in
include/linux/clk already (tegra and ti), it's not uAPI and we do have
reasons to do so, so I guess it's fine.

I'd like to avoid having two drivers for the same device if possible,
especially in two separate places. This creates some confusion since the
general expectation is that there's only one driver per device. There's
also the fact that this could lead to subtle bugs since the probe order
is the link order (or module loading).

And synchronizing access to registers between those two drivers will be
hard, while we could just share the same spin lock between the RTC and
clock drivers if they are instanciated in the same place.

Maxime

--auq6fgnyvsqqa77k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYTnJsgAKCRDj7w1vZxhR
xWKfAP9WolSmwsGNKd7TEH30FKvAYAxNAYNgceOQQI81F6ZUaAD/X64s6BKisuDB
r08jQKq1pjleoCJbhAkLWl4nN9Wn7gU=
=qRHE
-----END PGP SIGNATURE-----

--auq6fgnyvsqqa77k--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C196A41AB78
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbhI1JIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:08:13 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:42333 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239623AbhI1JII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:08:08 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id B00A02B01605;
        Tue, 28 Sep 2021 05:06:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 Sep 2021 05:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=3
        +KWQOmitGlx5dS7qikRhiEwaMwGqnlRLiJbVG/4vB8=; b=dhwTA5T8yWAPFeHs1
        qwbkgrHqohaW/mbsotgt1VPB7urO3mWKXpAD8yxlrbk/bJICddts8vEpBzr8BmP2
        +mViREf0WVmwrnT6pbmpPlXavHOTrjW2lkXS6NR/MOaWtdTdY+4KcXTI9smdVEVf
        LHCdc7z4n9KmakPnRJ4+EWYSwmdjLDZh7JnUjDEnG3qxNb/CZeNg9sx3sJbvFvgg
        jboNPluRGcMVRwWevjesxhSCmAUeuLjrKQzLMjB/bzNYWJ/2doPUIfkGioiOHA5R
        2TYnexm7bsa7glZbeNumPuan3VTGhzGQejb4K53nyBHkPYzURhxTSFf1NbaYd17n
        Xv+7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=3+KWQOmitGlx5dS7qikRhiEwaMwGqnlRLiJbVG/4v
        B8=; b=wu2VOcyAxjXpLYAo505J3eaVGTZoQccNmueq7IUlW00Kwk3NC8Nu5z9fV
        k8fOyRW4/eznPeyw0XuJn3teesPS4xl9KgPaQAd61lwRaQFEZWuZ6M2FepiMeCAu
        eYs0YjZwnVo8G11B6CJGRaNQtR77L7odeEfbiRQG4tuRpSUIcLxc+fsBlh4xXdVk
        K84/3CUEVdPnq4RnZP8jrYBAOpCkDwNADs81G8uGTwNjQtV+oZKUsGta3edljmOg
        Tld2Wym2VRvS6/Ul89GvaCHCB1wNWJMpjCHriO+S0+tNLkAT1/rxcWrH4tm4VVDV
        FNiOwp9uUpT/fOao3tPfPcZFBEs7A==
X-ME-Sender: <xms:E9tSYTeKFMnsgkCrQ1twBNMq3gxMcIggnWTwgLaTkednGlhIBVI9IQ>
    <xme:E9tSYZNflnaFuUjIqV-6eh2pdVmT3Qe13I1CYtuE64bdjY3XsuqHneW1zrzmGCQGB
    IxyNyO2wpayOVFxPck>
X-ME-Received: <xmr:E9tSYcgbySTrWhz414tVgEzNxhE7q9CvW88EbIZnB6vobE_45CxhUGpxXdHbwC2vmBzZNW3rbzmnIroCRouRwSTvgfWb_FZCgfxH9Dxk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:E9tSYU_w2akdumQCi5yQHjVcKFX48JWRqnpKnAvhTsSzGtFzCquYUQ>
    <xmx:E9tSYfsPymaoY6lyY0lk7FoCxQvZzisPc3K3mZqA1YQH_StmeRksBg>
    <xmx:E9tSYTHsrjTmI8jQ5QAK37RhTJXSA2uGCn2xnKe0QcTlR6LlKkF6OQ>
    <xmx:FNtSYdLCF3X69qnIoHXDtWvqtq6F-3JBsyDODXIYgKDU5ReqwE3f8PkjGZY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 05:06:27 -0400 (EDT)
Date:   Tue, 28 Sep 2021 11:06:25 +0200
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
Message-ID: <20210928090625.rq3atiaejaq5kcbx@gilmour>
References: <20210901053951.60952-1-samuel@sholland.org>
 <20210903145013.hn6dv7lfyvfys374@gilmour>
 <4a187add-462b-dfe4-868a-fdab85258b8d@sholland.org>
 <20210909084538.jeqltc7b3rtqvu4h@gilmour>
 <c910527d-e2d7-31ca-efd9-1915db62d85d@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c910527d-e2d7-31ca-efd9-1915db62d85d@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 28, 2021 at 02:46:39AM -0500, Samuel Holland wrote:
> On 9/9/21 3:45 AM, Maxime Ripard wrote:
> > On Fri, Sep 03, 2021 at 10:21:13AM -0500, Samuel Holland wrote:
> >> On 9/3/21 9:50 AM, Maxime Ripard wrote:
> >>> Hi,
> >>>
> >>> On Wed, Sep 01, 2021 at 12:39:44AM -0500, Samuel Holland wrote:
> >>>> This patch series adds a CCU driver for the RTC in the H616 and R329.
> >>>> The extra patches at the end of this series show how it would be
> >>>> explanded to additional hardware variants.
> >>>>
> >>>> The driver is intended to support the existing binding used for the =
H6,
> >>>> but also an updated binding which includes all RTC input clocks. I do
> >>>> not know how to best represent that binding -- that is a major reason
> >>>> why this series is an RFC.
> >>>>
> >>>> A future patch series could add functionality to the driver to manage
> >>>> IOSC calibration at boot and during suspend/resume.
> >>>>
> >>>> It may be possible to support all of these hardware variants in the
> >>>> existing RTC clock driver and avoid some duplicate code, but I'm
> >>>> concerned about the complexity there, without any of the CCU
> >>>> abstraction.
> >>>>
> >>>> This series is currently based on top of the other series I just sent
> >>>> (clk: sunxi-ng: Lifetime fixes and module support), but I can rebase=
 it
> >>>> elsewhere.
> >>>
> >>> I'm generally ok with this, it makes sense to move it to sunxi-ng,
> >>> especially with that other series of yours.
> >>>
> >>> My main concern about this is the split driver approach. We used to h=
ave
> >>> that before in the RTC too, but it was mostly due to the early clock
> >>> requirements. With your previous work, that requirement is not there
> >>> anymore and we can just register it as a device just like the other
> >>> clock providers.
> >>
> >> That's a good point. Originally, I had this RTC CCU providing osc24M, =
so
> >> it did need to be an early provider. But with the current version, we
> >> could have the RTC platform driver call devm_sunxi_ccu_probe. That does
> >> seem cleaner.
> >>
> >> (Since it wasn't immediately obvious to me why this works: the only
> >> early provider remaining is the sun5i CCU, and it doesn't use the sun6i
> >> RTC driver.)
> >>
> >>> And since we can register all those clocks at device probe time, we
> >>> don't really need to split the driver in two (and especially in two
> >>> different places). The only obstacle to this after your previous seri=
es
> >>> is that we don't have of_sunxi_ccu_probe / devm_sunxi_ccu_probe
> >>> functions public, but that can easily be fixed by moving their
> >>> definition to include/linux/clk/sunxi-ng.h
> >>
> >> Where are you thinking the clock definitions would go? We don't export
> >> any of those structures (ccu_mux, ccu_common) or macros
> >> (SUNXI_CCU_GATE_DATA) in a public header either.
> >=20
> > Ah, right...
> >=20
> >> Would you want to export those? That seems like a lot of churn. Or wou=
ld
> >> we put the CCU descriptions in drivers/clk/sunxi-ng and export a
> >> function that the RTC driver can call? (Or some other idea?)
> >=20
> > I guess we could export it. There's some fairly big headers in
> > include/linux/clk already (tegra and ti), it's not uAPI and we do have
> > reasons to do so, so I guess it's fine.
> >=20
> > I'd like to avoid having two drivers for the same device if possible,
> > especially in two separate places. This creates some confusion since the
> > general expectation is that there's only one driver per device. There's
> > also the fact that this could lead to subtle bugs since the probe order
> > is the link order (or module loading).
>=20
> I don't think there can be two "struct device"s for a single OF node.

That's not what I meant, there's indeed a single of_node for a single
struct device. If we dig a bit into the core framework, the most likely
scenario is that we would register both the RTC and clock driver at
module_init, and with the device already created with its of_node set
during the initial DT parsing.

We register our platform driver using module_platform_driver, which
expands to calling driver_register() at module_init(), setting the
driver bus to the platform_bus in the process (in
__platform_driver_register()).

After some sanity check, driver_register() calls bus_add_driver(), which
will call driver_attach() if drivers_autoprobe is set (which is the
default, set into bus_register()).

driver_attach() will, for each device on the platform bus, call
__driver_attach(). If there's a match between that device and our driver
(which is evaluated by platform_match() in our case), we'll call our
driver probe with that device through driver_probe_device(),
__driver_probe_device() and finally really_probe().

However, at no point in time there's any check about whether that device
has already been bound to a driver, nor does it create a new device for
each driver. So this means that, if you have two drivers that match the
same device (like our clock and RTC drivers), you'll have both probe
being called with the same device, and the probe order will be defined
by the link order. Worse, they would share the same driver_data, with
each driver not being aware of the other. This is incredibly fragile,
and hard to notice since it goes against the usual expectations.

> So if the CCU part is in drivers/clk/sunxi-ng, the CCU "probe"
> function would have to be called from the RTC driver.

No, it would be called by the core directly if there's a compatible to
match.

> Since there has to be cooperation anyway, I don't think there would be
> any ordering problems.

My initial point was that, with a direct function call, it's both
deterministic and obvious.

> > And synchronizing access to registers between those two drivers will be
> > hard, while we could just share the same spin lock between the RTC and
> > clock drivers if they are instanciated in the same place.
>=20
> While the RTC driver currently shares a spinlock between the clock part
> and the RTC part, there isn't actually any overlap in register usage
> between the two. So there doesn't need to be any synchronization.

I know, but this was more of a social problem than a technical one. Each
contributor and reviewer in the future will have to know or remember
that it's there, and make sure that it's still the case after any change
they make or review.

This is again a fairly fragile assumption.

Maxime

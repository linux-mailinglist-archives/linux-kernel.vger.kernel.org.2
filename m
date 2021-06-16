Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6F43A96E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhFPKIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:08:07 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59989 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231741AbhFPKIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:08:06 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 91161580604;
        Wed, 16 Jun 2021 06:05:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 16 Jun 2021 06:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=z
        2UmXQhDugDkY3JPY2VRubJRfdN52LF2DGHHRLorphg=; b=R6H3erMeBMR3fIoM2
        77xoA6yS7bg5QXVivp3ylMv9MZd/zfzltpfqDXvtmAeuaLOaRpZyFF0jHi2LCr+w
        ZhhjvGZjWKjtUyq3x0CMLK70v4uBkHUt/zkeJuKTReRA59oq6MduD2TLLTCOjsmU
        gK9FquEyI/dC1/9SbtyumTwMKjZMAMqf9GZJsHeVHZ2bcqo4BLFfz5czSdm0M37V
        L1t3icC3hRFM1VVEYrVYkRpkxGhFL7vQWhWyU17OE/pN+yr9mWTckOnV/zvdTFVe
        ZonT7zxN3dwI9yNLRin5YBB7IRdBjeuulB0gYBasTYLnkiNt9aoxwrjam2R6DAqm
        f/wMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=z2UmXQhDugDkY3JPY2VRubJRfdN52LF2DGHHRLorp
        hg=; b=jsDSEhVcFO8gvA0na/olEN5ylxjEW9Ja+YhUGN6Yw8xkYweA2iTPpeIQg
        0NJF2jBg8lIFhlzY6k8WHdRzkWCtmDlKTf7CykoEHBlLwmgK/sia8VE4k7CmiguV
        rG78yU1QiNWt+PESpW/4XMrPiREZOLgJkl/Ge82o8C+mwx8S1s2WxhJpOHII74ds
        +kPhB4vQP6uxAlW2xEtHGyQp2VHAHHuXsy3RiVaKPXsTwMH02C3aG9OLEwQvZNmx
        vQAIa1St0P9cXZQsJohrAcRw4kz47moIC7xLzmrC6MxLFZU0N9cPP5+jVyWsm8Gm
        mi7oHrB1m1j1fOvoyG9AiubWLlMbA==
X-ME-Sender: <xms:Bs3JYMMt9TyZmcXpU3IAd1qtExhNfWav3V3At8NMNdUKHm4u2nJIig>
    <xme:Bs3JYC_KO831DpFMm114ng8_UlATdMdzgKShLPCzlb3Stk9B_TDu7DIQ3epzY44uY
    bgmV1rpSDa8To3nIFo>
X-ME-Received: <xmr:Bs3JYDSozzZz1TLYLZCNCMZ2ULx8MPLCoj9-dSg_IheXxXGL8CUKx6SibqdbKoOTsm8tcFHm_8O0VwPUmtJcJlzXylUAbvWDTG8y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeekieelteevjeffgeeuteejiefggfefgfekueeuteffhfehgeevfefhkeeh
    veekudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:Bs3JYEvCXFS374RDtVAWktaaD12hkElXzI9QElcb5K_F_rVZFCv3vw>
    <xmx:Bs3JYEfgdaWe38JK5keIn3ue5zEQKZf4i4WUCvNgBaNMqzg0gAssqA>
    <xmx:Bs3JYI3kCi8c3VLug69BuOpbyktCZ5HGlJnzHRew5tUMCOCGaiLusg>
    <xmx:B83JYP1l7lydSwSPKvYzRg5LPGHhvVzr2pklNt160u6gyz3LfPq79g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jun 2021 06:05:57 -0400 (EDT)
Date:   Wed, 16 Jun 2021 12:05:56 +0200
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
Message-ID: <20210616100556.marhidqeljaxswyf@gilmour>
References: <20210413101320.321584-1-maxime@cerno.tech>
 <161981637939.1363782.4943687720432536625@swboyd.mtv.corp.google.com>
 <20210503083221.qsdurp2f3bkwfa6d@gilmour>
 <20210524124811.74g75n672wrpzqqi@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210524124811.74g75n672wrpzqqi@gilmour>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Mike,

On Mon, May 24, 2021 at 02:48:11PM +0200, Maxime Ripard wrote:
> Hi Stephen, Mike,
>=20
> On Mon, May 03, 2021 at 10:32:21AM +0200, Maxime Ripard wrote:
> > Hi Stephen,
> >=20
> > On Fri, Apr 30, 2021 at 01:59:39PM -0700, Stephen Boyd wrote:
> > > Quoting Maxime Ripard (2021-04-13 03:13:18)
> > > > Hi,
> > > >=20
> > > > This is a follow-up of the discussion here:
> > > > https://lore.kernel.org/linux-clk/20210319150355.xzw7ikwdaga2dwhv@g=
ilmour/
> > > >=20
> > > > This implements a mechanism to raise and lower clock rates based on=
 consumer
> > > > workloads, with an example of such an implementation for the Raspbe=
rryPi4 HDMI
> > > > controller.
> > > >=20
> > > > There's a couple of things worth discussing:
> > > >=20
> > > >   - The name is in conflict with clk_request_rate, and even though =
it feels
> > > >     like the right name to me, we should probably avoid any confusi=
on
> > > >=20
> > > >   - The code so far implements a policy of always going for the low=
est rate
> > > >     possible. While we don't have an use-case for something else, t=
his should
> > > >     maybe be made more flexible?
> > >=20
> > > I'm definitely confused how it is different from the
> > > clk_set_rate_exclusive() API and associated
> > > clk_rate_exclusive_get()/clk_rate_exclusive_put(). Can you explain
> > > further the differences in the cover letter here?
> >=20
> > The exclusive API is meant to prevent the clock rate from changing,
> > allowing a single user to make sure that no other user will be able to
> > change it.
> >=20
> > What we want here is instead to allow multiple users to be able to
> > express a set of minimum rates and then let the CCF figure out a rate
> > for that clock that matches those constraints (so basically what
> > clk_set_min_rate does), but then does allow for the clock to go back to
> > its initial rate once that constraint is not needed anymore.
> >=20
> > So I guess it's more akin to clk_set_min_rate with rollback than the
> > exclusive API?
>=20
> Is that rationale good enough, or did you expect something else?

I'm not really sure what to do at this point. It's been over 2 months
since I sent this series, and we really need that mechanism in some form
or another.

I'm really fine with changing that series in any way, but I got no
comment that I could address to turn this into something that would be
acceptable to you. How can we move this forward?

Maxime

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3C3D6B46
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 02:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhG0AGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 20:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233580AbhG0AGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 20:06:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 607E160F59;
        Tue, 27 Jul 2021 00:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627346826;
        bh=Qck6iY4YvM505kFR7EcKgK8YwluegBU6mcH0/wgjirw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lvAJOyrs1pGwM00bQChe+MqDNBtUu/V1sVqgjFd7J165/Mdpf05/CRRla1Qdp1XX/
         /kLkE5qlxJAeCV5nL+aIQZ1cl60q0sG7JCPvg3wWUYo6zOTkg8piAGjNklc1lYepJN
         DID9BWd9BXitIaKWRj2+v99wYdThVX1VZMujrNT5WNznhRc60gqQ2AKWrZ364UTZ5z
         LRzQ9fSaHPChM0zxgyih+26dZRDPSn+DyzgoXgyWm2kvEM/C6rl6v9X68KzCnzAnl0
         B/kbFTHyZm3gUHZsHI8UEk39/GcHdF6ET0ITvyayt6vrGYsMvScsBIDaXbdLlwyWGy
         ZFjePSaoXOtBA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jzgvnfdng.fsf@starbuckisacylon.baylibre.com>
References: <20210528113403.5374-1-peng.fan@oss.nxp.com> <162262192433.4130789.1017942859005253343@swboyd.mtv.corp.google.com> <a5833012-3e86-5be0-71f2-de4d9b32a152@pengutronix.de> <1j1r9kobln.fsf@starbuckisacylon.baylibre.com> <1jzgvnfdng.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH 0/3] clk: support regmap
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Peng Fan (OSS) <peng.fan@oss.nxp.com>,
        mturquette@baylibre.com
Date:   Mon, 26 Jul 2021 17:47:05 -0700
Message-ID: <162734682512.2368309.12015873010777083014@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2021-06-18 07:30:59)
>=20
> On Wed 02 Jun 2021 at 11:32, Jerome Brunet <jbrunet@baylibre.com> wrote:
>=20
> > On Wed 02 Jun 2021 at 10:21, Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
> >
> >> On 6/2/21 10:18 AM, Stephen Boyd wrote:
> >>> Quoting Peng Fan (OSS) (2021-05-28 04:34:00)
> >>>> From: Peng Fan <peng.fan@nxp.com>
> >>>>
> >>>> To i.MX8ULP, a PCC register provides clk(mux, gate, divider) and per=
ipheral
> >>>> reset functionality, so we need make sure the access to the PCC regi=
ster
> >>>> be protected to avoid concurrent access from clk and reset subsystem.
> >>>>
> >>>> So let's use regmap here.
> >>>>
> >>>> The i.MX specific code will be posted if this patchset is ok for you.
> >>>=20
> >>> We have a couple regmap clk drivers in the tree. Either combine the
> >>> different regmap clk drivers or duplicate it into the imx directory. =
I'd
> >>> prefer we combine them but last time I couldn't agree on the approach
> >>> when Jerome wanted to do it. Maybe now is the time to combine them all
> >>> into one common piece of code.
> >>
> >> IMHO for the basic drivers, such as gate, divider, mux, mux-div, etc..=
. it makes
> >> no sense to have them in an arch specific subdir, like meson.
> >
> > Indeed, those basic types were not meant to remain platform
> > specific. Some framework (ASoC for ex) make heavy use of regmap and
> > could welcome regmap based basic clock types.
> >
> > At the time, Stephen (qcom) and I (meson) had slightly different
> > approaches. Before having those types spread through the kernel, I think
> > testing things out was a good thing ... this is why these are platform
> > specific ATM.
> >
> > It's been 3 years now ... and it has not been a total disaster :)
> >
> > In the end things are not so different. Let's compare:
> > a. Both have a generic "clk_regmap" type common to all regmap based
> >   types. This is very useful to easily fix the regmap pointer in static
> >   clocks (which are heavily used by both platform)
> >
> > b. Meson uses a generic pointer to store the type specific info.
> >   Qcom embeds the generic clk_regmap into the specific type one.
> >   =3D> In the end, I don't see any advantage to the meson
> >   approach. Switching to the qcom method would be quite a big bang
> >   for meson but it is doable (nothing difficult, just a huge line count)
> >  =20
> > c. Qcom basic regmap type deviates a bit from the regular basic ones
> >   when it comes to the actual data. The qcom "clk_regmap" also provides
> >   the gate, mux have the qcom "parent_map". In meson, I tried to keep as
> >   close as possible to regular basic types ... at least what they were 3
> >   years ago. Only the register poking part should be different actually.
> >   =3D> I'd be in favor of keeping close to meson here.
> >
> > A possible plan could be:
> > 1. Rework meson as explained in [b] above.
> > 2. reword types in qcom where necessary to avoid name clashes (add
> >    "_qcom" extension for ex)
> > 3. Move the clk_regmap implementation out of meson to drivers/clk
> > 4. Things are yours to play with ...
> >
> > I can take care of 1. and 3. I would welcome help for 2. especially sin=
ce
> > I won't be able to test it.
> >
>=20
> Hi Stephen,
>=20
> What do you think of the proposition above ?
> There rework is going to take some time to do. I'll start only if this
> OK with you.

Hey Jerome,

Sorry I wrote a long email and then it got lost when my machine
rebooted. :( That was weeks ago! :( :(

Anyway, we have struct device now associated with clks when they're
registered (yay!), so I wonder if perhaps we can make an API or two like
clk_hw_get_regmap(struct clk_hw *) that takes a clk_hw and finds the
device associated with the clk and then calls dev_get_regmap() with that
device pointer to get the regmap pointer. Then clk drivers can use the
regmap pointer wherever they want. The basic clk type code can be
modified to either have a flag like "I_AM_A_REGMAP_CLK" (please pick
better name), or to have an init clk_op that stores the regmap pointer
in the basic type structure if grabbing it all the time is too costly
(no idea here so it really needs a measurement).

We do have some clks that are registered with devices that have
more than one regmap. The clk_hw_get_regmap() API would need to probably
take a string argument too, similar to dev_get_regmap() that lets clk
providers figure out what regmap they're asking for if there's more than
one associated with it.

With that API (and probably one for clk_hw_get_dev(struct clk_hw *)) we
should be able to avoid having to consolidate on a 'struct clk_regmap'
and let the various drivers keep doing what they're doing with the
regmap pointer. I know this may not be what you're envisioning, but I
think it would be a good step to take so that we can simplify some of the
registration code and add regmap support to the basic types in a way
that isn't heavily invasive because we're changing structs or struct
members all over the place.

I for one don't look forward to reviewing a huge rewrite of any clk
driver :)

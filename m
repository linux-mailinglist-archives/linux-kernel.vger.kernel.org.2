Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01BB315D62
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhBJCfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:35:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235292AbhBJCaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:30:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3390D64E2E;
        Wed, 10 Feb 2021 02:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924172;
        bh=3Mx7WnlVCi7iLf7Z4T8FAAbN3TrWqbP/lKf4nZEbdEI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oyEYhFwp0DZbNc0cAh3kBUdou6YamNQI7Z3Of1bdT3vpMiQKL1d/uq6vfxY1N7yla
         9Aa+C+wmjXJl/v0Re0Qp13yRBK4r+lyLjJO00fo36ksp8eZNn0XrMncxAAt7vPST70
         Zi/kMiZITEWwmy/OHfPbvdokc7s6LernVW8SygGPxxmdMzKfbUm/rJ3ZOMHuoIuV4m
         JD+j4G2KH7xy2hsbuxIjsav2sl3BXCHhKRf4ek1A28TotTsZpfmxzTv5Y9IV2Wj/LX
         e8ZwMT1TW342ZD/NgLL+77mChT1kFrv9EHTtpGc1PhI5HM41S3BZR65qTfRjPO4lkG
         EyamCSw/n0gfg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFr9PX=oLqQqvykiwOGAGg1H2CG0BTEqn0TuSrijodjxY52LxQ@mail.gmail.com>
References: <20201114135044.724385-1-daniel@0x0f.com> <20201114135044.724385-3-daniel@0x0f.com> <160843556037.1580929.13575770228476494246@swboyd.mtv.corp.google.com> <CAFr9PX=f=HyHBk4s3e_vnMDC53R1X18m7sKFCLMMjitPm+8oEQ@mail.gmail.com> <160848984935.1580929.936824086681978646@swboyd.mtv.corp.google.com> <CAFr9PX=oLqQqvykiwOGAGg1H2CG0BTEqn0TuSrijodjxY52LxQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: clk: mstar msc313 mpll binding description
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
To:     Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 09 Feb 2021 18:29:30 -0800
Message-ID: <161292417080.418021.13416197091150418216@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Palmer (2020-12-21 00:51:56)
> Hi Stephen,
>=20
> On Mon, 21 Dec 2020 at 03:44, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Daniel Palmer (2020-12-19 22:35:41)
> > > Hi Stephen,
> > >
> > > On Sun, 20 Dec 2020 at 12:39, Stephen Boyd <sboyd@kernel.org> wrote:
> > > > > +  clock-output-names:
> > > > > +    minItems: 8
> > > > > +    maxItems: 8
> > > > > +    description: |
> > > > > +      This should provide a name for the internal PLL clock and =
then
> > > > > +      a name for each of the divided outputs.
> > > >
> > > > Is this necessary?
> > >
> > > I found without the names specified in the dt probing of muxes that
> > > depend on the outputs but appear earlier didn't work.
> > > Also this same PLL layout seems to be used in some other places so
> > > eventually I was thinking this driver would get used for those PLLs
> > > with different output names.
> >
> > Still seems like it could be auto-generated based on dev_name() +
> > number.
>=20
> At one point I had something similar to that where the output names
> were generated at probe.
> Without the clock outputs listed in the device tree clock muxes that
> source clocks from the mpll couldn't probe properly as they couldn't
> look up all of their parents if they probed before the mpll.
> Maybe I'm doing something wrong there? I couldn't find a way to always
> resolve all of the parents or defer the probe of the muxes until the
> mpll clocks are registered.
>=20

The child clks should be using clk_parent_data to point to the parent
clks through DT. That way the name of the clk doesn't matter except for
debug purposes.

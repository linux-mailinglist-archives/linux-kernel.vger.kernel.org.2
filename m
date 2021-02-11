Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31F53183F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 04:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBKD1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 22:27:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhBKD1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 22:27:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99CB064DDA;
        Thu, 11 Feb 2021 03:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613014020;
        bh=PCiw2rBG+NnKh3mugRkCiTperZH5eqqJY5RdAXR3cbs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PH1IwJLvbZ5s6LMertC03KILBTRO3b1ofB3HuAwBxY6XspnkdGT5EAHbmVigd7FPi
         f+EXFJZ9m516Ss85NYv+MnmFWkKzKNqku5U4CkKU664kUVNhG/XmW+bUclyLsjedrg
         4976k2+4v21SBVzBRbsH0RZHngWnU3oPjQEbkd78qWjrOesiSTFeiFkwqzjl1Pwdew
         p627CHsBL15h2Dhr3BclTCIZC9nz24LEm6dUgvBXlsOukuF+xrX6sVRqybAxTrkIjj
         /uFz+dgGM+zP1iFnNnLPWFjsXo2PxTB+2rZKselQM4uwjacAOauZhA+simLZXfkGEn
         X1u9sGp0i5yQQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YAxuE8un+nznqtSx@pendragon.ideasonboard.com>
References: <1560138293-4163-1-git-send-email-weiyi.lu@mediatek.com> <20190625221415.B0DC22086D@mail.kernel.org> <1561511122.24282.10.camel@mtksdaap41> <20190626035246.4591A20659@mail.kernel.org> <YAxuE8un+nznqtSx@pendragon.ideasonboard.com>
Subject: Re: [RFC v1] clk: core: support clocks that need to be enabled during re-parent
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, Biao Huang <biao.huang@mediatek.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Wed, 10 Feb 2021 19:26:59 -0800
Message-ID: <161301401933.1254594.17328948754641721355@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Laurent Pinchart (2021-01-23 10:42:27)
> Hi Stephen,
>=20
> On Tue, Jun 25, 2019 at 08:52:45PM -0700, Stephen Boyd wrote:
> > Quoting Weiyi Lu (2019-06-25 18:05:22)
> > > On Tue, 2019-06-25 at 15:14 -0700, Stephen Boyd wrote:
> > > > Quoting Weiyi Lu (2019-06-09 20:44:53)
> > > > > When using property assigned-clock-parents to assign parent clock=
s,
> > > > > core clocks might still be disabled during re-parent.
> > > > > Add flag 'CLK_OPS_CORE_ENABLE' for those clocks must be enabled
> > > > > during re-parent.
> > > > >=20
> > > > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > >=20
> > > > Can you further describe the scenario where this is a problem? Is it
> > > > some sort of clk that is enabled by default out of the bootloader a=
nd is
> > > > then configured to have an 'assigned-clock-parents' property to cha=
nge
> > > > the parent, but that clk needs to be "enabled" so that the framework
> > > > turns on the parents for the parent switch?
> > >=20
> > > When driver is built as module(.ko) and install at runtime after the
> > > whole initialization stage. Clk might already be turned off before
> > > configuring by assigned-clock-parents. For such clock design that need
> > > to have clock enabled during re-parent, the configuration of
> > > assigned-clock-parents might be failed. That's the problem we have no=
w.
> >=20
> > Great. Please put this sort of information in the commit text.
> >=20
> > > Do you have any suggestion for such usage of clocks? Many thanks.
> >=20
> > Ok, and in this case somehow CLK_OPS_PARENT_ENABLE flag doesn't work? Is
> > that because the clk itself doesn't do anything unless it's enabled?  I
> > seem to recall that we usually work around this by caching the state of
> > the clk parents or frequencies and then when the clk prepare or enable
> > op is called we actually write the hardware to change the state. There
> > are some qcom clks like this and we basically just use the hardware
> > itself to cache the state of the clk while it hasn't actually changed to
> > be at that rate, because the clk is not enabled yet.
>=20
> I'm trying to move the fix to the clock driver itself. Do you have any
> pointer to such a clock that I can use as an example ?

This reminds me of some stuff we did in the qcom clk driver to handle
shared clks. Look at clk_rcg2_shared_ops in drivers/clk/qcom/clk-rcg2.c
for some more details. But there we have hardware that allows you to
write new settings but not set the "go" bit that actually switches the
mux/divider to a new rate. The non-linux entity using the clks doesn't
care what rate the clk is running at, it needs to just make sure the clk
turns on so it can do its thing. But the problem is the clk can be
turned on and off at random and that gets the clk stuck, so we put the
clk at some safe frequency that is always on (XO) and let the other side
go wild. But to the kernel we want it to think the rate is still what it
was set to, so we cache away the rate the kernel thinks in the hardware
and don't set the "go" bit so that when we enable the clk again in linux
it will reconfigure the clk to be the rate we want.

If you don't have that hardware then I suppose you'll have to cache the
register value in the set_rate clk op and return that cached value from
recalc_rate but only write the register value on the prepare/enable
path. Should be doable, but not a lot of fun! It may also be possible to
have some clk flag that makes the core do this for you by calling the
set_rate() call at the right time.

>=20
> > The main concern is that we're having to turn on clks to make things
> > work, when it would be best to not turn on clks just so that register
> > writes actually make a difference to what the hardware does.
>=20
> I agree, it's best not to turn the clock on if we can avoid it.
>

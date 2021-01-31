Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0189C309E4C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 20:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhAaTfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 14:35:33 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55849 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhAaTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:32:18 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E15C5C00AD;
        Sun, 31 Jan 2021 13:51:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 31 Jan 2021 13:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=jxeUXLuaimNiZia6MBCJXMUoovo
        pXP5DSHjG2fgERJw=; b=FkY+KI1S+8v4K9WCq8Cp/LdPifjyMAyFvfimBKjP/rA
        BEopN5/tyXEUIvvUrX4AqTbZrP92VCsF5IOke6hQDpqaA+C0q9OFHo2ZhyIkRo2l
        kb7+/X6dfpeZ4vyuR/2h06EV4gInYjmeH+Ei9zQ2RabggbPMKblFDqSrKlIHoQDf
        hfNAHHv3hsbfnrHIiV2lsUeweRJ9t2z9jHmiFIpuWfuLRdlQiEsurO1l+0/aKlQL
        vw1Eou4HqhPHisTfRxk3ifRqEyj2gvLRIez2qkAZNt5HlHj7Xr7N+Bnlj87eGY/F
        3qwg7LpcLCb2ZmgYU2mBk5+TpnwHsy+HIKjL8yrEQZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jxeUXL
        uaimNiZia6MBCJXMUoovopXP5DSHjG2fgERJw=; b=PlRPe1h0Vuc14psbG7A3AF
        /7Ty2fuZFNSiZs6eg5464j/D2TzprUCyumFYyrTUdO8yDYHkz0Q5zE3z0R6t42PP
        qevOTqd/8/ZZX8BeDuj/fIK2kx4l09FvhXLQvzPdqUIH37ch8/Lw6LIXbqj+/1ak
        TEOb3YNB1MlyoZuBQFRY1ORzbO1MtfXsVC7/+/CwiYkPFK6JsexznXXIRhDQiWu4
        NQ7QlvDosMMKuWA9BCU4nfeiykxqVHjWJ8Fhrzer6zre1oO1Ay0nZb6yygaWbq7o
        g+aX42vrcmet/iITWWotP2FG1qMEQXsdh3c691n/+k2eiEeChk7UVkl4MwmVlVTA
        ==
X-ME-Sender: <xms:QfwWYI1aaGZyditsUPmrjghAa1D9g_q5LCZ7Nij4q-2u_phaxYqfAg>
    <xme:QfwWYDFYu2OpAlqSapn7TlqnvVHWEJGRkp8lEZrpRZZ9h7BZu-klczKkBir6uSwCb
    49tCneVTPnlG9YPgAk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeigdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:QfwWYA7rjIpPyfZkEj2uIUzHcieM-QiXmzZtKVlr3rl9YFKLj9J7dw>
    <xmx:QfwWYB0V-rIunhk8BS72ESRVvGdkHxE9kkrmm4CMBiHESrXzyU9MUw>
    <xmx:QfwWYLHPcrwuXqy1eg0I5HoHTOLUj-GXksFRK6wk1oCY2GiG7GdV6A>
    <xmx:QvwWYDA9oEdd3FN2E9Vs928lbFeHkldhexcTONiv_ypv1-3hCK1PAA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4D5861080057;
        Sun, 31 Jan 2021 13:51:45 -0500 (EST)
Date:   Sun, 31 Jan 2021 19:51:43 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: arm: sunxi: &83t: WARNING: CPU: 2 PID: 57 at
 drivers/thermal/thermal_core.c:563 thermal_zone_device_update
Message-ID: <20210131185143.hnx6sibielrsavvr@gilmour>
References: <YBWPN3ZHkARxmGe9@Red>
 <CAGb2v67bWu0n--REsmmMo9oqdSu8wh6ys0b4omEQ57223W7suw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yqmlpou36nljsmcp"
Content-Disposition: inline
In-Reply-To: <CAGb2v67bWu0n--REsmmMo9oqdSu8wh6ys0b4omEQ57223W7suw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yqmlpou36nljsmcp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 31, 2021 at 01:33:32PM +0800, Chen-Yu Tsai wrote:
> Hi,
>=20
> On Sun, Jan 31, 2021 at 12:54 AM Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> >
> > Hello
> >
> > When booting next-20210128, I got the following warning on by bpim3
> >     6.148421] ------------[ cut here ]------------
> > [    6.153145] WARNING: CPU: 2 PID: 57 at drivers/thermal/thermal_core.=
c:563 thermal_zone_device_update+0x134/0x154
> > [    6.163378] 'thermal_zone_device_update' must not be called without =
'get_temp' ops set
> > [    6.171300] Modules linked in: sha256_generic libsha256
> > [    6.176553] CPU: 2 PID: 57 Comm: kworker/2:1 Not tainted 5.11.0-rc1-=
00042-gf3788af62cfe #399
> > [    6.184984] Hardware name: Allwinner A83t board
> > [    6.189517] Workqueue: events deferred_probe_work_func
> > [    6.194686] [<c010d568>] (unwind_backtrace) from [<c010a060>] (show_=
stack+0x10/0x14)
> > [    6.202438] [<c010a060>] (show_stack) from [<c07e156c>] (dump_stack+=
0x98/0xac)
> > [    6.209666] [<c07e156c>] (dump_stack) from [<c07df02c>] (__warn+0xc0=
/0xd8)
> > [    6.216545] [<c07df02c>] (__warn) from [<c07df0dc>] (warn_slowpath_f=
mt+0x98/0xc0)
> > [    6.224030] [<c07df0dc>] (warn_slowpath_fmt) from [<c0630384>] (ther=
mal_zone_device_update+0x134/0x154)
> > [    6.233426] [<c0630384>] (thermal_zone_device_update) from [<c063091=
8>] (__thermal_cooling_device_register+0x334/0x35c)
> > [    6.244204] [<c0630918>] (__thermal_cooling_device_register) from [<=
c0633ea0>] (__cpufreq_cooling_register.constprop.0+0x184/0x294)
> > [    6.256026] [<c0633ea0>] (__cpufreq_cooling_register.constprop.0) fr=
om [<c0633ff0>] (of_cpufreq_cooling_register+0x40/0x7c)
> > [    6.267153] [<c0633ff0>] (of_cpufreq_cooling_register) from [<c064cb=
44>] (cpufreq_online+0x2b4/0x8f4)
> > [    6.276379] [<c064cb44>] (cpufreq_online) from [<c064d200>] (cpufreq=
_add_dev+0x6c/0x78)
> > [    6.284383] [<c064d200>] (cpufreq_add_dev) from [<c04f7a98>] (subsys=
_interface_register+0xa4/0xf0)
> > [    6.293344] [<c04f7a98>] (subsys_interface_register) from [<c064b664=
>] (cpufreq_register_driver+0x144/0x2dc)
> > [    6.303169] [<c064b664>] (cpufreq_register_driver) from [<c064de34>]=
 (dt_cpufreq_probe+0x298/0x3b8)
> > [    6.312215] [<c064de34>] (dt_cpufreq_probe) from [<c04fb540>] (platf=
orm_probe+0x5c/0xb8)
> > [    6.320313] [<c04fb540>] (platform_probe) from [<c04f9374>] (really_=
probe+0x1dc/0x3b8)
> > [    6.328231] [<c04f9374>] (really_probe) from [<c04f95ac>] (driver_pr=
obe_device+0x5c/0xb4)
> > [    6.336406] [<c04f95ac>] (driver_probe_device) from [<c04f778c>] (bu=
s_for_each_drv+0x84/0xc8)
> > [    6.344928] [<c04f778c>] (bus_for_each_drv) from [<c04f9124>] (__dev=
ice_attach+0xe8/0x154)
> > [    6.353189] [<c04f9124>] (__device_attach) from [<c04f8440>] (bus_pr=
obe_device+0x84/0x8c)
> > [    6.361365] [<c04f8440>] (bus_probe_device) from [<c04f88d4>] (defer=
red_probe_work_func+0x64/0x90)
> > [    6.370321] [<c04f88d4>] (deferred_probe_work_func) from [<c0134b98>=
] (process_one_work+0x1dc/0x438)
> > [    6.379456] [<c0134b98>] (process_one_work) from [<c0135050>] (worke=
r_thread+0x25c/0x55c)
> > [    6.387632] [<c0135050>] (worker_thread) from [<c013b7b4>] (kthread+=
0x124/0x150)
> > [    6.395032] [<c013b7b4>] (kthread) from [<c0100150>] (ret_from_fork+=
0x14/0x24)
> > [    6.402256] Exception stack(0xc12d1fb0 to 0xc12d1ff8)
> > [    6.407307] 1fa0:                                     00000000 00000=
000 00000000 00000000
> > [    6.415478] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000=
000 00000000 00000000
> > [    6.423648] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000=
000
> > [    6.430301] ---[ end trace bd63a5c976f3611c ]---
> >
> > I bisected the problem to
> > ARM: dts: sunxi: Remove thermal zones without trip points
> >
> > Reverting this commit remove the warning.

I dropped the commit from our PR, thanks

> The thermal subsystem seems to require a thermal zone be present for each
> thermal sensor that is registered.
>=20
> So maybe a better solution is not to remove the thermal zones without trip
> points, but just add the standard passive and critical trip points based
> on the SoC's thermal limits.

I'm not really fond of having trip points that have never been really
tested either. I guess we should start that discussion with the
maintainers.

Maxime

--yqmlpou36nljsmcp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBb8PwAKCRDj7w1vZxhR
xQ7ZAQC3iXvVs2wGEew23zV9CqJ/kL6eUvp2uLuJIeU+DgDXWgEArzdiT/aOr4T3
Rjrrhwb2Q2vBBHo+U8e/MQMRjleiIAY=
=Zcsb
-----END PGP SIGNATURE-----

--yqmlpou36nljsmcp--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA36C3F4DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 18:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhHWQE0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Aug 2021 12:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhHWQEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 12:04:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E51C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 09:03:42 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mICQ9-0007C2-Dr; Mon, 23 Aug 2021 18:03:33 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mICQ7-0002Gk-Rt; Mon, 23 Aug 2021 18:03:31 +0200
Message-ID: <b596373b280dfe23a7e932b84ce31a2dbb806912.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/4] ASoC: rockchip: add support for i2s-tdm
 controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Date:   Mon, 23 Aug 2021 18:03:31 +0200
In-Reply-To: <9368735.gdWEK3B62L@archbook>
References: <20210820182731.29370-1-frattaroli.nicolas@gmail.com>
         <20210820182731.29370-2-frattaroli.nicolas@gmail.com>
         <6bc6330215980f10853a2dac69f0bdfd9c8fb303.camel@pengutronix.de>
         <9368735.gdWEK3B62L@archbook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Mon, 2021-08-23 at 16:35 +0200, Nicolas Frattaroli wrote:
[...]
> > I'm not too fond of reimplementing half a reset controller in here.
> > The reset framework does not support synchronized (de)assertion of
> > multiple reset controls, I wonder if this would be useful to add.
> > Without having thought about this too hard, I could imagine this as an
> > extension to the bulk API, or possibly a call to join multiple reset
> > controls into a reset control array.
> 
> I agree, the code required for synchronised reset seems to be a good
> candidate for a generalised solution elsewhere.
> However, I'm not sure if I'm the right candidate to design this API
> as my first kernel contribution when the board I'm currently testing
> this with doesn't even utilise the synchronized reset.
> 
> If I come across an opportunity to test synchronised resets, I'll
> definitely look into refactoring this. I'd also be happy to hear of
> any other driver which is currently implementing its own synchronised
> reset.
[...] 
> > What is the reason for the different delays in
> > rockchip_snd_xfer_sync_reset() and rockchip_snd_reset()?
> > 
> 
> Simply put: I have no idea. This is what downstream does, and it
> appears to work for me. The git history of the downstream kernel
> also doesn't tell me anything about why the sync reset is 150
> and this one is 1.
> 
> I've got no device to test the sync reset with at the moment so
> I'm wary of playing with the delay value.

Fair points. You could remove the untested synchronized reset support
for now; that would allow to get rid of the rockchip,cru device tree
property, which is only required to let this driver access the CRU
registers behind the clock/reset controller driver's back.

[...]
> > > +	if (i2s_tdm->clk_trcm != TRCM_TXRX) {
> > > +		cru_node = of_parse_phandle(node, "rockchip,cru", 0);
> > > +		i2s_tdm->cru_base = of_iomap(cru_node, 0);
> > 
> > This is a bit ugly if there is another driver sitting on the
> > rockchip,cru compatible node. Which reset controller driver is backing
> > the reset controls below?
> 
> I'm not sure if I understand the question (I only just today learned that
> reset controls have drivers) but I think the reset it is using in the
> Quartz64 dts is backed by rk3568-cru. Let me know if I misunderstood you.

That's the one, thanks.

The devm_reset_control_get() calls below follow the "reset-names"
and "resets" device tree properties. Those point (&cru) to a
clock-controller node with compatible = "rockchip,rk3568-cru".

The corresponding driver is drivers/clk/rockchip/clk-rk3568.c,
so the reset controller is provided by the reset_controller_register()
call in drivers/clk/rockchip/softrst.c.

regards
Philipp

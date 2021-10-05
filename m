Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E573422832
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbhJENrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbhJENr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:47:29 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F74C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 06:45:38 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 6C26A5C2764;
        Tue,  5 Oct 2021 15:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1633441536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MnLwo57Qj0/f1FqMi0leRR6DjLfqh+PNYNZjNC/l4+0=;
        b=zKhxc2nCDtT7NVNnobPuUcNui9X+zSA9Vs2LQxQTfZLLHnjPI5iIQgAsnNfUu9tJ0F7FqN
        GjDcZgclNsSchMXXyg/pSNKphqGLYO81gDqwfo4jSF1TdRYauvtQidp0pt5IGb69yh96fJ
        Dc8kulsxMammBs8ZAm8noz/WgKNGYxU=
MIME-Version: 1.0
Date:   Tue, 05 Oct 2021 15:45:36 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        Alison Wang <alison.wang@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: fsl-dcu: enable PIXCLK on LS1021A
In-Reply-To: <8e6830c43fbd97bbca59702896b0dd320f83e940.camel@ew.tq-group.com>
References: <20200820105832.22331-1-matthias.schiffer@ew.tq-group.com>
 <0321e3b1a9def003322b71f2a5fdfe08@agner.ch>
 <5015d9c9fe02733f8dfb2714a903ab725e7cdd7f.camel@ew.tq-group.com>
 <8e6830c43fbd97bbca59702896b0dd320f83e940.camel@ew.tq-group.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <b718fb759c07aaac8f397e4bf7632141@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-05 14:35, Matthias Schiffer wrote:
> On Thu, 2021-09-16 at 14:50 +0200, Matthias Schiffer wrote:
>> On Fri, 2020-08-21 at 15:41 +0200, Stefan Agner wrote:
>> > Hi Matthias,
>> >
>> > On 2020-08-20 12:58, Matthias Schiffer wrote:
>> > > The PIXCLK needs to be enabled in SCFG before accessing the DCU on LS1021A,
>> > > or the access will hang.
>> >
>> > Hm, this seems a rather ad-hoc access to SCFG from the DCU. We do
>> > support a pixel clock in the device tree bindings of fsl-dcu, so ideally
>> > we should enable the pixel clock through the clock framework.
>> >
>> > On the other hand, I guess that would mean adding a clock driver to flip
>> > a single bit, which seems a bit excessive too.
>> >
>> > I'd like a second opinion on that. Adding clk framework maintainers.
>>
>> It's been a while, and nobody else has given their opinion. How should
>> we proceed with this patch?
>>
>> Matthias
> 
> This patch is still blocked on a maintainer decision. Should I send a
> rebased version of the current solution, or do we want to have a proper
> clk driver to flip this bit?
> 

The clock maintainers haven't stated an opinion. I've seen similar hacks
for reset and other bits in other places, so I guess it's fine.

Can you also drop the np argument from fsl_dcu_scfg_config_ls1021a(), it
seems unnecessary.

--
Stefan

> 
>>
>>
>> >
>> > --
>> > Stefan
>> >
>> > >
>> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
>> > > ---
>> > >  drivers/gpu/drm/fsl-dcu/Kconfig           |  1 +
>> > >  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 25 +++++++++++++++++++++++
>> > >  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h |  3 +++
>> > >  3 files changed, 29 insertions(+)
>> > >
>> > > diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
>> > > index d7dd8ba90e3a..9e5a35e7c00c 100644
>> > > --- a/drivers/gpu/drm/fsl-dcu/Kconfig
>> > > +++ b/drivers/gpu/drm/fsl-dcu/Kconfig
>> > > @@ -8,6 +8,7 @@ config DRM_FSL_DCU
>> > >  	select DRM_PANEL
>> > >  	select REGMAP_MMIO
>> > >  	select VIDEOMODE_HELPERS
>> > > +	select MFD_SYSCON if SOC_LS1021A
>> > >  	help
>> > >  	  Choose this option if you have an Freescale DCU chipset.
>> > >  	  If M is selected the module will be called fsl-dcu-drm.
>> > > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
>> > > b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
>> > > index abbc1ddbf27f..8a7556655581 100644
>> > > --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
>> > > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
>> > > @@ -51,6 +51,23 @@ static const struct regmap_config fsl_dcu_regmap_config = {
>> > >  	.volatile_reg = fsl_dcu_drm_is_volatile_reg,
>> > >  };
>> > >
>> > > +static int fsl_dcu_scfg_config_ls1021a(struct device_node *np)
>> > > +{
>> > > +	struct regmap *scfg;
>> > > +
>> > > +	scfg = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
>> > > +	if (IS_ERR(scfg))
>> > > +		return PTR_ERR(scfg);
>> > > +
>> > > +	/*
>> > > +	 * For simplicity, enable the PIXCLK unconditionally. It might
>> > > +	 * be possible to disable the clock in PM or on unload as a future
>> > > +	 * improvement.
>> > > +	 */
>> > > +	return regmap_update_bits(scfg, SCFG_PIXCLKCR, SCFG_PIXCLKCR_PXCEN,
>> > > +				  SCFG_PIXCLKCR_PXCEN);
>> > > +}
>> > > +
>> > >  static void fsl_dcu_irq_uninstall(struct drm_device *dev)
>> > >  {
>> > >  	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
>> > > @@ -70,6 +87,14 @@ static int fsl_dcu_load(struct drm_device *dev,
>> > > unsigned long flags)
>> > >  		return ret;
>> > >  	}
>> > >
>> > > +	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu")) {
>> > > +		ret = fsl_dcu_scfg_config_ls1021a(fsl_dev->np);
>> > > +		if (ret < 0) {
>> > > +			dev_err(dev->dev, "failed to enable pixclk\n");
>> > > +			goto done;
>> > > +		}
>> > > +	}
>> > > +
>> > >  	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
>> > >  	if (ret < 0) {
>> > >  		dev_err(dev->dev, "failed to initialize vblank\n");
>> > > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
>> > > b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
>> > > index e2049a0e8a92..566396013c04 100644
>> > > --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
>> > > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
>> > > @@ -160,6 +160,9 @@
>> > >  #define FSL_DCU_ARGB4444		12
>> > >  #define FSL_DCU_YUV422			14
>> > >
>> > > +#define SCFG_PIXCLKCR			0x28
>> > > +#define SCFG_PIXCLKCR_PXCEN		BIT(31)
>> > > +
>> > >  #define VF610_LAYER_REG_NUM		9
>> > >  #define LS1021A_LAYER_REG_NUM		10

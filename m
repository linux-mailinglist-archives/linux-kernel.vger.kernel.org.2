Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A460A41B103
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbhI1NlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhI1NlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:41:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA01DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:39:40 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mVDKd-0004QP-7h; Tue, 28 Sep 2021 15:39:39 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mVDKc-0001Ae-Dr; Tue, 28 Sep 2021 15:39:38 +0200
Date:   Tue, 28 Sep 2021 15:39:38 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: imx6: mask all interrupts before calling
 stby-poweroff sequence
Message-ID: <20210928133938.GG18181@pengutronix.de>
References: <20210817122500.31953-1-o.rempel@pengutronix.de>
 <20210922023740.GD10217@dragon>
 <01b708d2-f211-8217-f686-0f7bf9fc8129@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01b708d2-f211-8217-f686-0f7bf9fc8129@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:39:02 up 222 days, 17:02, 124 users,  load average: 0.09, 0.11,
 0.12
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 07:57:49PM -0700, Florian Fainelli wrote:
> 
> 
> On 9/21/2021 7:37 PM, Shawn Guo wrote:
> > On Tue, Aug 17, 2021 at 02:25:00PM +0200, Oleksij Rempel wrote:
> > > Any pending interrupt can prevent entering standby based power off state.
> > > To avoid it, mask all interrupts.
> > > 
> > > Fixes: 8148d2136002 ("ARM: imx6: register pm_power_off handler if "fsl,pmic-stby-poweroff" is set")
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > >   arch/arm/mach-imx/pm-imx6.c | 23 +++++++++++++++++++++++
> > >   1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> > > index 9244437cb1b9..63887ade411a 100644
> > > --- a/arch/arm/mach-imx/pm-imx6.c
> > > +++ b/arch/arm/mach-imx/pm-imx6.c
> > > @@ -59,8 +59,11 @@
> > >   #define MX6Q_SUSPEND_OCRAM_SIZE		0x1000
> > >   #define MX6_MAX_MMDC_IO_NUM		33
> > > +#define GIC_DIST_ENABLE_CLEAR		0x180
> > > +
> > >   static void __iomem *ccm_base;
> > >   static void __iomem *suspend_ocram_base;
> > > +static void __iomem *gic_raw_dist_base;
> > >   static void (*imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
> > >   /*
> > > @@ -592,6 +595,7 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
> > >   static void __init imx6_pm_common_init(const struct imx6_pm_socdata
> > >   					*socdata)
> > >   {
> > > +	struct device_node *np;
> > >   	struct regmap *gpr;
> > >   	int ret;
> > > @@ -615,10 +619,29 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
> > >   	if (!IS_ERR(gpr))
> > >   		regmap_update_bits(gpr, IOMUXC_GPR1, IMX6Q_GPR1_GINT,
> > >   				   IMX6Q_GPR1_GINT);
> > > +
> > > +	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
> > > +	gic_raw_dist_base = of_iomap(np, 0);
> > > +}
> > > +
> > > +static void imx_gic_mask_all(void)
> > > +{
> > > +	int i;
> > > +
> > > +	if (WARN_ON(!gic_raw_dist_base))
> > > +		return;
> > > +
> > > +	for (i = 0; i < 4; i++)
> > > +		writel_relaxed(~0, gic_raw_dist_base + GIC_DIST_ENABLE_CLEAR + 4 * i);
> > 
> > Is it possible to have a helper function in GIC driver, that we can
> > simply call into?
> 
> Cannot you call gic_cpu_if_down(0) which would presumably have the same
> effect?

Good idea, thank you! It works.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

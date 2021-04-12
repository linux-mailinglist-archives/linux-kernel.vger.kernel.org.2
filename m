Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF11235C2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244131AbhDLJvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:51:32 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:59442 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243151AbhDLJl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:41:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6EBFDFB03;
        Mon, 12 Apr 2021 11:41:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4sdDvHv5JWMk; Mon, 12 Apr 2021 11:41:05 +0200 (CEST)
Date:   Mon, 12 Apr 2021 11:41:03 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v5 1/2] phy: core: Use runtime pm during configure too
Message-ID: <YHQVr6HYpfW5r5AO@bogon.m.sigxcpu.org>
References: <cover.1617968250.git.agx@sigxcpu.org>
 <2de2ee26bbf443491dfff1c802f2fa9efaf58d52.1617968250.git.agx@sigxcpu.org>
 <3ae6e6413901cbc9e432c7057db8fb9e81e56f39.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ae6e6413901cbc9e432c7057db8fb9e81e56f39.camel@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Apr 12, 2021 at 04:40:56PM +0800, Liu Ying wrote:
> Hi Guido,
> 
> On Fri, 2021-04-09 at 13:40 +0200, Guido Günther wrote:
> > The phy's configure phase usually needs register access so taking the
> > device out of pm_runtime suspend looks useful.
> > 
> > There's currently two in tree drivers using runtime pm and .configure
> > (qualcomm/phy-qcom-qmp.c, rockchip/phy-rockchip-inno-dsidphy.c) but both
> > don't use the phy layers 'transparent' runtime phy_pm_runtime handling
> > but manage it manually so this will for now only affect the
> > phy-fsl-imx8-mipi-dphy driver.
> 
> IIUC, the qualcomm one's runtime PM is managed by the phy core when
> users enable it using power/control in sysfs(see comment just before
> pm_runtime_forbid() in that driver).
> I'm assuming it's affected and it would be good to test it.

Ah, right. I'll reword the commit message but i don't have any means to
test it.

> I'm not pretty sure if the rockchip one is affected or not, because I'm
> assuming the power/control nodes of phy->dev and phy->parent.dev in
> sysfs are both 'auto' after the driver probes.

Testing if adding runtime pm for .configure to phy_core breaks anything
here would be great too.

I've added Dmitry and Heiko to cc: since they were active in those
drivers lately and i sure don't want to break these.

> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  drivers/phy/phy-core.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> > index ccb575b13777..256a964d52d3 100644
> > --- a/drivers/phy/phy-core.c
> > +++ b/drivers/phy/phy-core.c
> > @@ -470,10 +470,16 @@ int phy_configure(struct phy *phy, union phy_configure_opts *opts)
> >  	if (!phy->ops->configure)
> >  		return -EOPNOTSUPP;
> >  
> > +	ret = phy_pm_runtime_get_sync(phy);
> > +	if (ret < 0 && ret != -ENOTSUPP)
> > +		return ret;
> > +	ret = 0; /* Override possible ret == -ENOTSUPP */
> 
> This override is not needed, because 'ret' will be the return value of
> phy->ops->configure() right below.

I thought being explicit is better here but i'll drop that for the next
rev.

Thanks!
 -- Guido

> 
> Regards,
> Liu Ying
> 
> > +
> >  	mutex_lock(&phy->mutex);
> >  	ret = phy->ops->configure(phy, opts);
> >  	mutex_unlock(&phy->mutex);
> >  
> > +	phy_pm_runtime_put(phy);
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(phy_configure);
> 

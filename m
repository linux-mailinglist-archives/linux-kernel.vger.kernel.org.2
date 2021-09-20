Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF2F411D89
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 19:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345156AbhITRVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 13:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348426AbhITRTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 13:19:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A76C0604C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:50:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mSMUt-00042Z-Ln; Mon, 20 Sep 2021 18:50:27 +0200
Message-ID: <12e1d4b64f3f7f705439cdf7b81f4ead75909948.camel@pengutronix.de>
Subject: Re: [PATCH v4 5/9] ARM: imx_v6_v7_defconfig: build imx sdma driver
 as module
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Marek Vasut <marex@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andreas@kemnade.info" <andreas@kemnade.info>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "pzimmermann@dh-electronics.com" <pzimmermann@dh-electronics.com>,
        "festevam@gmail.com" <festevam@gmail.com>
Date:   Mon, 20 Sep 2021 18:50:23 +0200
In-Reply-To: <f4d57f8e-2c84-0abb-7031-1f878eb28c08@denx.de>
References: <20210920144938.314588-1-marcel@ziswiler.com>
         <20210920144938.314588-6-marcel@ziswiler.com>
         <dc987232-8687-a3cc-cc44-9e82e94ddd52@denx.de>
         <b399f461991b3dc6ba3d3332a054e7feea1d37f1.camel@toradex.com>
         <f4d57f8e-2c84-0abb-7031-1f878eb28c08@denx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 20.09.2021 um 18:14 +0200 schrieb Marek Vasut:
> On 9/20/21 5:55 PM, Marcel Ziswiler wrote:
> > On Mon, 2021-09-20 at 16:52 +0200, Marek Vasut wrote:
> > > On 9/20/21 4:49 PM, Marcel Ziswiler wrote:
> > > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > > 
> > > > Build CONFIG_IMX_SDMA as a module to avoid the following boot issue:
> > > > 
> > > > [    5.214751] imx-sdma 20ec000.sdma: Direct firmware load for
> > > >    imx/sdma/sdma-imx6q.bin failed with error -2
> > > > [    5.215762] imx-sdma 20ec000.sdma: Falling back to sysfs fallback
> > > >    for: imx/sdma/sdma-imx6q.bin
> > > 
> > > Isn't there some ROM-side SDMA firmware baked into the MX6 which is used
> > > as a fallback if loading newer one from filesystem fails ? I suspect the
> > > default ROM firmware might be buggy.
> > 
> > I'm not so sure about this. At least it seems to fail if no external firmware can be loaded.
> 
> See e.g. SDMA chapter in MX6SDLRM or similar, it does talk about 4k boot 
> ROM, which contains scripts and utilities later referenced by scripts in 
> RAM. It might be worth looking into that a bit further, but that seems 
> like a separate topic from this patch.
> 
Yep, most of the systems we ship do work with the ROM firmware, which
should be picked when firmware loading fails.

The RAM firmware is useful in some cases like multichannel SAI or now
to work around the SPI DMA issue on i.MX6.

Regards,
Lucas


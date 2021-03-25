Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E8F3489DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhCYHJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhCYHJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:09:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996C8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 00:09:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1lPK6y-0007Xe-A6; Thu, 25 Mar 2021 08:08:56 +0100
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1lPK6w-0000gc-Ew; Thu, 25 Mar 2021 08:08:54 +0100
Date:   Thu, 25 Mar 2021 08:08:54 +0100
From:   Philipp Zabel <pza@pengutronix.de>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] drm/imx: imx-ldb: fix out of bounds array access
 warning
Message-ID: <20210325070854.GC22419@pengutronix.de>
References: <20210324164750.3833773-1-arnd@kernel.org>
 <42e9cf4dd5f12ca437787d80fee0945b0af9424c.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e9cf4dd5f12ca437787d80fee0945b0af9424c.camel@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:08:16 up 35 days, 10:32, 66 users,  load average: 0.33, 0.39,
 0.40
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 10:03:23AM +0800, Liu Ying wrote:
> On Wed, 2021-03-24 at 17:47 +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > When CONFIG_OF is disabled, building with 'make W=1' produces warnings
> > about out of bounds array access:
> > 
> > drivers/gpu/drm/imx/imx-ldb.c: In function 'imx_ldb_set_clock.constprop':
> > drivers/gpu/drm/imx/imx-ldb.c:186:8: error: array subscript -22 is below array bounds of 'struct clk *[4]' [-Werror=array-bounds]
> > 
> > Add an error check before the index is used, which helps with the
> > warning, as well as any possible other error condition that may be
> > triggered at runtime.
> > 
> > The warning could be fixed by adding a Kconfig depedency on CONFIG_OF,
> > but Liu Ying points out that the driver may hit the out-of-bounds
> > problem at runtime anyway.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Liu Ying <victor.liu@nxp.com>

Thank you, applied to imx-drm/fixes.

regards
Philipp

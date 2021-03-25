Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339ED3489D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhCYHHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCYHHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:07:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBD4C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 00:07:22 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1lPK5J-0007S3-Ix; Thu, 25 Mar 2021 08:07:13 +0100
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1lPK5F-0000cp-La; Thu, 25 Mar 2021 08:07:09 +0100
Date:   Thu, 25 Mar 2021 08:07:09 +0100
From:   Philipp Zabel <pza@pengutronix.de>
To:     Pan Bian <bianpan2016@163.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/imx: fix memory leak when fails to init
Message-ID: <20210325070709.GA22419@pengutronix.de>
References: <20210120091608.12430-1-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120091608.12430-1-bianpan2016@163.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:04:41 up 35 days, 10:28, 65 users,  load average: 0.33, 0.47,
 0.42
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 01:16:08AM -0800, Pan Bian wrote:
> Put DRM device on initialization failure path rather than directly
> return error code.
> 
> Fixes: a67d5088ceb8 ("drm/imx: drop explicit drm_mode_config_cleanup")
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Thank you, applied to imx-drm/fixes.

regards
Philipp

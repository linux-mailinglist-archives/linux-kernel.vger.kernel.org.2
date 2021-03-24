Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB4E347A83
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhCXOVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:21:04 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:59940 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236123AbhCXOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:20:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E3CBF8406;
        Wed, 24 Mar 2021 14:20:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2689:2901:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6119:6742:7522:7576:7652:7903:10004:10400:11026:11232:11473:11657:11658:11783:11914:12043:12048:12295:12296:12297:12438:12740:12895:13069:13311:13357:13894:14181:14659:14721:21080:21433:21451:21627:21660:21939:21966:30034:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mist41_450a56a2777b
X-Filterd-Recvd-Size: 3203
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Mar 2021 14:20:25 +0000 (UTC)
Message-ID: <e1310273dcc577f3a772380ada7b6cc1906d680b.camel@perches.com>
Subject: Re: [PATCH] [v2] drm/imx: imx-ldb: fix out of bounds array access
 warning
From:   Joe Perches <joe@perches.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 07:20:23 -0700
In-Reply-To: <20210324121832.3714570-1-arnd@kernel.org>
References: <20210324121832.3714570-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-24 at 13:17 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_OF is disabled, building with 'make W=1' produces warnings
> about out of bounds array access:
> 
> drivers/gpu/drm/imx/imx-ldb.c: In function 'imx_ldb_set_clock.constprop':
> drivers/gpu/drm/imx/imx-ldb.c:186:8: error: array subscript -22 is below array bounds of 'struct clk *[4]' [-Werror=array-bounds]
> 
> Add an error check before the index is used, which helps with the
> warning, as well as any possible other error condition that may be
> triggered at runtime.
> 
> The warning could be fixed by adding a Kconfig depedency on CONFIG_OF,
> but Liu Ying points out that the driver may hit the out-of-bounds
> problem at runtime anyway.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: fix subject line
>     expand patch description
>     print mux number
>     check upper bound as well
[]
> diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
[]
> @@ -197,6 +197,12 @@ static void imx_ldb_encoder_enable(struct drm_encoder *encoder)
>  	int dual = ldb->ldb_ctrl & LDB_SPLIT_MODE_EN;
>  	int mux = drm_of_encoder_active_port_id(imx_ldb_ch->child, encoder);
> 
> +	if (mux < 0 || mux >= ARRAY_SIZE(ldb->clk_sel)) {
> +		dev_warn(ldb->dev, "%s: invalid mux %d\n",
> +			 __func__, ERR_PTR(mux));

This does not compile without warnings.

drivers/gpu/drm/imx/imx-ldb.c: In function ‘imx_ldb_encoder_enable’:
drivers/gpu/drm/imx/imx-ldb.c:201:22: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘void *’ [-Wformat=]
  201 |   dev_warn(ldb->dev, "%s: invalid mux %d\n",
      |                      ^~~~~~~~~~~~~~~~~~~~~~

If you want to use ERR_PTR, the %d should be %pe as ERR_PTR
is converting an int a void * to decode the error type and
emit it as a string.



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE24B421CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 05:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhJED0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 23:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231854AbhJEDZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 23:25:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B99461354;
        Tue,  5 Oct 2021 03:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633404246;
        bh=WrmQ/ch7lTYulLVKOIr6/0DLBP5xXhqS7/Dh78rlNbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I4u9BEvU/grj6hQ4AcxJ77igOA89LgvxL8VBgJjpe3qS/126sIQu8q8S1UXHLsN4T
         xs4wlfvowU+Jq/ISv3S/VF37MnsDDau62hzAqNagT05r5anyLM/KlupP85WLXih+lM
         pD3wzpTNJn2LkjzwmgLkvNOOzZQMyCb7GN6vshHtaHGWf6oEG9NegCzP0JPtMuNx2u
         xH5q0NNvkKuaO4mtevXm6drF48qigHXeZE+2my71Sq/m9m/9Kp2H5hHL+9SlLVdBOl
         IZkWTkpcPjy95PvpqgsqyAJ5zO9Xh+qNEBUjazGTmdZk6ky7wPiNUtFewVcTA7aw/4
         h9og8ONzuSKsQ==
Date:   Tue, 5 Oct 2021 11:24:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/9] ARM: imx_v6_v7_defconfig: build imx sdma driver
 as module
Message-ID: <20211005032400.GD20743@dragon>
References: <20210920144938.314588-1-marcel@ziswiler.com>
 <20210920144938.314588-6-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920144938.314588-6-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 04:49:34PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Build CONFIG_IMX_SDMA as a module to avoid the following boot issue:
> 
> [    5.214751] imx-sdma 20ec000.sdma: Direct firmware load for
>  imx/sdma/sdma-imx6q.bin failed with error -2
> [    5.215762] imx-sdma 20ec000.sdma: Falling back to sysfs fallback
>  for: imx/sdma/sdma-imx6q.bin
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks!

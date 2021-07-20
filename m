Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D9C3CF886
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 13:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbhGTKTQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jul 2021 06:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbhGTKLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:11:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF5AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 03:52:21 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m5nMK-0005E8-1J; Tue, 20 Jul 2021 12:52:20 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m5nMH-0003Ys-FO; Tue, 20 Jul 2021 12:52:17 +0200
Message-ID: <039151e1f17676a101fb9c0682f5ee9fb8ad502d.camel@pengutronix.de>
Subject: Re: [PATCH v2 6/7] soc: mediatek: mmsys: Add reset controller
 support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     chunkuang.hu@kernel.org, hsinyi@chromium.org, kernel@collabora.com,
        drinkcat@chromium.org, eizan@chromium.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, linux-arm-kernel@lists.infradead.org
Date:   Tue, 20 Jul 2021 12:52:17 +0200
In-Reply-To: <20210714121116.v2.6.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid>
References: <20210714101141.2089082-1-enric.balletbo@collabora.com>
         <20210714121116.v2.6.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid>
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

Hi Enric,

On Wed, 2021-07-14 at 12:11 +0200, Enric Balletbo i Serra wrote:
> Among other features the mmsys driver should implement a reset
> controller to be able to reset different bits from their space.
> 
> Cc: Jitao Shi <jitao.shi@mediatek.com>
> Suggested-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

The reset controller driver looks fine, just two questions below.

> ---
> 
> (no changes since v1)
> 
>  drivers/soc/mediatek/mtk-mmsys.c | 69 ++++++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-mmsys.h |  2 +
>  2 files changed, 71 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index e681029fe804..6ac4deff0164 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
[...]
> @@ -91,6 +95,59 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
[...]
> +static int mtk_mmsys_reset(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	int ret;
> +
> +	ret = mtk_mmsys_reset_assert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 1100);

Is this known to be enough for all IP cores that can be reset by this
controller?

> +	return mtk_mmsys_reset_deassert(rcdev, id);
> +}
> +
> +static const struct reset_control_ops mtk_mmsys_reset_ops = {
> +	.assert = mtk_mmsys_reset_assert,
> +	.deassert = mtk_mmsys_reset_deassert,
> +	.reset = mtk_mmsys_reset,
> +};
> +
>  static int mtk_mmsys_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -111,6 +168,18 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	spin_lock_init(&mmsys->lock);
> +
> +	mmsys->rcdev.owner = THIS_MODULE;
> +	mmsys->rcdev.nr_resets = 32;

Are all bits in the MMSYS_SW0_RST_B register individual reset controls?

regards
Philipp

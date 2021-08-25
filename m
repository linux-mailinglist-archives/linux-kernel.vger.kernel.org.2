Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5024D3F7397
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbhHYKrc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Aug 2021 06:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbhHYKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:47:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A4C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:46:45 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mIqQe-0007J6-0q; Wed, 25 Aug 2021 12:46:44 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mIqQc-0002Bg-EG; Wed, 25 Aug 2021 12:46:42 +0200
Message-ID: <ebbe37cb0188a7ea23608569ab083e65e0f95df6.camel@pengutronix.de>
Subject: Re: [PATCH v3 6/7] soc: mediatek: mmsys: Add reset controller
 support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, "Nancy.Lin" <nancy.lin@mediatek.com>
Cc:     matthias.bgg@gmail.com, hsinyi@chromium.org,
        linux-mediatek@lists.infradead.org, jitao.shi@mediatek.com,
        eizan@chromium.org, drinkcat@chromium.org, chunkuang.hu@kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org
Date:   Wed, 25 Aug 2021 12:46:42 +0200
In-Reply-To: <20210825122613.v3.6.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid>
References: <20210825102632.601614-1-enric.balletbo@collabora.com>
         <20210825122613.v3.6.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid>
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

On Wed, 2021-08-25 at 12:26 +0200, Enric Balletbo i Serra wrote:
> Among other features the mmsys driver should implement a reset
> controller to be able to reset different bits from their space.
> 
> Cc: Jitao Shi <jitao.shi@mediatek.com>
> Suggested-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> 
> (no changes since v1)
> 
>  drivers/soc/mediatek/mtk-mmsys.c | 69 ++++++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-mmsys.h |  2 +

Cc: Nancy - this patch clashes with [1], please coordinate.

[1] https://lore.kernel.org/linux-arm-kernel/20210825100531.5653-11-nancy.lin@mediatek.com/

regards
Philipp

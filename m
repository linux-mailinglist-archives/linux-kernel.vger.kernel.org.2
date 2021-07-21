Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E65B3D0C43
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 12:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbhGUJWp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jul 2021 05:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbhGUJNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:13:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BCAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 02:53:34 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m68uy-0000iB-MM; Wed, 21 Jul 2021 11:53:32 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m68uw-0003Cy-QZ; Wed, 21 Jul 2021 11:53:30 +0200
Message-ID: <83b95ddab7c43ada71b7863522348aca076fe291.camel@pengutronix.de>
Subject: Re: [PATCH v2 6/7] soc: mediatek: mmsys: Add reset controller
 support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     chunkuang.hu@kernel.org, hsinyi@chromium.org, kernel@collabora.com,
        drinkcat@chromium.org, eizan@chromium.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, linux-arm-kernel@lists.infradead.org
Date:   Wed, 21 Jul 2021 11:53:30 +0200
In-Reply-To: <a3227633-626d-10f5-c190-86dbf36a469c@collabora.com>
References: <20210714101141.2089082-1-enric.balletbo@collabora.com>
         <20210714121116.v2.6.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid>
         <039151e1f17676a101fb9c0682f5ee9fb8ad502d.camel@pengutronix.de>
         <a3227633-626d-10f5-c190-86dbf36a469c@collabora.com>
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

On Tue, 2021-07-20 at 19:07 +0200, Enric Balletbo i Serra wrote:
> Hi Philipp,
> 
> Thank you to take a look
> 
> On 20/7/21 12:52, Philipp Zabel wrote:
> > Hi Enric,
> > 
> > On Wed, 2021-07-14 at 12:11 +0200, Enric Balletbo i Serra wrote:
> > > Among other features the mmsys driver should implement a reset
> > > controller to be able to reset different bits from their space.
> > > 
> > > Cc: Jitao Shi <jitao.shi@mediatek.com>
> > > Suggested-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > 
> > The reset controller driver looks fine, just two questions below.
> > 
> > > ---
> > > 
> > > (no changes since v1)
> > > 
> > >  drivers/soc/mediatek/mtk-mmsys.c | 69 ++++++++++++++++++++++++++++++++
> > >  drivers/soc/mediatek/mtk-mmsys.h |  2 +
> > >  2 files changed, 71 insertions(+)
> > > 
> > > diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> > > index e681029fe804..6ac4deff0164 100644
> > > --- a/drivers/soc/mediatek/mtk-mmsys.c
> > > +++ b/drivers/soc/mediatek/mtk-mmsys.c
> > [...]
> > > @@ -91,6 +95,59 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
> > [...]
> > > +static int mtk_mmsys_reset(struct reset_controller_dev *rcdev, unsigned long id)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = mtk_mmsys_reset_assert(rcdev, id);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	usleep_range(1000, 1100);
> > 
> > Is this known to be enough for all IP cores that can be reset by this
> > controller?
> > 
> 
> This time is copied from the downstream kernel, so, tbh, I am not totally sure
> is enough or needed. Let me try to reach the Mediatek people for if they can
> answer this.

That would be great. When this is resolved either way, feel free to add

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

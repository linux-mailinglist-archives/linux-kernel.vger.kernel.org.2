Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC6D460755
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 16:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358124AbhK1QDC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 28 Nov 2021 11:03:02 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35714 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244386AbhK1QA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:00:56 -0500
X-UUID: a06df0059a734746a1cc6e4dd9453dbf-20211128
X-UUID: a06df0059a734746a1cc6e4dd9453dbf-20211128
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 283879108; Sun, 28 Nov 2021 23:57:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sun, 28 Nov 2021 23:57:34 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 28 Nov 2021 23:57:33 +0800
Message-ID: <ae29424d8121f8951cfb5fece114b6fcba90d351.camel@mediatek.com>
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Tzung-Bi Shih <tzungbi@google.com>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "; Philipp Zabel" <p.zabel@pengutronix.de>,
        "; Matthias Brugger" <matthias.bgg@gmail.com>,
        "; Jassi Brar" <jassisinghbrar@gmail.com>,
        "; David Airlie" <airlied@linux.ie>,
        "; Daniel Vetter" <daniel@ffwll.ch>,
        "; dri-devel@lists.freedesktop.org; linux-mediatek@lists.infradead.org; 
        linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; 
        hsinyi@chromium.org; fshao@chromium.org; Nancy Lin
        =?UTF-8?Q?=28=E6=9E=97=E6=AC=A3=E8=9E=A2=29?=" 
        <Nancy.Lin@mediatek.com>,
        "; Singo Chang =?UTF-8?Q?=28=E5=BC=B5=E8=88=88=E5=9C=8B=29?=" 
        <Singo.Chang@mediatek.com>
In-Reply-To: <PU1PR03MB306252A252139515F7EA9ABCB8659@PU1PR03MB3062.apcprd03.prod.outlook.com>
References: <20211117064158.27451-1-jason-jh.lin@mediatek.com>
         <20211117064158.27451-4-jason-jh.lin@mediatek.com>
         <YZXqz6XDChwscDC0@google.com>
         <PU1PR03MB306252A252139515F7EA9ABCB8659@PU1PR03MB3062.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Subject: Re: FW: [PATCH 3/3] drm/mediatek: add devlink to cmdq dev
Date:   Sun, 28 Nov 2021 23:57:33 +0800
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 8BIT
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,

Thanks for the reviews.

> From: Linux-mediatek <linux-mediatek-bounces@lists.infradead.org> On
> Behalf Of Tzung-Bi Shih
> Sent: Thursday, November 18, 2021 1:55 PM
> To: Jason-JH Lin (林睿祥) <Jason-JH.Lin@mediatek.com>
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>; Philipp Zabel <
> p.zabel@pengutronix.de>; Matthias Brugger <matthias.bgg@gmail.com>;
> Jassi Brar <jassisinghbrar@gmail.com>; David Airlie <airlied@linux.ie
> >; Daniel Vetter <daniel@ffwll.ch>; dri-devel@lists.freedesktop.org; 
> linux-mediatek@lists.infradead.org; 
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; 
> hsinyi@chromium.org; fshao@chromium.org; Nancy Lin (林欣螢) <
> Nancy.Lin@mediatek.com>; Singo Chang (張興國) <Singo.Chang@mediatek.com>
> Subject: Re: [PATCH 3/3] drm/mediatek: add devlink to cmdq dev
> 
> On Wed, Nov 17, 2021 at 02:41:58PM +0800, jason-jh.lin wrote:
> > @@ -158,6 +159,7 @@ static void mtk_drm_crtc_destroy(struct
> > drm_crtc *crtc)
> >  	mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_handle);
> >  
> >  	if (mtk_crtc->cmdq_client.chan) {
> > +		device_link_remove(mtk_crtc->drm_dev, mtk_crtc-
> > >cmdq_client.chan->mbox->dev);
> >  		mbox_free_channel(mtk_crtc->cmdq_client.chan);
> >  		mtk_crtc->cmdq_client.chan = NULL;
> >  	}
> 
> [...]
> > @@ -956,6 +959,16 @@ int mtk_drm_crtc_create(struct drm_device
> > *drm_dev,
> >  	}
> >  
> >  	if (mtk_crtc->cmdq_client.chan) {
> > +		struct device_link *link;
> > +
> > +		/* add devlink to cmdq dev to make sure suspend/resume
> > order is correct */
> > +		link = device_link_add(dev, mtk_crtc->cmdq_client.chan-
> > >mbox->dev,
> > +				       DL_FLAG_PM_RUNTIME |
> > DL_FLAG_STATELESS);
> > +		if (!link) {
> > +			dev_err(dev, "Unable to link dev=%s\n",
> > +				dev_name(mtk_crtc->cmdq_client.chan-
> > >mbox->dev));
> > +		}
> > +
> 
> If device_link_add() failed, doesn't mtk_drm_crtc_create() need to
> return an error and exit?

OK, I'll add the return error at the next verion.
> 
> OTOH, if device_link_add() failed, won't it bring any side effects to
> call device_link_remove()?
> 

Because device_link_remove() will find the device_link of supplier and
consumer, then delete the device_link between them.
If device_link_add() failed, supplier and consumer won't create the
device_link.
So calling device_link_remove() won't do anything without deive_link
and won't bring any side effects.

Regards,
Jason-JH.Lin
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> 
https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-mediatek__;!!CTRNKA9wMg0ARbw!125dmOZ7xCLkwbIrzZf1VqVLQBbdT4RFHoMjR38U1GeCxaTM6xvvB-mSr7sTc6BuY5IH$
>  
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>


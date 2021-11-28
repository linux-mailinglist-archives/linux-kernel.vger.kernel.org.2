Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CFC460735
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 16:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358099AbhK1Pp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 10:45:29 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:44064 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233985AbhK1Pn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 10:43:29 -0500
X-UUID: dca377fefa5d4ab8aa2fa998b9fdac89-20211128
X-UUID: dca377fefa5d4ab8aa2fa998b9fdac89-20211128
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1112483941; Sun, 28 Nov 2021 23:40:10 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 28 Nov 2021 23:40:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 28 Nov
 2021 23:40:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 28 Nov 2021 23:40:08 +0800
Message-ID: <8670ab73cf64f9e8e5c533587437c53f2c557463.camel@mediatek.com>
Subject: Re: [PATCH 2/3] mailbox: add cmdq_mbox_flush to clear all task
 before suspend
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Fei Shao" <fshao@chromium.org>, <tzungbi@google.com>,
        Nancy Lin <nancy.lin@mediatek.com>, <singo.chang@mediatek.com>
Date:   Sun, 28 Nov 2021 23:40:08 +0800
In-Reply-To: <CAAOTY_-Ws7BmYr-87rb=MWYyGwSCCvv0AoPV10J7d+7TU+7OCA@mail.gmail.com>
References: <20211117064158.27451-1-jason-jh.lin@mediatek.com>
         <20211117064158.27451-3-jason-jh.lin@mediatek.com>
         <CAAOTY_-Ws7BmYr-87rb=MWYyGwSCCvv0AoPV10J7d+7TU+7OCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

Thanks for the reviews.

On Fri, 2021-11-19 at 08:01 +0800, Chun-Kuang Hu wrote:
> Hi, Jason:
> 
> jason-jh.lin <jason-jh.lin@mediatek.com> 於 2021年11月17日 週三 下午2:42寫道：
> > 
> > CMDQ driver will occupy GCE clock to execute the task in GCE
> > thread.
> > 
> > So call cmdq_mbox_flush to clear all task in GCE thread before
> > CMDQ suspend.
> > 
> > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > ---
> >  drivers/mailbox/mtk-cmdq-mailbox.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c
> > b/drivers/mailbox/mtk-cmdq-mailbox.c
> > index 03f9ed4c5131..28cadfc0091b 100644
> > --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> > +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> > @@ -484,21 +484,18 @@ static int cmdq_suspend(struct device *dev)
> >         struct cmdq *cmdq = dev_get_drvdata(dev);
> >         struct cmdq_thread *thread;
> >         int i;
> > -       bool task_running = false;
> > 
> >         cmdq->suspended = true;
> > 
> >         for (i = 0; i < cmdq->thread_nr; i++) {
> >                 thread = &cmdq->thread[i];
> >                 if (!list_empty(&thread->task_busy_list)) {
> > -                       task_running = true;
> > -                       break;
> > +                       /* try to clear all task in this thread */
> > +                       cmdq_mbox_flush(thread->chan, 2000);
> 
> I would like the normal control flow rather than error handling. So
> the normal control flow is:
> 
> 1. Client driver suspend: Flush command.
> 2. CMDQ driver suspend: There is no command to flush. If there are
> command, show error message and debug the client driver.
> 
> The error handling flow:
> 
> 1. Client driver suspend: Does not flush command.
> 2. CMDQ driver suspend: Flush command and callback to client driver.
> Client driver process these callback as error handling.
> 
> The client driver may integrate multiple driver. In the suspend flow,
> it may need to stop these driver in a sequence such as.
> 
> 1. Stop driver 1
> 2. Stop driver 2
> 3. Stop driver 3 (cmdq)
> 4. Stop driver 4
> 5. Stop driver 5.
> 
> In the normal flow, client driver could control the stop flow. In the
> error handling flow, it does not match the stop flow.
> 
> Regards,
> Chun-Kuang.
> 

I have tried the normal flow:
1. Client driver suspend: Flush command.
2. CMDQ driver suspend: There is no command to flush. If there are
command, show error message and debug the client driver.

Then I found the cmdq task of crtc_1 is still executing when
cmdq_suspend sometimes. I think it is the latest async cmd sent in
mtk_drm_crtc_disable.
So I'll try to change it to blocking cmd and see the issue is still
happened or not.

If it works, then I'll revert this patch and send add blocking cmd in
mtk_drm_crtc_disable at the next version.

Regards,
Jason-JH.Lin

> > +                       dev_warn(dev, "thread[%d] exist running
> > task(s) in suspend\n", i);
> >                 }
> >         }
> > 
> > -       if (task_running)
> > -               dev_warn(dev, "exist running task(s) in
> > suspend\n");
> > -
> >         clk_bulk_unprepare(cmdq->gce_num, cmdq->clocks);
> > 
> >         return 0;
> > --
> > 2.18.0
> > 
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>


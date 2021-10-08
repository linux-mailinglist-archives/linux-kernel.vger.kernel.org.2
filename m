Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09893426D19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbhJHO6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhJHO6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:58:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F2E260F6B;
        Fri,  8 Oct 2021 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633704969;
        bh=xujWQTXjYOhyZ2RyQwPqWI29++CG8GP7k2MyQXlnTRA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QnO2Y25mqhEpD2uis/RXDeVsXsxECW9fev1qYn0QbHdKuya2CJ/QcxDtZkFrRwdwI
         JxXvrqkIFa6y6etq6KfGVY1mZ7zNyeGHgtQFehqs5iYIYCr2df9F66sge3IMMezQVZ
         sI3rmk5bl2yHYnRU4Q/D9JxA18ftaldaiH+Fkj3Dzr2zw3rYDWpFo3F6eI7kWQpgYt
         3JuPdTv670CEFjmr26aqreMOF+m3AHXLFn5LrHZXfAgdpVvH7t4IEqD9IcA0ch/YXJ
         dZhV3ZU19ddAA4J1Yzb2Yov0zLDcg5agRHKnzj5TWgTk9awEr7TJL+wALCKqohk8zq
         pyNWAE/2daNVQ==
Received: by mail-ed1-f43.google.com with SMTP id y12so24413923eda.4;
        Fri, 08 Oct 2021 07:56:09 -0700 (PDT)
X-Gm-Message-State: AOAM5312VaIv+2/jYwQLaxQgYP9e6+SylYuQANKCFPEuqld8t0g9ykaT
        SDqxZ5Z9XvpLj5519LcqChHEWWKeXYZpJU/qwg==
X-Google-Smtp-Source: ABdhPJx3Y34GgHtBFp/5Jw7IJqKuehz0xBb3j7mhVfZO4jfZeudpUPDTGLYxF4PGpxhhTFHTvDVGL3iKsa0QZCK7oFA=
X-Received: by 2002:a05:6402:143b:: with SMTP id c27mr16161354edx.224.1633704968209;
 Fri, 08 Oct 2021 07:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210930131850.21202-1-yongqiang.niu@mediatek.com>
 <20210930131850.21202-2-yongqiang.niu@mediatek.com> <CAAOTY_82OaLAz0o6BUcogQ=xgYTsFJSov=J72UzMwwq3YtkPdg@mail.gmail.com>
 <ffe2d4aaf4f884c4de2d2a157d08087cef3e6a0f.camel@mediatek.com>
In-Reply-To: <ffe2d4aaf4f884c4de2d2a157d08087cef3e6a0f.camel@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 8 Oct 2021 22:55:57 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9xhga5yP7OVB6npPesTHc8UR3WydwOvY=Fvo-CCawxLg@mail.gmail.com>
Message-ID: <CAAOTY_9xhga5yP7OVB6npPesTHc8UR3WydwOvY=Fvo-CCawxLg@mail.gmail.com>
Subject: Re: [PATCH v2, 1/1] mailbox: cmdq: add instruction time-out interrupt support
To:     "yongqiang.niu" <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

yongqiang.niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=
=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=889:49=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Tue, 2021-10-05 at 07:41 +0800, Chun-Kuang Hu wrote:
> > Hi, Yongqiang:
> >
> > Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B49=E6=
=9C=8830=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:18=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > add time-out cycle setting to make sure time-out interrupt irq
> > > will happened when instruction time-out for wait and poll
> > >
> > > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > ---
> > >  drivers/mailbox/mtk-cmdq-mailbox.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c
> > > b/drivers/mailbox/mtk-cmdq-mailbox.c
> > > index 64175a893312..197b03222f94 100644
> > > --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> > > +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> > > @@ -36,6 +36,7 @@
> > >  #define CMDQ_THR_END_ADDR              0x24
> > >  #define CMDQ_THR_WAIT_TOKEN            0x30
> > >  #define CMDQ_THR_PRIORITY              0x40
> > > +#define CMDQ_THR_INSTN_TIMEOUT_CYCLES  0x50
> > >
> > >  #define GCE_GCTL_VALUE                 0x48
> > >
> > > @@ -54,6 +55,15 @@
> > >  #define CMDQ_JUMP_BY_OFFSET            0x10000000
> > >  #define CMDQ_JUMP_BY_PA                        0x10000001
> > >
> > > +/*
> > > + * instruction time-out
> > > + * cycles to issue instruction time-out interrupt for wait and
> > > poll instructions
> > > + * GCE axi_clock 156MHz
> > > + * 1 cycle =3D 6.41ns
> > > + * instruction time out 2^22*2*6.41ns =3D 53ms
> >
> > For different clients, the timeout value would be different, and each
> > client could use timer to detect timeout, so it's not necessary to
> > enable timeout in cmdq driver.
> >
> > Regards,
> > Chun-Kuang.
>
> if we do not set cmdq hardware timeout, this condition will never
> happen
> cmdq_thread_irq_handler
> if (irq_flag & CMDQ_THR_IRQ_ERROR)
>                 err =3D true;
>
> and no error callback
> else if (err) {
>                         cmdq_task_exec_done(task, -ENOEXEC);
>                         cmdq_task_handle_error(curr_task);
>                         kfree(task);
>                 }
> the client will never received the error callback, cmdq hardware will
> poll the event for ever and no report timeout

I think there are two way to implement the timeout mechanism. The
first way is to use the GCE hardware to detect timeout. The second way
is that client driver use timer to detect timeout, when it's timeout,
use mbox_flush() to clean up the packets in mtk cmdq driver, and
remove the error handle in irq handler.
If you think the first way is better, I think you should pass the
timeout value from client driver to cmdq driver because each client
driver has different timeout value. And the GCE clock may be different
in each SoC, so use clk_get_rate() to get the clock frequency for
different SoC.

Regards,
Chun-Kuang.

> >
> > > + */
> > > +#define CMDQ_INSTN_TIMEOUT_CYCLES      22
> > > +
> > >  struct cmdq_thread {
> > >         struct mbox_chan        *chan;
> > >         void __iomem            *base;
> > > @@ -376,6 +386,7 @@ static int cmdq_mbox_send_data(struct mbox_chan
> > > *chan, void *data)
> > >                 writel((task->pa_base + pkt->cmd_buf_size) >> cmdq-
> > > >shift_pa,
> > >                        thread->base + CMDQ_THR_END_ADDR);
> > >
> > > +               writel(CMDQ_INSTN_TIMEOUT_CYCLES, thread->base +
> > > CMDQ_THR_INSTN_TIMEOUT_CYCLES);
> > >                 writel(thread->priority, thread->base +
> > > CMDQ_THR_PRIORITY);
> > >                 writel(CMDQ_THR_IRQ_EN, thread->base +
> > > CMDQ_THR_IRQ_ENABLE);
> > >                 writel(CMDQ_THR_ENABLED, thread->base +
> > > CMDQ_THR_ENABLE_TASK);
> > > --
> > > 2.25.1
> > >

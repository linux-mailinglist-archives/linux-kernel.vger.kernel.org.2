Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EE83CBAA8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 18:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhGPQpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 12:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhGPQpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:45:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20E71613EE;
        Fri, 16 Jul 2021 16:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626453776;
        bh=iyvboBbJB24fM/KsyAy5OW3yngHgd2gk9Z7P8CwT2uQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BqWFxgtf2F90LRIp3skiNIGRSj9fbCyS/B5EneSGMlCDMjZzXsA3K4x3sYhcZKduJ
         0Y1Je2sxlFdrU7lgi2JhXQ61+2LPmn/B9Pi+k+iK57R+3qzlnDzyPbBW0K4it149Hi
         xLOK7Bng3RL9dyJtTbKwMq0onxIFdHwuQZpW4+OyghyT+eT9dvPYV9qTMZyBfAOO1+
         C27QrYhbrCiuxuJ3sa7PFS7iRwifeGGzGUDFFv+r2pYvlfWIoONcc2OraRS4l2QVW/
         aheSxDUJ4Zwx58GZmR/p+mSKqNw2P2Stgy2F0/NQhyETJsz5v8VYoz2cYRAIfxvhWI
         lbf2D/XbMnaTQ==
Received: by mail-ed1-f49.google.com with SMTP id w14so13723920edc.8;
        Fri, 16 Jul 2021 09:42:56 -0700 (PDT)
X-Gm-Message-State: AOAM530BbHhTVyilZ9NrVJJ/GWtOlUfnGBR2m5pwik+RHL0s0+BB3HJ6
        tV76lUDcYgKZM97OWtt79krVyutdEYh58FRN5A==
X-Google-Smtp-Source: ABdhPJxTUG7dBNjzKlgl2NjPeLK61EE68JCSroh9Re1GaEepDQbfq2+PN9sWPI3SzPvcfAVEylqryt0r4BYXQEWqlYc=
X-Received: by 2002:aa7:da06:: with SMTP id r6mr16153573eds.38.1626453774729;
 Fri, 16 Jul 2021 09:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <1626418701-28467-1-git-send-email-yongqiang.niu@mediatek.com> <1626418701-28467-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1626418701-28467-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 17 Jul 2021 00:42:43 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8eoz=TaXxT8hbyyEWow2CO1bv9ceEHmY5J5oAwDTtrUg@mail.gmail.com>
Message-ID: <CAAOTY_8eoz=TaXxT8hbyyEWow2CO1bv9ceEHmY5J5oAwDTtrUg@mail.gmail.com>
Subject: Re: [PATCH v1] mailbox: cmdq: add instruction time-out interrupt support
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
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

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=
=8816=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:58=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add time-out cycle setting to make sure time-out interrupt irq
> will happened when instruction time-out for wait and poll
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index de4793e..9a76bcd 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -35,6 +35,7 @@
>  #define CMDQ_THR_END_ADDR              0x24
>  #define CMDQ_THR_WAIT_TOKEN            0x30
>  #define CMDQ_THR_PRIORITY              0x40
> +#define CMDQ_THR_INSTN_TIMEOUT_CYCLES  0x50
>
>  #define GCE_GCTL_VALUE                 0x48
>
> @@ -53,6 +54,15 @@
>  #define CMDQ_JUMP_BY_OFFSET            0x10000000
>  #define CMDQ_JUMP_BY_PA                        0x10000001
>
> +/*
> + * instruction time-out
> + * cycles to issue instruction time-out interrupt for wait and poll inst=
ructions
> + * GCE axi_clock 156MHz
> + * 1 cycle =3D 6.41ns
> + * instruction time out 2^22*2*6.41ns =3D 53ms

I think every client has different timeout value, so it's not a good
idea to have a unique timeout value in mailbox controller. Client
could use timer or something similar to detect timeout.

Regards,
Chun-Kuang.

> + */
> +#define CMDQ_INSTN_TIMEOUT_CYCLES      22
> +
>  struct cmdq_thread {
>         struct mbox_chan        *chan;
>         void __iomem            *base;
> @@ -368,6 +378,7 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan=
, void *data)
>                 writel((task->pa_base + pkt->cmd_buf_size) >> cmdq->shift=
_pa,
>                        thread->base + CMDQ_THR_END_ADDR);
>
> +               writel(CMDQ_INSTN_TIMEOUT_CYCLES, thread->base + CMDQ_THR=
_INSTN_TIMEOUT_CYCLES);
>                 writel(thread->priority, thread->base + CMDQ_THR_PRIORITY=
);
>                 writel(CMDQ_THR_IRQ_EN, thread->base + CMDQ_THR_IRQ_ENABL=
E);
>                 writel(CMDQ_THR_ENABLED, thread->base + CMDQ_THR_ENABLE_T=
ASK);
> --
> 1.8.1.1.dirty
>

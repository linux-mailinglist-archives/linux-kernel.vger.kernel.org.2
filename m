Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E7931B4FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 06:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhBOFRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 00:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhBOFRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 00:17:04 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6FDC061574;
        Sun, 14 Feb 2021 21:16:24 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id z68so3600213pgz.0;
        Sun, 14 Feb 2021 21:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TBkqrZBLcfDTB0/M+9n3lElFVq72Vy5NJAtkuckTGN4=;
        b=pm4fNvBwXWCxUC5cgUyImGLfR4w/yKZ/pflBxno08azXdHVjNAF7N/TiLY6z306gz/
         NwT40nkx/FTz+vU0BOctZuzk/kvqILDE4t19NPsl6Ny9Z7uIyTkIR9JcQevyZX/WlPso
         dlOleXIZSuXw82L96wMXWZUd9NvG8+qzzVBYdpFCPzJJflFd0uJaRuMlVBMGJ2JebX/G
         Qsu5+rhqLnv3pDiAVLF/86KcPk5OFYdMSGyqseOouuZHe0XxiFsKO9rjFl3bxkFJfC1R
         Lvh4o7KXBD+YBQLwSczpEhhLc1c0oP1BcrnMlNQ4x2yYjMZybNxD8GuFAaL3mTPjkB2Z
         oOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TBkqrZBLcfDTB0/M+9n3lElFVq72Vy5NJAtkuckTGN4=;
        b=o8SxHp1C5BmaGNf5NdqX3vpB1XZXChDswolNPhq/2FtW0xfo42IkESDQXIRQSfmsNh
         57cfdLlTa7TCsenFtKBBASMveDIUXTb3T2kR3E9HhmK1Ytob72TFlN0r+EQDzel37+yR
         lZESblLnYNNK91vwKSEfc7z+zz8280oF0eqa/1ImrvZLD07a2kSyUTD45BZrdiShL5Wk
         3t9T3lZ0JWcJPsl9tqs496b6kyBIz1uAvDNr3zw9Pg4NQKa1rcEKrt4qvOxphwVnZoNY
         oyoIwMDT2sUAqKglOr9fgwo119iL6yA24vAV01GUZiiJ9EnIvOKARYAP6HQfSpE6xdSr
         eOvA==
X-Gm-Message-State: AOAM531rlJj69SCUXoVK7NBPMcci3NGJoYE53vCySdxDIF4CEKoAK4Ws
        7+kHkDiFrasmsekGrouRgQI2VY2CCyNrWU9B57o=
X-Google-Smtp-Source: ABdhPJwOiZw4Qqqmjkha2m3NiVtY90y2KGeUq38HkrELdAMi1GmyuchWJQIojbLcrd0WcqkoeEZZMy7VUEb0HVASvmM=
X-Received: by 2002:a63:1519:: with SMTP id v25mr13584867pgl.217.1613366183592;
 Sun, 14 Feb 2021 21:16:23 -0800 (PST)
MIME-Version: 1.0
References: <1608712499-24956-1-git-send-email-yongqiang.niu@mediatek.com>
 <1608712499-24956-2-git-send-email-yongqiang.niu@mediatek.com> <1610070485.1574.10.camel@mhfsdcap03>
In-Reply-To: <1610070485.1574.10.camel@mhfsdcap03>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 14 Feb 2021 23:16:13 -0600
Message-ID: <CABb+yY3JQUYf8b-mU_01eYR-4nswFRbBE42WS9fS8aSmk2rjmw@mail.gmail.com>
Subject: Re: [PATCH v2] soc: mediatek: cmdq: add address shift in jump
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Damon Chu <damon.chu@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 7:48 PM Yongqiang Niu <yongqiang.niu@mediatek.com> wrote:
>
> On Wed, 2020-12-23 at 16:34 +0800, Yongqiang Niu wrote:
> > Add address shift when compose jump instruction
> > to compatible with 35bit format.
> >
> > Fixes: 0858fde496f8 ("mailbox: cmdq: variablize address shift in platform")
> >
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> >  drivers/mailbox/mtk-cmdq-mailbox.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> > index 5665b6e..75378e3 100644
> > --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> > +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> > @@ -168,7 +168,8 @@ static void cmdq_task_insert_into_thread(struct cmdq_task *task)
> >       dma_sync_single_for_cpu(dev, prev_task->pa_base,
> >                               prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
> >       prev_task_base[CMDQ_NUM_CMD(prev_task->pkt) - 1] =
> > -             (u64)CMDQ_JUMP_BY_PA << 32 | task->pa_base;
> > +             (u64)CMDQ_JUMP_BY_PA << 32 |
> > +             (task->pa_base >> task->cmdq->shift_pa);
> >       dma_sync_single_for_device(dev, prev_task->pa_base,
> >                                  prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
> >
>
> hi jassi
>
> please confirm is there any question about this patch.
> if not, please apply this into next version, tks
>
I can't locate this patch in my inbox. And I can't fwd it from lkml to
myself. Please resend.

thnks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B226E391082
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhEZGTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:19:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhEZGTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:19:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE42F613C9
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622009862;
        bh=PsfC7MVr+2Eywp2f8VjXIEceDitx1IJHsOxTWNWKkUM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UqDSzwVIRmivXZYs8rgxA1gDI0CnYxIouBB9ViE1bvdVmFaTboTrwGaSYyMkfSKQO
         87zTAIdLfWUop/6XlB9znMEDbioAW4uvQwOpjSZOU69wY/1TCGAaMlbIO0TKbqrT3F
         5tkJzQR/ymdD6LzMjHRcvJb4ysD+T/6YwhjTZ1VUCm8nerBUR6Z0iuX45NKVTOFmAj
         VU8aNxj4ddTOVgbawT5UKNIA3WA5oiqhjMlzvRNznyQw0Kj1ce+7XJgn3x0aQqs/qV
         18i7VMNYlRjLu+14bhSJZFG0tuhM6bqqnHr2OdK7KcETudhre3P9TanqarJ2GFxzho
         dFH27Uxjxl1yQ==
Received: by mail-ed1-f48.google.com with SMTP id t3so39052289edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:17:42 -0700 (PDT)
X-Gm-Message-State: AOAM533EWljULCiKo07UvcX1OliV/vj8jFGf8tPAB+xlZFpOsjWhE2wP
        UUTonnvI3M2wIDPhHId1N7TiQBZM7IOVPyIfLA==
X-Google-Smtp-Source: ABdhPJzwemgK0Ks5mmVpZCBvWxM5hQi6ZtH0dlR0VagAuAwklTi+So046naen/mPcYKT9kzju3JtqTQd6rEfD43twa8=
X-Received: by 2002:aa7:ccc6:: with SMTP id y6mr36053931edt.303.1622009861405;
 Tue, 25 May 2021 23:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210314233323.23377-1-chunkuang.hu@kernel.org> <20210314233323.23377-3-chunkuang.hu@kernel.org>
In-Reply-To: <20210314233323.23377-3-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 26 May 2021 14:17:32 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-yo0oWfgaCNNvkESgnWf6cyY=1g0T82-_aTJ-d7EiUWw@mail.gmail.com>
Message-ID: <CAAOTY_-yo0oWfgaCNNvkESgnWf6cyY=1g0T82-_aTJ-d7EiUWw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mailbox: mtk-cmdq: Use mailbox rx_callback
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Yongqiang

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B43=E6=9C=8815=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=887:33=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> rx_callback is a standard mailbox callback mechanism and could cover the
> function of proprietary cmdq_task_cb, so use the standard one instead of
> the proprietary one. But the client driver has already used cmdq_task_cb,
> so keep cmdq_task_cb until all client driver use rx_callback instead of
> cmdq_task_cb.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Houlong Wei <houlong.wei@mediatek.com>
> Cc: Bibby Hsieh <bibby.hsieh@mediatek.com>
> Cc: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index 3d37c1cd40f1..ef59e2234f22 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -188,7 +188,10 @@ static void cmdq_task_exec_done(struct cmdq_task *ta=
sk, int sta)
>         WARN_ON(cb->cb =3D=3D (cmdq_async_flush_cb)NULL);
>         data.sta =3D sta;
>         data.data =3D cb->data;
> -       cb->cb(data);
> +       if (cb->cb)
> +               cb->cb(data);
> +
> +       mbox_chan_received_data(task->thread->chan, &data);
>
>         list_del(&task->list_entry);
>  }
> @@ -451,12 +454,13 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, =
unsigned long timeout)
>
>         list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
>                                  list_entry) {
> +               data.sta =3D -ECONNABORTED;
> +               data.data =3D cb->data;
>                 cb =3D &task->pkt->async_cb;
> -               if (cb->cb) {
> -                       data.sta =3D -ECONNABORTED;
> -                       data.data =3D cb->data;
> +               if (cb->cb)
>                         cb->cb(data);
> -               }
> +
> +               mbox_chan_received_data(task->thread->chan, &data);
>                 list_del(&task->list_entry);
>                 kfree(task);
>         }
> --
> 2.17.1
>

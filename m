Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61B739107F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhEZGQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231657AbhEZGQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:16:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E48BC613C9
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622009713;
        bh=K9VDx8l9Fk35dCxg8qbp0CYu7i27EvYaYxaUjqRCaGA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QK8ptdbQMIVDkeHjRJDyCbqjz30EDJvgsnLgsSS5lXJjXoxC8t2BovkOpaHQ/YbUq
         G9DvZ9yiXO07O+Q5tqWYC9MOZ+5W1MGWEoMnRvRnSUFHmnsxBd/W+aQwailOUC4dQ/
         r2C7SUAr7hfdlLDtyJ4axwrY1XSd1iEqgcnyk4zmrcBMy5J5GC2PO86Gk/4zsX8HDB
         dKxUGl1hBjG/k37CvxqecSFaCgBeYViTILUKRnTxwvjpFMOafrPJys4vsWXwbTWu6e
         45aSbsO2q75G1Q0uN0iJ0LvcgXWl9+/X+zOtCUpB/z4WcviERkMstDbUTQ79TVoZLx
         Gfg2k85OiRyaw==
Received: by mail-ej1-f50.google.com with SMTP id lz27so540627ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:15:13 -0700 (PDT)
X-Gm-Message-State: AOAM533edKWvLJosvFXCEHFRWAjccRFK3SUgLJ2VapFFm9230aAiw3zS
        scuOKQl3B7MPTilF/oqINhm383Zredknv/Zytg==
X-Google-Smtp-Source: ABdhPJyabKi0LWwM/PA6CRZRJ7yKxu8Ed2vDuD7MWKFm13lniftrSzzbsQwiHZTy3W9YN6BoLRM2MlemgaJGcuSt8JU=
X-Received: by 2002:a17:907:1ca1:: with SMTP id nb33mr31925940ejc.75.1622009712454;
 Tue, 25 May 2021 23:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210314233323.23377-1-chunkuang.hu@kernel.org> <20210314233323.23377-2-chunkuang.hu@kernel.org>
In-Reply-To: <20210314233323.23377-2-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 26 May 2021 14:15:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-SdjB5yTxwABLdrYgr+PpbbCnKhTPskBYwcQDeCCxvhQ@mail.gmail.com>
Message-ID: <CAAOTY_-SdjB5yTxwABLdrYgr+PpbbCnKhTPskBYwcQDeCCxvhQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mailbox: mtk-cmdq: Remove cmdq_cb_status
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
> cmdq_cb_status is an error status. Use the standard error number
> instead of cmdq_cb_status to prevent status duplication.
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
>  drivers/mailbox/mtk-cmdq-mailbox.c       | 10 +++++-----
>  include/linux/mailbox/mtk-cmdq-mailbox.h |  7 +------
>  2 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index 5665b6ea8119..3d37c1cd40f1 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -180,7 +180,7 @@ static bool cmdq_thread_is_in_wfe(struct cmdq_thread =
*thread)
>         return readl(thread->base + CMDQ_THR_WAIT_TOKEN) & CMDQ_THR_IS_WA=
ITING;
>  }
>
> -static void cmdq_task_exec_done(struct cmdq_task *task, enum cmdq_cb_sta=
tus sta)
> +static void cmdq_task_exec_done(struct cmdq_task *task, int sta)
>  {
>         struct cmdq_task_cb *cb =3D &task->pkt->async_cb;
>         struct cmdq_cb_data data;
> @@ -244,10 +244,10 @@ static void cmdq_thread_irq_handler(struct cmdq *cm=
dq,
>                         curr_task =3D task;
>
>                 if (!curr_task || curr_pa =3D=3D task_end_pa - CMDQ_INST_=
SIZE) {
> -                       cmdq_task_exec_done(task, CMDQ_CB_NORMAL);
> +                       cmdq_task_exec_done(task, 0);
>                         kfree(task);
>                 } else if (err) {
> -                       cmdq_task_exec_done(task, CMDQ_CB_ERROR);
> +                       cmdq_task_exec_done(task, -ENOEXEC);
>                         cmdq_task_handle_error(curr_task);
>                         kfree(task);
>                 }
> @@ -415,7 +415,7 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan=
)
>
>         list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
>                                  list_entry) {
> -               cmdq_task_exec_done(task, CMDQ_CB_ERROR);
> +               cmdq_task_exec_done(task, -ECONNABORTED);
>                 kfree(task);
>         }
>
> @@ -453,7 +453,7 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, un=
signed long timeout)
>                                  list_entry) {
>                 cb =3D &task->pkt->async_cb;
>                 if (cb->cb) {
> -                       data.sta =3D CMDQ_CB_ERROR;
> +                       data.sta =3D -ECONNABORTED;
>                         data.data =3D cb->data;
>                         cb->cb(data);
>                 }
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mai=
lbox/mtk-cmdq-mailbox.h
> index d5a983d65f05..2f7d9a37d611 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -65,13 +65,8 @@ enum cmdq_code {
>         CMDQ_CODE_LOGIC =3D 0xa0,
>  };
>
> -enum cmdq_cb_status {
> -       CMDQ_CB_NORMAL =3D 0,
> -       CMDQ_CB_ERROR
> -};
> -
>  struct cmdq_cb_data {
> -       enum cmdq_cb_status     sta;
> +       int                     sta;
>         void                    *data;
>  };
>
> --
> 2.17.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7924388CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349975AbhESLXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241088AbhESLXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:23:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59EFC6108B
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 11:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621423314;
        bh=fYglNnaQAuxyqNWH/krc3Hg57khobkxg9ya/DgyJ1RQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q/jAuaSOmf39GSQwhaz77Q8HwKs9NI/MXXDej3zH+ZZ5leN+Gee0CfZC9IdC97cPd
         FJXNA0CLfB6FzKQeHlUQ0bAO8J4/YZb519tX23nQBxTcKyJQ8bSdsF3rzAxc9MvmxP
         A5l+cBlPZy8crrKC/CJsg5BdlNVZurEh3kLiVrXZQccx3DAUUeyUdnPpSO9l5q1q9J
         t8wHD0WuavvnUTn9RALhO1Ws2gViUgrSXj4zzGnFu/YhEvO1ta39iQHxmKORDU72PS
         31geyv09Iits+L0Wjt+u2DrIdNF6S9gDeUCo7quGFs6vITfeZPVXH+oL4vxn4QR6u1
         Yu9NtpFrJ+ABg==
Received: by mail-ed1-f41.google.com with SMTP id g7so2739619edm.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 04:21:54 -0700 (PDT)
X-Gm-Message-State: AOAM531ZDr9gPXDTtWaNsHWPh+fQ5Ef9q4uoJhv4gjCBkHzodaAQ7xYk
        d9VMEEBKXBMYv0p6WoF24YtlcM9Is7U5cL2tfQ==
X-Google-Smtp-Source: ABdhPJyhU1VHrUgMaJOH/P0DFczuZUCtXu2r+76ZrF10+WGgIhv+5vQxqqI9hG1DvdaQC+1oa4aSa7YPHzDhOA1Re8U=
X-Received: by 2002:aa7:ccc6:: with SMTP id y6mr388400edt.303.1621423312942;
 Wed, 19 May 2021 04:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210314233323.23377-1-chunkuang.hu@kernel.org> <20210314233323.23377-2-chunkuang.hu@kernel.org>
In-Reply-To: <20210314233323.23377-2-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 19 May 2021 19:21:42 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8ASVD_kApnRmrrsA6nh3XDYAyS-u0g7jK_GF4KipT=wg@mail.gmail.com>
Message-ID: <CAAOTY_8ASVD_kApnRmrrsA6nh3XDYAyS-u0g7jK_GF4KipT=wg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mailbox: mtk-cmdq: Remove cmdq_cb_status
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jassi:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B43=E6=9C=8815=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=887:33=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> cmdq_cb_status is an error status. Use the standard error number
> instead of cmdq_cb_status to prevent status duplication.

How do you think about this series?

Regards,
Chun-Kuang.

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BFD334CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 00:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhCJXgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 18:36:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231478AbhCJXfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 18:35:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADEDB64FC3;
        Wed, 10 Mar 2021 23:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615419353;
        bh=DwM3rH6AjLTUq5Tg8FAIDbBoM73Bq7C9XBbJ6XvjWxY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VKTPqsrdQZkUZDkpfwG/MgplUaGFVZWU5F8VZ7tCN+Ao0RwDcICDLJ08VMYPCPh2S
         1F4rqDEKHddeSg0wPkp9xEkY0zozeb+4rjwhCtZP6ValSwdbHxcAsxKyxhom3k4Oxs
         a6bfOHa1kQs/ogWq/th5I8HDpnP8mheO8gFSxAN1RgMzRFXn4sScH5JFDvGJUovb1m
         j8qrU+E1j6dJ/31TFL00Nd4yKj40QjzRSsb2l4eEhD0fl/kvwELAJrzA4US2F0oTUb
         187k+XNLNTWQ/ezrA9skfyIQ4S9XaMrjMr90SwmjdFtTcTkxgxXH0BSqtKuWdQMdmA
         v3V6cOvI803vg==
Received: by mail-ej1-f45.google.com with SMTP id p8so42296679ejb.10;
        Wed, 10 Mar 2021 15:35:52 -0800 (PST)
X-Gm-Message-State: AOAM5321+SvCB3r4C85OlCyX2MdMGiNa+bg8Y5BcQpNWY4t+uUfDpArz
        t4ERaPQJoV+E2P0hzWkV17xWc5eLIr9YZUMt/w==
X-Google-Smtp-Source: ABdhPJyyDif+L5a43V6gNiRG6kb8yDCVOo0IMCgDsfizW5sw67eRKFFjTESXqKCVEuUZv3BQIsOsOjm/MSiwvulHBg4=
X-Received: by 2002:a17:906:3750:: with SMTP id e16mr321756ejc.75.1615419351300;
 Wed, 10 Mar 2021 15:35:51 -0800 (PST)
MIME-Version: 1.0
References: <1615373812-16204-1-git-send-email-yongqiang.niu@mediatek.com> <1615373812-16204-3-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1615373812-16204-3-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 11 Mar 2021 07:35:39 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-WYGEBjfisMBxSMuvCY_5Ty1naeZ0NEN0YkR5sVSbFOA@mail.gmail.com>
Message-ID: <CAAOTY_-WYGEBjfisMBxSMuvCY_5Ty1naeZ0NEN0YkR5sVSbFOA@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 2/2] Revert "mailbox: mediatek: remove
 implementation related to atomic_exec"
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=
=8810=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:58=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This reverts commit c9ea564f3d9dd20d88bd34f40a6ff6d31a0d7e8c.
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 80 ++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 71 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index 5665b6e..e0d9a86 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -56,6 +56,7 @@ struct cmdq_thread {
>         void __iomem            *base;
>         struct list_head        task_busy_list;
>         u32                     priority;
> +       bool                    atomic_exec;
>  };
>
>  struct cmdq_task {
> @@ -168,18 +169,56 @@ static void cmdq_task_insert_into_thread(struct cmd=
q_task *task)
>         dma_sync_single_for_cpu(dev, prev_task->pa_base,
>                                 prev_task->pkt->cmd_buf_size, DMA_TO_DEVI=
CE);
>         prev_task_base[CMDQ_NUM_CMD(prev_task->pkt) - 1] =3D
> -               (u64)CMDQ_JUMP_BY_PA << 32 | task->pa_base;
> +               (u64)CMDQ_JUMP_BY_PA << 32 |
> +               (task->pa_base >> task->cmdq->shift_pa);
>         dma_sync_single_for_device(dev, prev_task->pa_base,
>                                    prev_task->pkt->cmd_buf_size, DMA_TO_D=
EVICE);
>
>         cmdq_thread_invalidate_fetched_data(thread);
>  }
>
> +static bool cmdq_command_is_wfe(u64 cmd)
> +{
> +       u64 wfe_option =3D CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAI=
T_VALUE;
> +       u64 wfe_op =3D (u64)(CMDQ_CODE_WFE << CMDQ_OP_CODE_SHIFT) << 32;
> +       u64 wfe_mask =3D (u64)CMDQ_OP_CODE_MASK << 32 | 0xffffffff;
> +
> +       return ((cmd & wfe_mask) =3D=3D (wfe_op | wfe_option));
> +}
> +
> +/* we assume tasks in the same display GCE thread are waiting the same e=
vent. */
> +static void cmdq_task_remove_wfe(struct cmdq_task *task)
> +{
> +       struct device *dev =3D task->cmdq->mbox.dev;
> +       u64 *base =3D task->pkt->va_base;
> +       int i;
> +
> +       dma_sync_single_for_cpu(dev, task->pa_base, task->pkt->cmd_buf_si=
ze,
> +                               DMA_TO_DEVICE);
> +       for (i =3D 0; i < CMDQ_NUM_CMD(task->pkt); i++)
> +               if (cmdq_command_is_wfe(base[i]))
> +                       base[i] =3D (u64)CMDQ_JUMP_BY_OFFSET << 32 |
> +                                 (CMDQ_JUMP_PASS >> task->cmdq->shift_pa=
);
> +       dma_sync_single_for_device(dev, task->pa_base, task->pkt->cmd_buf=
_size,
> +                                  DMA_TO_DEVICE);
> +}
> +
>  static bool cmdq_thread_is_in_wfe(struct cmdq_thread *thread)
>  {
>         return readl(thread->base + CMDQ_THR_WAIT_TOKEN) & CMDQ_THR_IS_WA=
ITING;
>  }
>
> +static void cmdq_thread_wait_end(struct cmdq_thread *thread,
> +                                unsigned long end_pa)
> +{
> +       struct device *dev =3D thread->chan->mbox->dev;
> +       unsigned long curr_pa;
> +
> +       if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_CURR_ADDR,
> +                       curr_pa, curr_pa =3D=3D end_pa, 1, 20))
> +               dev_err(dev, "GCE thread cannot run to end.\n");
> +}
> +
>  static void cmdq_task_exec_done(struct cmdq_task *task, enum cmdq_cb_sta=
tus sta)
>  {
>         struct cmdq_task_cb *cb =3D &task->pkt->async_cb;
> @@ -371,15 +410,37 @@ static int cmdq_mbox_send_data(struct mbox_chan *ch=
an, void *data)
>                         cmdq->shift_pa;
>                 end_pa =3D readl(thread->base + CMDQ_THR_END_ADDR) <<
>                         cmdq->shift_pa;
> -               /* check boundary */
> -               if (curr_pa =3D=3D end_pa - CMDQ_INST_SIZE ||
> -                   curr_pa =3D=3D end_pa) {
> -                       /* set to this task directly */
> -                       writel(task->pa_base >> cmdq->shift_pa,
> -                              thread->base + CMDQ_THR_CURR_ADDR);
> +
> +               /*
> +                * Atomic execution should remove the following wfe, i.e.=
 only
> +                * wait event at first task, and prevent to pause when ru=
nning.
> +                */
> +               if (thread->atomic_exec) {
> +                       /* GCE is executing if command is not WFE */
> +                       if (!cmdq_thread_is_in_wfe(thread)) {
> +                               cmdq_thread_resume(thread);
> +                               cmdq_thread_wait_end(thread,
> +                                                    end_pa >> cmdq->shif=
t_pa);
> +                               WARN_ON(cmdq_thread_suspend(cmdq, thread)=
 < 0);
> +                               /* set to this task directly */
> +                               writel(task->pa_base >> cmdq->shift_pa,
> +                                      thread->base + CMDQ_THR_CURR_ADDR)=
;
> +                       } else {
> +                               cmdq_task_insert_into_thread(task);
> +                               cmdq_task_remove_wfe(task);
> +                               smp_mb(); /* modify jump before enable th=
read */
> +                       }
>                 } else {
> -                       cmdq_task_insert_into_thread(task);
> -                       smp_mb(); /* modify jump before enable thread */
> +                       /* check boundary */
> +                       if (curr_pa =3D=3D end_pa - CMDQ_INST_SIZE ||
> +                           curr_pa =3D=3D end_pa) {
> +                               /* set to this task directly */
> +                               writel(task->pa_base >> cmdq->shift_pa,
> +                                      thread->base + CMDQ_THR_CURR_ADDR)=
;
> +                       } else {
> +                               cmdq_task_insert_into_thread(task);
> +                               smp_mb(); /* modify jump before enable th=
read */
> +                       }
>                 }
>                 writel((task->pa_base + pkt->cmd_buf_size) >> cmdq->shift=
_pa,
>                        thread->base + CMDQ_THR_END_ADDR);
> @@ -500,6 +561,7 @@ static struct mbox_chan *cmdq_xlate(struct mbox_contr=
oller *mbox,
>
>         thread =3D (struct cmdq_thread *)mbox->chans[ind].con_priv;
>         thread->priority =3D sp->args[1];
> +       thread->atomic_exec =3D (sp->args[2] !=3D 0);

This does not match the binding [1].
Why not just fix the bug rather than revert this patch?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/mailbox/mtk-gce.txt?h=3Dv5.12-rc2

Regards,
Chun-Kuang.

>         thread->chan =3D &mbox->chans[ind];
>
>         return &mbox->chans[ind];
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

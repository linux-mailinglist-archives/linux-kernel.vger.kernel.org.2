Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233E0391084
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhEZGTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbhEZGTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:19:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87C1E613F4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622009903;
        bh=qRZywFAIS8OG9QveAM/amHgYEO4sE+tckC4V3AGxm88=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P120oTMgalXw4yYHrH5iquo7LDfRNNEgmX/+/gaWZdr/K0lBmUTsgvJ2HpaZx9xa3
         IYsT5WaILFpwCCSqjr7e7yfvac7NoMTpujpj21Lo9vftykBEs7H4HABpatjwDyhqLb
         WmGzDxP2757/VqAVqOEk+jHey5Dg7iffrEO74hsq6uDsRM1wCN2d0hp1hOVpAYQujH
         nXQ21yVJQ0zRMSlny4zkjbCyvXCaGsJUroqsumGS/zVuPONFjDYBwwA0LukmzyVtrE
         Rz2Is4YPzm39Zu4ib2ClOtL4WgcHJNfmpYL19bnrCxODppP/5ceSNhwFB8Ww/TnF4L
         4ZpxI+oreSVzA==
Received: by mail-ej1-f52.google.com with SMTP id lz27so551574ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:18:23 -0700 (PDT)
X-Gm-Message-State: AOAM530xpmgtAaOdAc4WR+Fq70zyq8GF1DVfv0gbt998Iwpw3WTPB0N/
        lL4DEZVyMBz1xeU7lX3xR/uNzgJokxzbO2xl/A==
X-Google-Smtp-Source: ABdhPJxQRgDV8LFOf1AQsXJIXTlfjg4Ec/JLjUGKbtsJXWp5lXf9l3goBntr+bCxj9zUO4SL9qOy7gQzLtsZDx8Rn3A=
X-Received: by 2002:a17:906:b0cb:: with SMTP id bk11mr32710935ejb.310.1622009902111;
 Tue, 25 May 2021 23:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210314233323.23377-1-chunkuang.hu@kernel.org> <20210314233323.23377-4-chunkuang.hu@kernel.org>
In-Reply-To: <20210314233323.23377-4-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 26 May 2021 14:18:12 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-L1URHwkiCQv5Z0sF_caWTkU7_2+jw=9DLfCyPyhfT+Q@mail.gmail.com>
Message-ID: <CAAOTY_-L1URHwkiCQv5Z0sF_caWTkU7_2+jw=9DLfCyPyhfT+Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] mailbox: mtk-cmdq: Add struct cmdq_pkt in struct cmdq_cb_data
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
> Current client use 'struct cmdq_pkt' as callback data, so
> change 'void *data' to 'struct cmdq_pkt *pkt'. Keep data
> until client use pkt instead of data.
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
>  drivers/mailbox/mtk-cmdq-mailbox.c       | 2 ++
>  include/linux/mailbox/mtk-cmdq-mailbox.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index ef59e2234f22..99a9e0787501 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -188,6 +188,7 @@ static void cmdq_task_exec_done(struct cmdq_task *tas=
k, int sta)
>         WARN_ON(cb->cb =3D=3D (cmdq_async_flush_cb)NULL);
>         data.sta =3D sta;
>         data.data =3D cb->data;
> +       data.pkt =3D task->pkt;
>         if (cb->cb)
>                 cb->cb(data);
>
> @@ -456,6 +457,7 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, un=
signed long timeout)
>                                  list_entry) {
>                 data.sta =3D -ECONNABORTED;
>                 data.data =3D cb->data;
> +               data.pkt =3D task->pkt;
>                 cb =3D &task->pkt->async_cb;
>                 if (cb->cb)
>                         cb->cb(data);
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mai=
lbox/mtk-cmdq-mailbox.h
> index 2f7d9a37d611..44365aab043c 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -68,6 +68,7 @@ enum cmdq_code {
>  struct cmdq_cb_data {
>         int                     sta;
>         void                    *data;
> +       struct cmdq_pkt         *pkt;
>  };
>
>  typedef void (*cmdq_async_flush_cb)(struct cmdq_cb_data data);
> --
> 2.17.1
>

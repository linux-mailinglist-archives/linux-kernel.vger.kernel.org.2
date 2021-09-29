Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A41241C797
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344882AbhI2PAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344730AbhI2PAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:00:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42CAE613CE;
        Wed, 29 Sep 2021 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632927505;
        bh=EQQTnRS8lPfDTcCQ7Qonvy40+E4FTsuJpNfA2zp7kgs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=onlZ98hwlZ5oYGqO4Cu2vlKurJF5NzXl00KPNRdEahyjrQRGKUkc2vpzcwqZ8Rgzo
         fokFz4U0ZbnD8qiAN79xYbJM5wwgjz/2holVbpCtsl2j1KRiG7Gp8axaUIegjsu/4p
         AjFLTkfHj7DiChESUu+VpawS2RSH5ewFu0c7Zg7olxi195KkNWfDYgCEUm0Kk+2qDo
         8dE+fZtQXjul1rB54wF++6nylTIwZvG6wFsK+su8ab5tMrXn0e8LtBTSQol5iLl2Q9
         zhXDYjYIfxxUhSFEmlAvysmUcj1rB9zUVQ8N5u1+/4SkbYKLIsUlLuFCmo07CQXpTa
         Rml1+Mm67lgqw==
Received: by mail-ed1-f51.google.com with SMTP id dj4so10101209edb.5;
        Wed, 29 Sep 2021 07:58:25 -0700 (PDT)
X-Gm-Message-State: AOAM532mEZ2zmSdNLpjfFs8nOARL2P1aEuZWbQMnSvvl/+x4VFOT126f
        abQWThHMsNUYI9H0Lecdl/sqIGGy5PEN+SD6jQ==
X-Google-Smtp-Source: ABdhPJxjDTCqpw+W11Ljil+9t3MzrJAqBg+zykn7W36zQ7oVw8AEF8t6rSe/akCB+6pScUV0nvaP5KPkV9V+4m3JciE=
X-Received: by 2002:a17:907:3e21:: with SMTP id hp33mr145136ejc.205.1632927436610;
 Wed, 29 Sep 2021 07:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210929070807.4488-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20210929070807.4488-1-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 29 Sep 2021 22:57:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-EEz0tAU_XoL789uOXx_hKGCz53vaaZrA4DSNM4NZ=8g@mail.gmail.com>
Message-ID: <CAAOTY_-EEz0tAU_XoL789uOXx_hKGCz53vaaZrA4DSNM4NZ=8g@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Remove WARN_ON for async_cb.cb in cmdq_exec_done
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=882=
9=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:08=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Because mtk_drm_crtc_update_config is not using cmdq_pkt_flush_async,
> it won't have pkt->async_cb.cb anymore.
>
> So remove the WARN_ON check of pkt->async_cb.cb at cmdq_exec_done.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Fixes: 1b6b0ce2240e ("mailbox: mtk-cmdq: Use mailbox rx_callback")
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index 64175a893312..c591dab9d5a4 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -195,7 +195,6 @@ static void cmdq_task_exec_done(struct cmdq_task *tas=
k, int sta)
>         struct cmdq_task_cb *cb =3D &task->pkt->async_cb;
>         struct cmdq_cb_data data;
>
> -       WARN_ON(cb->cb =3D=3D (cmdq_async_flush_cb)NULL);
>         data.sta =3D sta;
>         data.data =3D cb->data;
>         data.pkt =3D task->pkt;
> --
> 2.18.0
>

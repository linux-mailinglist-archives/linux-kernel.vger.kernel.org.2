Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5E0426C9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhJHOSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhJHOSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:18:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7F1961039
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633702569;
        bh=gfnYmiYx+3dkf2QkxY+VQ8BWqcH+BG2yBzByLC0yQFQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SmAbaTP49xnbbJwvMEkONUKVqObtjfRfY4b2SYkUBQ5vTgXDpMb3PGhpQt3W5eSk1
         mp8IohvNPiPK5jMzq83lgDsmoLnO8OqkzHU+sZU8xkd0Uw4yOVq88mYuJ/bfe8DoDf
         ZRXk6SyP1WzCx4TDisbU9PFgMLe2A/mzv5k1bplEkzX+qf2WMeXOXEMLGsvfX1r/qv
         0iWyTJdDYdkXwqBj60/BcoYFtRWHzyjSXLmBvm1MiCkdfjVlRLCpWcIieHGUGyPsWH
         UFP23LUNAr6tA4Rno/a8pQaxnIFOOH3NARZK3bM3Cp3B4WcwAEydHTOpPs8OxhmzOf
         GR18fC/1FkIVA==
Received: by mail-ed1-f52.google.com with SMTP id z20so36785134edc.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 07:16:09 -0700 (PDT)
X-Gm-Message-State: AOAM5312a3DMxOBKQrkBTaL8r3fLpTNmDRiCXpGF0G5NKnLcNdPOfTnt
        F4Sq/7Axan1+KVlzcsn8T43YIOpya7a5rWUQ4A==
X-Google-Smtp-Source: ABdhPJwdhKOutSaYK+RNrD+9iDbGHmKNrnmA/aPTFJPid4OWVGl9MH0bIy7Jr3s/kHMiLiPvTEE5f6q+Xnn20xQaVBc=
X-Received: by 2002:a17:906:c7c1:: with SMTP id dc1mr4791596ejb.6.1633702568065;
 Fri, 08 Oct 2021 07:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210915232722.10031-1-chunkuang.hu@kernel.org>
In-Reply-To: <20210915232722.10031-1-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 8 Oct 2021 22:15:57 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8BZ9BgWeQVsD_01ioP8H16c1_QUb_+yniU_4Wp91Nc7A@mail.gmail.com>
Message-ID: <CAAOTY_8BZ9BgWeQVsD_01ioP8H16c1_QUb_+yniU_4Wp91Nc7A@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: cmdq: Use mailbox rx_callback instead of cmdq_task_cb
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
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

Hi, Matthias:

Please ignore this patch because this patch depend on [1] which would
cause numerous warning message. So I would revert that patch in [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/gpu/drm/mediatek?h=3Dv5.15-rc4&id=3Dc1ec54b7b5af25c779192253f5a9=
f05e95cb43d7
[2] https://patchwork.kernel.org/project/linux-mediatek/patch/2021100723531=
0.14626-6-chunkuang.hu@kernel.org/

Regards,
Chun-Kuang.

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B49=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=887:27=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> rx_callback is a standard mailbox callback mechanism and could cover the
> function of proprietary cmdq_task_cb, so use the standard one instead of
> the proprietary one. Client has changed to use the standard callback
> machanism and sync dma buffer in client driver, so remove the proprietary
> callback in cmdq helper.
>
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c | 25 +------------------------
>  include/linux/soc/mediatek/mtk-cmdq.h  |  5 +----
>  2 files changed, 2 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediate=
k/mtk-cmdq-helper.c
> index 3c8e4212d941..c1837a468267 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -425,34 +425,11 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>  }
>  EXPORT_SYMBOL(cmdq_pkt_finalize);
>
> -static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
> -{
> -       struct cmdq_pkt *pkt =3D (struct cmdq_pkt *)data.data;
> -       struct cmdq_task_cb *cb =3D &pkt->cb;
> -       struct cmdq_client *client =3D (struct cmdq_client *)pkt->cl;
> -
> -       dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base,
> -                               pkt->cmd_buf_size, DMA_TO_DEVICE);
> -       if (cb->cb) {
> -               data.data =3D cb->data;
> -               cb->cb(data);
> -       }
> -}
> -
> -int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
> -                        void *data)
> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
>  {
>         int err;
>         struct cmdq_client *client =3D (struct cmdq_client *)pkt->cl;
>
> -       pkt->cb.cb =3D cb;
> -       pkt->cb.data =3D data;
> -       pkt->async_cb.cb =3D cmdq_pkt_flush_async_cb;
> -       pkt->async_cb.data =3D pkt;
> -
> -       dma_sync_single_for_device(client->chan->mbox->dev, pkt->pa_base,
> -                                  pkt->cmd_buf_size, DMA_TO_DEVICE);
> -
>         err =3D mbox_send_message(client->chan, pkt);
>         if (err < 0)
>                 return err;
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/me=
diatek/mtk-cmdq.h
> index ac6b5f3cba95..2b498f4f3946 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -268,8 +268,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
>   * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the C=
MDQ
>   *                          packet and call back at the end of done pack=
et
>   * @pkt:       the CMDQ packet
> - * @cb:                called at the end of done packet
> - * @data:      this data will pass back to cb
>   *
>   * Return: 0 for success; else the error code is returned
>   *
> @@ -277,7 +275,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
>   * at the end of done packet. Note that this is an ASYNC function. When =
the
>   * function returned, it may or may not be finished.
>   */
> -int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
> -                        void *data);
> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt);
>
>  #endif /* __MTK_CMDQ_H__ */
> --
> 2.25.1
>

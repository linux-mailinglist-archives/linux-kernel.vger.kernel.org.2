Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2414543B62D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbhJZP6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235729AbhJZP6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:58:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B59A6108B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635263740;
        bh=NGSch2WtYB3nDlQ/+9YEqgDLoXEDKMRu/wdD8415fBY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uOxlN6zOqT2omHcVNelIwvgof8GWLuIreza4BWEIGF0cSmGon3FHkXbAKF2TjGX99
         A1dR4GajSgcsFZ1RE6krHef/3thwVIp2Bzsfk2M1m4nrm1DOY2AHGi9vNux/0/J39B
         oP2gkftMTUTlPzvsFcAjkkU51p4+umBFcIsQy4NLrYHUEtyQD75x1OpX+bavVmSDVC
         TbrxjNR36WKGwYPFwRv83NVmAUO4GrHmpoKqT3hTtPJhiz5mTqwMa1ZfiBBHDWzBUX
         V+pXIAQ4KGOzq//qPbkndefH0HBuxLpjaYJIOlf5TGJ73LhPIRrQsAcTgKARnLBler
         lj5OxaOfZO+VA==
Received: by mail-ed1-f45.google.com with SMTP id z20so2224473edi.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:55:40 -0700 (PDT)
X-Gm-Message-State: AOAM5332UwJAkWFmwPH9c5KL1qqI7wKWS0cHlGwNLPA5J0JG9eGRE1dc
        Agka7FSnmHRt1CFSCydyaZPkQPIbJE34+8BXiA==
X-Google-Smtp-Source: ABdhPJzgqVCWXT+M41aSMPpOJ3v17st31iPfPukH3+SRVrfDKy8AVSdPsaimk9diarnRpFFsF7bEkw5S9zvp3XNpVJA=
X-Received: by 2002:a50:ff0a:: with SMTP id a10mr22764187edu.357.1635263560041;
 Tue, 26 Oct 2021 08:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211026052916.8222-1-jason-jh.lin@mediatek.com> <20211026052916.8222-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20211026052916.8222-3-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 26 Oct 2021 23:52:29 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-=JhEzK0UT3qVScLWh75LTr9K3VFJhJ6Zs_nuM0kmBXw@mail.gmail.com>
Message-ID: <CAAOTY_-=JhEzK0UT3qVScLWh75LTr9K3VFJhJ6Zs_nuM0kmBXw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] drm/mediatek: Remove the pointer of struct cmdq_client
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, fshao@chromium.org,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=88=
26=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=881:29=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>
> In mailbox rx_callback, it pass struct mbox_client to callback
> function, but it could not map back to mtk_drm_crtc instance
> because struct cmdq_client use a pointer to struct mbox_client:
>
> struct cmdq_client {
>         struct mbox_client client;
>         struct mbox_chan *chan;
> };
>
> struct mtk_drm_crtc {
>         /* client instance data */
>         struct cmdq_client *cmdq_client;
> };
>
> so remove the pointer of struct cmdq_client and let mtk_drm_crtc
> instance define cmdq_client as:
>
> struct mtk_drm_crtc {
>         /* client instance data */
>         struct cmdq_client cmdq_client;
> };
>
> and in rx_callback function, use struct mbox_client to get
> struct mtk_drm_crtc.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 37 +++++++++++++------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 369d3e68c0b6..e23e3224ac67 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -52,7 +52,7 @@ struct mtk_drm_crtc {
>         bool                            pending_async_planes;
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> -       struct cmdq_client              *cmdq_client;
> +       struct cmdq_client              cmdq_client;
>         u32                             cmdq_event;
>  #endif
>
> @@ -472,19 +472,19 @@ static void mtk_drm_crtc_update_config(struct mtk_d=
rm_crtc *mtk_crtc,
>                 mtk_mutex_release(mtk_crtc->mutex);
>         }
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> -       if (mtk_crtc->cmdq_client) {
> -               mbox_flush(mtk_crtc->cmdq_client->chan, 2000);
> -               cmdq_handle =3D cmdq_pkt_create(mtk_crtc->cmdq_client, PA=
GE_SIZE);
> +       if (mtk_crtc->cmdq_client.chan) {
> +               mbox_flush(mtk_crtc->cmdq_client.chan, 2000);
> +               cmdq_handle =3D cmdq_pkt_create(&mtk_crtc->cmdq_client, P=
AGE_SIZE);
>                 cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
>                 cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, false);
>                 mtk_crtc_ddp_config(crtc, cmdq_handle);
>                 cmdq_pkt_finalize(cmdq_handle);
> -               dma_sync_single_for_device(mtk_crtc->cmdq_client->chan->m=
box->dev,
> +               dma_sync_single_for_device(mtk_crtc->cmdq_client.chan->mb=
ox->dev,
>                                            cmdq_handle->pa_base,
>                                            cmdq_handle->cmd_buf_size,
>                                            DMA_TO_DEVICE);
> -               mbox_send_message(mtk_crtc->cmdq_client->chan, cmdq_handl=
e);
> -               mbox_client_txdone(mtk_crtc->cmdq_client->chan, 0);
> +               mbox_send_message(mtk_crtc->cmdq_client.chan, cmdq_handle=
);
> +               mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
>         }
>  #endif
>         mtk_crtc->config_updating =3D false;
> @@ -498,7 +498,7 @@ static void mtk_crtc_ddp_irq(void *data)
>         struct mtk_drm_private *priv =3D crtc->dev->dev_private;
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> -       if (!priv->data->shadow_register && !mtk_crtc->cmdq_client)
> +       if (!priv->data->shadow_register && !mtk_crtc->cmdq_client.chan)
>  #else
>         if (!priv->data->shadow_register)
>  #endif
> @@ -838,17 +838,20 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>         mutex_init(&mtk_crtc->hw_lock);
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> -       mtk_crtc->cmdq_client =3D
> -                       cmdq_mbox_create(mtk_crtc->mmsys_dev,
> -                                        drm_crtc_index(&mtk_crtc->base))=
;
> -       if (IS_ERR(mtk_crtc->cmdq_client)) {
> +       mtk_crtc->cmdq_client.client.dev =3D mtk_crtc->mmsys_dev;
> +       mtk_crtc->cmdq_client.client.tx_block =3D false;
> +       mtk_crtc->cmdq_client.client.knows_txdone =3D true;
> +       mtk_crtc->cmdq_client.client.rx_callback =3D ddp_cmdq_cb;
> +       mtk_crtc->cmdq_client.chan =3D
> +                       mbox_request_channel(&mtk_crtc->cmdq_client.clien=
t,
> +                                            drm_crtc_index(&mtk_crtc->ba=
se));
> +       if (IS_ERR(mtk_crtc->cmdq_client.chan)) {
>                 dev_dbg(dev, "mtk_crtc %d failed to create mailbox client=
, writing register by CPU now\n",
>                         drm_crtc_index(&mtk_crtc->base));
> -               mtk_crtc->cmdq_client =3D NULL;
> +               mtk_crtc->cmdq_client.chan =3D NULL;
>         }
>
> -       if (mtk_crtc->cmdq_client) {
> -               mtk_crtc->cmdq_client->client.rx_callback =3D ddp_cmdq_cb=
;
> +       if (mtk_crtc->cmdq_client.chan) {
>                 ret =3D of_property_read_u32_index(priv->mutex_node,
>                                                  "mediatek,gce-events",
>                                                  drm_crtc_index(&mtk_crtc=
->base),
> @@ -856,8 +859,8 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>                 if (ret) {
>                         dev_dbg(dev, "mtk_crtc %d failed to get mediatek,=
gce-events property\n",
>                                 drm_crtc_index(&mtk_crtc->base));
> -                       cmdq_mbox_destroy(mtk_crtc->cmdq_client);
> -                       mtk_crtc->cmdq_client =3D NULL;
> +                       mbox_free_channel(mtk_crtc->cmdq_client.chan);
> +                       mtk_crtc->cmdq_client.chan =3D NULL;
>                 }
>         }
>  #endif
> --
> 2.18.0
>

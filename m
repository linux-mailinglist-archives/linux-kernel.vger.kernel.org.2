Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84965423BEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbhJFLGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbhJFLGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:06:52 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07363C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 04:05:00 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t4so1648564oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 04:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=plRGZC/b0XlnIowiw7LrSMNdc+E008oB9HIcD1bAFMM=;
        b=Gz+mKlNX6iYHVHBV62n61UJsNZ5ZzCSVBw5HTcBLOSzxoqYbZEPwEXjyVL3QIGH5p4
         wSSKN1egJjNlOzSFCPtIVkOx1/PAQfYrAEbv4NMY2Y72bn/tWP0pizN6Lf5hd/UT5EwS
         Y95OkZq3JhOw6CYqcQSOkTOkZVJCNenCx9InkH+mSymk8eRUvG/mvDpgH0Dx6FcDQmN+
         3y6tkAPI3xL/TRK2CMa/VLjGVNRA0aQBYT2OKgg8cBEURiLTJlKzDscrBezRlkrHXRFh
         zlOsEsfTMN4xv5uH9sHQqpZyBnzmQu1iCBkLPTDV0tFg/XhyDB6JnfqkNl0XEVuQWXd0
         fLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=plRGZC/b0XlnIowiw7LrSMNdc+E008oB9HIcD1bAFMM=;
        b=E3eD0w5316Vk36VDmgSm6t94sz4pgTM1pAdY56yWqXltvasoczky2R9nnDmkEezqfR
         YA+yTvi6zSeCvcggukWtvLQYNS/eb+ukgRHiQyl4qSnqX0OmiM2ECeuF1YnhtTbzFmLs
         a06S+QlUNr6M8ayhL+2E5i/jbFg1/1Haiu5pdbLhuzWlYWwWp5+SMpJLKUDerdoGitRO
         1SdVN0hOiwo6y8d4gvO5w6925VWO89W83XjgU18bufPAq4noqykxqf9pxk8Dl0RW2oCD
         H5GYxalxYX4mH++Pamh9nqpnrm//1dbAJ091JEAwIbF40ku5QTtzvOxjpde4F4niylW9
         zZ4A==
X-Gm-Message-State: AOAM533vKFsZXGSWBOlogb/CiUhdSJB8rDzKMbrfsScB3+C8RphzX4ZN
        DapKyE2b+9NQftNEMfFq12o42MB+/wIg6isZt9U=
X-Google-Smtp-Source: ABdhPJzflq44pP3zuilcXdFd+dsa1YyGrsk2CdEsAF1B8YFzd0ZJ9AQUCgslQZqXMfb6bTinrWHGdp9NtU9U45pwEzI=
X-Received: by 2002:aca:b388:: with SMTP id c130mr6822278oif.39.1633518299287;
 Wed, 06 Oct 2021 04:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210930024704.6966-1-jason-jh.lin@mediatek.com>
 <20210930024704.6966-2-jason-jh.lin@mediatek.com> <CAFqH_52w787DGbVE0WqMjA2y8Psw6XDMp8AFhj=7UMyCA-uv+g@mail.gmail.com>
 <CAAOTY_-bU-zuNE6-omHV=54R5UDOH2KQ0iD_ZcLc-VDeA65vTA@mail.gmail.com>
 <CAFqH_52W6qaG665rikgo5rkiYfo5Z_xX9RycHpA1rG_+yEm_xg@mail.gmail.com> <CAAOTY_8gXd_XtePjuOfheY6A6QuPJiYsXhyxt70R3MZP2juDZw@mail.gmail.com>
In-Reply-To: <CAAOTY_8gXd_XtePjuOfheY6A6QuPJiYsXhyxt70R3MZP2juDZw@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 6 Oct 2021 13:04:47 +0200
Message-ID: <CAFqH_51Ajj=Jv+6ySdQrVCWAKkVFmEbQCRadEm0OeQdaV=6xLQ@mail.gmail.com>
Subject: Re: [v2 PATCH 1/3] drm/mediatek: Fix crash at using pkt->cl->chan in cmdq_pkt_finalize
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, fshao@chromium.org,
        "Nancy.Lin" <nancy.lin@mediatek.com>, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

Missatge de Chun-Kuang Hu <chunkuang.hu@kernel.org> del dia dv., 1
d=E2=80=99oct. 2021 a les 17:52:
>
> Hi, Enric:
>
> Enric Balletbo Serra <eballetbo@gmail.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=
=8830=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:48=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Hi Chun-Kuang,
> >
> > Missatge de Chun-Kuang Hu <chunkuang.hu@kernel.org> del dia dj., 30 de
> > set. 2021 a les 15:11:
> > >
> > > Hi, Enric:
> > >
> > > Enric Balletbo Serra <eballetbo@gmail.com> =E6=96=BC 2021=E5=B9=B49=
=E6=9C=8830=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=883:12=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > >
> > > > Hi Jason,
> > > >
> > > >
> > > > Missatge de jason-jh.lin <jason-jh.lin@mediatek.com> del dia dj., 3=
0
> > > > de set. 2021 a les 4:47:
> > > > >
> > > > > Because mtk_drm_crtc_create_pkt didn't assign pkt->cl, it will
> > > > > crash at using pkt->cl->chan in cmdq_pkt_finalize.
> > > > >
> > > > > So add struct cmdq_client and let mtk_drm_crtc instance define
> > > > > cmdq_client as:
> > > > >
> > > > > struct mtk_drm_crtc {
> > > > >         /* client instance data */
> > > > >         struct cmdq_client cmdq_client;
> > > > > };
> > > > >
> > > > > and in rx_callback function can use pkt->cl to get
> > > > > struct cmdq_client.
> > > > >
> > > > > Fixes: f4be17cd5b14 ("drm/mediatek: Remove struct cmdq_client")
> > > >
> > > > Looking at this patchset looks like you're fixing the above commit =
by
> > > > reintroducing the 'struct cmdq_client' again, which makes the above
> > > > commit as a non-sense commit. That's confusing and not clear. I'm
> > > > wondering if it wouldn't be more clear if you can just revert that
> > > > patch. Then if there are more changes that need to be done do it wi=
th
> > > > a follow up patch and really explain why these changes are needed.
> > >
> > > The patch f4be17cd5b14 ("drm/mediatek: Remove struct cmdq_client")
> > > does two things. One is to remove struct cmdq_client, another one is
> > > to embed cmdq_cl
> >
> > Then it should have been two patches, one thing for patch really
> > helps, specially when something breaks and you try to bisect it.
> >
> > > in mtk_drm_crtc (This means the pointer of cmdq_cl could be used to
> > > find the pointer of mtk_drm_crtc). The correct way to fix that patch
> > > is to remove the access to cmdq_client in cmdq_pkt_finalize(), but
> > > that would be a long term process. The simple way is to revert that
> > > patch, but the other patches depend on embedding cmdq_cl in
> > > mtk_drm_crtc. So this patch just revert the removing of struct
> > > cmdq_client but keep embedding cmdq_cl in mtk_drm_crtc.
> > >
> >
> > Yes, I know and I suffered that when bisecting and I ended to revert
> > the full series in my local tree,  although I figured out that the
> > problem was this specific patch.
> >
> > The following series landed during -rc1 cycle and break the Acer Chrome=
book R13
> >
> >  9efb16c2fdd6 ("drm/mediatek: Clear pending flag when cmdq packet is do=
ne")
> >  bc9241be73d9 ("drm/mediatek: Add cmdq_handle in mtk_crtc")
> >  8cdcb3653424 ("drm/mediatek: Detect CMDQ execution timeout")
> >  f4be17cd5b14 ("drm/mediatek: Remove struct cmdq_client")
> >  c1ec54b7b5af ("drm/mediatek: Use mailbox rx_callback instead of cmdq_t=
ask_cb")
> >
> > Apart from that it was a pain bisecting and introduced different
> > behaviours between patches, all the above commits have a follow-up
> > patch (see [1] and [2]) as a fix for the landed series. That makes me
> > think that were no stable enough. As we're in the rc, and as you said
> > this is not the correct way to fix it, and the landed patches seems
> > more a cleanup that really solving a real problem I'd consider to just
> > revert the full series and resubmit again for next release with these
> > fixes squashed. IMO that will also help to no miss anything when
> > someone would backport all this to the stable versions and understand
> > better the history.
> >
> > Just my 5 cents. In any case, I can confirm that applying the full
> > series solves the current problems that I have with my Acer Chromebook
> > R13.
>
> OK, that series depend on an WARN_ON fixes in mailbox driver, and need
> a better solution in cmdq helper, so let's revert that series first.
> Would you like to send the revert patches? Or I send the revert
> patches and let you test?
>

I'll let you to send the revert patches :-)

Thanks,
  Enric

> Regards,
> Chun-Kuang.
>
> >
> > Thanks,
> >   Enric
> >
> > [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D=
555383
> > [2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D=
554767
> >
> >
> >
> > > Regards,
> > > Chun-Kuang.
> > >
> > > >
> > > > Thanks,
> > > >   Enric
> > > >
> > > >
> > > > > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > > > > ---
> > > > >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 73 +++++++++++++------=
------
> > > > >  1 file changed, 38 insertions(+), 35 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gp=
u/drm/mediatek/mtk_drm_crtc.c
> > > > > index 5f81489fc60c..411d99fcbb8f 100644
> > > > > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > > > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > > > > @@ -52,8 +52,7 @@ struct mtk_drm_crtc {
> > > > >         bool                            pending_async_planes;
> > > > >
> > > > >  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> > > > > -       struct mbox_client              cmdq_cl;
> > > > > -       struct mbox_chan                *cmdq_chan;
> > > > > +       struct cmdq_client              cmdq_client;
> > > > >         struct cmdq_pkt                 cmdq_handle;
> > > > >         u32                             cmdq_event;
> > > > >         u32                             cmdq_vblank_cnt;
> > > > > @@ -227,8 +226,8 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_pla=
ne(struct drm_crtc *crtc,
> > > > >  }
> > > > >
> > > > >  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> > > > > -static int mtk_drm_cmdq_pkt_create(struct mbox_chan *chan, struc=
t cmdq_pkt *pkt,
> > > > > -                                   size_t size)
> > > > > +static int mtk_drm_cmdq_pkt_create(struct cmdq_client *client, s=
truct cmdq_pkt *pkt,
> > > > > +                                  size_t size)
> > > > >  {
> > > > >         struct device *dev;
> > > > >         dma_addr_t dma_addr;
> > > > > @@ -239,8 +238,9 @@ static int mtk_drm_cmdq_pkt_create(struct mbo=
x_chan *chan, struct cmdq_pkt *pkt,
> > > > >                 return -ENOMEM;
> > > > >         }
> > > > >         pkt->buf_size =3D size;
> > > > > +       pkt->cl =3D (void *)client;
> > > > >
> > > > > -       dev =3D chan->mbox->dev;
> > > > > +       dev =3D client->chan->mbox->dev;
> > > > >         dma_addr =3D dma_map_single(dev, pkt->va_base, pkt->buf_s=
ize,
> > > > >                                   DMA_TO_DEVICE);
> > > > >         if (dma_mapping_error(dev, dma_addr)) {
> > > > > @@ -255,9 +255,11 @@ static int mtk_drm_cmdq_pkt_create(struct mb=
ox_chan *chan, struct cmdq_pkt *pkt,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > -static void mtk_drm_cmdq_pkt_destroy(struct mbox_chan *chan, str=
uct cmdq_pkt *pkt)
> > > > > +static void mtk_drm_cmdq_pkt_destroy(struct cmdq_pkt *pkt)
> > > > >  {
> > > > > -       dma_unmap_single(chan->mbox->dev, pkt->pa_base, pkt->buf_=
size,
> > > > > +       struct cmdq_client *client =3D (struct cmdq_client *)pkt-=
>cl;
> > > > > +
> > > > > +       dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, p=
kt->buf_size,
> > > > >                          DMA_TO_DEVICE);
> > > > >         kfree(pkt->va_base);
> > > > >         kfree(pkt);
> > > > > @@ -265,8 +267,9 @@ static void mtk_drm_cmdq_pkt_destroy(struct m=
box_chan *chan, struct cmdq_pkt *pk
> > > > >
> > > > >  static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
> > > > >  {
> > > > > -       struct mtk_drm_crtc *mtk_crtc =3D container_of(cl, struct=
 mtk_drm_crtc, cmdq_cl);
> > > > >         struct cmdq_cb_data *data =3D mssg;
> > > > > +       struct cmdq_client *cmdq_cl =3D container_of(cl, struct c=
mdq_client, client);
> > > > > +       struct mtk_drm_crtc *mtk_crtc =3D container_of(cmdq_cl, s=
truct mtk_drm_crtc, cmdq_client);
> > > > >         struct mtk_crtc_state *state;
> > > > >         unsigned int i;
> > > > >
> > > > > @@ -299,7 +302,7 @@ static void ddp_cmdq_cb(struct mbox_client *c=
l, void *mssg)
> > > > >         }
> > > > >
> > > > >         mtk_crtc->cmdq_vblank_cnt =3D 0;
> > > > > -       mtk_drm_cmdq_pkt_destroy(mtk_crtc->cmdq_chan, data->pkt);
> > > > > +       mtk_drm_cmdq_pkt_destroy(data->pkt);
> > > > >  }
> > > > >  #endif
> > > > >
> > > > > @@ -550,24 +553,24 @@ static void mtk_drm_crtc_update_config(stru=
ct mtk_drm_crtc *mtk_crtc,
> > > > >                 mtk_mutex_release(mtk_crtc->mutex);
> > > > >         }
> > > > >  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> > > > > -       if (mtk_crtc->cmdq_chan) {
> > > > > -               mbox_flush(mtk_crtc->cmdq_chan, 2000);
> > > > > +       if (mtk_crtc->cmdq_client.chan) {
> > > > > +               mbox_flush(mtk_crtc->cmdq_client.chan, 2000);
> > > > >                 cmdq_handle->cmd_buf_size =3D 0;
> > > > >                 cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_=
event);
> > > > >                 cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, f=
alse);
> > > > >                 mtk_crtc_ddp_config(crtc, cmdq_handle);
> > > > >                 cmdq_pkt_finalize(cmdq_handle);
> > > > > -               dma_sync_single_for_device(mtk_crtc->cmdq_chan->m=
box->dev,
> > > > > -                                           cmdq_handle->pa_base,
> > > > > -                                           cmdq_handle->cmd_buf_=
size,
> > > > > -                                           DMA_TO_DEVICE);
> > > > > +               dma_sync_single_for_device(mtk_crtc->cmdq_client.=
chan->mbox->dev,
> > > > > +                                          cmdq_handle->pa_base,
> > > > > +                                          cmdq_handle->cmd_buf_s=
ize,
> > > > > +                                          DMA_TO_DEVICE);
> > > > >                 /*
> > > > >                  * CMDQ command should execute in next vblank,
> > > > >                  * If it fail to execute in next 2 vblank, timeou=
t happen.
> > > > >                  */
> > > > >                 mtk_crtc->cmdq_vblank_cnt =3D 2;
> > > > > -               mbox_send_message(mtk_crtc->cmdq_chan, cmdq_handl=
e);
> > > > > -               mbox_client_txdone(mtk_crtc->cmdq_chan, 0);
> > > > > +               mbox_send_message(mtk_crtc->cmdq_client.chan, cmd=
q_handle);
> > > > > +               mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0)=
;
> > > > >         }
> > > > >  #endif
> > > > >         mtk_crtc->config_updating =3D false;
> > > > > @@ -581,7 +584,7 @@ static void mtk_crtc_ddp_irq(void *data)
> > > > >         struct mtk_drm_private *priv =3D crtc->dev->dev_private;
> > > > >
> > > > >  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> > > > > -       if (!priv->data->shadow_register && !mtk_crtc->cmdq_chan)
> > > > > +       if (!priv->data->shadow_register && !mtk_crtc->cmdq_clien=
t.chan)
> > > > >                 mtk_crtc_ddp_config(crtc, NULL);
> > > > >         else if (mtk_crtc->cmdq_vblank_cnt > 0 && --mtk_crtc->cmd=
q_vblank_cnt =3D=3D 0)
> > > > >                 DRM_ERROR("mtk_crtc %d CMDQ execute command timeo=
ut!\n",
> > > > > @@ -924,20 +927,20 @@ int mtk_drm_crtc_create(struct drm_device *=
drm_dev,
> > > > >         mutex_init(&mtk_crtc->hw_lock);
> > > > >
> > > > >  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> > > > > -       mtk_crtc->cmdq_cl.dev =3D mtk_crtc->mmsys_dev;
> > > > > -       mtk_crtc->cmdq_cl.tx_block =3D false;
> > > > > -       mtk_crtc->cmdq_cl.knows_txdone =3D true;
> > > > > -       mtk_crtc->cmdq_cl.rx_callback =3D ddp_cmdq_cb;
> > > > > -       mtk_crtc->cmdq_chan =3D
> > > > > -                       mbox_request_channel(&mtk_crtc->cmdq_cl,
> > > > > -                                             drm_crtc_index(&mtk=
_crtc->base));
> > > > > -       if (IS_ERR(mtk_crtc->cmdq_chan)) {
> > > > > +       mtk_crtc->cmdq_client.client.dev =3D mtk_crtc->mmsys_dev;
> > > > > +       mtk_crtc->cmdq_client.client.tx_block =3D false;
> > > > > +       mtk_crtc->cmdq_client.client.knows_txdone =3D true;
> > > > > +       mtk_crtc->cmdq_client.client.rx_callback =3D ddp_cmdq_cb;
> > > > > +       mtk_crtc->cmdq_client.chan =3D
> > > > > +                       mbox_request_channel(&mtk_crtc->cmdq_clie=
nt.client,
> > > > > +                                            drm_crtc_index(&mtk_=
crtc->base));
> > > > > +       if (IS_ERR(mtk_crtc->cmdq_client.chan)) {
> > > > >                 dev_dbg(dev, "mtk_crtc %d failed to create mailbo=
x client, writing register by CPU now\n",
> > > > >                         drm_crtc_index(&mtk_crtc->base));
> > > > > -               mtk_crtc->cmdq_chan =3D NULL;
> > > > > +               mtk_crtc->cmdq_client.chan =3D NULL;
> > > > >         }
> > > > >
> > > > > -       if (mtk_crtc->cmdq_chan) {
> > > > > +       if (mtk_crtc->cmdq_client.chan) {
> > > > >                 ret =3D of_property_read_u32_index(priv->mutex_no=
de,
> > > > >                                                  "mediatek,gce-ev=
ents",
> > > > >                                                  drm_crtc_index(&=
mtk_crtc->base),
> > > > > @@ -945,17 +948,17 @@ int mtk_drm_crtc_create(struct drm_device *=
drm_dev,
> > > > >                 if (ret) {
> > > > >                         dev_dbg(dev, "mtk_crtc %d failed to get m=
ediatek,gce-events property\n",
> > > > >                                 drm_crtc_index(&mtk_crtc->base));
> > > > > -                       mbox_free_channel(mtk_crtc->cmdq_chan);
> > > > > -                       mtk_crtc->cmdq_chan =3D NULL;
> > > > > +                       mbox_free_channel(mtk_crtc->cmdq_client.c=
han);
> > > > > +                       mtk_crtc->cmdq_client.chan =3D NULL;
> > > > >                 } else {
> > > > > -                       ret =3D mtk_drm_cmdq_pkt_create(mtk_crtc-=
>cmdq_chan,
> > > > > -                                                      &mtk_crtc-=
>cmdq_handle,
> > > > > -                                                      PAGE_SIZE)=
;
> > > > > +                       ret =3D mtk_drm_cmdq_pkt_create(&mtk_crtc=
->cmdq_client,
> > > > > +                                                     &mtk_crtc->=
cmdq_handle,
> > > > > +                                                     PAGE_SIZE);
> > > > >                         if (ret) {
> > > > >                                 dev_dbg(dev, "mtk_crtc %d failed =
to create cmdq packet\n",
> > > > >                                         drm_crtc_index(&mtk_crtc-=
>base));
> > > > > -                               mbox_free_channel(mtk_crtc->cmdq_=
chan);
> > > > > -                               mtk_crtc->cmdq_chan =3D NULL;
> > > > > +                               mbox_free_channel(mtk_crtc->cmdq_=
client.chan);
> > > > > +                               mtk_crtc->cmdq_client.chan =3D NU=
LL;
> > > > >                         }
> > > > >                 }
> > > > >         }
> > > > > --
> > > > > 2.18.0
> > > > >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9958445514F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbhKQXys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 18:54:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233682AbhKQXyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 18:54:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35C9D61BA1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 23:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637193105;
        bh=ZIuBXznCZTHqa3nOAy53L5b5XyA4/YwjswwSJW5QWNU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gswTE0ACcQ/r+5MGUJl40onWeslOi99B5YCJGx59mn/WP+15Jvn3lNPb1R/E50Khg
         +EpK64tWg//+NhYiq9JINeaGBDm2IhwxQHTwPj1tZ8ZY9TmYOINwpGCbvmN9kXdeoB
         nitUJpwHuLctod25/VYhPSe9ANWusBZC6JCrrMS3zj29xT7zxjOT3ztRda3sEXvhY4
         ODOz+A5v4wweoG9I372h4NBS54owVuo/dU9WrAo7FR7YJMpVYc1FDTZX6UTHSmy476
         l9KG4SD6fBA1A7w+UubB8w0xDi7neOaW7vQQrN6u9x6GBJZEpBhtCCHBa+Neo+6rE4
         MErDiOLCYbOVg==
Received: by mail-ed1-f48.google.com with SMTP id x15so18608470edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 15:51:45 -0800 (PST)
X-Gm-Message-State: AOAM530ENU4OuCYdR0qk5jChFdUeRqXoHESSE+VOPjJ44Y5oMZScoFXk
        kz1nhLNwr36nVhykOmXwM+UX0m5qzeqmC0uU0A==
X-Google-Smtp-Source: ABdhPJzZpYIo+cd8wMcVpCye06DU1Qqc9x9xGxki7AWNJrrL9JgkZksVJDRb9AP2dnU2JZGb4+zU7elF+rs/DoPFF6k=
X-Received: by 2002:aa7:c347:: with SMTP id j7mr4277614edr.272.1637193103549;
 Wed, 17 Nov 2021 15:51:43 -0800 (PST)
MIME-Version: 1.0
References: <20211027021857.20816-1-jason-jh.lin@mediatek.com>
 <20211027021857.20816-4-jason-jh.lin@mediatek.com> <CAC=S1ng2=XRV9s2t2dxQf1a2V2GsFwhfB8tRxnNDp-QD5eR_xQ@mail.gmail.com>
 <CAAOTY_9sCr-CM6WsZ6q7mtfqr9A5sNccC0bk1vq=Hdqr3rGkQw@mail.gmail.com> <CAC=S1njhuzPi6gOmGfqhtKMtDTsGPzZ7P=PoVbAviHt1o00U6w@mail.gmail.com>
In-Reply-To: <CAC=S1njhuzPi6gOmGfqhtKMtDTsGPzZ7P=PoVbAviHt1o00U6w@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 18 Nov 2021 07:51:32 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9eA3pzCDdXpjRUpd-zy2uzn_kVmeVnBwFT6hU=U5hZ-A@mail.gmail.com>
Message-ID: <CAAOTY_9eA3pzCDdXpjRUpd-zy2uzn_kVmeVnBwFT6hU=U5hZ-A@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] drm/mediatek: Detect CMDQ execution timeout
To:     Fei Shao <fshao@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "jason-jh.lin" <jason-jh.lin@mediatek.com>,
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
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fei:

Fei Shao <fshao@chromium.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=8828=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:19=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On Thu, Oct 28, 2021 at 7:47 AM Chun-Kuang Hu <chunkuang.hu@kernel.org> w=
rote:
> >
> > Hi, Fei:
> >
> > Fei Shao <fshao@chromium.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:32=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > Hi Jason,
> > >
> > > On Wed, Oct 27, 2021 at 10:19 AM jason-jh.lin <jason-jh.lin@mediatek.=
com> wrote:
> > > >
> > > > From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > >
> > > > CMDQ is used to update display register in vblank period, so
> > > > it should be execute in next 2 vblank. One vblank interrupt
> > > > before send message (occasionally) and one vblank interrupt
> > > > after cmdq done. If it fail to execute in next 3 vblank,
> > > > tiemout happen.
> > > >
> > > > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > > > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > > ---
> > > >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 20 ++++++++++++++++++--
> > > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/=
drm/mediatek/mtk_drm_crtc.c
> > > > index e23e3224ac67..dad1f85ee315 100644
> > > > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > > > @@ -54,6 +54,7 @@ struct mtk_drm_crtc {
> > > >  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> > > >         struct cmdq_client              cmdq_client;
> > > >         u32                             cmdq_event;
> > > > +       u32                             cmdq_vblank_cnt;
> > > >  #endif
> > > >
> > > >         struct device                   *mmsys_dev;
> > > > @@ -227,7 +228,10 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plan=
e(struct drm_crtc *crtc,
> > > >  static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
> > > >  {
> > > >         struct cmdq_cb_data *data =3D mssg;
> > > > +       struct cmdq_client *cmdq_cl =3D container_of(cl, struct cmd=
q_client, client);
> > > > +       struct mtk_drm_crtc *mtk_crtc =3D container_of(cmdq_cl, str=
uct mtk_drm_crtc, cmdq_client);
> > > >
> > > > +       mtk_crtc->cmdq_vblank_cnt =3D 0;
> > > >         cmdq_pkt_destroy(data->pkt);
> > > >  }
> > > >  #endif
> > > > @@ -483,6 +487,15 @@ static void mtk_drm_crtc_update_config(struct =
mtk_drm_crtc *mtk_crtc,
> > > >                                            cmdq_handle->pa_base,
> > > >                                            cmdq_handle->cmd_buf_siz=
e,
> > > >                                            DMA_TO_DEVICE);
> > > > +               /*
> > > > +                * CMDQ command should execute in next 3 vblank.
> > > > +                * One vblank interrupt before send message (occasi=
onally)
> > > > +                * and one vblank interrupt after cmdq done,
> > > > +                * so it's timeout after 3 vblank interrupt.
> > > > +                * If it fail to execute in next 3 vblank, timeout =
happen.
> > > > +                */
> > > > +               mtk_crtc->cmdq_vblank_cnt =3D 3;
> > > > +
> > > >                 mbox_send_message(mtk_crtc->cmdq_client.chan, cmdq_=
handle);
> > > >                 mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
> > > >         }
> > > > @@ -499,11 +512,14 @@ static void mtk_crtc_ddp_irq(void *data)
> > > >
> > > >  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> > > >         if (!priv->data->shadow_register && !mtk_crtc->cmdq_client.=
chan)
> > > > +               mtk_crtc_ddp_config(crtc, NULL);
> > > > +       else if (mtk_crtc->cmdq_vblank_cnt > 0 && --mtk_crtc->cmdq_=
vblank_cnt =3D=3D 0)
> > > I think atomic_dec_and_test() does what you want to do here.
> >
> > I think this operation is not necessary to be atomic operation, and
> > this statement could be reduced to
> >
> > else if (--mtk_crtc->cmdq_vblank_cnt =3D=3D 0)
>
> I was thinking about using existing helpers to wrap up the counter
> operations, but I agree that it's not necessary.
> Just dropping the redundant check would be good enough.

I find one thing so that I would like this version. If we do not check
mtk_crtc->cmdq_vblank_cnt > 0, mtk_crtc->cmdq_vblank_cnt would
decrease to minus. And one day it would round to positive. So I would
pick this version instead of v6.

Regards,
Chun-Kuang.

>
>
> >
> > >
> > > > +               DRM_ERROR("mtk_crtc %d CMDQ execute command timeout=
!\n",
> > > > +                         drm_crtc_index(&mtk_crtc->base));
> > > >  #else
> > > >         if (!priv->data->shadow_register)
> > > > -#endif
> > > >                 mtk_crtc_ddp_config(crtc, NULL);
> > > > -
> > > > +#endif
> > > >         mtk_drm_finish_page_flip(mtk_crtc);
> > > >  }
> > > >
> > > > --
> > > > 2.18.0
> > > >

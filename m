Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE4A43D9CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 05:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhJ1DWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 23:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhJ1DWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 23:22:10 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3633C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 20:19:43 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z144so5168977iof.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 20:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8iLqanegbeY/oC5IucoRrB/uNp5p6hrJTUbMi+FyPCg=;
        b=I/BQtp4v9VF9Mrf/HLCEPNJpd/6gyYZZhOoXLzv9PA68p4CmdvxV3LrV9GdRlfmrpY
         DlKSHwbewUBrYPxr7U4RR76y6oWMF7J4K18U/GFNGmhQNyQAsD/o648g3YZOZtci+FaP
         GYLoNR94SVRFEgAyk0lFT5e85rc3gjBq+25ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8iLqanegbeY/oC5IucoRrB/uNp5p6hrJTUbMi+FyPCg=;
        b=O4q/WlEmqmhf2uF1zcfJoHmoWzBslBPKI0XYlbd2O18Wir01VgBX7nnEc4xbZ2vzNB
         uC0xPwT4m8KiwKN8AR+koIU+14v+8AyXt4XzFpLtO47rh2d5JaYkoIYi93raiJeBHBHa
         uWoD72b8o+24kWlAW71M/wIME5KVieTZf0dwyXGFsG9XD7xVWQbqSAJSp3rlFljm+FMO
         GVWV3RswFtUWd4R7qODqHeakWHZwEC8WcBlMDbYnSL0GJQ4pho+ET1z3H12iW3rGWLxe
         vkrmYNGmft/PRvidB66AABAAsTxozpoPcFeHR2SPAEvuIrSQH68JmI5Adxo7YqGhJl4j
         E0aA==
X-Gm-Message-State: AOAM530pis8iLn7Ou2c37G/ZJXQmooqAFmx61NEyEmNkMkZLwILG6YWB
        YGNDz+A+P7EcJHDhFzUW1SvlwU5MWUYSkw==
X-Google-Smtp-Source: ABdhPJzDTMLn9y163EmQnDA7VMAqBZP0BtZ+TZiuRJhXAiNzKOKwkmtE2QdUciVZjaOhzBY86WSX+Q==
X-Received: by 2002:a05:6638:3727:: with SMTP id k39mr1242664jav.143.1635391182775;
        Wed, 27 Oct 2021 20:19:42 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id s7sm1021801ilv.61.2021.10.27.20.19.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 20:19:42 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id y17so5243153ilb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 20:19:41 -0700 (PDT)
X-Received: by 2002:a05:6e02:687:: with SMTP id o7mr1270144ils.222.1635391180904;
 Wed, 27 Oct 2021 20:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211027021857.20816-1-jason-jh.lin@mediatek.com>
 <20211027021857.20816-4-jason-jh.lin@mediatek.com> <CAC=S1ng2=XRV9s2t2dxQf1a2V2GsFwhfB8tRxnNDp-QD5eR_xQ@mail.gmail.com>
 <CAAOTY_9sCr-CM6WsZ6q7mtfqr9A5sNccC0bk1vq=Hdqr3rGkQw@mail.gmail.com>
In-Reply-To: <CAAOTY_9sCr-CM6WsZ6q7mtfqr9A5sNccC0bk1vq=Hdqr3rGkQw@mail.gmail.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 28 Oct 2021 11:19:04 +0800
X-Gmail-Original-Message-ID: <CAC=S1njhuzPi6gOmGfqhtKMtDTsGPzZ7P=PoVbAviHt1o00U6w@mail.gmail.com>
Message-ID: <CAC=S1njhuzPi6gOmGfqhtKMtDTsGPzZ7P=PoVbAviHt1o00U6w@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] drm/mediatek: Detect CMDQ execution timeout
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
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

Hi Chun-Kuang,

On Thu, Oct 28, 2021 at 7:47 AM Chun-Kuang Hu <chunkuang.hu@kernel.org> wro=
te:
>
> Hi, Fei:
>
> Fei Shao <fshao@chromium.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=8827=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:32=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Hi Jason,
> >
> > On Wed, Oct 27, 2021 at 10:19 AM jason-jh.lin <jason-jh.lin@mediatek.co=
m> wrote:
> > >
> > > From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > >
> > > CMDQ is used to update display register in vblank period, so
> > > it should be execute in next 2 vblank. One vblank interrupt
> > > before send message (occasionally) and one vblank interrupt
> > > after cmdq done. If it fail to execute in next 3 vblank,
> > > tiemout happen.
> > >
> > > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_crtc.c
> > > index e23e3224ac67..dad1f85ee315 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > > @@ -54,6 +54,7 @@ struct mtk_drm_crtc {
> > >  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> > >         struct cmdq_client              cmdq_client;
> > >         u32                             cmdq_event;
> > > +       u32                             cmdq_vblank_cnt;
> > >  #endif
> > >
> > >         struct device                   *mmsys_dev;
> > > @@ -227,7 +228,10 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plane(=
struct drm_crtc *crtc,
> > >  static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
> > >  {
> > >         struct cmdq_cb_data *data =3D mssg;
> > > +       struct cmdq_client *cmdq_cl =3D container_of(cl, struct cmdq_=
client, client);
> > > +       struct mtk_drm_crtc *mtk_crtc =3D container_of(cmdq_cl, struc=
t mtk_drm_crtc, cmdq_client);
> > >
> > > +       mtk_crtc->cmdq_vblank_cnt =3D 0;
> > >         cmdq_pkt_destroy(data->pkt);
> > >  }
> > >  #endif
> > > @@ -483,6 +487,15 @@ static void mtk_drm_crtc_update_config(struct mt=
k_drm_crtc *mtk_crtc,
> > >                                            cmdq_handle->pa_base,
> > >                                            cmdq_handle->cmd_buf_size,
> > >                                            DMA_TO_DEVICE);
> > > +               /*
> > > +                * CMDQ command should execute in next 3 vblank.
> > > +                * One vblank interrupt before send message (occasion=
ally)
> > > +                * and one vblank interrupt after cmdq done,
> > > +                * so it's timeout after 3 vblank interrupt.
> > > +                * If it fail to execute in next 3 vblank, timeout ha=
ppen.
> > > +                */
> > > +               mtk_crtc->cmdq_vblank_cnt =3D 3;
> > > +
> > >                 mbox_send_message(mtk_crtc->cmdq_client.chan, cmdq_ha=
ndle);
> > >                 mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
> > >         }
> > > @@ -499,11 +512,14 @@ static void mtk_crtc_ddp_irq(void *data)
> > >
> > >  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> > >         if (!priv->data->shadow_register && !mtk_crtc->cmdq_client.ch=
an)
> > > +               mtk_crtc_ddp_config(crtc, NULL);
> > > +       else if (mtk_crtc->cmdq_vblank_cnt > 0 && --mtk_crtc->cmdq_vb=
lank_cnt =3D=3D 0)
> > I think atomic_dec_and_test() does what you want to do here.
>
> I think this operation is not necessary to be atomic operation, and
> this statement could be reduced to
>
> else if (--mtk_crtc->cmdq_vblank_cnt =3D=3D 0)

I was thinking about using existing helpers to wrap up the counter
operations, but I agree that it's not necessary.
Just dropping the redundant check would be good enough.


>
> >
> > > +               DRM_ERROR("mtk_crtc %d CMDQ execute command timeout!\=
n",
> > > +                         drm_crtc_index(&mtk_crtc->base));
> > >  #else
> > >         if (!priv->data->shadow_register)
> > > -#endif
> > >                 mtk_crtc_ddp_config(crtc, NULL);
> > > -
> > > +#endif
> > >         mtk_drm_finish_page_flip(mtk_crtc);
> > >  }
> > >
> > > --
> > > 2.18.0
> > >

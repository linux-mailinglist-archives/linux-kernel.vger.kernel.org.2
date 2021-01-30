Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1B3093AC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhA3Jr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:47:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhA3Jqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:46:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 846CE64DE2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611999951;
        bh=MhQGmFgm/LGG1ligU9jCk3BNvT4EdziFNPpiMLDajrE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ttc3Y1c7ogHDMe1fGfGMNlq8p6ptIklpY7cIqMmFL1YhWivfE7GfWl3xrgyjPCIno
         BAC/zvnVdviTnfV2EH6VTNE7mg9S0G9iDmaQVOBL9TFX/Dsu/DT2/0MuwkzboHX6G+
         KG/OdwPyERud0t44FCFJeyrhCmanu3LGerldZ+acAz5wfhGfX1c8qgo9hfB/kHWSsG
         XmOQv4uxoPcP6mxfaTnd4y9LP+6zkjyOe4QFJHbpNC2JOWY9LB0E/iSJJq+xe9bmJS
         jcAPFazowHSASrDTnsdCSlVRkL5RcO3/5BBQzAT+ihDzH/ujDpVvkVfHFWowcJSOGj
         WlmOZXmoLmaQw==
Received: by mail-wr1-f44.google.com with SMTP id v15so11260776wrx.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 01:45:51 -0800 (PST)
X-Gm-Message-State: AOAM530B3KURtrzeYpE6ERTkcNSEx0nlTShgVF/VISdEmoBf0FF558vf
        gCK34U3SgUdwuTEidLyyFfvhQKFpXUU3NzQBrg==
X-Google-Smtp-Source: ABdhPJyB4BiUHRoeBGFBg4TGw9IN5L7kt1fDo/DtawET2t8dfkdw1dTjhLZCj+8lSm4K+kgbv7iA2Qui4j5NU86e5WA=
X-Received: by 2002:adf:f303:: with SMTP id i3mr8763867wro.60.1611999950124;
 Sat, 30 Jan 2021 01:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20201202235856.7652-1-chunkuang.hu@kernel.org> <CAAOTY__p4C0ctXuOFu42-9HaTrGnOef-Sg47pyC0Uk7yN5406w@mail.gmail.com>
In-Reply-To: <CAAOTY__p4C0ctXuOFu42-9HaTrGnOef-Sg47pyC0Uk7yN5406w@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 30 Jan 2021 17:45:37 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9Qk8Bun9km1DRoCPMAwOJdJ2omsnMipS1jGzUrrrv=sg@mail.gmail.com>
Message-ID: <CAAOTY_9Qk8Bun9km1DRoCPMAwOJdJ2omsnMipS1jGzUrrrv=sg@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: cmdq: Remove cmdq_pkt_flush()
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8810=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=886:59=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi, Matthias:
>
> Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=
=883=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=887:59=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > rx_callback is a standard mailbox callback mechanism and could
> > cover the function of proprietary cmdq_task_cb, so it is better
> > to use the standard one instead of the proprietary one. But
> > register rx_callback should before mbox_request_channel(),
> > so remove cmdq_pkt_flush() and let client driver implement
> > its own synchronous flush.
>
> How do you think about this patch? This patch is derived from [1]
> according to Jassi's suggestion [2].
>
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20200927230=
422.11610-3-chunkuang.hu@kernel.org/
> [2] https://patchwork.kernel.org/project/linux-mediatek/cover/20200927230=
422.11610-1-chunkuang.hu@kernel.org/

Just a ping.

Regards,
Chun-Kuang.

>
> Regards,
> Chun-Kuang.
>
> >
> > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > ---
> >  drivers/soc/mediatek/mtk-cmdq-helper.c | 32 --------------------------
> >  include/linux/soc/mediatek/mtk-cmdq.h  | 12 ----------
> >  2 files changed, 44 deletions(-)
> >
> > diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/media=
tek/mtk-cmdq-helper.c
> > index 505651b0d715..fd3bc39538a1 100644
> > --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> > +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> > @@ -502,36 +502,4 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmd=
q_async_flush_cb cb,
> >  }
> >  EXPORT_SYMBOL(cmdq_pkt_flush_async);
> >
> > -struct cmdq_flush_completion {
> > -       struct completion cmplt;
> > -       bool err;
> > -};
> > -
> > -static void cmdq_pkt_flush_cb(struct cmdq_cb_data data)
> > -{
> > -       struct cmdq_flush_completion *cmplt;
> > -
> > -       cmplt =3D (struct cmdq_flush_completion *)data.data;
> > -       if (data.sta !=3D CMDQ_CB_NORMAL)
> > -               cmplt->err =3D true;
> > -       else
> > -               cmplt->err =3D false;
> > -       complete(&cmplt->cmplt);
> > -}
> > -
> > -int cmdq_pkt_flush(struct cmdq_pkt *pkt)
> > -{
> > -       struct cmdq_flush_completion cmplt;
> > -       int err;
> > -
> > -       init_completion(&cmplt.cmplt);
> > -       err =3D cmdq_pkt_flush_async(pkt, cmdq_pkt_flush_cb, &cmplt);
> > -       if (err < 0)
> > -               return err;
> > -       wait_for_completion(&cmplt.cmplt);
> > -
> > -       return cmplt.err ? -EFAULT : 0;
> > -}
> > -EXPORT_SYMBOL(cmdq_pkt_flush);
> > -
> >  MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/=
mediatek/mtk-cmdq.h
> > index 960704d75994..2c6aa84c0e80 100644
> > --- a/include/linux/soc/mediatek/mtk-cmdq.h
> > +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> > @@ -288,16 +288,4 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
> >  int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
> >                          void *data);
> >
> > -/**
> > - * cmdq_pkt_flush() - trigger CMDQ to execute the CMDQ packet
> > - * @pkt:       the CMDQ packet
> > - *
> > - * Return: 0 for success; else the error code is returned
> > - *
> > - * Trigger CMDQ to execute the CMDQ packet. Note that this is a
> > - * synchronous flush function. When the function returned, the recorde=
d
> > - * commands have been done.
> > - */
> > -int cmdq_pkt_flush(struct cmdq_pkt *pkt);
> > -
> >  #endif /* __MTK_CMDQ_H__ */
> > --
> > 2.17.1
> >

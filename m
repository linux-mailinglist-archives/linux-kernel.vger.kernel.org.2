Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93AC3800F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 01:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhEMXn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 19:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhEMXn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 19:43:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5D1561440;
        Thu, 13 May 2021 23:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620949336;
        bh=Q+ZtNVyGmIl0eXIQdcuUrxm022erUcWDgP5SQNOKYQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iH49wNJ+6khauFhNYkW4TjYuSUoVNxpNAXZwdwX1vzihY0Q/34epUJFzJ1oKStd42
         WZAsWkiNHkMrVshVnZyX9l06691jq9xHRcRuhboOHs0sSxTd743O2L9mnvP6Dy4//5
         at++XhheqRV58LqTyVD2TYMsYsRfkrcCFQ4Y7kjh7wFUezH6ACP8dHk/Gd8gvKFVwv
         GB0WzLc0DZ0amS16V59vFKKOHpJlHASkBkV8HfFarusvPeESM1BwulNWbue2EKaaiJ
         mK6zQyBivpA0SCi03Jdeq707COQjTm9ON/Q/HYni9EDWx85PYqigEDbRFLdfUmfOLB
         KU5Dg6bY8VpgQ==
Received: by mail-ej1-f48.google.com with SMTP id k10so10956253ejj.8;
        Thu, 13 May 2021 16:42:16 -0700 (PDT)
X-Gm-Message-State: AOAM530BdsZFqSJtMlxqvRA6HAOaks32VqQFslHjkkIWyyvuEVYT7Oii
        2dI2SHz+utkLGtF+bB+cjBXdzK4KSb203O2x7w==
X-Google-Smtp-Source: ABdhPJwjsoRig7IOCycfYr7+vBwT5PLJsBVb7geAGrFTpeUYk95619iAQHs5U3NzTbepCRoakv8rIPSUJ04vCjqg1co=
X-Received: by 2002:a17:906:3da9:: with SMTP id y9mr46028343ejh.303.1620949335233;
 Thu, 13 May 2021 16:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210410034841.16567-1-wangli74@huawei.com> <CAAOTY_-qNeoZT1CorqhBrQe888tG21TF=LnPkUgymv=rQ8-YAA@mail.gmail.com>
In-Reply-To: <CAAOTY_-qNeoZT1CorqhBrQe888tG21TF=LnPkUgymv=rQ8-YAA@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 14 May 2021 07:42:04 +0800
X-Gmail-Original-Message-ID: <CAAOTY_95X+z83Ng8EO3zwbAqqE9E1=YQYT+3e-N2KHTOVqfsKg@mail.gmail.com>
Message-ID: <CAAOTY_95X+z83Ng8EO3zwbAqqE9E1=YQYT+3e-N2KHTOVqfsKg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/mediatek: Fix PM reference leak in mtk_crtc_ddp_hw_init()
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Wang Li <wangli74@huawei.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wang:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B44=E6=9C=8812=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:32=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi, Wang:
>
> Wang Li <wangli74@huawei.com> =E6=96=BC 2021=E5=B9=B44=E6=9C=8810=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8811:31=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > pm_runtime_get_sync will increment pm usage counter even it failed.
> > Forgetting to putting operation will result in reference leak here.
> > Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> > counter balanced.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wang Li <wangli74@huawei.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/=
mediatek/mtk_drm_crtc.c
> > index 54ab3a324752..f1954242d8f6 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -259,7 +259,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc=
 *mtk_crtc)
> >                 drm_connector_list_iter_end(&conn_iter);
> >         }
> >
> > -       ret =3D pm_runtime_get_sync(crtc->dev->dev);
> > +       ret =3D pm_runtime_resume_and_get(crtc->dev->dev);
> >         if (ret < 0) {
> >                 DRM_ERROR("Failed to enable power domain: %d\n", ret);
> >                 return ret;
> > --
> > 2.17.1
> >
